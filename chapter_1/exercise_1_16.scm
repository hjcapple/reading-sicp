#lang racket

;; P30 - [练习 1.16]

(define (fast-expt b n)
  (define (iter a b n)
    (cond ((= n 0) a)
          ((even? n) (iter a (* b b) (/ n 2)))
          (else (iter (* a b) b (- n 1)))))
  (iter 1 b n))

;;;;;;;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (define (for-loop n last op)
    (cond ((<= n last)
           (op n)
           (for-loop (+ n 1) last op))))

  (define (expt b n)
    (if (= n 0) 
        1 
        (* b (expt b (- n 1)))))
  
  (define (check i)
    (check-= (expt 1.1 i) (fast-expt 1.1 i)  0.00001))

  (for-loop 0 100 check)
)
