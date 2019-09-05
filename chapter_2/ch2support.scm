#lang racket

(provide get put gcd square fib =number?)
(provide get-coercion put-coercion)
(provide display-brackets)

;;;from chapter 1
(define (square x) (* x x))

(define (=number? x num) (and (number? x) (= x num)))

;;;from section 1.2.5, for Section 2.1.1
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;;;from section 1.2.2, for Section 2.2.3
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

;;; ***not in book, but needed for code before quote is introduced*** 
(define nil '())

;;;-----------
;; put get 简单实现
(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) #f))

;;;-----------
;; put-coercion get-coercion 简单实现
(define *coercion-table* (make-hash))

(define (put-coercion op type proc)
  (hash-set! *coercion-table* (list op type) proc))

(define (get-coercion op type)
  (hash-ref *coercion-table* (list op type) #f))

;;---------------
(define (display-brackets val)
  (display "(")
  (display val)
  (display ")"))



