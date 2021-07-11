#lang racket

;; P238 - [练习 3.70]

(require "stream.scm")
(require "infinite_stream.scm")
(require "pairs_stream.scm")
(provide weighted-pairs)

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else 
          (let ((w1 (weight (stream-car s1)))
                (w2 (weight (stream-car s2))))
            (cond ((< w1 w2)
                   (cons-stream (stream-car s1) (merge-weighted (stream-cdr s1) s2 weight)))
                  ((> w1 w2)
                   (cons-stream (stream-car s2) (merge-weighted s1 (stream-cdr s2) weight)))
                  (else
                    ;; 跟原来的 merge 不同，需要同时包含 (stream-car s1) 和 (stream-car s2) 两项
                    (cons-stream (stream-car s1)
                                 (cons-stream (stream-car s2)
                                              (merge-weighted (stream-cdr s1)
                                                              (stream-cdr s2)
                                                              weight)))))))))

(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
      weight)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a)
(define (weight-a pair)
  (+ (car pair) (cadr pair)))

(define a-pairs (weighted-pairs integers integers weight-a))

; b)
(define (weight-b pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (* 2 i) (* 3 j) (* 5 i j))))

; i 或者 j 可以被 2，3 或者 5 整除
(define filter-integers-b
  (stream-filter (lambda (x)
                   (or (= (remainder x 2) 0)
                       (= (remainder x 3) 0)
                       (= (remainder x 5) 0)))
                 integers))

(define b-pairs (weighted-pairs filter-integers-b filter-integers-b weight-b))

; c)
; 根据 https://www.math.pku.edu.cn/teachers/qiuzy/books/sicp/errata.htm 中勘误
; 中文书中 b 问中的， i 或者 j 可以被 2，3 或者 5 整除 有误。应该修正i 和 j 都不能被 2, 3, 5 整除

; i 和 j 都不能被 2, 3, 5 整除
(define filter-integers-c
  (stream-filter (lambda (x)
                   (and (not (= (remainder x 2) 0))
                        (not (= (remainder x 3) 0))
                        (not (= (remainder x 5) 0))))
                 integers))

(define c-pairs (weighted-pairs  filter-integers-c  filter-integers-c weight-b))

(module* main #f
  (displayln "a-pairs")
  (display-stream-n a-pairs 30)
  
  (displayln "b-pairs")
  (display-stream-n b-pairs 30)

  (displayln "c-pairs")
  (display-stream-n c-pairs 30)
)
