#lang racket

;; P76 - [练习 2.31]

(define (square x)
  (* x x))

(define (tree-map proc tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (proc tree))
        (else (cons (tree-map proc (car tree))
                    (tree-map proc (cdr tree))))))

(define (tree-map-2 proc tree)
  (define (f sub-tree)
    (if (pair? sub-tree)
        (tree-map-2 proc sub-tree)
        (proc sub-tree)))
  (map f tree))

;;;;;;;;;;;;;;;;;
(define tree '(1 (2 (3 4) 5 (6 7))))

(tree-map square tree)
(tree-map-2 square tree)
