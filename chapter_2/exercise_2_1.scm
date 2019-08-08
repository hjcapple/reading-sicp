#lang racket

;; P58 - [练习 2.1]

(define (gcd a b)
    (if (= b 0)
        a 
    (gcd b (remainder a b))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (make-rat n d) 
    (if (< d 0) (make-rat (- n) (- d))
        (let ((g (gcd (abs n) (abs d))))
        (cons (/ n g) (/ d g)))))

(define (number x) (car x))
(define (denom x) (cdr x))

(define (add-rat x y)
    (make-rat (+ (* (number x) (denom y))
                 (* (number y) (denom x)))
              (* (denom x) (denom y))))

(define (sub-rat x y)
    (make-rat (- (* (number x) (denom y)
                 (* (number y) (denom x)))
              (* (denom x) (denom y)))))

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
(print-rat (make-rat 0 -4))
(print-rat (make-rat 2 -8))
(print-rat (make-rat -2 -8))
(print-rat (make-rat 2 -8))
(print-rat (make-rat -2 8))

