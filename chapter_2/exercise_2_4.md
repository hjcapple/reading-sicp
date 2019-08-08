## P62 - [练习 2.4]

cons、car、cdr 的另一种过程性表示如下。

``` Scheme
(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))
```

展开 `(car (cons x y))` 的计算过程为

``` Scheme
(car (cons x y))
(car (lambda (m) (m x y)))
((lambda (m) (m x y)) (lambda (p q) p))
((lambda (p q) p) x y)
x
```

展开 `(cdr (cons x y))` 的计算过程为

``` Scheme
(cdr (cons x y))
(cdr (lambda (m) (m x y)))
((lambda (m) (m x y)) (lambda (p q) q))
((lambda (p q) q) x y)
y
```
