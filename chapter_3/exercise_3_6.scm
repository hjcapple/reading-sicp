#lang racket

;; P157 - [练习 3.6]

; 线性同余法，a 和 m 是素数
(define (rand-update x)
  (let ((a 48271) (b 19851020) (m 2147483647))
    (modulo (+ (* a x) b) m)))

(define random-init 7)
(define rand
  (let ((x random-init))
    (lambda (m)
      (cond ((eq? m 'generate)
             (set! x (rand-update x))
             x)
            ((eq? m 'reset)
             (lambda (new-value) (set! x new-value)))
            (else (error "Unknown request -- RAND" m))))))

;;;;;;;;;;;;;;;;;;;;;;;;;
((rand 'reset) 1000)
(rand 'generate)
(rand 'generate)

((rand 'reset) 1000)
(rand 'generate)
(rand 'generate)
