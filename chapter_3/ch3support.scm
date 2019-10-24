#lang racket

(provide prime? gcd)
(provide rand-update)

;; P33 - 1.2.6 实例： 素数检测, [寻找因子]
(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; P32 - [1.2.5 最大公约数]
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;;;;;;;;;;;;;;
; 线性同余法，a 和 m 是素数
(define (rand-update x)
  (let ((a 48271) (b 19851020) (m 2147483647))
    (modulo (+ (* a x) b) m)))
