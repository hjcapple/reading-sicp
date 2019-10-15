#lang racket

;; P235 - [练习 3.65]

(require "stream.scm")
(require "infinite_stream.scm")
(require "stream_iterations.scm")
(require "exercise_3_55.scm") ; for partial-sums

(define (ln2-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln2-summands (+ n 1)))))

; 原始流定义
(define ln2-stream
  (partial-sums (ln2-summands 1)))

; 欧拉加速
(define ln2-stream-2
  (euler-transform ln2-stream))

; 超级加速器
(define ln2-stream-3
  (accelerated-sequence euler-transform ln2-stream))

;;;;;;;;;;;;;;;;
(define (display-stream-withmsg msg s n)
  (display msg)
  (newline)
  (display-stream-n s n)
  (display "============")
  (newline))

(display-stream-withmsg "ln2-stream" ln2-stream 100)
(display-stream-withmsg "ln2-stream-2" ln2-stream-2 20)
(display-stream-withmsg "ln2-stream-3" ln2-stream-3 10)

; ln2 的精确值为 0.693147180559945309417232121458176568075500134360255254120...

; 原始的 ln2-stream 收敛很慢，就算取 100 项，计算结果为 0.688172179310195，才有 1 位小数相同。
; 采用欧拉加速的 ln2-stream-2 收敛快得多，取 20 项的计算结果为 0.6931346368409872，有 4 位小数相同。
; 采用超级加速的 ln2-stream-3 收敛速度更快，

