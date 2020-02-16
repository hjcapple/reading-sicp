// 原生函数实现

#ifndef __SCHEME_LIBS_H__
#define __SCHEME_LIBS_H__

#include "scheme_runtime.h"

struct PrimitiveProc {
    const char *symbol;
    Primitive proc;
};
struct PrimitiveProc *get_primitive_procedures(int *size);
void display_primitive(Primitive proc);

int length(Reg *list);
void reverse(Reg *result, Reg *list);
void append(Reg *result, Reg *list0, Reg *list1);

void for_each(Reg *args, void *userdata, void (*callback)(void *userdata, Reg *item));

Reg *cadr(Reg *reg, Reg *pair);
Reg *cddr(Reg *reg, Reg *pair);
Reg *caddr(Reg *reg, Reg *pair);
Reg *caadr(Reg *reg, Reg *pair);
Reg *cdadr(Reg *reg, Reg *pair);
Reg *cdddr(Reg *reg, Reg *pair);
Reg *cadddr(Reg *reg, Reg *pair);

#endif
