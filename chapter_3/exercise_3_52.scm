#lang racket

;; P226 - [练习 3.52]

(require "stream.scm")

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream 
        (apply proc (map stream-car argstreams))
        (apply stream-map
               (cons proc (map stream-cdr argstreams))))))

;;;;;;;;;;;;;;;;;;;;;
;; delay 具有记忆过程时的结果

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
sum               ; 1

(define y (stream-filter even? seq))
sum               ; 6

(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
sum               ; 10

(stream-ref y 7)  ; 136
sum               ; 136

(display-stream z)  ; 10 15 45 55 105 120 190 210
sum                 ; 210
