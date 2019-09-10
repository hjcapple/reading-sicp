#lang racket

;; P157 - [练习 3.5]

; 稍微改了这个函数，random 的行为有所不同，在 Racket 中不能写成
; (+ low (random range))
; 不然产生不了浮点数。
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (* (random) range))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else 
            (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (experiment)
    (P (random-in-range x1 x2)
       (random-in-range y1 y2)))
  (let ((rt-area (* (abs (- x2 x1))
                    (abs (- y2 y1)))))
    (* rt-area (monte-carlo trials experiment)))) ; 矩形面积乘以比率

;;;;;;;;;;;;;;;;;;;;;;
(define (square x) (* x x))
(define (estimate-pi trials)
  (define (inside-circle? x y)
    (< (+ (square x) (square y)) 1.0))
  (estimate-integral inside-circle? -1 1 -1 1 trials))

(exact->inexact (estimate-pi 1000000))


