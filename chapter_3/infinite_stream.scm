#lang sicp

;; P226 - [3.5.2 无穷流]

(#%require "stream.scm")

(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (divisible? x y) (= (remainder x y) 0))

(define no-sevens
  (stream-filter (lambda (x) (not (divisible? x 7)))
                 integers))

(define (fibgen a b)
  (cons-stream a (fibgen b (+ a b))))

(define fibs (fibgen 0 1))

(define (sieve stream)
  (cons-stream
    (stream-car stream)
    (sieve (stream-filter
             (lambda (x)
               (not (divisible? x (stream-car stream))))
             (stream-cdr stream)))))

(define primes (sieve (integers-starting-from 2)))

;; 隐式地定义流
(define ones (cons-stream 1 ones))

(define (add-stream s1 s2)
  (stream-map + s1 s2))

(define integers-2 (cons-stream 1 (add-stream ones integers-2)))

(define fibs-2 
  (cons-stream 0
               (cons-stream 1
                            (add-stream (stream-cdr fibs) 
                                        fibs))))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define double (cons-stream 1 (scale-stream double 2)))

(define primes-2
  (cons-stream 2 (stream-filter prime? (integers-starting-from 3))))

(define (square x) (* x x))

(define (prime? n)
  (define (iter ps)
    (cond ((> (square (stream-car ps)) n) true)
          ((divisible? n (stream-car ps)) false)
          (else (iter (stream-cdr ps)))))
  (iter primes-2))

;;;;;;;;;;;;;;;;;;;;
(stream-ref no-sevens 100)  ; 117
(stream-ref fibs 10)        ; 55
(stream-ref fibs-2 10)      ; 55
(stream-ref primes 50)      ; 233
(stream-ref primes-2 50)    ; 233
(stream-ref ones 100)       ; 1
(stream-ref integers 100)   ; 101
(stream-ref integers-2 100) ; 101
(stream-ref double 10)      ; 1024

