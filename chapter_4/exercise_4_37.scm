#lang sicp

;; P290 - [练习 4.37]

(#%require "ambeval.scm")
(#%require (only racket current-inexact-milliseconds))

(easy-ambeval 10 '(begin
                    
(define (require p)
  (if (not p) (amb)))

(define (an-integer-between low high)
  (require (<= low high))
  (amb low (an-integer-between (+ low 1) high)))               

(define (a-pythagorean-triple-between-ex-4.35 low high)
  (let ((i (an-integer-between low high)))
    (let ((j (an-integer-between i high)))
      (let ((k (an-integer-between j high)))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))

(define (a-pythagorean-triple-between-ex-4.37 low high)
  (let ((i (an-integer-between low high))
        (hsq (* high high)))
    (let ((j (an-integer-between i high)))
      (let ((ksq (+ (* i i) (* j j))))
        (require (>= hsq ksq))
        (let ((k (sqrt ksq)))
          (require (integer? k))
          (list i j k))))))
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define star-time (current-inexact-milliseconds))
(easy-ambeval 10 '(begin
(a-pythagorean-triple-between-ex-4.35 1 100)
;(a-pythagorean-triple-between-ex-4.37 1 400)
))
(- (current-inexact-milliseconds) star-time)


