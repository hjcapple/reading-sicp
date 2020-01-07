## P304 - [练习 4.52]

### a)

在 [ambeval.scm](./ambeval.scm) 的基础上修改测试。`analyze` 添加判断

``` Scheme
((if-fail? exp) (analyze-if-fail exp))
```

`if-fail` 实现如下：

``` Scheme
(define (if-fail? exp) (tagged-list? exp 'if-fail))
(define (analyze-if-fail exp)
  (let ((try-proc (analyze (cadr exp)))
        (fail-proc (analyze (caddr exp))))
    (lambda (env succeed fail)
      (try-proc env
                succeed
                (lambda ()
                  (fail-proc env succeed fail))))))
```

### b)

将测试代码补充完整

``` Scheme
(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

(define (require p)
  (if (not p) (amb)))

(define (even? n)
  (= (remainder n 2) 0))

(if-fail (let ((x (an-element-of '(1 3 5))))
           (require (even? x))
           x)
         'all-odd)

(if-fail (let ((x (an-element-of '(1 3 5 8))))
           (require (even? x))
           x)
         'all-odd)
```
