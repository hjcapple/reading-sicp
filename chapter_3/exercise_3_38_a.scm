#lang racket

;; P210 - [练习 3.38-a]

(require "ch3support.scm")

(define (run orders)
  (let ((balance 100))
    (define (process x)
      (cond ((eq? x 'Peter)
             (set! balance (+ balance 10)))
            ((eq? x 'Paul)
             (set! balance (- balance 20)))
            ((eq? x 'Mary)
             (set! balance (- balance (/ balance 2))))))
    (for-each process orders)
    (display orders)
    (display ": ")
    (display balance)
    (newline)))

(define orders (permutations (list 'Peter 'Paul 'Mary)))
(for-each run orders)
