## P286 - [练习 4.33]

在 [lazyeval.scm](./lazyeval.scm) 的基础上修改测试。`eval` 中修改判断

``` Scheme
((quoted? exp) (eval-quotation exp env))
```

`eval-quotation` 的实现如下

``` Scheme
(define (eval-quotation exp env)
  (define (list->cons lst)
    (if (null? lst)
        ''()
        (list 'cons (list 'quote (car lst))
              (list->cons (cdr lst)))))
  
  (let ((lst (cadr exp)))
    (if (pair? lst)
        (eval (list->cons lst) env)
        lst)))
```
