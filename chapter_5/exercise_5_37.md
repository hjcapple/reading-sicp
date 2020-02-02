## P421 - [练习 5.37]

### a)

我们将 [编译器代码中](./ch5-compiler.scm), 过程 `preserving` 的 `if` 判断去掉，修改为

``` Scheme
(define (preserving regs seq1 seq2)
  (if (null? regs)
      (append-instruction-sequences seq1 seq2)
      (let ((first-reg (car regs)))
        (preserving (cdr regs)
          (make-instruction-sequence
            (list-union (list first-reg)
                        (registers-needed seq1))
            (list-difference (registers-modified seq1)
                             (list first-reg))
            (append `((save ,first-reg))
                    (statements seq1)
                    `((restore ,first-reg))))
          seq2))))
```

### b)

修改后，我们编译表达式 `(f 1 2)`

``` Scheme
(compile
  '(f 1 2)
  'val
  'next)
```

编译结果为:

``` Scheme
'((save continue)     ; 不必要
  (save env)          ; 不必要
  (save continue)     ; 不必要
  (assign proc (op lookup-variable-value) (const f) (reg env))
  (restore continue)  ; 不必要
  (restore env)       ; 不必要
  (restore continue)  ; 不必要
  (save continue)     ; 不必要
  (save proc)         ; 不必要
  (save env)          ; 不必要
  (save continue)     ; 不必要
  (assign val (const 2))
  (restore continue)  ; 不必要
  (assign argl (op list) (reg val))
  (restore env)       ; 不必要
  (save argl)         ; 不必要
  (save continue)     ; 不必要
  (assign val (const 1))
  (restore continue)  ; 不必要
  (restore argl)      ; 不必要
  (assign argl (op cons) (reg val) (reg argl))
  (restore proc)      ; 不必要
  (restore continue)  ; 不必要
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch1))
  compiled-branch2
  (assign continue (label after-call3))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
  primitive-branch1
  (save continue)     ; 不必要
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (restore continue)  ; 不必要
```
事实上，上面编译结果中，所有的 `save` 和 `restore` 都是不必要的。

