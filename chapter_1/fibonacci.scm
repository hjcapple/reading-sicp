#lang racket 

;; P24 - [1.2.2 树形递归]

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1)) 
                 (fib (- n 2))))))

(define (fib-2 n) 
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  
  (fib-iter 1 0 n))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require rackunit)
(define (for-loop n last op)
  (cond ((<= n last)
         (op n)
         (for-loop (+ n 1) last op))))

(define (test-n n)
  (check-equal? (fib n) (fib-2 n))
  (displayln (fib n)))

(for-loop 1 10 test-n)

