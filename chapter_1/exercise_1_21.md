## P35 - [练习 1.21]

``` Scheme
#lang racket

(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

;;;;;;;;;;;;;;;;
(smallest-divisor 199)    ; 199
(smallest-divisor 1999)   ; 1999
(smallest-divisor 19999)  ; 7
```

199 和 1999 的最小因子为自身，它们都是素数。

19999 的最小因子是 7，它是合数。`19999 = 7 * 2857`

