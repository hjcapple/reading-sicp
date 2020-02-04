## P424 - [练习 5.43]

* [完整代码在这里](./exercise_5_43.scm)

[练习 4.16](../chapter_4/exercise_4_16.md) 中有 `scan-out-defines` 的实现。在 [练习 5.42](./exercise_5_42.scm) 的基础上，在 `compile-lambda-body` 中增加这个变换。

``` Scheme
(define (compile-lambda-body exp proc-entry env)
  (let ((formals (lambda-parameters exp)))
    (append-instruction-sequences
     (make-instruction-sequence '(env proc argl) '(env)
      `(,proc-entry
        (assign env (op compiled-procedure-env) (reg proc))
        (assign env
                (op extend-environment)
                (const ,formals)
                (reg argl)
                (reg env))))
     (compile-sequence (scan-out-defines (lambda-body exp)) ;; 修改了这里
                       'val 
                       'return 
                       (extend-compile-time-environment formals env)))))
```
                       

