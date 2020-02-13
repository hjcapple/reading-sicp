// 实现 Scheme 的运行时环境，包含一个很简单的 GC。

#ifndef __SCHEME_RUNTIME_H__
#define __SCHEME_RUNTIME_H__

typedef struct Scheme Scheme;
typedef struct Register Reg;

typedef void (*Primitive)(Reg *result, Reg *args);
typedef void (*DisplayPrimitive)(Primitive proc);
typedef void (*ErrorHandler)(Scheme *S, void *userdata);

Scheme *scheme_alloc(void);
void scheme_free(Scheme *s);

void reset_scheme(Scheme *s);
Reg *set_eval_env(Scheme *s, Reg *newEnv);
Reg *eval_env(Scheme *s);

void display_scheme_state(Scheme *s);
void set_display_primitive_hander(Scheme *S, DisplayPrimitive handler);
void set_error_handler(Scheme *S, void *userdata, ErrorHandler handler);

Reg *global_env(Scheme *s);

Reg *reg_alloc(Scheme *s);
void reg_free(Reg *reg);

#define reg_alloc_array(S, regs)                               \
    do {                                                       \
        int i = 0;                                             \
        for (i = 0; i < sizeof(regs) / sizeof(regs[0]); i++) { \
            regs[i] = reg_alloc(S);                            \
        }                                                      \
    } while (0)

#define reg_free_array(regs)                                   \
    do {                                                       \
        int i = 0;                                             \
        for (i = 0; i < sizeof(regs) / sizeof(regs[0]); i++) { \
            reg_free(regs[i]);                                 \
        }                                                      \
    } while (0)

Scheme *get_scheme(Reg *reg);

void makeVoid(Reg *reg);
Reg *null(Reg *reg);
Reg *symbol(Reg *reg, const char *symbol);
Reg *str(Reg *reg, const char *str);
Reg *boolean(Reg *reg, int boolean);
Reg *number(Reg *reg, double number);
Reg *primitive(Reg *reg, Primitive proc);
Reg *procedure(Reg *reg, Reg *lst);
Reg *label(Reg *reg, void *label);

int is_null(Reg *reg);
int is_symbol(Reg *reg);
int is_string(Reg *reg);
int is_boolean(Reg *reg);
int is_number(Reg *reg);
int is_pair(Reg *reg);
int is_primitive(Reg *reg);
int is_procedure(Reg *reg);

const char *symbol_get(Reg *reg);
const char *string_get(Reg *reg);
int boolean_get(Reg *reg);
double number_get(Reg *reg);
Primitive primitive_get(Reg *reg);
void *label_get(Reg *reg);

void procedure_set_symbol(Reg *symbol, Reg *procedure);
Reg *procedure_get(Reg *result, Reg *procedure);

Reg *cons(Reg *reg, Reg *car, Reg *cdr);
Reg *car(Reg *reg, Reg *pair);
Reg *cdr(Reg *reg, Reg *pair);
Reg *assign(Reg *reg, Reg *exp);

void set_car(Reg *reg, Reg *car);
void set_cdr(Reg *reg, Reg *cdr);

int is_eq(Reg *r0, Reg *r1);

void save(Reg *reg);
Reg *restore(Reg *reg);

void display(Reg *reg);
void displayln(Reg *reg);
void displayln2(Reg *reg, int showVoid);
void newline(void);

Reg *read(Reg *result);
Reg *parse(Reg *result, const char *str, int *pos);

void errorList(Scheme *S, int reg_count, Reg **list);
void error(Scheme *S, const char *msg, int reg_count, ...);

#endif
