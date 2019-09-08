#lang racket

;; P51 - [练习 1.42]

(define (compose f g)
  (lambda (x) (f (g x))))

(define (square x) (* x x))
(define (inc x) (+ x 1))

;;;;;;;;;;;;;;;;;;;
((compose square inc) 6)  ; 49
