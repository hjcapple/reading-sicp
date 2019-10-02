#lang sicp

;; P218 - [练习 3.47]

(define (make-mutex)
  (let ((cell (list false)))            
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))

(define (clear! cell)
  (set-car! cell false))

;; 这里的 test-and-set! 并非原子操作,实现不了真正的 mutex
(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
        false)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

; b) 基于 test-and-set!,类似于基于互斥元的版本。
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

