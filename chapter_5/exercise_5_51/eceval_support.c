// 对应 ch5-eceval-support.scm

#include "eceval_support.h"
#include "prime_libs.h"
#include <stdarg.h>
#include <string.h>

int is_true(Reg *x) {
    return !is_false(x);
}

int is_false(Reg *x) {
    return is_boolean(x) && boolean_get(x) == 0;
}

void make_procedure(Reg *result, Reg *parameters, Reg *body, Reg *env) {
    Scheme *S = get_scheme(body);
    Reg *tmp = reg_alloc(S);
    null(tmp);
    cons(tmp, env, tmp);
    cons(tmp, body, tmp);
    cons(tmp, parameters, tmp);
    procedure(result, tmp);
    reg_free(tmp);
}

int is_compound_procedure(Reg *proc) {
    return is_procedure(proc);
}

void procedure_parameters(Reg *result, Reg *p) {
    procedure_get(result, p);
    car(result, result);
}

void procedure_body(Reg *result, Reg *p) {
    procedure_get(result, p);
    cadr(result, result);
}

void procedure_environment(Reg *result, Reg *p) {
    procedure_get(result, p);
    caddr(result, result);
}

static Reg *enclosing_environment(Reg *result, Reg *env) {
    return cdr(result, env);
}

static Reg *first_frame(Reg *result, Reg *env) {
    return car(result, env);
}

static Reg *make_frame(Reg *result, Reg *variables, Reg *values) {
    return cons(result, variables, values);
}

static Reg *frame_variables(Reg *result, Reg *frame) {
    return car(result, frame);
}

static Reg *frame_values(Reg *result, Reg *frame) {
    return cdr(result, frame);
}

static void add_binding_to_frame(Reg *var, Reg *val, Reg *frame) {
    Scheme *S = get_scheme(frame);
    Reg *tmp[2];
    reg_alloc_array(S, tmp);

    set_car(frame, cons(tmp[0], var, car(tmp[1], frame)));
    set_cdr(frame, cons(tmp[0], val, cdr(tmp[1], frame)));

    reg_free_array(tmp);
}

void extend_environment(Reg *result, Reg *vars, Reg *vals, Reg *base_env) {
    Scheme *S = get_scheme(result);
    int varsLen = length(vars);
    int valsLen = length(vals);
    if (varsLen == valsLen) {
        Reg *tmp = reg_alloc(S);
        cons(result, make_frame(tmp, vars, vals), base_env);
        reg_free(tmp);
    } else if (varsLen < valsLen) {
        error(S, "Too many arguments supplied", 2, vars, vals);
    } else {
        error(S, "Too few arguments supplied", 2, vars, vals);
    }
}

int is_primitive_procedure(Reg *proc) {
    return is_primitive(proc);
}

void apply_primitive_procedure(Reg *result, Reg *proc, Reg *args) {
    Primitive p = primitive_get(proc);
    (*p)(result, args);
}

void define_variable(Reg *var, Reg *val, Reg *env) {
    Scheme *S = get_scheme(env);
    Reg *frame = reg_alloc(S);
    Reg *vars = reg_alloc(S);
    Reg *vals = reg_alloc(S);
    Reg *tmp = reg_alloc(S);

    first_frame(frame, env);
    frame_variables(vars, frame);
    frame_values(vals, frame);

    for (;;) {
        if (is_null(vars)) {
            add_binding_to_frame(var, val, frame);
            break;
        } else if (is_eq(var, car(tmp, vars))) {
            set_car(vals, val);
            break;
        }
        cdr(vars, vars);
        cdr(vals, vals);
    }

    if (is_procedure(val)) {
        procedure_set_symbol(var, val);
    }

    reg_free(tmp);
    reg_free(frame);
    reg_free(vars);
    reg_free(vals);
}

