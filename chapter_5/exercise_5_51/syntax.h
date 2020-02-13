// 对应 ch5-syntax.scm

#ifndef __SCHEME_SYNTAX_H__
#define __SCHEME_SYNTAX_H__

#include "scheme_runtime.h"

int is_tagged_list(Reg *exp, const char *tag);
int is_self_evaluating(Reg *exp);

int is_quoted(Reg *exp);
void text_of_quotation(Reg *result, Reg *exp);

int is_variable(Reg *exp);

int is_assignment(Reg *exp);
void assignment_variable(Reg *result, Reg *exp);
void assignment_value(Reg *result, Reg *exp);

int is_definition(Reg *exp);
void definition_variable(Reg *result, Reg *exp);
void definition_value(Reg *result, Reg *exp);

int is_lambda(Reg *exp);
void lambda_parameters(Reg *result, Reg *exp);
void lambda_body(Reg *result, Reg *exp);

int is_if(Reg *exp);
void if_predicate(Reg *result, Reg *exp);
void if_consequent(Reg *result, Reg *exp);
void if_alternative(Reg *result, Reg *exp);

int is_begin(Reg *exp);
void begin_action(Reg *result, Reg *exp);

int is_last_exp(Reg *seq);
void first_exp(Reg *result, Reg *seq);
void rest_exp(Reg *result, Reg *seq);

int is_application(Reg *exp);

void operator_(Reg *result, Reg *exp);
void operands(Reg *result, Reg *exp);

int is_no_operands(Reg *ops);

void first_operand(Reg *result, Reg *ops);

void rest_operands(Reg *result, Reg *ops);

// cond 语法 C 实现
int is_cond(Reg *exp);
void cond_to_if(Reg *result, Reg *exp);

// let 语法 C 实现
int is_let(Reg *exp);
void let_to_combination(Reg *result, Reg *exp);

int is_and(Reg *exp);
int is_or(Reg *exp);

#endif
