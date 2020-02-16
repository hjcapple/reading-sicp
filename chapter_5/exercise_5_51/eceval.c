#include "eceval.h"
#include "eceval_support.h"
#include "syntax.h"

static void eval_and(Reg *val, Reg *exp, Reg *env) {
    cdr(exp, exp);
    if (is_null(exp)) {
        boolean(val, 1);
        return;
    }
    for (;;) {
        save(exp);
        save(env);
        first_exp(exp, exp);
        eval(val, exp, env);
        restore(env);
        restore(exp);
        if (is_last_exp(exp)) {
            break;
        } else if (is_true(val)) {
            rest_exp(exp, exp);
        } else {
            boolean(val, 0);
            break;
        }
    }
}

static void eval_or(Reg *val, Reg *exp, Reg *env) {
    cdr(exp, exp);
    if (is_null(exp)) {
        boolean(val, 0);
        return;
    }
    for (;;) {
        save(exp);
        save(env);
        first_exp(exp, exp);
        eval(val, exp, env);
        restore(env);
        restore(exp);
        if (is_last_exp(exp)) {
            break;
        } else if (is_true(val)) {
            break;
        } else {
            rest_exp(exp, exp);
        }
    }
}

static void meta_syntax(Reg *result, const char *name, Reg *exp, Reg *env) {
    Scheme *S = get_scheme(result);
    Reg *args = reg_alloc(S);
    Reg *proc = reg_alloc(S);
    lookup_variable_value(proc, symbol(args, name), env);

    null(args);
    cons(args, exp, args);
    apply(result, proc, args);

    reg_free(args);
    reg_free(proc);
}

