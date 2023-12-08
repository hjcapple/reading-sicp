#lang racket

;; P13 - [练习 1.3]
;; 英文原文是: Define a procedure that takes three numbers as arguments and returns the
;; sum of the squares of the two larger numbers.
;; 中文翻译错了, 并非“较大的两个数之和”，而是“较大两个数的平方和”

(define (square x) (* x x))
(define (sum-of-squares x y) (+ (square x) (square y)))

(define (max3 a b c)
  (cond ((and (>= a c) (>= b c)) (sum-of-squares a b))
        ((and (>= a b) (>= c b)) (sum-of-squares a c))
        (else (sum-of-squares b c))))

;;;;;;;;;;;;;
(require rackunit)
(check-equal? (max3 1 2 3) 13)
(check-equal? (max3 1 3 2) 13)
(check-equal? (max3 3 2 1) 13)
(check-equal? (max3 3 4 4) 32)

