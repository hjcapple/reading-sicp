## P259 - [练习 4.6]

在 [mceval.scm](./mceval.scm) 的基础上修改测试。`eval` 函数中添加一个判断。

``` Scheme
((let? exp) (eval (let->combination exp) env))
```

let 的代码实现为

``` Scheme
(define (let? exp) (tagged-list? exp 'let))

(define (let->combination exp)
  (define (let-body exp) (cddr exp))
  (define (let-vars exp) (map car (cadr exp)))
  (define (let-exps exp) (map cadr (cadr exp)))
  
  (cons (make-lambda (let-vars exp) 
                     (let-body exp)) 
        (let-exps exp)))
```

测试代码:

``` Scheme
(define (f a) a)

(let ((a (f 'Hello))
      (b (f 'World)))
  (display a)
  (display b))
```

