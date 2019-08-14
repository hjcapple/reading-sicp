#lang racket

;; P74 - [练习 2.29]

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

;(define (make-mobile left right)
;  (cons left right))

;(define (make-branch length structure)
;  (cons length structure))

;(define (left-branch mobile)
;  (car mobile))

;(define (right-branch mobile)
;  (cdr mobile))

;(define (branch-length branch)
;  (car branch))

;(define (branch-structure branch)
;  (cdr branch))

(define (total-weight-branch b)
  (let ((s (branch-structure b)))
    (if (pair? s)
        (total-weight-mobile s)
        s)))

(define (total-weight-mobile m)
  (+ (total-weight-branch (left-branch m))
     (total-weight-branch (right-branch m))))

(define (balanced-branch? b)
   (let ((s (branch-structure b)))
    (if (pair? s)
        (mobile-balanced? s)
        #t)))

(define (mobile-balanced? m)  
  (let ((left (left-branch m))
        (right (right-branch m)))
    (and (balanced-branch? left)
         (balanced-branch? right)
         (= (* (total-weight-branch left) (branch-length left))
            (* (total-weight-branch right) (branch-length right))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define x (make-branch 1 2))
(define b (make-mobile x (make-branch 1 (make-mobile x x))))
(define c (make-mobile (make-branch 1 (make-mobile x x)) (make-branch 1 (make-mobile x x))))

(total-weight-mobile b)
(total-weight-mobile c)
(mobile-balanced? b)
(mobile-balanced? c)
