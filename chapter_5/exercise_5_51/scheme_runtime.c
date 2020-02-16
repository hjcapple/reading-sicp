// 实现 Scheme 的运行时环境，包含一个很简单的 GC。

#include "scheme_runtime.h"
#include <assert.h>
#include <ctype.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 简单的符号表实现
typedef struct {
    int size;
    int capacity;
    char **symbols;
} SymbolTable;

static void SymbolTable_Init(SymbolTable *table) {
    table->capacity = 512;
    table->size = 0;
    table->symbols = (char **)malloc(table->capacity * sizeof(char *));
}

static void SymbolTable_Free(SymbolTable *table) {
    int i = 0;
    for (i = 0; i < table->size; i++) {
        free(table->symbols[i]);
    }
    free(table->symbols);
}

static const char *SymbolTable_Alloc(SymbolTable *table, const char *symbol) {
    int i = 0;
    for (i = 0; i < table->size; i++) {
        if (strcmp(symbol, table->symbols[i]) == 0) {
            return table->symbols[i];
        }
    }
    if (table->size == table->capacity) {
        table->capacity *= 2;
        table->symbols = (char **)realloc(table->symbols, table->capacity * sizeof(char *));
    }
    i = table->size;
    table->symbols[i] = strdup(symbol);
    table->size++;
    return table->symbols[i];
}

typedef enum {
    ValueType_BrokenHeart,
    ValueType_Void,
    ValueType_Null,
    ValueType_Boolean,
    ValueType_Number,
    ValueType_Symbol,
    ValueType_String,
    ValueType_Pair,
    ValueType_Primitive,
    ValueType_Procedure,
    ValueType_Label,
} ValueType;

typedef struct {
    ValueType type;
    union {
        char *str;
        const char *symbol;
        void *label;
        Primitive primitive;
        double number;
        int boolean;
        int brokenHeart;
        struct {
            int val;
            int symbol;
        } procedure;
        struct {
            int car;
            int cdr;
        } pair;
    };
} Value;

static void Value_FreeStr(Value *val) {
    if (val->type == ValueType_String) {
        free((void *)val->str);
    }
    val->type = ValueType_BrokenHeart;
}

typedef struct {
    int size;
    int capacity;
    Value *values;
} MemBlock;

static void MemBlock_Init(MemBlock *block) {
    block->capacity = 16;
    block->size = 0;
    block->values = (Value *)malloc(block->capacity * sizeof(Value));
    memset(block->values, 0, block->capacity * sizeof(Value));
}

static void MemBlock_Free(MemBlock *block) {
    int i = 0;
    for (i = 0; i < block->size; i++) {
        Value_FreeStr(&block->values[i]);
    }
    free(block->values);
}

static void MemBlock_Expand(MemBlock *block, int capacity) {
    assert(capacity > block->capacity);
    int oldcapacity = block->capacity;
    block->capacity = capacity;
    block->values = (Value *)realloc(block->values, block->capacity * sizeof(Value));
    memset(block->values + oldcapacity, 0, (block->capacity - oldcapacity) * sizeof(Value));
}

static int MemBlock_Alloc(MemBlock *block) {
    int idx = -1;
    if (block->size < block->capacity) {
        idx = block->size;
        Value *val = &block->values[idx];
        if (val->type == ValueType_String) {
            free((void *)val->str);
        }
        memset(val, 0, sizeof(Value));
        block->size++;
    }
    return idx;
}

typedef struct {
    MemBlock *working;
    MemBlock *free;
    MemBlock blocks[2];
} MemGC;

static void MemGC_Init(MemGC *gc) {
    gc->working = &gc->blocks[0];
    gc->free = &gc->blocks[1];

    MemBlock_Init(gc->working);
    MemBlock_Init(gc->free);

    assert(gc->working->capacity == gc->free->capacity);
}

static void MemGC_Free(MemGC *gc) {
    MemBlock_Free(gc->working);
    MemBlock_Free(gc->free);
}

static int MemGC_Alloc(MemGC *gc) {
    return MemBlock_Alloc(gc->working);
}

