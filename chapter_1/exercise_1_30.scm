#lang racket

;; P40 - [练习 1.30]

(define (sum term a next b)
  (define (iter a ret)
    (if (> a b)
        ret
        (iter (next a) (+ (term a) ret))))
  (iter a 0))

;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (define (inc n) (+ n 1))
  (define (identity x) x)
  
  (check-equal? (sum identity 1 inc 100) 5050)
)
