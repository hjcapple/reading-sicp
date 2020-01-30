#lang sicp

;; P515 - [5.5.5 编译代码的实例]

(#%require "ch5-compiler.scm")

(compile
  '(define (factorial n)
     (if (= n 1)
         1
         (* (factorial (- n 1)) n)))
  'val
  'next)
