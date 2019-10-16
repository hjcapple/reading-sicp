#lang racket

;; P235 - [序对的无穷流]

(require "stream.scm")
(require "infinite_stream.scm")
(require "ch3support.scm")
(provide interleave pairs)

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module* main #f
  (displayln "int-pairs")
  (define int-pairs (pairs integers integers))
  (display-stream-n int-pairs 20)
  
  (displayln "prime-pairs")
  (define prime-pairs (stream-filter (lambda (pair)
                                       (prime? (+ (car pair) (cadr pair))))
                                     int-pairs))
  (display-stream-n prime-pairs 20)
)

