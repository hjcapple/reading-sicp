#lang racket

;; P81 - [练习 2.35]

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 
              0
              (map (lambda (x)
                     (if (pair? x)
                         (count-leaves x)
                         1))
                   t)))

;;;;;;;;;;;;;;;;;
(count-leaves '(1 (2 3) (4 5 (6 7))))