// 翻译自 SICP 5.4 节的求值器，所以写得有点奇怪
void eval(Reg *val, Reg *exp, Reg *env) {
    Scheme *S = get_scheme(val);
    Reg *proc = reg_alloc(S);
    Reg *argl = reg_alloc(S);
    Reg *unev = reg_alloc(S);
    Reg *continue_ = reg_alloc(S);
    label(continue_, &&eval_done);
    Reg *oldEvalEnv = set_eval_env(S, env);

    save(exp);
    save(env);

eval_dispatch:
    if (is_self_evaluating(exp)) {
        goto ev_self_eval;
    }
    if (is_variable(exp)) {
        goto ev_variable;
    }
    if (is_quoted(exp)) {
        goto ev_quoted;
    }
    if (is_assignment(exp)) {
        goto ev_assignment;
    }
    if (is_definition(exp)) {
        goto ev_definition;
    }
    if (is_if(exp)) {
        goto ev_if;
    }
    if (is_lambda(exp)) {
        goto ev_lambda;
    }
    if (is_begin(exp)) {
        goto ev_begin;
    }
    if (is_and(exp)) {
        eval_and(val, exp, env);
        goto *label_get(continue_);
    }
    if (is_or(exp)) {
        eval_or(val, exp, env);
        goto *label_get(continue_);
    }
    if (is_cond(exp)) {
        cond_to_if(exp, exp);
        goto eval_dispatch;
    }
    if (is_let(exp)) {
        let_to_combination(exp, exp);
        goto eval_dispatch;
    }
    if (is_tagged_list(exp, "let*")) {
        meta_syntax(exp, "meta-syntax-let*->nested-lets", exp, env);
        goto eval_dispatch;
    }
    if (is_application(exp)) {
        goto ev_application;
    }
    error(S, "Unknown expression type:", 1, exp);
    goto *label_get(continue_);

ev_self_eval:
    assign(val, exp);
    goto *label_get(continue_);
ev_variable:
    lookup_variable_value(val, exp, env);
    goto *label_get(continue_);
ev_quoted:
    text_of_quotation(val, exp);
    goto *label_get(continue_);
ev_lambda:
    lambda_parameters(unev, exp);
    lambda_body(exp, exp);
    make_procedure(val, unev, exp, env);
    goto *label_get(continue_);

ev_application:
    save(continue_);
    save(env);
    operands(unev, exp);
    save(unev);
    operator_(exp, exp);
    label(continue_, &&ev_appl_did_operator);
    goto eval_dispatch;
ev_appl_did_operator:
    restore(unev);
    restore(env);
    empty_arglist(argl);
    assign(proc, val);
    if (is_no_operands(unev)) {
        goto apply_dispatch;
    }
    save(proc);
ev_appl_operand_loop:
    save(argl);
    first_operand(exp, unev);
    if (is_last_operand(unev)) {
        goto ev_appl_last_arg;
    }
    save(env);
    save(unev);
    label(continue_, &&ev_appl_accumulate_arg);
    goto eval_dispatch;
ev_appl_accumulate_arg:
    restore(unev);
    restore(env);
    restore(argl);
    adjoin_arg(argl, val, argl);
    rest_operands(unev, unev);
    goto ev_appl_operand_loop;
ev_appl_last_arg:
    label(continue_, &&ev_appl_accum_last_arg);
    goto eval_dispatch;
ev_appl_accum_last_arg:
    restore(argl);
    adjoin_arg(argl, val, argl);
    restore(proc);
    goto apply_dispatch;
apply_dispatch:
    if (is_primitive_procedure(proc)) {
        goto primitive_apply;
    }
    if (is_compound_procedure(proc)) {
        goto compound_apply;
    }

    error(S, "Unknown procedure type:", 1, proc);
    goto *label_get(continue_);

primitive_apply:
    apply_primitive_procedure(val, proc, argl);
    restore(continue_);
    goto *label_get(continue_);

compound_apply:
    procedure_parameters(unev, proc);
    procedure_environment(env, proc);
    extend_environment(env, unev, argl, env);
    procedure_body(unev, proc);
    goto ev_sequence;

ev_begin:
    begin_action(unev, exp);
    save(continue_);
    goto ev_sequence;

ev_sequence:
    first_exp(exp, unev);
    if (is_last_exp(unev)) {
        goto ev_sequence_last_exp;
    }
    save(unev);
    save(env);
    label(continue_, &&ev_sequence_continue);
    goto eval_dispatch;
ev_sequence_continue:
    restore(env);
    restore(unev);
    rest_exp(unev, unev);
    goto ev_sequence;
ev_sequence_last_exp:
    restore(continue_);
    goto eval_dispatch;

ev_if:
    save(exp);
    save(env);
    save(continue_);
    label(continue_, &&ev_if_decide);
    if_predicate(exp, exp);
    goto eval_dispatch;
ev_if_decide:
    restore(continue_);
    restore(env);
    restore(exp);
    if (is_true(val)) {
        goto ev_if_consequent;
    }
ev_if_alternative:
    if_alternative(exp, exp);
    goto eval_dispatch;
ev_if_consequent:
    if_consequent(exp, exp);
    goto eval_dispatch;

ev_assignment:
    assignment_variable(unev, exp);
    save(unev);
    assignment_value(exp, exp);
    save(env);
    save(continue_);
    label(continue_, &&ev_assignment_1);
    goto eval_dispatch;
ev_assignment_1:
    restore(continue_);
    restore(env);
    restore(unev);
    set_variable_value(unev, val, env);
    // symbol(val, "ok");
    makeVoid(val);
    goto *label_get(continue_);

ev_definition:
    definition_variable(unev, exp);
    save(unev);
    definition_value(exp, exp);
    save(env);
    save(continue_);
    label(continue_, &&ev_definition_1);
    goto eval_dispatch;
ev_definition_1:
    restore(continue_);
    restore(env);
    restore(unev);
    define_variable(unev, val, env);
    // symbol(val, "ok");
    makeVoid(val);
    goto *label_get(continue_);

eval_done:
    set_eval_env(S, oldEvalEnv);
    restore(env);
    restore(exp);

    reg_free(continue_);
    reg_free(proc);
    reg_free(argl);
    reg_free(unev);
}

void apply(Reg *val, Reg *proc, Reg *argl) {
    if (is_primitive(proc)) {
        Primitive p = primitive_get(proc);
        (*p)(val, argl);
    } else if (is_procedure(proc)) {
        Scheme *S = get_scheme(proc);
        Reg *exp = reg_alloc(S);
        Reg *env = reg_alloc(S);
        Reg *unev = reg_alloc(S);

        procedure_parameters(unev, proc);
        procedure_environment(env, proc);
        extend_environment(env, unev, argl, env);
        procedure_body(unev, proc);

        for (;;) {
            first_exp(exp, unev);
            if (is_last_exp(unev)) {
                eval(val, exp, env);
                break;
            }
            eval(val, exp, env);
            rest_exp(unev, unev);
        }

        reg_free(exp);
        reg_free(env);
        reg_free(unev);
    }
}
