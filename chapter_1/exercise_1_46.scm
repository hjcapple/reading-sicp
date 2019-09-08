#lang racket

;; P52 - [练习 1.46]

(define (iterative-improve good-enough? improve)
  (define (try guess)
    (let ((next-guess (improve guess)))
      (if (good-enough? guess next-guess)
          guess
          (try next-guess))))
  try)

(define (fixed-point f first-guess)
  (define (close-enough? guess new-guess)
    (let ((tolerance 0.00001))
      (< (abs (- guess new-guess)) tolerance)))
  ((iterative-improve close-enough? f) first-guess))

(define (square x) (* x x))
(define (average x y) (/ (+ x y) 2))

(define (sqrt x)
  (define (good-enough? guess new-guess)
    (let ((tolerance 0.00001))
      (< (abs (- (square guess) x)) tolerance)))
  
  (define (improve guess)
    (average guess (/ x guess)))
  
  ((iterative-improve good-enough? improve) 1.0))

;;;;;;;;;;;;;;;;;
(sqrt 2)                ; 1.4142156862745097
(fixed-point cos 1.0)   ; 0.7390893414033928

