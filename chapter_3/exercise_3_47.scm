#lang sicp

;; P218 - [练习 3.47]

(#%require "serializer.scm")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 信号量的实现需要维护好一个计数器。每次获取，就递减计数器，当计数器为 0 时，就需要重试。释放时
; 就递增计数器。重点在于这个计数器本身需要 mutex 或者 test-and-set! 进行保护。

; a) 基于互斥元
(define (make-semaphore n)
  (let ((lock (make-mutex)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (lock 'acquire)
             (if (> n 0)
                 (begin
                   (set! n (- n 1))
                   (lock 'release))
                 (begin
                   (lock 'release)
                   (the-semaphore 'acquire)))) ; retry
            ((eq? m 'release)
             (lock 'acquire)
             (set! n (+ n 1))
             (lock 'release))))
    the-semaphore))

; b) 基于 test-and-set!，类似于基于互斥元的版本。
; 仅仅是将 (lock 'acquire) 和 (lock 'release) 的实现展开。
(define (make-semaphore-2 n)
  (let ((cell (list false)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-semaphore 'acquire)
                 (if (> n 0)
                     (begin 
                       (set! n (- n 1))
                       (clear! cell))
                     (begin
                       (clear! cell)
                       (the-semaphore 'acquire)))))  ; retry
            ((eq? m 'release)
             (if (test-and-set! cell)
                 (the-semaphore 'release))
             (set! n (+ n 1))
             (clear! cell))))
    the-semaphore))