static int MemGC_Relocate(MemGC *gc, int idx) {
    Value val = gc->working->values[idx];
    if (val.type == ValueType_BrokenHeart) {
        return val.brokenHeart;
    }

    int freeIdx = MemBlock_Alloc(gc->free);
    assert(freeIdx >= 0);
    gc->working->values[idx].type = ValueType_BrokenHeart;
    gc->working->values[idx].brokenHeart = freeIdx;

    if (val.type == ValueType_Pair) {
        val.pair.car = MemGC_Relocate(gc, val.pair.car);
        val.pair.cdr = MemGC_Relocate(gc, val.pair.cdr);
    } else if (val.type == ValueType_Procedure) {
        val.procedure.val = MemGC_Relocate(gc, val.procedure.val);
        val.procedure.symbol = MemGC_Relocate(gc, val.procedure.symbol);
    }

    gc->free->values[freeIdx] = val;
    return freeIdx;
}

void MemGC_Flip(MemGC *gc) {
    MemBlock *tmp = gc->working;
    gc->working = gc->free;
    gc->free = tmp;
    gc->free->size = 0;

    // 动态扩大 GC 空间
    if (gc->working->size > gc->working->capacity * 0.8) {
        MemBlock_Expand(gc->working, gc->working->capacity * 2);
        MemBlock_Expand(gc->free, gc->free->capacity * 2);
        assert(gc->working->capacity == gc->free->capacity);
    }
}

typedef struct {
    int size;
    int capacity;
    int *values;
} Stack;

void Stack_Init(Stack *stack) {
    stack->size = 0;
    stack->capacity = 512;
    stack->values = (int *)malloc(stack->capacity * sizeof(int));
}

void Stack_Free(Stack *stack) {
    free(stack->values);
}

void Stack_Push(Stack *stack, int val) {
    if (stack->size == stack->capacity) {
        stack->capacity *= 2;
        stack->values = (int *)realloc(stack->values, stack->capacity * sizeof(int));
    }
    stack->values[stack->size] = val;
    stack->size++;
}

int Stack_Pop(Stack *stack) {
    assert(stack->size > 0);
    stack->size--;
    return stack->values[stack->size];
}

struct Register {
    struct Scheme *S;
    int val;
    struct Register *next;
    struct Register *prev;
};

static void init_list(struct Register *head) {
    head->next = head;
    head->prev = head;
}

static void list_add(struct Register *head, struct Register *node) {
    node->next = head->next;
    node->prev = head;
    head->next->prev = node;
    head->next = node;
}

static void delink(struct Register *node) {
    struct Register *next = node->next;
    node->prev->next = next;
    next->prev = node->prev;
}

static void list_free(struct Register *lst) {
    struct Register *iter = lst->next;
    while (iter != lst) {
        struct Register *node = iter;
        iter = iter->next;
        free(node);
    }
}

static int list_size(struct Register *lst) {
    int size = 0;
    struct Register *iter = lst->next;
    while (iter != lst) {
        size++;
        iter = iter->next;
    }
    return size;
}

struct Scheme {
    MemGC gc;
    Stack stack;
    SymbolTable symbolTable; // 符号表
    struct Register workingRegs;
    struct Register freeRegs;
    struct Register globalEnv;
    struct {
        char *begin;
        char *current;
    } readCache;
    int nullValue;                           // 复用 nullValue
    DisplayPrimitive displayPrimitiveHander; // 用于打印原生的过程
    struct {
        void *userdata;
        ErrorHandler handler;
    } errorInfo;
    Reg *evalReg;
};

static Value *Scheme_AllocValue(Scheme *s, int *pidx);
Scheme *scheme_alloc() {
    Scheme *s = (Scheme *)malloc(sizeof(Scheme));
    MemGC_Init(&s->gc);
    Stack_Init(&s->stack);
    SymbolTable_Init(&s->symbolTable);
    init_list(&s->workingRegs);
    init_list(&s->freeRegs);
    memset(&s->globalEnv, 0, sizeof(struct Register));
    s->globalEnv.S = s;

    s->readCache.begin = NULL;
    s->readCache.current = NULL;
    s->displayPrimitiveHander = NULL;
    s->errorInfo.userdata = NULL;
    s->errorInfo.handler = NULL;

    Value *val = Scheme_AllocValue(s, &s->nullValue);
    val->type = ValueType_Null;

    s->evalReg = NULL;
    return s;
}

void scheme_free(Scheme *s) {
    MemGC_Free(&s->gc);
    Stack_Free(&s->stack);
    SymbolTable_Free(&s->symbolTable);

    list_free(&s->freeRegs);
    list_free(&s->workingRegs);

    if (s->readCache.begin) {
        free(s->readCache.begin);
    }

    free(s);
}