void lookup_variable_value(Reg *result, Reg *var, Reg *env) {
    Scheme *S = get_scheme(env);
    Reg *frame = reg_alloc(S);
    Reg *vars = reg_alloc(S);
    Reg *vals = reg_alloc(S);
    Reg *tmp = reg_alloc(S);
    save(env);

    for (;;) {
        if (is_null(env)) {
            error(S, "Unbound variable:", 1, var);
            break;
        }
        first_frame(frame, env);
        frame_variables(vars, frame);
        frame_values(vals, frame);

        while (!is_null(vars)) {
            if (is_eq(var, car(tmp, vars))) {
                car(result, vals);
                goto lookup_done;
            }
            cdr(vars, vars);
            cdr(vals, vals);
        }
        enclosing_environment(env, env);
    }

lookup_done:
    restore(env);
    reg_free(tmp);
    reg_free(frame);
    reg_free(vars);
    reg_free(vals);
}

void set_variable_value(Reg *var, Reg *val, Reg *env) {
    Scheme *S = get_scheme(env);
    Reg *frame = reg_alloc(S);
    Reg *vars = reg_alloc(S);
    Reg *vals = reg_alloc(S);
    Reg *tmp = reg_alloc(S);
    save(env);

    for (;;) {
        if (is_null(env)) {
            error(S, "Unbound variable -- SET!", 1, var);
            break;
        }
        first_frame(frame, env);
        frame_variables(vars, frame);
        frame_values(vals, frame);

        while (!is_null(vars)) {
            if (is_eq(var, car(tmp, vars))) {
                set_car(vals, val);
                goto set_done;
            }
            cdr(vars, vars);
            cdr(vals, vals);
        }
        enclosing_environment(env, env);
    }

set_done:
    restore(env);
    reg_free(tmp);
    reg_free(frame);
    reg_free(vars);
    reg_free(vals);
}

void setup_environment(Reg *env) {
    Scheme *S = get_scheme(env);
    Reg *args[3];
    reg_alloc_array(S, args);

    extend_environment(env, null(args[0]), null(args[1]), null(args[2]));
    int i = 0;
    int size = 0;
    struct PrimitiveProc *procs = get_primitive_procedures(&size);
    for (i = 0; i < size; i++) {
        define_variable(symbol(args[0], procs[i].symbol), primitive(args[1], procs[i].proc), env);
    }

    define_variable(symbol(args[0], "true"), boolean(args[1], 1), env);
    define_variable(symbol(args[0], "false"), boolean(args[1], 0), env);
    define_variable(symbol(args[0], "null"), null(args[1]), env);

    reg_free_array(args);
}

void empty_arglist(Reg *result) {
    null(result);
}

void adjoin_arg(Reg *result, Reg *arg, Reg *arglist) {
    Scheme *S = get_scheme(result);
    Reg *tmp = reg_alloc(S);
    append(result, arglist, cons(tmp, arg, null(tmp)));
    reg_free(tmp);
}

int is_last_operand(Reg *ops) {
    save(ops);
    cdr(ops, ops);
    int ret = is_null(ops);
    restore(ops);
    return ret;
}

int is_no_more_exps(Reg *seq) {
    return is_null(seq);
}

void make_compiled_procedure(Reg *result, Reg *entry, Reg *env) {
    Scheme *S = get_scheme(result);
    Reg *tmp = reg_alloc(S);
    null(tmp);
    cons(tmp, env, tmp);
    cons(tmp, entry, tmp);
    cons(result, symbol(result, "compiled-procedure"), tmp);
    reg_free(tmp);
}

void compiled_procedure_entry(Reg *result, Reg *proc) {
    cadr(result, proc);
}

void compiled_procedure_env(Reg *result, Reg *proc) {
    caddr(result, proc);
}

Reg *symbol_list(Reg *result, int reg_count, ...) {
    Scheme *S = get_scheme(result);
    Reg *tmp = reg_alloc(S);

    null(result);
    va_list args;
    va_start(args, reg_count);
    int i = 0;
    for (i = 0; i < reg_count; i++) {
        const char *str = va_arg(args, const char *);
        cons(result, symbol(tmp, str), result);
    }
    va_end(args);
    reg_free(tmp);
    reverse(result, result);
    return result;
}
