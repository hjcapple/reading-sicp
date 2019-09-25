#lang sicp

;; P180 - [3.3.2 队列的表示]

(#%provide make-queue insert-queue! delete-queue! empty-queue? front-queue)

(define (front-ptr queue) (car queue))

(define (rear-ptr queue) (cdr queue))

(define (set-front-ptr! queue item) (set-car! queue item))

(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (cons '() '()))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else 
            (set-cdr! (rear-ptr queue) new-pair)
            (set-rear-ptr! queue new-pair)
            queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else
          (set-front-ptr! queue (cdr (front-ptr queue)))
          queue)))

(define (print-queue queue)
  (display (car queue))
  (newline))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(#%require (only racket module*))
(module* main #f
  (define q1 (make-queue))
  
  (insert-queue! q1 'a) ; ((a) a)
  (print-queue q1)      ; (a)
  
  (insert-queue! q1 'b) ; ((a b) b)
  (print-queue q1)      ; (a b)
  
  (delete-queue! q1)    ; ((b) b)
  (print-queue q1)      ; (b)
  
  (delete-queue! q1)    ; (() b)
  (print-queue q1)      ; ()
)
