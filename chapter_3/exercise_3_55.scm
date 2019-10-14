#lang racket

;; P230 - [练习 3.55]

(require "stream.scm")
(require "infinite_stream.scm")
(provide partial-sums)

(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (partial-sums s) (stream-cdr s))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module* main #f
  (stream-head->list (partial-sums integers) 10)  ; (1 3 6 10 15 21 28 36 45 55)
)

