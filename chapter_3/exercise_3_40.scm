#lang racket

;; P212 - [练习 3.40]

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
(define all-x-values '())

(define (run orders)
  (let ((x-value 10)
        (p1-x-1 0)
        (p1-x-2 0)
        (p2-x-1 0)
        (p2-x-2 0)
        (p2-x-3 0)
        )
    (define (process p)
      (cond ((eq? p 'p1-get-1) (set! p1-x-1 x-value))
            ((eq? p 'p1-get-2) (set! p1-x-2 x-value))
            ((eq? p 'p2-get-1) (set! p2-x-1 x-value))
            ((eq? p 'p2-get-2) (set! p2-x-2 x-value))
            ((eq? p 'p2-get-3) (set! p2-x-3 x-value))
            ((eq? p 'p1-set) (set! x-value (* p1-x-1 p1-x-2)))
            ((eq? p 'p2-set) (set! x-value (* p2-x-1 p2-x-2 p2-x-3)))
            ))
    (for-each process orders)
    
    (set! all-x-values (adjoin-set x-value all-x-values))
    (display orders)
    (display ": ")
    (display x-value)
    (newline)))

; 用于判断列表中 a 是否在 b 前面。
; 当 a 在 b 的前面时,肯定先搜索到 a, 再搜索到 b
(define (right-order? order a b)
  (and (memq a order)
       (memq b (memq a order))))

(define (gen-orders)
  (let* ((lst (list 'p1-get-1 'p1-get-2 'p1-set 'p2-get-1 'p2-get-2 'p2-get-3 'p2-set))
         (orders (permutations lst)))
    (filter (lambda (x)
              (and (right-order? x 'p1-get-1 'p1-get-2)
                   (right-order? x 'p1-get-2 'p1-set)
                   (right-order? x 'p2-get-1 'p2-get-2)
                   (right-order? x 'p2-get-2 'p2-get-3)
                   (right-order? x 'p2-get-3 'p2-set)))
            orders)))

(define orders (gen-orders))
(length orders)

(for-each run orders)
all-x-values

