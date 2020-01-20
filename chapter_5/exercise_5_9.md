## P371 - [练习 5.9]

在 [ch5-regsim.scm](./ch5-regsim.scm) 的基础上，将 `make-operation-exp` 修改为:

``` Scheme
(define (make-operation-exp exp machine labels operations)
  (let ((op (lookup-prim (operation-exp-op exp) operations))
        (aprocs
          (map (lambda (e)
                 (if (label-exp? e) ;; 这里添加判断
                     (error "Can't operate on label -- MAKE-OPERATION-EXP" e)
                     (make-primitive-exp e machine labels)))
               (operation-exp-operands exp))))
    (lambda ()
      (apply op (map (lambda (p) (p)) aprocs)))))
```
