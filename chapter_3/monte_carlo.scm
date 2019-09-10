#lang racket 

;; P154 - [3.1.2 引进赋值带来的利益]

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; 线性同余法，a 和 m 是素数
(define (rand-update x)
  (let ((a 48271) (b 19851020) (m 2147483647))
    (modulo (+ (* a x) b) m)))

(define random-init 7)
(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else 
            (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

;;;;;;;;;;;;;;;;;
(define (estimate-pi-2 trials)
  (sqrt (/ 6 (random-gcd-test trials random-init))))

(define (random-gcd-test trials initial-x)
  (define (iter trials-remaining trials-passed x)
    (let ((x1 (rand-update x)))
      (let ((x2 (rand-update x1)))
        (cond ((= trials-remaining 0)
               (/ trials-passed trials))
              ((= (gcd x1 x2) 1)
               (iter (- trials-remaining 1) (+ trials-passed 1) x2))
              (else 
                (iter (- trials-remaining 1) trials-passed x2))))))
  (iter trials 0 initial-x))

;;;;;;;;;;;;;;;;;
(estimate-pi 1000000)
(estimate-pi-2 1000000)
