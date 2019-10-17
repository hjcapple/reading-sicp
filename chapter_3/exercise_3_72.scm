#lang racket

;; P238 - [练习 3.72]

(require "stream.scm")
(require "infinite_stream.scm")
(require "pairs_stream.scm")
(require "exercise_3_70.scm") ; for weighted-pairs

(define (square x) (* x x))

(define (square-sum pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (square i) (square j))))

(define (3-way-square-sum-filter s)
  (let ((s0 (stream-car s))
        (s1 (stream-car (stream-cdr s)))
        (s2 (stream-car (stream-cdr (stream-cdr s)))))
    (if (and (= (square-sum s0) (square-sum s1))
             (= (square-sum s1) (square-sum s2)))
        (cons-stream 
          (list (square-sum s0) s0 s1 s2)
          (3-way-square-sum-filter (stream-cdr (stream-cdr (stream-cdr s)))))
        (3-way-square-sum-filter (stream-cdr s)))))

(define 3-way-square-sum-numbers
  (3-way-square-sum-filter (weighted-pairs integers integers square-sum)))

(display-stream-n 3-way-square-sum-numbers 10)

; 输出
; (325 (1 18) (6 17) (10 15))
; (425 (5 20) (8 19) (13 16))
; (650 (5 25) (11 23) (17 19))
; (725 (7 26) (10 25) (14 23))
; (845 (2 29) (13 26) (19 22))
; (850 (3 29) (11 27) (15 25))
; (925 (5 30) (14 27) (21 22))
; (1025 (1 32) (8 31) (20 25))
; (1105 (4 33) (9 32) (12 31))
; (1250 (5 35) (17 31) (25 25))

; 表示
; 325 = 1^2 + 18^2 = 6^2 + 17^2 = 10^2 + 15^2
; 425 = 5^2 + 20^2 = 8^2 + 19^2 = 13^2 + 16^2
