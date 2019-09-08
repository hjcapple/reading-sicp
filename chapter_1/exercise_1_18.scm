#lang racket

;; P31 - [练习 1.18]

(define (double x) (+ x x))
(define (halve x) (/ x 2))

(define (fast-mul b n)
  (define (iter ret b n)
    (cond ((= n 0) ret)
          ((even? n) (iter ret (double b) (halve n)))
          (else (iter (+ ret b) b (- n 1)))))
  (iter 0 b n))

;;;;;;;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (define (for-loop n last op)
    (cond ((<= n last)
           (op n)
           (for-loop (+ n 1) last op))))

  (define (check i)
    (check-equal? (fast-mul i i) (* i i)))

  (for-loop 0 999 check)
)