void reset_scheme(Scheme *s) {
    // 回收堆栈
    s->stack.size = 0;

    // 回收寄存器
    while (s->workingRegs.next != &s->workingRegs) {
        Reg *reg = s->workingRegs.next;
        delink(reg);
        list_add(&s->freeRegs, reg);
    }

    if (s->readCache.begin) {
        free(s->readCache.begin);
        s->readCache.begin = NULL;
        s->readCache.current = NULL;
    }
}

Reg *set_eval_env(Scheme *s, Reg *newEnv) {
    Reg *oldReg = s->evalReg;
    s->evalReg = newEnv;
    return oldReg;
}

Reg *eval_env(Scheme *s) {
    return s->evalReg;
}

void display_scheme_state(Scheme *s) {
    printf("stack size: %d\n", s->stack.size);
    printf("regs working: %d\n", list_size(&s->workingRegs));
    printf("regs free: %d\n", list_size(&s->freeRegs));
}

void set_error_handler(Scheme *S, void *userdata, ErrorHandler handler) {
    S->errorInfo.userdata = userdata;
    S->errorInfo.handler = handler;
}

void set_display_primitive_hander(Scheme *S, DisplayPrimitive handler) {
    S->displayPrimitiveHander = handler;
}

Reg *global_env(Scheme *s) {
    return &s->globalEnv;
}

static Value *Scheme_GetValue(Scheme *s, int idx) {
    return &s->gc.working->values[idx];
}

static Value *Scheme_AllocValue(Scheme *s, int *pidx) {
    int i = 0;
    int valIdx = MemGC_Alloc(&s->gc);
    if (valIdx < 0) {
        // 分配不了，触发 GC 过程
        s->nullValue = MemGC_Relocate(&s->gc, s->nullValue);
        s->globalEnv.val = MemGC_Relocate(&s->gc, s->globalEnv.val);

        for (i = 0; i < s->stack.size; i++) {
            s->stack.values[i] = MemGC_Relocate(&s->gc, s->stack.values[i]);
        }

        struct Register *iter = s->workingRegs.next;
        while (iter != &s->workingRegs) {
            iter->val = MemGC_Relocate(&s->gc, iter->val);
            iter = iter->next;
        }

        MemGC_Flip(&s->gc);
        valIdx = MemGC_Alloc(&s->gc);
        assert(valIdx >= 0);
    }
    *pidx = valIdx;
    return &s->gc.working->values[valIdx];
}

Reg *reg_alloc(Scheme *s) {
    struct Register *reg = s->freeRegs.next;
    if (reg == &s->freeRegs) {
        reg = malloc(sizeof(struct Register));
        reg->S = s;
        reg->val = 0;
        list_add(&s->workingRegs, reg);
    } else {
        delink(reg);
        list_add(&s->workingRegs, reg);
    }
    return reg;
}

void reg_free(Reg *reg) {
    assert(reg != &reg->S->globalEnv);
    Scheme *s = reg->S;
    delink(reg);
    list_add(&s->freeRegs, reg);
}

Scheme *get_scheme(Reg *reg) {
    return reg->S;
}

void makeVoid(Reg *reg) {
    Value *val = Scheme_AllocValue(reg->S, &reg->val);
    val->type = ValueType_Void;
}

Reg *null(Reg *reg) {
    reg->val = reg->S->nullValue;
    return reg;
}

Reg *symbol(Reg *reg, const char *symbol) {
    Value *val = Scheme_AllocValue(reg->S, &reg->val);
    val->type = ValueType_Symbol;
    val->symbol = SymbolTable_Alloc(&reg->S->symbolTable, symbol);
    return reg;
}

Reg *str(Reg *reg, const char *str) {
    Value *val = Scheme_AllocValue(reg->S, &reg->val);
    val->type = ValueType_String;
    val->str = strdup(str);
    return reg;
}

Reg *boolean(Reg *reg, int boolean) {
    Value *val = Scheme_AllocValue(reg->S, &reg->val);
    val->type = ValueType_Boolean;
    val->boolean = boolean ? 1 : 0;
    return reg;
}

Reg *number(Reg *reg, double number) {
    Value *val = Scheme_AllocValue(reg->S, &reg->val);
    val->type = ValueType_Number;
    val->number = number;
    return reg;
}

Reg *primitive(Reg *reg, Primitive proc) {
    Value *val = Scheme_AllocValue(reg->S, &reg->val);
    val->type = ValueType_Primitive;
    val->primitive = proc;
    return reg;
}

