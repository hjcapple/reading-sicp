#lang sicp

(#%require (only racket pretty-print))
(#%require "ch5-compiler.scm")
(#%require "ch5-eceval-compiler.scm")

(define (statements s)
  (if (symbol? s) (list s) (caddr s)))

(define code
  '(begin 
    (f (g 'x) 'y)
    ))

(pretty-print (compile code 'val  'next))

;(compile-and-go code)


