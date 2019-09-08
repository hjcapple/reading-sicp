#lang racket

;; P51 - [练习 1.40]

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


(define (deriv g)
  (let ((dx 0.00001))
    (lambda (x)
      (/ (- (g (+ x dx)) (g x))
         dx))))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (square x) (* x x))
(define (cube x) (* x x x))

(define (cubic a b c)
  (lambda (x)
    (+ (cube x) (* a (square x)) (* b x) c)))

;;;;;;;;;;;;;;;;;;;;;;;;;
(newtons-method (cubic 3 2 1) 1.0)  ; -2.3247179572447
(newtons-method (cubic 3 4 5) 1.0)  ; -2.2134116627622
(newtons-method (cubic 6 7 8) 1.0)  ; -4.9054740060655


