## P429 - [练习 5.47]

在 [编译器](./ch5-compiler.scm) 的基础上，修改 `compile-procedure-call` 过程

``` Scheme
(define (compile-procedure-call target linkage)
  (let ((primitive-branch (make-label 'primitive-branch))
        (compiled-branch (make-label 'compiled-branch))
        (compound-branch (make-label 'compound-branch))
        (after-call (make-label 'after-call)))
    (let ((compiled-linkage (if (eq? linkage 'next) after-call linkage)))
      (append-instruction-sequences
       (make-instruction-sequence '(proc) '()
        `((test (op primitive-procedure?) (reg proc))
          (branch (label ,primitive-branch))
          (test (op compound-procedure?) (reg proc))
          (branch (label ,compound-branch))))
       (parallel-instruction-sequences
        (append-instruction-sequences
         compiled-branch
         (compile-proc-appl target compiled-linkage))
        (parallel-instruction-sequences
          (append-instruction-sequences
           compound-branch
           (compile-compound-appl target compiled-linkage)) ;; 增加了这个分支
          (append-instruction-sequences
           primitive-branch
           (end-with-linkage linkage
            (make-instruction-sequence '(proc argl) (list target)
             `((assign ,target
                       (op apply-primitive-procedure)
                       (reg proc)
                       (reg argl))))))))
       after-call))))

(define (compile-compound-appl target linkage)
  (cond ((and (eq? target 'val) (not (eq? linkage 'return)))
       (make-instruction-sequence '(proc) all-regs
         `((assign continue (label ,linkage))
           (save continue)
           (goto (reg compapp)))))
      ((and (not (eq? target 'val))
            (not (eq? linkage 'return)))
       (let ((proc-return (make-label 'proc-return)))
         (make-instruction-sequence '(proc) all-regs
          `((assign continue (label ,proc-return))
            (save continue)
            (goto (reg compapp))
            ,proc-return
            (assign ,target (reg val))
            (goto (label ,linkage))))))
      ((and (eq? target 'val) (eq? linkage 'return))
       (make-instruction-sequence '(proc continue) all-regs
        '((save continue)
          (goto (reg compapp)))))
      ((and (not (eq? target 'val)) (eq? linkage 'return))
       (error "return linkage, target not val -- COMPILE"
              target))))
```

`compapp` 寄存器存储的是 [求值器](./ch5-eceval-compiler.scm) 的 `compound-apply` 标签。`compile-compound-appl` 中每个分支的生成代码，都有一个 `(save continue)` 指令。对应下面的 `restore`。

```
ev-sequence-last-exp
  (restore continue) ;; 对应这个 restore
  (goto (label eval-dispatch))
```
