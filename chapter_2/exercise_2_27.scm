#lang racket

;; P74 - [练习 2.27]

(define (deep-reverse items)
  (define (iter items result)
    (if (null? items)
        result
        (iter (cdr items) 
              (cons (deep-reverse (car items)) result))))
  
  (if (pair? items)
      (iter items null)
      items))

(define (deep-reverse-2 items)
  (cond ((null? items) null)
        ((not (pair? items)) items)
        (else (append (deep-reverse-2 (cdr items)) 
                      (list (deep-reverse-2 (car items)))))))


(define (deep-reverse-3 items)
  (cond ((null? items) null)
        ((not (pair? items)) items)
        (else (reverse (map deep-reverse-3 items)))))


;;;;;;;;;;;;;;
(define x (list (list 1 2) (list 3 4)))
x

(reverse x)

(deep-reverse x)
(deep-reverse-2 x)
(deep-reverse-3 x)

