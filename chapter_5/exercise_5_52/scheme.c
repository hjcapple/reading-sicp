#include "../exercise_5_51/eceval_support.h"
#include "../exercise_5_51/prime_libs.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void apply(Reg *val, Reg *proc, Reg *argl) {
    Primitive p = primitive_get(proc);
    (*p)(val, argl);
}

int main(int argc, const char *argv[]) {
    Scheme *S = scheme_alloc();
    set_display_primitive_hander(S, display_primitive);
    setup_environment(global_env(S));

    Reg *proc = reg_alloc(S);
    Reg *val = reg_alloc(S);
    Reg *argl = reg_alloc(S);
    Reg *continue_ = reg_alloc(S);
    Reg *env = reg_alloc(S);
    Reg *tmp = reg_alloc(S);

    assign(env, global_env(S));
    label(continue_, &&done);
    set_eval_env(S, env);

#include "gen-scheme.hpp"

done:
    displayln(val);
    scheme_free(S);
    return 0;
}
