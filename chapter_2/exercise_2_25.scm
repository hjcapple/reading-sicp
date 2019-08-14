#lang racket

;; P74 - [练习 2.25]

(define a '(1 3 (5 7) 9))
(car (cdr (car (cdr (cdr a)))))

(define b '((7)))
(car (car b))

(define c '(1 (2 (3 (4 (5 (6 7)))))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr c))))))))))))
