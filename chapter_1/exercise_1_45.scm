#lang racket

;; P52 - [练习 1.45]

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

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

(define (square x) (* x x))
(define (average x y) (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (nth-root x n)
  (define (fn y)
    (/ x (fast-expt y (- n 1))))
  (fixed-point ((repeated average-damp (- n 1)) fn) 1.0))

;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (define (for-loop n last op)
    (cond ((<= n last)
           (op n)
           (for-loop (+ n 1) last op))))
  
  (define (check-n n)
    (check-= (nth-root n 2) (expt n (/ 1 2)) 0.0001)
    (check-= (nth-root n 3) (expt n (/ 1 3)) 0.0001)
    (check-= (nth-root n 4) (expt n (/ 1 4)) 0.0001)
    (check-= (nth-root n 5) (expt n (/ 1 5)) 0.0001))
  
  (for-loop 1 100 check-n)
)
