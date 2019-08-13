#lang racket

;; P71 - [练习 2.21]

(define (square x)
  (* x x))

(define (square-list items)
  (if (null? items)
      null
      (cons (square (car items))
            (square-list (cdr items)))))


(define (square-list-2 items)
  (map square items))

;;;;;;;;;;;;;;;;;
(square-list (list 1 2 3 4 5))
(square-list-2 (list 1 2 3 4 5))
