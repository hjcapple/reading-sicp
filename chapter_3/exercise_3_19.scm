#lang sicp

;; P179 - [练习 3.19]

; 让 x1 每次用 cdr 前进 1，x2 每次用 cddr 前进 2 格。初始时 x2 在 x1 前面。
; 这样当列表包含环时，x2 就会绕圈，从后面追上 x1。
; 因此当 x1 和 x2 相遇，就表示有环。当 x2 到达尾部，就表示不包含环。
; 这里不用判断 x1 是否到达尾部，因为 x2 每次前进 2 格，会比 x1 要快，不含环时，x2 一定会先到达尾部。

(define (contains-cycle? x)
  (define (contains-cycle-step? x1 x2) 
    (cond ((not (pair? x2)) false)
          ((not (pair? (cdr x2))) false)
          ((eq? x1 x2) true)
          (else (contains-cycle-step? (cdr x1) (cddr x2)))))
  (if (not (pair? x))
      false
      (contains-cycle-step? x (cdr x))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (last-pair x)
  (if (null? (cdr x))
      x 
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(contains-cycle? (list 'a 'b 'c))                 ; #f
(contains-cycle? (make-cycle (list 'a)))          ; #t
(contains-cycle? (make-cycle (list 'a 'b 'c)))    ; #t
(contains-cycle? (make-cycle (list 'a 'b 'c 'd))) ; #t

(contains-cycle? (cons 1 2))                      ; f
(contains-cycle? '(1))                            ; f
(contains-cycle? '())                             ; f

