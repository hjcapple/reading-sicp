#lang sicp

;; P292 - [练习 4.42]

(#%require "ambeval.scm")

(easy-ambeval 10 '(begin
                    
(define (require p)
  (if (not p) (amb)))

(define (half-truth p1 p2)
  (if p1
      (not p2)
      p2))

(define (require-half-truth p1 p2)
  (require (half-truth p1 p2)))

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define (liars-puzzle)
  (let ((betty (amb 1 2 3 4 5))
        (ethel (amb 1 2 3 4 5))
        (joan (amb 1 2 3 4 5))
        (kitty (amb 1 2 3 4 5))
        (mary (amb 1 2 3 4 5)))
    (require-half-truth (= kitty 2) (= betty 3))
    (require-half-truth (= ethel 1) (= joan 2))
    (require-half-truth (= joan 1) (= ethel 5))
    (require-half-truth (= kitty 2) (= mary 4))
    (require-half-truth (= mary 4) (= betty 1))
    (require (distinct? (list betty ethel joan kitty mary)))
    (list (list 'betty betty)
          (list 'ethel ethel)
          (list 'joan joan)
          (list 'kitty kitty)
          (list 'mary mary))))

(liars-puzzle)

))

;; 结果为
;; ((betty 3) (ethel 5) (joan 2) (kitty 1) (mary 4))


