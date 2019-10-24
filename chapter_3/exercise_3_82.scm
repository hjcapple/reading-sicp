#lang racket

;; P246 - [练习 3.82]

(require "stream.scm")
(require "infinite_stream.scm")
(require "monte_carlo_stream.scm")  ; for monte-carlo
(require "ch3support.scm")          ; for rand-update

(define random-init 7)
(define random-numbers
  (cons-stream random-init
               (stream-map rand-update random-numbers)))

; 生成 0-1 之间的浮点数
(define max-rand-integer 1000000)
(define random-0-1
  (stream-map (lambda (v)
                (/ (remainder v max-rand-integer)
                   max-rand-integer))
              random-numbers))

(define (random-in-range low high random)
  (let ((range (- high low)))
    (+ low (* random range))))

(define (map-successive-rect P x1 x2 y1 y2 s)
  (cons-stream
    (P (random-in-range x1 x2 (stream-car s))
       (random-in-range y1 y2 (stream-car (stream-cdr s))))
    (map-successive-rect P x1 x2 y1 y2 (stream-cdr (stream-cdr s)))))

(define (estimate-integral P x1 x2 y1 y2)
  (let ((rt-area (* (abs (- x2 x1))
                    (abs (- y2 y1)))))
    (scale-stream (monte-carlo (map-successive-rect P x1 x2 y1 y2 random-0-1) 0 0)
                  rt-area)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (square x) (* x x))
(define (inside-circle? x y)
  (< (+ (square x) (square y)) 1.0))
(define estimate-pi
  (estimate-integral inside-circle? -1 1 -1 1))

(exact->inexact (stream-ref estimate-pi 10000))

