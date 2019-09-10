#lang racket

;; P161 - [练习 3.7]

(define (incorrect-password . args)
  "Incorrect password")

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
  
  (define (dispatch try-password m)
    (if (eq? try-password right-password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT" m)))
        incorrect-password))
  
  dispatch)


(define (make-joint account original-password new-password)
  (define (check-password? account password)
    (number? ((account password 'withdraw) 0)))
  
  (if (check-password? account original-password)
      (lambda (try-password m)
        (if (eq? try-password new-password)
            (account original-password m)
            incorrect-password))
      (incorrect-password)))

;;;;;;;;;;;;;;;;;;;;
(define peter-acc (make-account 100 'open-sesame))
(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))

((peter-acc 'open-sesame 'withdraw) 40)
((paul-acc 'rosebud 'deposit) 50)
((peter-acc 'open-sesame 'withdraw) 70)
((paul-acc 'open-sesame 'deposit) 50)
