#lang sicp

;; P420 - [练习 5.35]

(#%require "ch5-compiler.scm")

(compile
  '(define (f x)
     (+ x (g (+ x 2)))
     )
  'val
  'next)
