#lang racket

;; P205 - [练习 3.33]

(#%require "constraints.scm")

;; (a + b) = 2 * c
(define (averager a b c)
  (let ((x (make-connector))
        (y (make-connector)))
    (adder a b x)
    (multiplier y c x)
    (constant 2 y)
    'ok))

;;;;;;;;;;;;;;;;;;;;;;;
(define a (make-connector))
(define b (make-connector))
(define c (make-connector))

(probe "a" a)
(probe "b" b)
(probe "c" c)

(averager a b c)

(set-value! a 20 'user)
(set-value! b 10 'user)

(forget-value! a 'user)
(set-value! c 40 'user)

