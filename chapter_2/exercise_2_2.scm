#lang racket

;; P60 - [练习 2.2]

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

;;;;;;;;;;;;;;;
(define (make-segment start end)
  (cons start end))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cdr seg))

(define (midpoint-segment seg)
  (define (average a b)
    (/ (+ a b) 2.0))
  (define (midpoint a b)
    (make-point (average (x-point a) (x-point b))
                (average (y-point a) (y-point b))))
  (midpoint (start-segment seg) (end-segment seg)))

;;;;;;;;;;;;;;;
(define seg0 (make-segment (make-point 10 10) (make-point 20 20)))
(define seg1 (make-segment (make-point 3 3) (make-point 4 4)))
(print-point (midpoint-segment seg0))
(print-point (midpoint-segment seg1))

