#lang racket

;; P13 - [练习 1.1]

10                  ; 10
(+ 5 3 4)           ; 12
(- 9 1)             ; 8
(/ 6 2)             ; 3
(+ (* 2 4) (- 4 6)) ; 6

(define a 3)                    
(define b (+ a 1))

(+ a b (* a b))     ; 19
(= a b)             ; #f

; 4
(if (and (> b a) (< b (* a b)))
    b
    a)

; 16
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))

; 6
(+ 2 (if (> b a) b a))

; 16
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
