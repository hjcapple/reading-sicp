#lang sicp

;; P429 - [练习 5.46], 编译 fib

(#%require "ch5-eceval-compiler.scm")

(compile-and-go
  '(define (fib n)
     (if (< n 2)
         n
         (+ (fib (- n 1)) (fib (- n 2)))))
  )

