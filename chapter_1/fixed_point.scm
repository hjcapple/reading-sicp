#lang racket

;; P45 - [找出函数的不动点]

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (let ((tolerance 0.00001))
      (< (abs (- v1 v2)) tolerance)))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))


(define (average x y) 
  (/ (+ x y) 2))

(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))

;;;;;;;;;;;;;;;;;;;;;;;;;
(fixed-point cos 1.0)

(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0)

(sqrt 2)

