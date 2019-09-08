#lang racket

;; P40 - [练习 1.32]

; 递归版本
(define (accumulate combiner null_value term a next b)
  (if (> a b)
      null_value
      (combiner (term a) (accumulate combiner null_value term (next a) next b))))

; 迭代版本
(define (accumulate-2 combiner null_value term a next b)
  (define (iter a ret)
    (if (> a b)
        ret
        (iter (next a) (combiner (term a) ret))))
  (iter a null_value))


(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (inc n) (+ n 1))
(define (identity x) x)

(module* test #f
  (require rackunit)
  (check-equal? (sum identity 1 inc 100) 5050)
  (check-equal? (product identity 1 inc 6) 720)
)
