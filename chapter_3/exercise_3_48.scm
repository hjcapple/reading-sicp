#lang sicp

;; P219 - [练习 3.48]

(#%require "serializer.scm")

; exchange 需要获取两个账号的串行化队列。假设为 A、B 队列。
; 获取 A、B 队列分为可打断的 2 步，假如一个进程 P1 获取了 A，试图去获取 B。
; 而 P2 获取了 B, 试图去获取 A。这样 P1、P2 都分别获取了一个队列，同时都等待其它进程释放另一个队列，就会永远等待下去。
; 会发生死锁，主要因为获取队列的顺序问题，P1、P2 获取的队列的顺序是不同的。假如对账号编号，强制 P1、P2 都
; 按照 A、B 的顺序去获取队列，死锁就不会发生。

(define (make-account-and-serializer id balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
          balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'id) id)
            ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'balance) balance)
            ((eq? m 'serializer) balance-serializer)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))

(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    (if (< (account1 'id) (account2 'id))
        ((serializer1 (serializer2 exchange)) account1 account2)
        ((serializer2 (serializer1 exchange)) account1 account2))))

