## P62 - [练习 2.5]

根据算术基本定理，任何一个合数都可以分解成一系列素数的乘积，并且这种因式分解是唯一的。

2 和 3 都是素数。因此假如 `z = (2 ^ a) * (3 ^ b)`，那么将 z 因式分解之后，就可以唯一确定 a、b。

下面的 car 实现中，反复除以 2，每次累加计数。当除不尽时，就可还原出 a。cdr 的实现类似，只是反复除以 3。

``` Scheme
#lang racket

(define (my-cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (my-car z)
  (define (iter z a)
    (if (= 0 (remainder z 2))
      (iter (/ z 2) (+ a 1))
      a))
  (iter z 0))

(define (my-cdr z)
  (define (iter z b)
    (if (= 0 (remainder z 3))
      (iter (/ z 3) (+ b 1))
      b))
  (iter z 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(my-car (my-cons 10 20))
(my-cdr (my-cons 10 20))
```
