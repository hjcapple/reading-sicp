#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;; P91 - [练习 2.45]

(define (split big-op small-op)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller (right-split painter (- n 1))))
          (big-op painter (small-op smaller smaller))))))
  
(define right-split (split beside below))
(define up-split (split below beside))

;;;;;;;;;;;;;
(define wave einstein)
(paint (right-split wave 3))
(paint (up-split wave 3))

