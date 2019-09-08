#lang racket

;; P32 - [1.2.5 最大公约数]

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (check-equal? (gcd 206 40) 2)
  (check-equal? (gcd 3 5) 1)
  (check-equal? (gcd 15 5) 5)
  (check-equal? (gcd (* 3 4 5) (* 3 4 6)) 12)
)

