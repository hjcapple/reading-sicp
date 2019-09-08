#lang racket

;; P40 - [练习 1.31]

; 递归版本
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

; 迭代版本
(define (product-2 term a next b)
  (define (iter a ret)
    (if (> a b)
        ret
        (iter (next a) (* (term a) ret))))
  (iter a 1))

(define (inc n) (+ n 1))
(define (identity x) x)

(define (pi-product-base product_f n)
  (define (term i)
    (if (even? i)
        (exact->inexact (/ (+ i 2) (+ i 1)))
        (exact->inexact (/ (+ i 1) (+ i 2)))))
  (product_f term 1 inc n))

(define (pi-product n)
  (pi-product-base product n))

(define (pi-product-2 n)
  (pi-product-base product-2 n))

(define (factorial n)
  (product identity 1 inc n))

;;;;;;;;;;;;;;;;;;;;;;;;;;
(require rackunit)
(* 4 (pi-product 1000))

(check-equal? (factorial 6) 720)
(check-= (pi-product 1000) (pi-product-2 1000) 0.0001)

