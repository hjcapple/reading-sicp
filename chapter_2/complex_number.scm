#lang racket

;; P116 - [2.4.1 复数的表示]

(define (square x) (* x x))

(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
                       (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
                       (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))

;; Ben
(define (real-part z) (car z))

(define (imag-part z) (cdr z))

(define (magnitude z)
  (sqrt (+ (square (real-part z)) (square (imag-part z)))))

(define (angle z)
  (atan (imag-part z) (real-part z)))

(define (make-from-real-imag x y) (cons x y))

(define (make-from-mag-ang r a)
  (cons (* r (cos a)) (* r (sin a))))

;; Alyssa
;(define (real-part z)
;  (* (magnitude z) (cos (angle z))))

;(define (imag-part z)
;  (* (magnitude z) (sin (angle z))))

;(define (magnitude z) (car z))

;(define (angle z) (cdr z))

;(define (make-from-real-imag x y)
;  (cons (sqrt (+ (square x) (square y)))
;        (atan y x)))

;(define (make-from-mag-ang r a) (cons r a))

;;;;;;;;;;;;;;;;;;;
(define a (make-from-real-imag 10 20))
(define b (make-from-real-imag 1 2))
(define c (make-from-mag-ang (magnitude a) (angle a)))
(define d (make-from-mag-ang (magnitude b) (angle b)))

(add-complex a b)
(sub-complex a b)
(mul-complex a b)
(div-complex a b)

(add-complex c d)
(sub-complex c d)
(mul-complex c d)
(div-complex c d)

