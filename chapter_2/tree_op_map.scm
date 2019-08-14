#lang racket

;; P72 - [树操作和树映射]

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define (scale-tree tree factor)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))

(define (scale-tree-2 tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree sub-tree factor)
             (* sub-tree factor)))
       tree))

;;;;;;;;;;;;;;;;;;;;;;;;
(define x (cons (list 1 2) (list 3 4)))
(length x)
(count-leaves x)

(list x x)
(length (list x x))
(count-leaves (list x x))

(scale-tree (list 1 (list 2 (list 3 4 5) (list 6 7))) 10)
(scale-tree-2 (list 1 (list 2 (list 3 4 5) (list 6 7))) 10)
