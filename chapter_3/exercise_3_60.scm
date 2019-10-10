#lang sicp

;; P232 - [练习 3.60]

(#%require "stream.scm")
(#%require "infinite_stream.scm")
(#%require "exercise_3_59.scm")

(define (mul-series s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-stream (scale-stream (stream-cdr s2) (stream-car s1)) 
                (mul-series (stream-cdr s1) s2))))

;;;;;;;;;;;;;;
(define one (add-stream (mul-series cosine-series cosine-series)
                        (mul-series sine-series sine-series)))

(stream-head->list one 20) ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)

