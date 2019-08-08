#lang racket

;; P60 - [练习 2.3]

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

(define (make-size width height)
  (cons width height))

(define (width-size s)
  (car s))

(define (height-size s)
  (cdr s))

; 第一种矩形内部表示 point, size
(define (make-rect x y width height)
  (cons (make-point x y) (make-size width height)))

(define (perimeter-rect rt)
  (let ((size (cdr rt)))
  (* 2 (+ (width-size size) (height-size size)))))

(define (area-rect rt)
  (let ((size (cdr rt)))
  (* (width-size size) (height-size size))))

; 第二种矩形内部表示 min-point, max-point
(define (make-rect2 x y width height)
  (cons (make-point x y) (make-point (+ x width) (+ y height))))

(define (perimeter-rect2 rt)
  (let ((min-pt (car rt)) 
        (max-pt (cdr rt)))
       (* 2
          (+ (- (x-point max-pt) (x-point min-pt))
             (- (y-point max-pt) (y-point min-pt))))))

(define (area-rect2 rt)
  (let ((min-pt (car rt))
        (max-pt (cdr rt)))
       (* (- (x-point max-pt) (x-point min-pt))
          (- (y-point max-pt) (y-point min-pt)))))

;;;;;;;;;;;;;;;;;
(define (print-rect-info rt)
  (newline)
  (display "perimeter: ")
  (display (perimeter-rect rt))
  (newline)
  (display "area: ")
  (display (area-rect rt)))
  
(print-rect-info (make-rect 0 0 5 5))
(print-rect-info (make-rect2 0 0 5 5))