Reg *procedure(Reg *reg, Reg *lst) {
    int valIdx = 0;
    Scheme *S = reg->S;
    Value *val = Scheme_AllocValue(S, &valIdx);
    val->type = ValueType_Procedure;
    val->procedure.val = lst->val;
    val->procedure.symbol = S->nullValue;
    reg->val = valIdx; // 最后设置，预防 reg 和 lst 相同
    return reg;
}

Reg *label(Reg *reg, void *label) {
    Value *val = Scheme_AllocValue(reg->S, &reg->val);
    val->type = ValueType_Label;
    val->label = label;
    return reg;
}

static ValueType getValueType(Reg *reg) {
    Value *val = Scheme_GetValue(reg->S, reg->val);
    return val->type;
}

int is_null(Reg *reg) {
    return getValueType(reg) == ValueType_Null;
}

int is_symbol(Reg *reg) {
    return getValueType(reg) == ValueType_Symbol;
}

int is_string(Reg *reg) {
    return getValueType(reg) == ValueType_String;
}

int is_boolean(Reg *reg) {
    return getValueType(reg) == ValueType_Boolean;
}

int is_number(Reg *reg) {
    return getValueType(reg) == ValueType_Number;
}

int is_pair(Reg *reg) {
    return getValueType(reg) == ValueType_Pair;
}

int is_primitive(Reg *reg) {
    return getValueType(reg) == ValueType_Primitive;
}

int is_procedure(Reg *reg) {
    return getValueType(reg) == ValueType_Procedure;
}

const char *symbol_get(Reg *reg) {
    Value *val = Scheme_GetValue(reg->S, reg->val);
    assert(val->type == ValueType_Symbol);
    return val->symbol;
}

const char *string_get(Reg *reg) {
    Value *val = Scheme_GetValue(reg->S, reg->val);
    assert(val->type == ValueType_String);
    return val->str;
}

int boolean_get(Reg *reg) {
    Value *val = Scheme_GetValue(reg->S, reg->val);
    assert(val->type == ValueType_Boolean);
    return val->boolean;
}

double number_get(Reg *reg) {
    Value *val = Scheme_GetValue(reg->S, reg->val);
    assert(val->type == ValueType_Number);
    return val->number;
}

Primitive primitive_get(Reg *reg) {
    Value *val = Scheme_GetValue(reg->S, reg->val);
    assert(val->type == ValueType_Primitive);
    return val->primitive;
}

void *label_get(Reg *reg) {
    Value *val = Scheme_GetValue(reg->S, reg->val);
    assert(val->type == ValueType_Label);
    return val->label;
}

void procedure_set_symbol(Reg *symbol, Reg *procedure) {
    Value *procVal = Scheme_GetValue(procedure->S, procedure->val);
    procVal->procedure.symbol = symbol->val;
}

Reg *procedure_get(Reg *result, Reg *procedure) {
    Value *val = Scheme_GetValue(procedure->S, procedure->val);
    result->val = val->procedure.val;
    return result;
}

Reg *cons(Reg *reg, Reg *car, Reg *cdr) {
    int valIdx = 0;
    Value *val = Scheme_AllocValue(reg->S, &valIdx);
    val->type = ValueType_Pair;
    val->pair.car = car->val;
    val->pair.cdr = cdr->val;
    reg->val = valIdx; // 最后设置，预防 reg 和 car 或 cdr 相同
    return reg;
}

Reg *car(Reg *reg, Reg *pair) {
    Value *val = Scheme_GetValue(pair->S, pair->val);
    reg->val = val->pair.car;
    return reg;
}

Reg *cdr(Reg *reg, Reg *pair) {
    Value *val = Scheme_GetValue(pair->S, pair->val);
    reg->val = val->pair.cdr;
    return reg;
}

Reg *assign(Reg *reg, Reg *exp) {
    reg->val = exp->val;
    return reg;
}

void set_car(Reg *reg, Reg *car) {
    Value *val = Scheme_GetValue(reg->S, reg->val);
    val->pair.car = car->val;
}

void set_cdr(Reg *reg, Reg *cdr) {
    Value *val = Scheme_GetValue(reg->S, reg->val);
    val->pair.cdr = cdr->val;
}

int is_eq(Reg *r0, Reg *r1) {
    Value *v0 = Scheme_GetValue(r0->S, r0->val);
    Value *v1 = Scheme_GetValue(r1->S, r1->val);
    return memcmp(v0, v1, sizeof(Value)) == 0;
}

void save(Reg *reg) {
    Stack_Push(&reg->S->stack, reg->val);
}

