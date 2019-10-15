#lang racket

;; P232 - [系统地将迭代操作方式表示为流过程]

(require "stream.scm")
(require "infinite_stream.scm")
(require "exercise_3_55.scm") ; for partial-sums
(provide sqrt-stream euler-transform accelerated-sequence)

(define (average x y) (/ (+ x y) 2))
(define (square x) (* x x))

(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)

(define (pi-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s
               (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))

;;;;;;;;;;;;;;;;;;
(define (display-stream-withmsg msg s n)
  (display msg)
  (newline)
  (display-stream-n s n)
  (display "============")
  (newline))

(module* main #f
  (display-stream-withmsg "(sqrt-stream 2)" (sqrt-stream 2) 20)
  (display-stream-withmsg "pi-stream" pi-stream 20)
  (display-stream-withmsg "(euler-transform pi-stream)" (euler-transform pi-stream) 20)
  (display-stream-withmsg "accelerated-sequence" (accelerated-sequence euler-transform pi-stream) 8)
)

