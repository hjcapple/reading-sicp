#lang racket

;; P105 - [集合作为二叉树]

(define (entry tree)
  (car tree))

(define (left-branch tree)
  (cadr tree))

(define (right-branch tree)
  (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x null null))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

;;;;;;;;;;;;;;;;;;;;;
(define (list->tree lst)
  (cond ((null? lst) null)
        (else (adjoin-set (car lst) (list->tree (cdr lst))))))


(define a (list->tree '(2 4 6 8 10)))
(define b (list->tree '(3 4 5 6 7 8 9)))

(element-of-set? 3 a)
(element-of-set? 9 b)

(adjoin-set 7 a)
(adjoin-set 10 a)
(adjoin-set 11 a)