Reg *restore(Reg *reg) {
    reg->val = Stack_Pop(&reg->S->stack);
    return reg;
}

static void displayValue(Scheme *S, int idx, int showBrace) {
    Value *val = Scheme_GetValue(S, idx);
    switch (val->type) {
        case ValueType_Null:
            printf("()");
            break;

        case ValueType_Boolean:
            printf("%s", val->boolean ? "#t" : "#f");
            break;

        case ValueType_Number:
            printf("%g", val->number);
            break;

        case ValueType_Symbol:
            printf("%s", val->symbol);
            break;

        case ValueType_String:
            printf("%s", val->str);
            break;

        case ValueType_Primitive:
            if (S->displayPrimitiveHander) {
                S->displayPrimitiveHander(val->primitive);
            } else {
                printf("#<primitive:%p>", val->primitive);
            }
            break;

        case ValueType_Procedure: {
            Value *symbol = Scheme_GetValue(S, val->procedure.symbol);
            if (symbol->type == ValueType_Symbol) {
                printf("#<procedure:%s>", symbol->symbol);
            } else {
                printf("#<procedure>");
            }
        } break;

        case ValueType_Void:
            printf("#<void>");
            break;

        case ValueType_Pair: {
            if (showBrace) {
                printf("(");
            }
            displayValue(S, val->pair.car, 1);
            Value *cdr = Scheme_GetValue(S, val->pair.cdr);
            if (cdr->type == ValueType_Null) {
                // nothing
            } else if (cdr->type == ValueType_Pair) {
                printf(" ");
                displayValue(S, val->pair.cdr, 0);
            } else {
                printf(" . ");
                displayValue(S, val->pair.cdr, 0);
            }

            if (showBrace) {
                printf(")");
            }
        } break;

        default:
            printf("unkown");
            break;
    }
}

void display(Reg *reg) {
    displayValue(reg->S, reg->val, 1);
}

void newline(void) {
    printf("\n");
}

void displayln(Reg *reg) {
    display(reg);
    newline();
}

void displayln2(Reg *reg, int showVoid) {
    Value *val = Scheme_GetValue(reg->S, reg->val);
    if (val->type == ValueType_Void && !showVoid) {
        return;
    }
    displayln(reg);
}

typedef struct {
    const char *current;
} Parser;

static char advanceAndPeek(Parser *P) {
    P->current++;
    return *P->current;
}

static void skipWhitespace(Parser *P) {
    char peek = *P->current;
    while (isspace(peek) || peek == ';') {
        // 跳过注释
        if (peek == ';') {
            peek = advanceAndPeek(P);
            while (peek != '\n') {
                peek = advanceAndPeek(P);
            }
            peek = advanceAndPeek(P);
        } else {
            peek = advanceAndPeek(P);
        }
    }
}

static Reg *parseExp(Parser *P, Reg *reg);
static Reg *parseList(Parser *P, Reg *reg) {
    skipWhitespace(P);
    char peek = *P->current;
    if (peek == ')') {
        P->current++;
        return null(reg);
    }

    if (!parseExp(P, reg)) { // car
        return NULL;
    }

    save(reg);
    skipWhitespace(P);

    if (!parseList(P, reg)) { // cdr
        restore(reg);
        return NULL;
    }

    Reg *tmp = reg_alloc(reg->S);
    assign(tmp, reg); // cdr
    restore(reg);     // car
    cons(reg, reg, tmp);
    reg_free(tmp);
    return reg;
}

static int isNumberChar(int c) {
    return isdigit(c) || c == '.' || c == '+' || c == '-';
}

#define MAX_TOKEN_LENGTH 128

static Reg *parseNumber(Parser *P, Reg *reg) {
    char buffer[MAX_TOKEN_LENGTH + 1];
    int digitCount = 0;
    int dotCount = 0;
    int signCount = 0;
    int i = 0;

    char peek = *P->current;
    while (isNumberChar(peek)) {
        if (i < MAX_TOKEN_LENGTH) {
            buffer[i++] = peek;
        }
        if (peek == '+' || peek == '-') {
            signCount++;
        } else if (peek == '.') {
            dotCount++;
        } else {
            digitCount++;
        }
        peek = advanceAndPeek(P);
    }
    buffer[i] = 0;
    if (digitCount == 0 || dotCount > 1 || signCount > 1) {
        return symbol(reg, buffer);
    } else {
        return number(reg, atof(buffer));
    }
}

