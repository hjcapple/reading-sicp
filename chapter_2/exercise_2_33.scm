#lang racket

;; P80 - [练习 2.33]

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) null sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length sequence)
  (accumulate (lambda (x y) (+ y 1)) 0 sequence))

;;;;;;;;;;;;;;;;;
(define a (list 1 2 3 4 5))
(define b (list 6 7 8 9 10))

(map (lambda (x) (* x x)) a)
(append a b)
(length a)
(length (append a b))
