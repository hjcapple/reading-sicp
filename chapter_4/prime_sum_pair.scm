#lang sicp

;; 4.3.1 [amb 和搜索]

(#%require "ambeval.scm")

(easy-ambeval 10 '(begin
                 
(define (prime-sum-pair list1 list2)
  (let ((a (an-element-of list1))
        (b (an-element-of list2)))
    (require (prime? (+ a b)))
    (list a b)))

(define (require p)
  (if (not p) (amb)))

(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

(prime-sum-pair '(1 3 5 8) '(20 35 110))
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(easy-ambeval 20 '(begin
(list (amb 1 2 3) (amb 'a 'b))
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(easy-ambeval 20 '(begin
                    
(define (an-integer-starting-from n)
  (amb n (an-integer-starting-from (+ n 1))))

(an-integer-starting-from 1)

))
