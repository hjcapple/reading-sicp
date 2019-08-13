#lang racket

;; P69 - [练习 2.20]

(define (filter proc items)
  (if (null? items)
      null
      (if (proc (car items))
          (cons (car items) (filter proc (cdr items)))
          (filter proc (cdr items)))))

(define (same-parity a . w)
  (cons a 
        (filter (lambda (x) (even? (+ a x)))
                w)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(same-parity 1 2 3 4 5 7 9 10)
(same-parity 2 3 4 5 6 7 8 9 10)

