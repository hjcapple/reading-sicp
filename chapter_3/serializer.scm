#lang sicp

;; P216 - [串行化的实现]

(#%provide make-serializer make-mutex test-and-set! clear!)

(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serialized-p . args)
        (mutex 'acquire)
        (let ((val (apply p args)))
          (mutex 'release)
          val))
      serialized-p)))

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

;; 这里的 test-and-set! 并非原子操作，实现不了真正的 mutex
(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
        false)))
