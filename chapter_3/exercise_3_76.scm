#lang racket

;; P240 - [练习 3.76]

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

(define (average a b)
  (/ (+ a b) 2))

(define (smooth s last-value)
  (stream-map average s (cons-stream last-value s)))

(define (make-zero-crossings input-stream last-value)
  (let ((s (smooth input-stream last-value)))
    (stream-map sign-change-detector s (cons-stream last-value s))))

(define zero-crossings (make-zero-crossings sense-data 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
sense-data-lst
(stream-head->list zero-crossings (- (length sense-data-lst) 1))
