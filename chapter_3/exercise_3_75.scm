#lang racket

;; P240 - [练习 3.75]

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

(define (make-zero-crossings input-stream last-value last-avpt)
  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
    (cons-stream
      (sign-change-detector avpt last-avpt)
      (make-zero-crossings (stream-cdr input-stream)
                           (stream-car input-stream)
                           avpt))))

(define zero-crossings (make-zero-crossings sense-data 0 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
sense-data-lst
(stream-head->list zero-crossings (- (length sense-data-lst) 1))
