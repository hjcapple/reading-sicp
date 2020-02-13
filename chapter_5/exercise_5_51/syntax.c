// 对应 ch5-syntax.scm

#include "syntax.h"
#include "prime_libs.h"
#include <assert.h>
#include <string.h>

int is_self_evaluating(Reg *exp) {
    return is_number(exp) || is_string(exp) || is_boolean(exp);
}

int is_tagged_list(Reg *exp, const char *tag) {
    int ret = 0;
    if (is_pair(exp)) {
        save(exp);
        car(exp, exp);
        ret = is_symbol(exp) && (strcmp(symbol_get(exp), tag) == 0);
        restore(exp);
    }
    return ret;
}

int is_quoted(Reg *exp) {
    return is_tagged_list(exp, "quote");
}

void text_of_quotation(Reg *result, Reg *exp) {
    cadr(result, exp);
}

int is_variable(Reg *exp) {
    return is_symbol(exp);
}

int is_assignment(Reg *exp) {
    return is_tagged_list(exp, "set!");
}

void assignment_variable(Reg *result, Reg *exp) {
    cadr(result, exp);
}

void assignment_value(Reg *result, Reg *exp) {
    caddr(result, exp);
}

int is_definition(Reg *exp) {
    return is_tagged_list(exp, "define");
}

static void make_lambda(Reg *result, Reg *parameters, Reg *body) {
    Scheme *S = get_scheme(body);
    Reg *tmp = reg_alloc(S);
    cons(tmp, parameters, body);
    cons(result, symbol(result, "lambda"), tmp);
    reg_free(tmp);
}

void definition_variable(Reg *result, Reg *exp) {
    Scheme *S = get_scheme(exp);
    Reg *tmp = reg_alloc(S);

    if (is_symbol(cadr(tmp, exp))) {
        cadr(result, exp);
    } else {
        caadr(result, exp);
    }

    reg_free(tmp);
}

void definition_value(Reg *result, Reg *exp) {
    Scheme *S = get_scheme(exp);
    Reg *tmp[2];
    reg_alloc_array(S, tmp);

    if (is_symbol(cadr(tmp[0], exp))) {
        caddr(result, exp);
    } else {
        make_lambda(result, cdadr(tmp[0], exp), cddr(tmp[1], exp));
    }

    reg_free_array(tmp);
}

int is_lambda(Reg *exp) {
    return is_tagged_list(exp, "lambda");
}

void lambda_parameters(Reg *result, Reg *exp) {
    cadr(result, exp);
}

void lambda_body(Reg *result, Reg *exp) {
    cddr(result, exp);
}

int is_if(Reg *exp) {
    return is_tagged_list(exp, "if");
}

void if_predicate(Reg *result, Reg *exp) {
    cadr(result, exp);
}

void if_consequent(Reg *result, Reg *exp) {
    caddr(result, exp);
}

void if_alternative(Reg *result, Reg *exp) {
    Scheme *S = get_scheme(exp);
    Reg *tmp = reg_alloc(S);

    if (!is_null(cdddr(tmp, exp))) {
        cadddr(result, exp);
    } else {
        symbol(result, "false");
    }

    reg_free(tmp);
}

int is_begin(Reg *exp) {
    return is_tagged_list(exp, "begin");
}

void begin_action(Reg *result, Reg *exp) {
    cdr(result, exp);
}

int is_last_exp(Reg *seq) {
    save(seq);
    int ret = is_null(cdr(seq, seq));
    restore(seq);
    return ret;
}

void first_exp(Reg *result, Reg *seq) {
    car(result, seq);
}

void rest_exp(Reg *result, Reg *seq) {
    cdr(result, seq);
}

int is_application(Reg *exp) {
    return is_pair(exp);
}

void operator_(Reg *result, Reg *exp) {
    car(result, exp);
}

void operands(Reg *result, Reg *exp) {
    cdr(result, exp);
}

int is_no_operands(Reg *ops) {
    return is_null(ops);
}

void first_operand(Reg *result, Reg *ops) {
    car(result, ops);
}

void rest_operands(Reg *result, Reg *ops) {
    cdr(result, ops);
}

int is_cond(Reg *exp) {
    return is_tagged_list(exp, "cond");
}

static Reg *cond_clauses(Reg *result, Reg *exp) {
    return cdr(result, exp);
}

static void cond_predicate(Reg *result, Reg *clause) {
    car(result, clause);
}

static Reg *cond_actions(Reg *result, Reg *clause) {
    return cdr(result, clause);
}

