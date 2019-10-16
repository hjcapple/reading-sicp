#lang racket

;; P237 - [练习 3.67]

(require "stream.scm")
(require "infinite_stream.scm")

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

; 将其分成 4 块
; 左上角一个数字，最上面一行，最左边一行，右下角一大块
(define (all-pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (interleave
        (stream-map (lambda (x) (list (stream-car s) x))
                    (stream-cdr t))
        (stream-map (lambda (x) (list x (stream-car t)))
                    (stream-cdr s)))
      (all-pairs (stream-cdr s) (stream-cdr t)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(displayln "int-all-pairs")
(define int-all-pairs (all-pairs integers integers))
(display-stream-n int-all-pairs 100)
