#lang racket

;; P241 - [3.5.4 流和延时求值]

(require "stream.scm")
(require "infinite_stream.scm")

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-streams (scale-stream integrand dt)
                                int))))
  int)

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

;;;;;;;;;;;;;;;;;
(stream-ref (solve (lambda (y) y) 1 0.001) 1000) ; 2.716923932235896
