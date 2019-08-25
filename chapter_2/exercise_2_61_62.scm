#lang racket

;; P105 - [练习 2.61]
;; P105 - [练习 2.62]

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))
  
(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2)) 
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set (cdr set1) (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else 
          (let ((x1 (car set1))
                (x2 (car set2)))
              (cond ((= x1 x2)
               (cons x1 (union-set (cdr set1) (cdr set2))))
              ((< x1 x2)
               (cons x1 (union-set (cdr set1) set2)))
              ((< x2 x1)
               (cons x2 (union-set set1 (cdr set2)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define a '(2 4 6 8 10))
(define b '(3 4 5 6 7 8 9))

(element-of-set? 3 a)
(element-of-set? 9 b)

(adjoin-set 7 a)
(adjoin-set 10 a)
(adjoin-set 11 a)
(intersection-set a b)
(union-set a b)

