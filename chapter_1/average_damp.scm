#lang racket

;; P48 - [平均阻尼]

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

(define (square x) (* x x))
(define (average x y) 
  (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))

(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))

;;;;;;;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  
  (define (for-loop n last op)
  (cond ((<= n last)
        (op n)
        (for-loop (+ n 1) last op))))
  
  (define (check-n n)
  (check-= (sqrt n) (expt n (/ 1 2)) 0.0001)
  (check-= (cube-root n) (expt n (/ 1 3)) 0.0001))
  
  (for-loop 0 100 check-n)
)
