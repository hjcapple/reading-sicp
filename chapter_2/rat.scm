#lang racket

;; P55 - [2.1.1 实例： 有理数的算术运算]

(define (gcd a b)
    (if (= b 0)
        a 
    (gcd b (remainder a b))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (make-rat n d) 
    (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(define (number x) (car x))
(define (denom x) (cdr x))

(define (add-rat x y)
    (make-rat (+ (* (number x) (denom y))
                 (* (number y) (denom x)))
              (* (denom x) (denom y))))

(define (sub-rat x y)
    (make-rat (- (* (number x) (denom y))
                 (* (number y) (denom x)))
              (* (denom x) (denom y))))

(define (mul-rat x y)
    (make-rat (* (number x) (number y))
              (* (denom x) (denom y))))

(define (div-rat x y)
    (make-rat (* (number x) (denom y))
              (* (denom x) (number y))))

(define (equal-rat? x y)
    (=  (* (number x) (denom y))
        (* (number y) (denom x))))

(define (print-rat x)
    (newline)
    (display (number x))
    (display "/")
    (display (denom x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define one-half (make-rat 1 2))
(print-rat one-half)

(define one-third (make-rat 1 3))
(print-rat one-third)

(print-rat (add-rat one-half one-third))
(print-rat (sub-rat one-half one-third))
(print-rat (mul-rat one-half one-third))
(print-rat (add-rat one-third one-third))

