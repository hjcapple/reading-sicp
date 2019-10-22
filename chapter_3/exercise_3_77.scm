#lang racket

;; P242 - [练习 3.77]

(require "stream.scm")
(require "infinite_stream.scm")

(define (integral delayed-integrand initial-value dt)
  (cons-stream initial-value
               (let ((integrand (force delayed-integrand)))
                 (if (stream-null? integrand)
                     the-empty-stream
                     (integral (delay (stream-cdr integrand))
                               (+ (* dt (stream-car integrand))
                                  initial-value)
                               dt)))))

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

;;;;;;;;;;;;;;;;;
(stream-ref (solve (lambda (y) y) 1 0.001) 1000)  ; 2.716923932235896
