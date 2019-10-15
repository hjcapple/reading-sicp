#lang racket

;; P235 - [练习 3.63]

(require "stream.scm")
(require "infinite_stream.scm")

(define (average x y) (/ (+ x y) 2))
(define (square x) (* x x))

(define (sqrt-improve guess x)
  (display "sqrt-improve: guess= ")
  (display guess)
  (newline)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)

(define (sqrt-stream-2 x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream-2 x))))

;;;;;;;;;;;;;;;;;;
(define (display-stream-withmsg msg s n)
  (display msg)
  (newline)
  (display-stream-n s n)
  (display "============")
  (newline))

(display-stream-withmsg "(sqrt-stream 2)" (sqrt-stream 2) 4)
(display-stream-withmsg "(sqrt-stream-2 2)" (sqrt-stream-2 2) 4)

