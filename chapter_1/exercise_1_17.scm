#lang racket

;; P31 - [练习 1.17]

(define (mul a b)
  (if (= b 0)
      0
      (+ a (mul a (- b 1)))))

(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (fast-mul a n)
  (cond ((= n 0) 0)
        ((even? n) (double (fast-mul a (halve n))))
        (else (+ a (fast-mul a (- n 1))))))

;;;;;;;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (define (for-loop n last op)
    (cond ((<= n last)
           (op n)
           (for-loop (+ n 1) last op))))

  (define (check i)
    (check-equal? (mul i i) (* i i))
    (check-equal? (fast-mul i i) (* i i)))

  (for-loop 0 999 check)
)