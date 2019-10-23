#lang racket

;; P243 - [练习 3.80]

(require "stream.scm")
(require "infinite_stream.scm")

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-streams (scale-stream integrand dt)
                                int))))
  int)

(define (RLC R L C dt)
  (lambda (vc0 iL0)
    (define vc (integral (delay (scale-stream iL (- (/ 1.0 C)))) vc0 dt))
    (define iL (integral (delay diL) iL0 dt))
    (define diL (add-streams (scale-stream vc (/ 1.0 L))
                             (scale-stream iL (- (/ R L)))))
    (stream-map cons vc iL)))

;;;;;;;;;;;;;;;;;;;
(define RLC1 (RLC 1 1 0.2 0.1))
(display-stream-n (RLC1 10 0) 20)

