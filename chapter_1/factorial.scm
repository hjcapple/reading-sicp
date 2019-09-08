#lang racket

;; P21 - [1.2.1 线性的递归和迭代]

(define (factorial n)
  (if (= n 1) 
      1 
      (* n (factorial (- n 1)))))

(define (factorial-2 n) 
  (define (fact-iter product counter max-count)
    (if (> counter max-count)
        product
        (fact-iter (* counter product)
                   (+ counter 1)
                   max-count)))
  
  (fact-iter 1 1 n))

;;;;;;;;;;;;;;;;;;;;;;;
(require rackunit)
(check-equal? (factorial 4) 24)
(check-equal? (factorial-2 4) 24)

(check-equal? (factorial 1) 1)
(check-equal? (factorial-2 1) 1)

(check-equal? (factorial 2) 2)
(check-equal? (factorial-2 2) 2)