static int is_cond_else_clause(Reg *clause) {
    Scheme *S = get_scheme(clause);
    Reg *predicate = reg_alloc(S);

    cond_predicate(predicate, clause);
    int ret = is_symbol(predicate) && (strcmp(symbol_get(predicate), "else") == 0);

    reg_free(predicate);
    return ret;
}

static void make_if(Reg *result, Reg *predicate, Reg *consequent, Reg *alternative) {
    Scheme *S = get_scheme(result);
    Reg *tmp = reg_alloc(S);
    null(tmp);
    cons(tmp, alternative, tmp);
    cons(tmp, consequent, tmp);
    cons(tmp, predicate, tmp);
    cons(result, symbol(result, "if"), tmp);
    reg_free(tmp);
}

static void make_begin(Reg *result, Reg *seq) {
    Scheme *S = get_scheme(result);
    Reg *tmp = reg_alloc(S);
    cons(result, symbol(tmp, "begin"), seq);
    reg_free(tmp);
}

static void sequence_to_exp(Reg *result, Reg *seq) {
    if (is_null(seq)) {
        assign(result, seq);
    } else if (is_last_exp(seq)) {
        first_exp(result, seq);
    } else {
        make_begin(result, seq);
    }
}

static void expand_clauses(Reg *result, Reg *clauses) {
    assert(result != clauses);

    if (is_null(clauses)) {
        symbol(result, "false");
        return;
    }

    Scheme *S = get_scheme(result);
    Reg *tmp[2];
    reg_alloc_array(S, tmp);

    Reg *first = car(tmp[0], clauses);
    Reg *rest = cdr(tmp[1], clauses);

    if (is_cond_else_clause(first)) {
        if (is_null(rest)) {
            sequence_to_exp(result, cond_actions(first, first));
        } else {
            error(S, "ELSE clause isn't last -- COND->IF", 1, clauses);
        }
        reg_free_array(tmp);
    } else {
        save(first);
        save(clauses);
        reg_free_array(tmp);

        assign(clauses, rest);
        expand_clauses(result, clauses);

        reg_alloc_array(S, tmp);
        restore(clauses);
        first = restore(tmp[1]);

        cond_predicate(tmp[0], first);
        sequence_to_exp(tmp[1], cond_actions(tmp[1], first));
        make_if(result, tmp[0], tmp[1], result);

        reg_free_array(tmp);
    }
}

void cond_to_if(Reg *result, Reg *exp) {
    Scheme *S = get_scheme(result);
    Reg *tmp = reg_alloc(S);
    expand_clauses(result, cond_clauses(tmp, exp));
    reg_free(tmp);
}

int is_let(Reg *exp) {
    return is_tagged_list(exp, "let");
}

static Reg *let_body(Reg *result, Reg *exp) {
    return cddr(result, exp);
}

struct LetCallbackInfo {
    Reg *tmp;
    Reg *result;
    Reg *(*op)(Reg *result, Reg *pair);
};

static void map_callback(void *userdata, Reg *item) {
    struct LetCallbackInfo *info = (struct LetCallbackInfo *)userdata;
    cons(info->result, info->op(info->tmp, item), info->result);
}

static Reg *map(Reg *result, Reg *lst, Reg *(*op)(Reg *result, Reg *pair)) {
    Scheme *S = get_scheme(result);
    Reg *tmp[2];
    reg_alloc_array(S, tmp);

    struct LetCallbackInfo info;
    info.result = tmp[0];
    info.tmp = tmp[1];
    info.op = op;

    null(info.result);
    for_each(lst, &info, &map_callback);
    reverse(result, info.result);

    reg_free_array(tmp);
    return result;
}

static Reg *let_vars(Reg *result, Reg *exp) {
    return map(result, cadr(result, exp), car);
}

static Reg *let_exps(Reg *result, Reg *exp) {
    return map(result, cadr(result, exp), cadr);
}

void let_to_combination(Reg *result, Reg *exp) {
    Scheme *S = get_scheme(result);
    Reg *tmp[3];
    reg_alloc_array(S, tmp);

    let_vars(tmp[0], exp);
    let_body(tmp[1], exp);
    let_exps(tmp[2], exp);

    make_lambda(result, tmp[0], tmp[1]);
    cons(result, result, tmp[2]);

    reg_free_array(tmp);
}

int is_and(Reg *exp) {
    return is_tagged_list(exp, "and");
}

int is_or(Reg *exp) {
    return is_tagged_list(exp, "or");
}
