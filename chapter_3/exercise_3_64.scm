#lang racket

;; P235 - [练习 3.64]

(require "stream.scm")
(require "infinite_stream.scm")
(require "stream_iterations.scm") ; for sqrt-stream

(define (stream-limit s tolerance)
  (let ((s0 (stream-car s))
        (s1 (stream-car (stream-cdr s))))
    (if (< (abs (- s0 s1)) tolerance)
        s1
        (stream-limit (stream-cdr s) tolerance))))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))

;;;;;;;;;;;;;;;;
(sqrt 2 0.0001)
