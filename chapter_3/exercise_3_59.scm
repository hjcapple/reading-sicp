#lang racket

;; P231 - [练习 3.59]

(require "stream.scm")
(require "infinite_stream.scm")
(provide exp-series cosine-series sine-series)

(define (div-stream s1 s2)
  (stream-map / s1 s2))

(define (neg-stream s)
  (scale-stream s -1))

; a)
(define (integrate-series s)
  (div-stream s integers))

; b)
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series
  (cons-stream 1 (neg-stream (integrate-series sine-series))))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))

;;;;;;;;;;;;;;;;;;;;;
(module* main #f
  (define ones (cons-stream 1 ones))
  (stream-head->list (neg-stream ones) 10)       
  (stream-head->list (integrate-series ones) 10) 

  (stream-head->list exp-series 10)
  (stream-head->list cosine-series 10) 
  (stream-head->list sine-series 10)
)
