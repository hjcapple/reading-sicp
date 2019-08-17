#lang racket

;; P92 - [练习 2.46]

(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

(define (add-vect v0 v1)
  (make-vect (+ (xcor-vect v0) (xcor-vect v1))
             (+ (ycor-vect v0) (ycor-vect v1))))

(define (sub-vect v0 v1)
  (make-vect (- (xcor-vect v0) (xcor-vect v1))
             (- (ycor-vect v0) (ycor-vect v1))))

(define (scale-vect s v)
  (make-vect (* s (xcor-vect v))
             (* s (ycor-vect v))))

;;;;;;;;;;;;;;;;;;
(define a (make-vect 1 1))
(define b (make-vect 2 2))
(add-vect a b)
(sub-vect a b)
(scale-vect 10 a)

