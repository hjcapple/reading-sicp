#lang racket

;; P240 - [练习 3.74]

(require "stream.scm")
(require "infinite_stream.scm")

(define (list->stream lst)
  (if (null? lst)
      the-empty-stream
      (cons-stream (car lst) (list->stream (cdr lst)))))

(define sense-data-lst '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4))
(define sense-data (list->stream sense-data-lst))

;;;;;;;;;;;;;;;;;;;;;;;

(define (sign-change-detector value last-value)
  (cond ((and (> value 0) (< last-value 0)) 1)
        ((and (< value 0) (> last-value 0)) -1)
        (else 0)))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
    (sign-change-detector (stream-car input-stream) last-value)
    (make-zero-crossings (stream-cdr input-stream)
                         (stream-car input-stream))))

(define zero-crossings (make-zero-crossings sense-data 0))

(define zero-crossings-2
  (stream-map sign-change-detector sense-data (cons-stream 0 sense-data)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
sense-data-lst
(stream-head->list zero-crossings (- (length sense-data-lst) 1))
(stream-head->list zero-crossings-2 (- (length sense-data-lst) 1))
