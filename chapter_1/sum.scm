#lang racket

;; P37 - [1.3.1 过程作为参数]

(define (sum-integers a b)
  (if (> a b)
      0
      (+ a (sum-integers (+ a 1) b))))

(define (cube x) (* x x x))

(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a) (sum-cubes (+ a 1) b))))

(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

;;;;;;;;;;;;;;;;;;;;;;
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (inc n) (+ n 1))
(define (identity x) x)

(define (sum-integers-2 a b)
  (sum identity a inc b))

(define (sum-cubes-2 a b)
  (sum cube a inc b))

(define (pi-sum-2 a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

;;;;;;;;;;;;;;;;;;;;;;
(* 8 (pi-sum 1 1000))
(integral cube 0 1 0.01)
(integral cube 0 1 0.001)

(module* test #f
  (require rackunit)
  (check-equal? (pi-sum 1 1000) (pi-sum-2 1 1000))
  (check-equal? (sum-integers 1 1000) (sum-integers-2 1 1000))
  (check-equal? (sum-cubes 1 1000) (sum-cubes-2 1 1000))
)
