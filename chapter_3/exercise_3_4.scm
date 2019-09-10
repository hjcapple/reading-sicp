#lang racket

;; P154 - [练习 3.4]

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
  
  (define (call-the-cops)
    (displayln "call-the-cops"))
  
  (let ((try-passowrd-count 0))
    (define (incorrect-password . args)
      (cond ((>= try-passowrd-count 7) (call-the-cops)))
      "Incorrect password")
    
    (define (dispatch try-password m)
      (if (eq? try-password right-password)
          (begin
            (set! try-passowrd-count 0)
            (cond ((eq? m 'withdraw) withdraw)
                  ((eq? m 'deposit) deposit)
                  (else (error "Unknown request -- MAKE-ACCOUNT" m))))
          (begin
            (set! try-passowrd-count (+ try-passowrd-count 1))
            incorrect-password)))
    dispatch))

;;;;;;;;;;;;;;;;;;;;
(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)

((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
