#lang racket

;; P51 - [练习 1.44]

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

(define (smooth f)
  (lambda (x)
    (let ((dx 0.00001))
      (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3.0))))

(define (smooth-n-times f n)
  ((repeated smooth n) f))

(define (square x) (* x x))

;;;;;;;;;;;;;;;;;;;;;;
((smooth square) 5)             ; 25.000000000066663
((smooth-n-times square 10) 5)  ; 25.000000000666663

