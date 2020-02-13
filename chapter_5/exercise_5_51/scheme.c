#include "eceval.h"
#include "eceval_support.h"
#include "prime_libs.h"
#include "scheme_libs.h"
#include <setjmp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static void runCode(Scheme *S, const char *code) {
    Reg *exp = reg_alloc(S);
    Reg *val = reg_alloc(S);
    Reg *env = reg_alloc(S);

    const char *iter = code;
    int pos = 0;
    while (parse(exp, iter, &pos)) {
        assign(env, global_env(S));
        eval(val, exp, env);
        displayln2(val, 0);
        iter = iter + pos;
    }

    reg_free(exp);
    reg_free(val);
    reg_free(env);
}

static size_t getfilesize(FILE *file) {
    fseek(file, 0, SEEK_END);
    size_t read_len = ftell(file);
    fseek(file, 0, SEEK_SET);
    return read_len;
}

static void onError(Scheme *S, void *userdata) {
    jmp_buf *j = (jmp_buf *)userdata;
    reset_scheme(S);
    longjmp(*j, 0);
}

static void runFile(Scheme *S, const char *path) {
    FILE *file = fopen(path, "r");
    if (!file) {
        printf("can't read this file: %s\n", path);
        return;
    }

    size_t filesize = getfilesize(file);

    char *buffer = (char *)malloc(filesize + 1);
    fread(buffer, sizeof(char), filesize, file);
    fclose(file);

    buffer[filesize] = 0;

    jmp_buf j;
    if (setjmp(j) == 0) {
        // init
        set_error_handler(S, &j, onError);
        runCode(S, buffer);
    } else {
        printf("some errors in file: %s", path);
    }

    set_error_handler(S, NULL, NULL);
    newline();
    free(buffer);
}

static void repl(Scheme *S) {
    printf("====================================\n");
    printf("A simple Scheme interpreter (by HJC)\n");
    printf("====================================\n");

    jmp_buf j;
    if (setjmp(j) == 0) {
        // init
        set_error_handler(S, &j, onError);
    }

    Reg *exp = reg_alloc(S);
    Reg *val = reg_alloc(S);
    Reg *env = reg_alloc(S);

    while (read(exp)) {
        assign(env, global_env(S));
        eval(val, exp, env);
        displayln(val);
    }

    set_error_handler(S, NULL, NULL);
    reg_free(exp);
    reg_free(val);
    reg_free(env);
}

int main(int argc, const char *argv[]) {
    Scheme *S = scheme_alloc();
    set_display_primitive_hander(S, display_primitive);

    setup_environment(global_env(S));
    runCode(S, scheme_libs);

    if (argc > 1) {
        int i = 0;
        for (i = 1; i < argc; i++) {
            runFile(S, argv[i]);
        }
    } else {
        repl(S);
    }

    scheme_free(S);
    return 0;
}
