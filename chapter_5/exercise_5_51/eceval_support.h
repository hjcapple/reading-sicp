// 对应 ch5-eceval-support.scm

#ifndef __ECEVAL_SUPPORT_H__
#define __ECEVAL_SUPPORT_H__

#include "scheme_runtime.h"

int is_true(Reg *x);
int is_false(Reg *x);

void make_procedure(Reg *result, Reg *parameters, Reg *body, Reg *env);
int is_compound_procedure(Reg *p);

void procedure_parameters(Reg *result, Reg *p);
void procedure_body(Reg *result, Reg *p);
void procedure_environment(Reg *result, Reg *p);

void setup_environment(Reg *env);
void lookup_variable_value(Reg *result, Reg *var, Reg *env);
void set_variable_value(Reg *var, Reg *val, Reg *env);
void define_variable(Reg *var, Reg *val, Reg *env);
void extend_environment(Reg *result, Reg *vars, Reg *vals, Reg *base_env);

int is_primitive_procedure(Reg *proc);
void apply_primitive_procedure(Reg *result, Reg *proc, Reg *args);

void empty_arglist(Reg *result);
void adjoin_arg(Reg *result, Reg *arg, Reg *arglist);
int is_last_operand(Reg *ops);

int is_no_more_exps(Reg *seq);

void make_compiled_procedure(Reg *result, Reg *entry, Reg *env);
void compiled_procedure_entry(Reg *result, Reg *proc);
void compiled_procedure_env(Reg *result, Reg *proc);
Reg *symbol_list(Reg *result, int reg_count, ...);

#endif
