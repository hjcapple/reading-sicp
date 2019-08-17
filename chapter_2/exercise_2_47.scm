#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;; P93 - [练习 2.47]

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (cadr (cdr frame)))

;;;;;;;;;;;;;;;;;;
(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame-2 frame)
  (car frame))

(define (edge1-frame-2 frame)
  (car (cdr frame)))

(define (edge2-frame-2 frame)
  (cdr (cdr frame)))

;;;;;;;;;;;;;;;;;;;
(define a-frame (make-frame (make-vect 0 0)
                            (make-vect 2 0)
                            (make-vect 0 2)))
(origin-frame a-frame)
(edge1-frame a-frame)
(edge2-frame a-frame)

(define a-frame-2 (make-frame-2 (make-vect 0 0)
                                (make-vect 2 0)
                                (make-vect 0 2)))
(origin-frame-2 a-frame-2)
(edge1-frame-2 a-frame-2)
(edge2-frame-2 a-frame-2)

