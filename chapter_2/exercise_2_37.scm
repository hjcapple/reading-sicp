#lang racket

;; P82 - [练习 2.37]

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))

(define (transpose mat)
  (accumulate-n cons null mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) (matrix-*-vector cols x)) m)))

;;;;;;;;;;;;;;;;;
(define a '(1 2 3 4))
(define b '(5 6 7 8))
(dot-product a b)

(define m '((1 2 3 4) (4 5 6 6) (6 7 8 9)))
(matrix-*-vector m '(1 2 3 4))
(transpose m)
(matrix-*-matrix m (transpose m))
(matrix-*-matrix (transpose m) m)
