#lang racket

;; P109 - [练习 2.66]

(define (entry tree)
  (car tree))

(define (left-branch tree)
  (cadr tree))

(define (right-branch tree)
  (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (make-entry key value)
  (cons key value))

(define (entry-key entry)
  (car entry))

(define (entry-value entry)
  (cdr entry))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (lookup key tree)
  (cond ((null? tree) false)
        ((= key (entry-key (entry tree))) (entry-value (entry tree)))
        ((< key (entry-key (entry tree)))
         (lookup key (left-branch tree)))
        ((> key (entry-key (entry tree)))
         (lookup key (right-branch tree)))))

(define (insert key value tree)
  (cond ((null? tree) (make-tree (make-entry key value) null null))
        ((= key (entry-key (entry tree)))
         (make-tree (make-entry key value)
                    (left-branch tree)
                    (right-branch tree)))
        ((< key (entry-key (entry tree)))
         (make-tree (entry tree)
                    (insert key value (left-branch tree))
                    (right-branch tree)))
        ((> key (entry-key (entry tree)))
         (make-tree (entry tree)
                    (left-branch tree)
                    (insert key value (right-branch tree))))))

;;;;;;;;;;;;;;;;;;;;;
(define (list->tree lst)
  (if (null? lst)
      null 
      (let ((e (car lst)))
        (insert (car e) (cadr e) (list->tree (cdr lst))))))

(define a (list->tree '((1 "Yellow")
                        (3 "Red")
                        (9 "Green")
                        (4 "White")
                        (2 "Blue"))))
a

(lookup 9 a)
(lookup 10 a)
(lookup 4 a)

(lookup 4 (insert 4 "Black" a))

