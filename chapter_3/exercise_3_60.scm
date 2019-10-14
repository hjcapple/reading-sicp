#lang racket

;; P232 - [练习 3.60]

(require "stream.scm")
(require "infinite_stream.scm")
(require "exercise_3_59.scm")
(provide mul-series)

; s1 = (car-s1 + cdr-s1), s2 = (car-s2 + cdr-s2)
; s1 * s2 = car-s1 * car-s2 + cdr-s1 * car-s2 + cdr-s2 * car-s1 + cdr-s1 * cdr-s2
; 当 s1、s2 都是幂级数时，
; * car-s1 * car-s2 只含常数项
; * cdr-s1 * car-s2 + cdr-s2 * car-s1 最低项为 x
; * cdr-s1 * cdr-s2 最低项为 x^2
; 上面公式对应下面的实现。
(define (mul-series s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-streams (add-streams (scale-stream (stream-cdr s1) (stream-car s2))
                              (scale-stream (stream-cdr s2) (stream-car s1)))
                 (cons-stream 0 (mul-series (stream-cdr s1) (stream-cdr s2))))))

; 可以将上面公式稍微合并一下
; cdr-s1 * car-s2 + cdr-s1 * cdr-s2 合并一下，变为 cdr-s1 * (car-s2 + cdr-s2) = cdr-s1 * s2
; 于是 s1 * s2 = car-s1 * car-s2 + cdr-s2 * car-s1 + cdr-s1 * s2
; 就对应于下面实现
(define (mul-series-2 s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-streams (scale-stream (stream-cdr s2) (stream-car s1)) 
                 (mul-series-2 (stream-cdr s1) s2))))

; 另外一种合并方式
; cdr-s2 * car-s1 + cdr-s1 * cdr-s2 合并一下，变为 cdr-s2 * (car-s1 + cdr-s1) = cdr-s2 * s1
; 于是 s1 * s2 = car-s1 * car-s2 + cdr-s1 * car-s2 + cdr-s2 * s1
; 就对应于下面实现
(define (mul-series-3 s1 s2)
  (cons-stream
    (* (stream-car s1) (stream-car s2))
    (add-streams (scale-stream (stream-cdr s1) (stream-car s2)) 
                 (mul-series-3 (stream-cdr s2) s1))))

;;;;;;;;;;;;;;
(module* main #f
  ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (stream-head->list (add-streams (mul-series cosine-series cosine-series)
                                  (mul-series sine-series sine-series)) 
                     20)
  
  ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (stream-head->list (add-streams (mul-series-2 cosine-series cosine-series)
                                  (mul-series-2 sine-series sine-series)) 
                     20)
  
  ; (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
  (stream-head->list (add-streams (mul-series-3 cosine-series cosine-series)
                                  (mul-series-3 sine-series sine-series)) 
                     20)
)

