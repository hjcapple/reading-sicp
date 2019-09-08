#lang racket

;; P13 - [练习 1.3]

(define (max3 a b c)
  (cond ((and (>= a c) (>= b c)) (+ a b))
        ((and (>= a b) (>= c b)) (+ a c))
        (else (+ b c))))

;;;;;;;;;;;;;
(require rackunit)
(check-equal? (max3 1 2 3) 5)
(check-equal? (max3 1 3 2) 5)
(check-equal? (max3 3 2 1) 5)
(check-equal? (max3 3 4 4) 8)

