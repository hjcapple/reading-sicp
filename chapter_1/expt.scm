#lang racket

;; P29 - [1.2.4 求幂]

(define (square x) (* x x))

(define (even? n)
  (= (remainder n 2) 0))

(define (expt b n)
  (if (= n 0) 
      1 
      (* b (expt b (- n 1)))))

(define (expt-2 b n) 
  (define (expt-iter b counter product)
    (if (= counter 0)
        product
        (expt-iter b
                   (- counter 1)
                   (* b product))))
  
  (expt-iter b n 1))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

;;;;;;;;;;;;;;;;;;;;;;;;;
(define n 100)
(expt 1.1  n)
(expt-2 1.1 n)
(fast-expt 1.1 n)
