#lang racket

;; P154 - [练习 3.3]

(define (make-account balance right-password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin 
          (set! balance (- balance amount))
          balance)
        "Insufficient funds"))
  
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  
  (define (incorrect-password . args)
    "Incorrect password")
  
  (define (dispatch try-password m)
    (if (eq? try-password right-password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT" m)))
        incorrect-password))
  
  dispatch)

;;;;;;;;;;;;;;;;;;;;
(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
((acc 'some-other-password 'deposit) 50)
