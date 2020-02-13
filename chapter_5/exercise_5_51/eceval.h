// 对应 ch5-eceval.scm

#ifndef __ECEVAL_H___
#define __ECEVAL_H___

#include "scheme_runtime.h"

void eval(Reg *val, Reg *exp, Reg *env);
void apply(Reg *val, Reg *proc, Reg *args);

#endif
