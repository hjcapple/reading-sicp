## P264 - [练习 4.13]

我们将 `unbound` 定义成 `define` 的逆操作，消除 `define` 的影响。`define` 只操作第一个框架(frame), 我们将 `unbound` 定义成:

* 只删除第一个框架的约束。
* 假如在第一个框架中，找不到对应的 var, 返回出错消息。

在 [mceval.scm](./mceval.scm) 的基础上修改测试。在 `eval` 增加一个判断：

``` Scheme
((unbound? exp) (eval-unbound exp env))
```

实现代码为：

``` Scheme
(define (unbound? exp)
  (tagged-list? exp 'unbound))

(define (eval-unbound exp env)
  (make-unbound! (cadr exp) env)
  'ok)

(define (make-unbound! var env)
  (let ((frame (first-frame env)))
    (define (scan pre-vars pre-vals vars vals)
      (cond ((null? vars)
             (error "Unbound variable -- MAKE-UNBOUND!" var))
            ((eq? var (car vars))
             (if (null? pre-vars)
                 (begin
                   (set-car! frame (cdr vars))
                   (set-cdr! frame (cdr vals)))
                 (begin
                   (set-cdr! pre-vars (cdr vars))
                   (set-cdr! pre-vals (cdr vals)))))
            (else (scan vars vals (cdr vars) (cdr vals)))))
    (scan '()
          '()
          (frame-variables frame)
          (frame-values frame))))                 
```

测试代码中

``` Scheme
(define a 1)
(unbound a)
(unbound a) ; Unbound variable -- MAKE-UNBOUND! a
```
第一个 unbound，删除了 a 的约束。之后第二个 unbound 找不到相应的约束，就返回出错信息。


