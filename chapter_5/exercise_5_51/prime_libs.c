#include "prime_libs.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

Reg *cadr(Reg *reg, Reg *pair) {
    return car(reg, cdr(reg, pair));
}

Reg *cddr(Reg *reg, Reg *pair) {
    return cdr(reg, cdr(reg, pair));
}

Reg *caddr(Reg *reg, Reg *pair) {
    return car(reg, cdr(reg, cdr(reg, pair)));
}

Reg *caadr(Reg *reg, Reg *pair) {
    return car(reg, car(reg, cdr(reg, pair)));
}

Reg *cdadr(Reg *reg, Reg *pair) {
    return cdr(reg, car(reg, cdr(reg, pair)));
}

Reg *cdddr(Reg *reg, Reg *pair) {
    return cdr(reg, cdr(reg, cdr(reg, pair)));
}

Reg *cadddr(Reg *reg, Reg *pair) {
    return car(reg, cdr(reg, cdr(reg, cdr(reg, pair))));
}

void apply(Reg *val, Reg *proc, Reg *args);
void for_each(Reg *args, void *userdata, void (*callback)(void *userdata, Reg *item)) {
    Scheme *S = get_scheme(args);
    Reg *iter = reg_alloc(S);
    Reg *tmp = reg_alloc(S);

    assign(iter, args);
    while (!is_null(iter)) {
        callback(userdata, car(tmp, iter));
        cdr(iter, iter);
    }

    reg_free(iter);
    reg_free(tmp);
}

static void prime_list(Reg *result, Reg *args) {
    assign(result, args);
}

static void append_callback(void *userdata, Reg *lst) {
    Reg *result = userdata;
    append(result, result, lst);
}

static void prime_append(Reg *result, Reg *args) {
    null(result);
    for_each(args, result, append_callback);
}

static void prime_cons(Reg *result, Reg *args) {
    Scheme *S = get_scheme(result);
    Reg *tmp[2];
    reg_alloc_array(S, tmp);
    cons(result, car(tmp[0], args), cadr(tmp[1], args));
    reg_free_array(tmp);
}

static void prime_car(Reg *result, Reg *args) {
    car(result, car(result, args));
}

static void prime_set_car(Reg *result, Reg *args) {
    Scheme *S = get_scheme(args);
    Reg *tmp[2];
    reg_alloc_array(S, tmp);
    set_car(car(tmp[0], args), cadr(tmp[1], args));
    reg_free_array(tmp);
    makeVoid(result);
}

static void prime_set_cdr(Reg *result, Reg *args) {
    Scheme *S = get_scheme(args);
    Reg *tmp[2];
    reg_alloc_array(S, tmp);
    set_cdr(car(tmp[0], args), cadr(tmp[1], args));
    reg_free_array(tmp);
    makeVoid(result);
}

static void prime_cdr(Reg *result, Reg *args) {
    cdr(result, car(result, args));
}

static void prime_is_null(Reg *result, Reg *args) {
    int ret = is_null(car(result, args));
    boolean(result, ret);
}

static void prime_is_boolean(Reg *result, Reg *args) {
    int ret = is_boolean(car(result, args));
    boolean(result, ret);
}

static void prime_is_string(Reg *result, Reg *args) {
    int ret = is_string(car(result, args));
    boolean(result, ret);
}

static void prime_is_number(Reg *result, Reg *args) {
    int ret = is_number(car(result, args));
    boolean(result, ret);
}

static void prime_is_symbol(Reg *result, Reg *args) {
    int ret = is_symbol(car(result, args));
    boolean(result, ret);
}

static void prime_is_pair(Reg *result, Reg *args) {
    int ret = is_pair(car(result, args));
    boolean(result, ret);
}

static void prime_is_eq(Reg *result, Reg *args) {
    Scheme *S = get_scheme(args);
    Reg *tmp[2];
    reg_alloc_array(S, tmp);
    boolean(result, is_eq(car(tmp[0], args), cadr(tmp[1], args)));
    reg_free_array(tmp);
}

static void prime_display(Reg *result, Reg *args) {
    display(car(result, args));
    makeVoid(result);
}

static void prime_displayln(Reg *result, Reg *args) {
    displayln(car(result, args));
    makeVoid(result);
}

