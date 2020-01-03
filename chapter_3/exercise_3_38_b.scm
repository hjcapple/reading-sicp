#lang racket

;; P210 - [练习 3.38-b]

(require "ch3support.scm")

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define all-balance-values '())

(define (run orders)
  (let ((balance 100)
        (peter-balance 0)
        (paul-balance 0)
        (mary-balance-1 0)
        (mary-balance-2 0)
        )
    (define (process x)
      (cond ((eq? x 'Peter-Get)
             (set! peter-balance balance))
            ((eq? x 'Peter-Set)
             (set! balance (+ peter-balance 10)))
            ((eq? x 'Paul-Get)
             (set! paul-balance balance))
            ((eq? x 'Paul-Set)
             (set! balance (- paul-balance 20)))
            ((eq? x 'Mary-Get-1)
             (set! mary-balance-1 balance))
            ((eq? x 'Mary-Get-2)
             (set! mary-balance-2 balance))
            ((eq? x 'Mary-Set)
             (set! balance (- mary-balance-2 (/ mary-balance-1 2))))))
    (for-each process orders)
    
    (set! all-balance-values(adjoin-set balance all-balance-values))
    (display orders)
    (display ": ")
    (display balance)
    (newline)))

; 用于判断列表中 a 是否在 b 前面。
; 当 a 在 b 的前面时,肯定先搜索到 a, 再搜索到 b
(define (right-order? order a b)
  (and (memq a order)
       (memq b (memq a order))))

(define (gen-orders)
  (let* ((lst (list 'Peter-Get 'Peter-Set 'Paul-Get 'Paul-Set 'Mary-Get-1 'Mary-Get-2 'Mary-Set))
         (orders (permutations lst)))
    (filter (lambda (x)
              (and (right-order? x 'Peter-Get 'Peter-Set)
                   (right-order? x 'Paul-Get 'Paul-Set)
                   (right-order? x 'Mary-Get-1 'Mary-Get-2)
                   (right-order? x 'Mary-Get-2 'Mary-Set)))
            orders)))

(define orders (gen-orders))
(for-each run orders)
all-balance-values


