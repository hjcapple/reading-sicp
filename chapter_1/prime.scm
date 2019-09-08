#lang racket

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (for-each (lambda (num)
              (check-true (prime? num)))
            '(2 3 5 7 11 13 17 19 23))
  (for-each (lambda (num)
              (check-false (prime? num)))
            '(36 25 9 16 4))
)

