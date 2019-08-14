#lang racket

;; P74 - [练习 2.28]

(define (fringe items)
  (cond ((null? items) null)
        ((not (pair? items)) (list items))
        (else (append (fringe (car items))
                      (fringe (cdr items))))))


;;;;;;;;;;;;;;
(define x (list (list 1 2) (list 3 4)))
(fringe x)

(fringe (list x x))

