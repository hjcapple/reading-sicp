## P372 - [练习 5.13]

[完整的代码在这里](./exercise_5_13.scm)

最简单的方式，是修改 `make-new-machine` 内部的 `lookup-register` 函数。

``` Scheme
(define (lookup-register name)
  (let ((val (assoc name register-table)))
    (if val
        (cadr val)
        (let ((reg (list name (make-register name))))
          (set! register-table (cons reg register-table))
          (cadr reg)))))
```

当找不到寄存器时，就自动进行分配。这时也可以删除掉 machine 的 `allocate-register` 函数。
