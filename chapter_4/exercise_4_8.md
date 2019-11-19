## P260 - [练习 4.8]

在 [mceval.scm](./mceval.scm) 的 [练习 4.6](exercise_4_6.md) 基础上修改测试。

``` Scheme
(define (let? exp) (tagged-list? exp 'let))

(define (normal-let->combination exp)
  (define (let-body exp) (cddr exp))
  (define (let-vars exp) (map car (cadr exp)))
  (define (let-exps exp) (map cadr (cadr exp)))
  (cons (make-lambda (let-vars exp) 
                     (let-body exp)) 
        (let-exps exp)))

(define (named-let->combination exp)
  (define (let-name exp) (cadr exp))
  (define (let-body exp) (cdddr exp))
  (define (let-vars exp) (map car (caddr exp)))
  (define (let-exps exp) (map cadr (caddr exp)))
  (define (make-let-define exp) 
    (list 'define 
          (cons (let-name exp) (let-vars exp))
          (car (let-body exp))))
  (define (make-let-define-call exp)
    (list (make-let-define exp)
          (cons (let-name exp) (let-exps exp))))
  (cons (make-lambda '()
                     (make-let-define-call exp))
        '()))
                     
(define (let->combination exp)
  (define (named-let? exp) (symbol? (cadr exp)))
  (if (named-let? exp)
      (named-let->combination exp)
      (normal-let->combination exp)))
```      

测试代码:

``` Scheme
(define (f a) a)

; 普通的 let
(let ((a (f 'Hello))
      (b (f 'World)))
  (display a)
  (display b))

; 命名 let
(define (fib n)
  (let fib-iter ((a 1)
                 (b 0)
                 (count n))
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1)))))
(fib 10)          
```

其中 `fib` 会转成

``` Scheme
(define (fib n)
  ((lambda () 
     (define (fib-iter a b count) 
       (if (= count 0)
           b 
           (fib-iter (+ a b) a (- count 1)))) 
     (fib-iter 1 0 n))))
```

注意这里的 `fib-iter` 定义和 `(fib-iter 1 0 n)`，包在一个 `lambda` 中，防止 `fib-iter` 名字重名。


