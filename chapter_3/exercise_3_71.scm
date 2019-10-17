#lang racket

;; P238 - [练习 3.71]

(require "stream.scm")
(require "infinite_stream.scm")
(require "pairs_stream.scm")
(require "exercise_3_70.scm") ; for weighted-pairs

(define (cube x) (* x x x))

(define (cube-sum pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (cube i) (cube j))))

(define (ramanujan-filter s)
  (let ((s0 (stream-car s))
        (s1 (stream-car (stream-cdr s))))
    (if (= (cube-sum s0) (cube-sum s1))
        (cons-stream 
          (list (cube-sum s0) s0 s1)
          (ramanujan-filter (stream-cdr (stream-cdr s))))
        (ramanujan-filter (stream-cdr s)))))

(define ramanujan-numbers
  (ramanujan-filter (weighted-pairs integers integers cube-sum)))

(display-stream-n ramanujan-numbers 10)

; 输出
; (1729 (1 12) (9 10))
; (4104 (2 16) (9 15))
; (13832 (2 24) (18 20))
; (20683 (10 27) (19 24))
; (32832 (4 32) (18 30))
; (39312 (2 34) (15 33))
; (40033 (9 34) (16 33))
; (46683 (3 36) (27 30))
; (64232 (17 39) (26 36))
; (65728 (12 40) (31 33))
;
; 表示
; 1729 = 1^3 + 12^3 = 9^3 + 10^3
; 4104 = 2^3 + 16^3 = 9^3 + 15^3
; ...
; 可知前面 6 个 Ramanujan 数字为 1729、4104、13832、20683、32832、39312
