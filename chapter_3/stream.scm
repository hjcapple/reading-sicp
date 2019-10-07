#lang sicp

;; P220 - [3.5.1 流作为延时的表]

(#%provide stream-car stream-cdr)
(#%provide stream-enumerate-interval display-stream display-line stream-ref)
(#%provide stream-filter)

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (cond ((not (stream-null? s))
         (proc (stream-car s))
         (stream-for-each proc (stream-cdr s)))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred
                                     (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (display x)
  (newline))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream low
                   (stream-enumerate-interval (+ low 1) high))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(#%require "ch3support.scm")
(#%require (only racket module*))
(module* main #f
  (stream-car
    (stream-cdr
      (stream-filter prime?
                     (stream-enumerate-interval 10000 1000000))))

  (stream-ref (stream-filter prime?
                             (stream-enumerate-interval 10000 1000000)) 1)
)

