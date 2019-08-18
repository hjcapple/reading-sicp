#lang racket

;; P98 - [练习 2.54]

(define (equal? a b)
  (cond ((and (null? a) (null? b)) #t)
        ((and (symbol? a) (symbol? b)) (eq? a b))
        ((and (pair? a) (pair? b))
          (and (equal? (car a) (car b))
               (equal? (cdr a) (cdr b))))
        (else #f)))

;;;;;;;;;;;;;;;;;;;;
(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))
(equal? '(this is a list) '(this))

