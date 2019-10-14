#lang racket

;; P230 - [练习 3.54]

(require "stream.scm")
(require "infinite_stream.scm")

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials 
  (cons-stream 1 (mul-streams factorials (stream-cdr integers))))

;
;     1   2   6   24  120 720  ... = factorials
; *   2   3   4   5   6   7    ... = (stream-cdr integers)
; ----------------------------------------------
; 1   2   6   24  120 720 5040 ... = factorials
;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(stream-ref factorials 0)   ; 1! = 1
(stream-ref factorials 1)   ; 2! = 2
(stream-ref factorials 2)   ; 3! = 6
(stream-ref factorials 3)   ; 4! = 24
(stream-ref factorials 4)   ; 5! = 120
(stream-ref factorials 5)   ; 6! = 720

