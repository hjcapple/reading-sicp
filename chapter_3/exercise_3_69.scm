#lang racket

;; P238 - [练习 3.69]

(require "stream.scm")
(require "infinite_stream.scm")
(require "pairs_stream.scm")

(define (triples s t u)
  (cons-stream 
    (list (stream-car s) (stream-car t) (stream-car u))
    (interleave
      (stream-map (lambda (x) (cons (stream-car s) x))
                  (stream-cdr (pairs t u)))
      (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))

(define int-triples 
  (triples integers integers integers))

(define (square x) (* x x))

(define (pythagorean? t)
  (let ((t0 (car t))
        (t1 (cadr t))
        (t2 (caddr t)))
    (= (+ (square t0) (square t1)) (square t2))))

(define pythagorean-triples
  (stream-filter pythagorean? int-triples))

;;;;;;;;;;;;;;;;;;;
(displayln "int-triples")
(display-stream-n int-triples 20)

(displayln "pythagorean-triples")
(stream-ref pythagorean-triples 0)  ; (3 4 5)
(stream-ref pythagorean-triples 1)  ; (6 8 10)
(stream-ref pythagorean-triples 2)  ; (5 12 13)
(stream-ref pythagorean-triples 3)  ; (9 12 15)
(stream-ref pythagorean-triples 4)  ; (8 15 17)
