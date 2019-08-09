#lang racket

;; P63 - [练习 2.11]

(define (make-interval a b)
  (cons a b))

(define (lower-bound v)
  (car v))

(define (upper-bound v)
  (cdr v))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (add-interval
    x
    (make-interval (- (upper-bound y))
                   (- (lower-bound y)))))

(define (mul-interval x y)
  (let ((lower_x (lower-bound x))
        (upper_x (upper-bound x))
        (lower_y (lower-bound y))
        (upper_y (upper-bound y)))

      (cond ((< upper_x 0)  ; x 全为负
              (cond ((< upper_y 0) (make-interval (* upper_x upper_y) (* lower_x lower_y)))     ; y 全为负
                    ((> lower_y 0) (make-interval (* lower_x upper_y) (* upper_x lower_y)))     ; y 全为正
                    (else          (make-interval (* lower_x upper_y) (* lower_x lower_y)))))   ; y 跨过 0

            ((> lower_x 0)  ; x 全为正
              (cond ((< upper_y 0) (make-interval (* upper_x lower_y) (* lower_x upper_y)))     ; y 全为负 
                    ((> lower_y 0) (make-interval (* lower_x lower_y) (* upper_x upper_y)))     ; y 全为正
                    (else          (make-interval (* upper_x lower_y) (* upper_x upper_y)))))   ; y 跨过 0

            (else           ; x 跨过 0
              (cond ((< upper_y 0) (make-interval (* upper_x lower_y) (* lower_x lower_y)))     ; y 全为负 
                    ((> lower_y 0) (make-interval (* lower_x upper_y) (* upper_x upper_y)))     ; y 全为正
                    (else          (make-interval (min (* upper_x lower_y) (* lower_x upper_y)) ; y 跨过 0
                                                  (max (* lower_x lower_y) (* upper_x upper_y)))
                    )))
            )))
                              

(define (div-interval x y)
  (if (<= (* (lower-bound y) (upper-bound y)) 0)
      (error "division error (interval spans 0)" y)
      (mul-interval 
        x
        (make-interval (/ 1.0 (upper-bound y))
                       (/ 1.0 (lower-bound y))))))

(define (print-interval v)
  (newline)
  (display "[")
  (display (lower-bound v))
  (display ", ")
  (display (upper-bound v))
  (display "]"))

;;;;;;;;;;;;;;;;;;;;;
(define a (make-interval 10 20))
(define b (make-interval 1 5))
(print-interval (add-interval a b))
(print-interval (sub-interval a b))
(print-interval (mul-interval a b))
(print-interval (div-interval a b))
;(print-interval (div-interval a (make-interval -1 1))) ; error

