#lang racket

;; P27 - [练习 1.12]

(define (pascal-row n)
  (define (next-row lst)
    (if (= (length lst) 1)
        (list (car lst) (car lst))
        (let ((ret (next-row (cdr lst)))
              (first (car lst)))
          (cons first (cons (+ first (car ret)) (cdr ret))))))
  
  (if (<= n 1)
      (list 1)
      (next-row (pascal-row (- n 1)))))

;;;;;;;;;;;;;;;;;;;
(define (for-loop n last op)
  (cond ((<= n last)
         (op n)
         (for-loop (+ n 1) last op))))

(define (print-pascal-triangle n)
  (define (print-pascal-row x)
    (displayln (pascal-row x)))
  (for-loop 1 n print-pascal-row))

(print-pascal-triangle 13)

;输出
; (1)
; (1 1)
; (1 2 1)
; (1 3 3 1)
; (1 4 6 4 1)
; (1 5 10 10 5 1)
; (1 6 15 20 15 6 1)
; (1 7 21 35 35 21 7 1)
; (1 8 28 56 70 56 28 8 1)
; (1 9 36 84 126 126 84 36 9 1)
; (1 10 45 120 210 252 210 120 45 10 1)
; (1 11 55 165 330 462 462 330 165 55 11 1)
; (1 12 66 220 495 792 924 792 495 220 66 12 1)

