#lang racket

;; P225 - [练习 3.50]

(require "stream.scm")

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream 
        (apply proc (map stream-car argstreams))
        (apply stream-map
               (cons proc (map stream-cdr argstreams))))))


;;;;;;;;;;;;;;;;;;;;;
(define a (stream-map + 
                      (stream-enumerate-interval 10 20)
                      (stream-enumerate-interval 20 30)
                      (stream-enumerate-interval 30 40)))
(display-stream a)

(define b (stream-map *
                      (stream-enumerate-interval 10 20)
                      (stream-enumerate-interval 20 30)
                      (stream-enumerate-interval 30 40)))
(display-stream b)