static void prime_newline(Reg *result, Reg *args) {
    newline();
    makeVoid(result);
}

static void get_numbers(Reg *args, double *a, double *b) {
    Scheme *S = get_scheme(args);
    Reg *tmp = reg_alloc(S);
    *a = number_get(car(tmp, args));
    *b = number_get(cadr(tmp, args));
    reg_free(tmp);
}

static void prime_equal(Reg *result, Reg *args) {
    double a, b;
    get_numbers(args, &a, &b);
    boolean(result, a == b);
}

static void prime_greater(Reg *result, Reg *args) {
    double a, b;
    get_numbers(args, &a, &b);
    boolean(result, a > b);
}

static void prime_greater_eq(Reg *result, Reg *args) {
    double a, b;
    get_numbers(args, &a, &b);
    boolean(result, a >= b);
}

static void prime_less(Reg *result, Reg *args) {
    double a, b;
    get_numbers(args, &a, &b);
    boolean(result, a < b);
}

static void prime_less_eq(Reg *result, Reg *args) {
    double a, b;
    get_numbers(args, &a, &b);
    boolean(result, a <= b);
}

static void prime_remainder(Reg *result, Reg *args) {
    double a, b;
    get_numbers(args, &a, &b);
    number(result, (int)a % (int)b);
}

static void add_callback(void *userdata, Reg *num) {
    double *val = (double *)userdata;
    *val += number_get(num);
}

static void prime_add(Reg *result, Reg *args) {
    double val = 0;
    for_each(args, &val, add_callback);
    number(result, val);
}

struct ArgsInfo {
    int count;
    double val;
};

static void sub_callback(void *userdata, Reg *num) {
    struct ArgsInfo *info = (struct ArgsInfo *)userdata;
    if (info->count == 0) {
        info->val = number_get(num);
    } else {
        info->val -= number_get(num);
    }
    info->count++;
}

static void prime_sub(Reg *result, Reg *args) {
    struct ArgsInfo info;
    info.count = 0;
    info.val = 0;
    for_each(args, &info, sub_callback);
    if (info.count == 1) {
        info.val = -info.val;
    }
    number(result, info.val);
}

static void mul_callback(void *userdata, Reg *num) {
    double *val = (double *)userdata;
    *val *= number_get(num);
}

static void prime_mul(Reg *result, Reg *args) {
    double val = 1;
    for_each(args, &val, mul_callback);
    number(result, val);
}

static void div_callback(void *userdata, Reg *num) {
    struct ArgsInfo *info = (struct ArgsInfo *)userdata;
    if (info->count == 0) {
        info->val = number_get(num);
    } else {
        info->val /= number_get(num);
    }
    info->count++;
}

static void prime_div(Reg *result, Reg *args) {
    struct ArgsInfo info;
    info.count = 0;
    info.val = 1;
    for_each(args, &info, div_callback);
    if (info.count == 1) {
        info.val = 1.0 / info.val;
    }
    number(result, info.val);
}

static void min_callback(void *userdata, Reg *num) {
    struct ArgsInfo *info = (struct ArgsInfo *)userdata;
    if (info->count == 0) {
        info->val = number_get(num);
    } else {
        info->val = fmin(info->val, number_get(num));
    }
    info->count++;
}

static void prime_min(Reg *result, Reg *args) {
    struct ArgsInfo info;
    info.count = 0;
    info.val = 0;
    for_each(args, &info, min_callback);
    number(result, info.val);
}

static void max_callback(void *userdata, Reg *num) {
    struct ArgsInfo *info = (struct ArgsInfo *)userdata;
    if (info->count == 0) {
        info->val = number_get(num);
    } else {
        info->val = fmax(info->val, number_get(num));
    }
    info->count++;
}

static void prime_max(Reg *result, Reg *args) {
    struct ArgsInfo info;
    info.count = 0;
    info.val = 0;
    for_each(args, &info, max_callback);
    number(result, info.val);
}

static void prime_sqrt(Reg *result, Reg *args) {
    double ret = sqrt(number_get(car(result, args)));
    number(result, ret);
}

static void prime_read(Reg *result, Reg *args) {
    read(result);
}

static void prime_apply(Reg *result, Reg *args) {
    Scheme *S = get_scheme(args);
    Reg *tmp[2];
    reg_alloc_array(S, tmp);
    apply(result, car(tmp[0], args), cadr(tmp[1], args));
    reg_free_array(tmp);
}

