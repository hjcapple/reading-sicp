#lang racket

;; P205 - [练习 3.34]

(#%require "constraints.scm")

(define (squarer a b)
  (multiplier a a b))

;;;;;;;;;;;;;;;;;;;;;;;
(define a (make-connector))
(define b (make-connector))

(probe "a" a)
(probe "b" b)

(squarer a b)

(set-value! a 20 'user)
(forget-value! a 'user)

(set-value! b 400 'user)

