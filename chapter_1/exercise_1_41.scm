#lang racket

;; P51 - [练习 1.41]

(define (double f)
  (lambda (x) (f (f x))))

(define (inc x) (+ x 1))

;;;;;;;;;;;;;
(((double (double double)) inc) 5)  ; 21
