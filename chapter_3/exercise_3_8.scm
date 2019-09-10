#lang racket

;; P162 - [练习 3.8]

(define f
  (let ((store-value 0))
    (lambda (x)
      (let ((old store-value))
        (set! store-value x)
        old))))

;;;;;;;;;;;;;;;;;;;
; 模拟 (+ (f 0) (f 1)) 从左到右求值。从右到左求值交换 a b 两行
(define a (f 0))
(define b (f 1))
(+ a b)
