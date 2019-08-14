#lang racket

;; P75 - [练习 2.30]

(define (square x)
  (* x x))

(define (square-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(define (square-tree-2 tree)
  (define (f sub-tree)
    (if (pair? sub-tree)
        (square-tree-2 sub-tree)
        (square sub-tree)))
  (map f tree))

;;;;;;;;;;;;;;;;;
(define tree '(1 (2 (3 4) 5 (6 7))))

(square-tree tree)
(square-tree-2 tree)