static Reg *parseQuote(Parser *P, Reg *reg) {
    if (parseExp(P, reg)) {
        Reg *tmp = reg_alloc(reg->S);
        cons(reg, reg, null(tmp));
        cons(reg, symbol(tmp, "quote"), reg);
        reg_free(tmp);
        return reg;
    }
    return NULL;
}

static Reg *parseStr(Parser *P, Reg *reg) {
    char buffer[MAX_TOKEN_LENGTH + 1];
    int i = 0;
    char peek = *P->current;
    while (peek != '\"' && peek != 0) {
        if (i < MAX_TOKEN_LENGTH) {
            buffer[i++] = peek;
        }
        peek = advanceAndPeek(P);
    }
    if (peek != '\"') {
        return NULL;
    }
    P->current++;
    buffer[i] = 0;
    return str(reg, buffer);
}

static Reg *parseSymbol(Parser *P, Reg *reg) {
    char buffer[MAX_TOKEN_LENGTH + 1];
    int i = 0;

    char peek = *P->current;
    while (!isspace(peek) && peek != ')' && peek != 0) {
        if (i < MAX_TOKEN_LENGTH) {
            buffer[i++] = peek;
        }
        peek = advanceAndPeek(P);
    }

    if (i == 0) {
        return NULL;
    }

    buffer[i] = 0;
    if (strcmp(buffer, "#t") == 0) {
        boolean(reg, 1);
    } else if (strcmp(buffer, "#f") == 0) {
        boolean(reg, 0);
    } else {
        symbol(reg, buffer);
    }
    return reg;
}

static Reg *parseExp(Parser *P, Reg *reg) {
    skipWhitespace(P);
    char peek = *P->current;
    if (peek == '(') {
        P->current++;
        return parseList(P, reg);
    } else if (peek == '\'') {
        P->current++;
        return parseQuote(P, reg);
    } else if (peek == '\"') {
        P->current++;
        return parseStr(P, reg);
    } else if (isNumberChar(peek)) {
        return parseNumber(P, reg);
    } else {
        return parseSymbol(P, reg);
    }
}

Reg *parse(Reg *result, const char *str, int *pos) {
    Parser P;
    P.current = str;
    Reg *ret = parseExp(&P, result);
    skipWhitespace(&P);
    if (pos) {
        *pos = (int)(P.current - str);
    }
    return ret;
}

#define MAX_LINE_LENGTH 1024

static int is_str_empty(const char *str) {
    return str == NULL || *str == 0;
}

Reg *read(Reg *result) {
    Scheme *S = get_scheme(result);
    char line[MAX_LINE_LENGTH + 1];
    for (;;) {
        if (S->readCache.current != NULL) {
            int pos = 0;
            if (parse(result, S->readCache.current, &pos)) {
                S->readCache.current += pos;
                return result;
            }
        }

        if (is_str_empty(S->readCache.current)) {
            printf("> ");
        } else {
            printf(">> ");
        }

        if (!fgets(line, MAX_LINE_LENGTH, stdin)) {
            error(S, "Line too long", 0);
            return NULL;
        }

        if (S->readCache.current == NULL) {
            S->readCache.begin = strdup(line);
            S->readCache.current = S->readCache.begin;
        } else {
            assert(S->readCache.begin);

            size_t cacheLen = strlen(S->readCache.current);
            char *str = malloc(strlen(line) + cacheLen + 1);
            strcpy(str, S->readCache.current);
            strcat(str + cacheLen, line);

            free(S->readCache.begin);
            S->readCache.begin = str;
            S->readCache.current = S->readCache.begin;
        }
    }
    return result;
}

static void onErrorHandler(Scheme *S) {
    if (S->errorInfo.handler) {
        S->errorInfo.handler(S, S->errorInfo.userdata);
    } else {
        exit(0);
    }
}

void errorList(Scheme *S, int reg_count, Reg **list) {
    int i = 0;
    for (i = 0; i < reg_count; i++) {
        Reg *reg = list[i];
        display(reg);
        printf(" ");
    }
    printf("\n");
    onErrorHandler(S);
}

void error(Scheme *S, const char *msg, int reg_count, ...) {
    printf("%s ", msg);
    va_list args;
    va_start(args, reg_count);
    int i = 0;
    for (i = 0; i < reg_count; i++) {
        Reg *reg = va_arg(args, Reg *);
        display(reg);
        printf(" ");
    }
    va_end(args);
    printf("\n");
    onErrorHandler(S);
}
