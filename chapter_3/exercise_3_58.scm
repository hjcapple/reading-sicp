#lang racket

;; P231 - [练习 3.58]

(require "stream.scm")
(require "infinite_stream.scm")

(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) den radix)))

;;;;;;;;;;;;;;;;
(stream-head->list (expand 1 7 10) 20)  ; (1 4 2 8 5 7 1 4 2 8 5 7 1 4 2 8 5 7 1 4)
(stream-head->list (expand 3 8 10) 20)  ; (3 7 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
(stream-head->list (expand 71 7 10) 20) ; (101 4 2 8 5 7 1 4 2 8 5 7 1 4 2 8 5 7 1 4)

