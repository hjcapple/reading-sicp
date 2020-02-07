#lang sicp

;; P425 - [5.5.7 编译代码与求值器的互连]

(#%require "ch5-eceval-compiler.scm")

(compile-and-go
  '(begin
     (define (factorial n)
       (if (= n 1)
           1
           (* (factorial (- n 1)) n)))
     (factorial 5)
     ))
