#lang racket

;; P154 - [练习 3.1]

(define (make-accumulator init-val)
  (let ((sum init-val))
    (lambda (num)
      (set! sum (+ sum num))
      sum)))

;;;;;;;;;;;;;;;;;;
(define A (make-accumulator 5))
(A 10)  ; 15
(A 10)  ; 25
