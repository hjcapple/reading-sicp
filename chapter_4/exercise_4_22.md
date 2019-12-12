## P276 - [练习 4.22]

在 [analyzingmceval.scm](./analyzingmceval.scm) 的基础上修改测试。`analyze` 函数增加判断

``` Scheme
((let? exp) (analyze (let->combination exp)))
```

之后就是 [练习 4.6](./exercise_4_6.md) 的代码

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