struct ErrorInfo {
    Reg **tmp;
    int count;
};

static void error_callback(void *userdata, Reg *item) {
    struct ErrorInfo *info = (struct ErrorInfo *)userdata;
    assign(info->tmp[info->count], item);
    info->count++;
}

static void prime_error(Reg *result, Reg *args) {
    Scheme *S = get_scheme(args);
    const int kMaxReg = 16;
    Reg *tmp[kMaxReg];
    int argslen = length(args);
    if (argslen > kMaxReg) {
        argslen = kMaxReg;
    }

    int i = 0;
    for (i = 0; i < argslen; i++) {
        tmp[i] = reg_alloc(S);
    }

    struct ErrorInfo info;
    info.count = 0;
    info.tmp = tmp;
    for_each(args, &info, error_callback);
    errorList(S, argslen, tmp);

    for (i = 0; i < argslen; i++) {
        reg_free(tmp[i]);
    }
}

static void prime_env(Reg *result, Reg *args) {
    Scheme *S = get_scheme(result);
    Reg *env = eval_env(S);
    if (env) {
        assign(result, env);
    } else {
        makeVoid(result);
    }
}

static struct PrimitiveProc primitive_procedures[] = {
    {"list", prime_list},
    {"append", prime_append},
    {"cons", prime_cons},
    {"car", prime_car},
    {"cdr", prime_cdr},
    {"set-car!", prime_set_car},
    {"set-cdr!", prime_set_cdr},
    {"null?", prime_is_null},
    {"eq?", prime_is_eq},
    {"boolean?", prime_is_boolean},
    {"string?", prime_is_string},
    {"number?", prime_is_number},
    {"symbol?", prime_is_symbol},
    {"pair?", prime_is_pair},
    {"display", prime_display},
    {"newline", prime_newline},
    {"displayln", prime_displayln},
    {"read", prime_read},
    {"apply", prime_apply},
    {"error", prime_error},

    {"+", prime_add},
    {"-", prime_sub},
    {"*", prime_mul},
    {"/", prime_div},
    {"remainder", prime_remainder},
    {"min", prime_min},
    {"max", prime_max},
    {"sqrt", prime_sqrt},

    {"=", prime_equal},
    {">", prime_greater},
    {">=", prime_greater_eq},
    {"<", prime_less},
    {"<=", prime_less_eq},
    {"__env", prime_env},
};

struct PrimitiveProc *get_primitive_procedures(int *size) {
    *size = sizeof(primitive_procedures) / sizeof(primitive_procedures[0]);
    return primitive_procedures;
}

void display_primitive(Primitive proc) {
    int size = sizeof(primitive_procedures) / sizeof(primitive_procedures[0]);
    int i = 0;
    for (i = 0; i < size; i++) {
        if (proc == primitive_procedures[i].proc) {
            printf("#<primitive:%s>", primitive_procedures[i].symbol);
            break;
        }
    }
}

/////////////////////
static void length_callback(void *userdata, Reg *item) {
    int *num = (int *)userdata;
    *num += 1;
}

int length(Reg *list) {
    int num = 0;
    for_each(list, &num, length_callback);
    return num;
}

static void __append(Reg *result, Reg *list1, Reg *list2) {
    if (is_null(list1)) {
        assign(result, list2);
    } else {
        save(list1);
        append(result, cdr(list1, list1), list2);
        restore(list1);
        save(list1);
        cons(result, car(list1, list1), result);
        restore(list1);
    }
}

void append(Reg *result, Reg *list1, Reg *list2) {
    Scheme *S = get_scheme(result);
    Reg *args[2];
    reg_alloc_array(S, args);
    __append(result, assign(args[0], list1), assign(args[1], list2));
    reg_free_array(args);
}

static void reverse_callback(void *userdata, Reg *item) {
    Reg *tmp = (Reg *)userdata;
    cons(tmp, item, tmp);
}

void reverse(Reg *result, Reg *list) {
    Scheme *S = get_scheme(result);
    Reg *tmp = reg_alloc(S);
    null(tmp);
    for_each(list, tmp, reverse_callback);
    assign(result, tmp);
    reg_free(tmp);
}
