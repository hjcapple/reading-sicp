## P304 - [练习 4.54]

在 [ambeval.scm](./ambeval.scm) 基础上修改测试，`analyze` 添加新分支

``` Scheme
((require? exp) (analyze-require exp))
```

其实现为

``` Scheme
(define (require? exp) (tagged-list? exp 'require))
(define (require-predicate exp) (cadr exp))

(define (analyze-require exp)
  (let ((pproc (analyze (require-predicate exp))))
    (lambda (env succeed fail)
      (pproc env
             (lambda (pred-value fail2)
               (if (not (true? pred-value))
                   (fail2)
                   (succeed 'ok fail2)))
             fail))))
```

