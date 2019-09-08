#lang racket

;; P17 - [1.1.8 过程作为黑箱抽象]

(define (average x y) 
  (/ (+ x y) 2))

(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

(define (square x) (* x x))

(define (sqrt x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  
  (define (improve guess x)
    (average guess (/ x guess)))
  
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  
  (sqrt-iter 1.0 x))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(sqrt 9)
(sqrt (+ 100 37))
(sqrt (+ (sqrt 2) (sqrt 3)))
(square (sqrt 1000))
