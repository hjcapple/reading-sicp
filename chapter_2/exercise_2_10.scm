#lang racket

;; P63 - [练习 2.10]

(define (make-interval a b)
  (cons a b))

(define (lower-bound v)
  (car v))

(define (upper-bound v)
  (cdr v))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (add-interval
    x
    (make-interval (- (upper-bound y))
                   (- (lower-bound y)))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
      (make-interval (min p1 p2 p3 p4)
                     (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (<= (* (lower-bound y) (upper-bound y)) 0)
      (error "division error (interval spans 0)" y)
      (mul-interval 
        x
        (make-interval (/ 1.0 (upper-bound y))
                       (/ 1.0 (lower-bound y))))))

(define (print-interval v)
  (newline)
  (display "[")
  (display (lower-bound v))
  (display ", ")
  (display (upper-bound v))
  (display "]"))

;;;;;;;;;;;;;;;;;;;;;
(define a (make-interval 10 20))
(define b (make-interval 1 5))
(print-interval (add-interval a b))
(print-interval (sub-interval a b))
(print-interval (mul-interval a b))
(print-interval (div-interval a b))
;(print-interval (div-interval a (make-interval -1 1))) ; error
