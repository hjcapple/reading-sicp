#lang racket

;; P27 - [练习 1.11]

;; 递归版本
(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

;; 迭代版本
(define (f2 n)
  (define (iter a b c count)
    (if (= count 0)
        c
        (iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))
  
  (if (< n 3)
      n
      (iter 0 1 2 (- n 2))))

;;;;;;;;;;;;;;;;;;;;
(require rackunit)
(define (for-loop n last op)
  (cond ((<= n last)
         (op n)
         (for-loop (+ n 1) last op))))

(define (test-n n)
  (check-equal? (f n) (f2 n))
  (displayln (f n)))

(for-loop 0 16 test-n)
