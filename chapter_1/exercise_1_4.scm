#lang racket

;; P13 - [练习 1.4]

; 假如 b > 0，相当于 (+ a b)
; 否则，相当于 (- a b)
; 于是式子相当于 a 加上 b 的绝对值。这实际是高阶函数的一个例子

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;;;;;;;;;;;;;;;;;
(require rackunit)
(check-equal? (a-plus-abs-b 1 2) 3)
(check-equal? (a-plus-abs-b 1 -2) 3)