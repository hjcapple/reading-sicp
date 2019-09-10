#lang racket

;; P150 - [3.1.1 局部状态变量]

(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
      (begin 
        (set! balance (- balance amount))
        balance)
      "Insufficient funds"))

(define new-withdraw
  (let ((balance 100))
    (lambda (amount)
      (if (>= balance amount)
          (begin 
            (set! balance (- balance amount))
            balance)
          "Insufficient funds"))))

(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin 
          (set! balance (- balance amount))
          balance)
        "Insufficient funds")))

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin 
          (set! balance (- balance amount))
          balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT" m))))
  dispatch)

;;;;;;;;;;;;;;;;;;;
(displayln "withdraw")
(withdraw 25)
(withdraw 25)
(withdraw 60)
(withdraw 15)

(displayln "new-withdraw")
(new-withdraw 25)
(new-withdraw 25)
(new-withdraw 60)
(new-withdraw 15)

(displayln "make-withdraw")
(define W1 (make-withdraw 100))
(define W2 (make-withdraw 100))

(W1 50)
(W2 70)
(W2 40)
(W1 40)

(displayln "make-account")
(define acc (make-account 100))
((acc 'withdraw) 50)
((acc 'withdraw) 60)
((acc 'deposit) 40)
((acc 'deposit) 60)


