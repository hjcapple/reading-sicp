#lang sicp

;; P183 - [练习 3.22]

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (set-front-ptr! item) (set! front-ptr item))
    (define (set-rear-ptr! item) (set! rear-ptr item))
    (define (empty-queue?) (null? front-ptr))
    
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT called with an empty queue" dispatch)
          (car front-ptr)))
    
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set-front-ptr! new-pair)
               (set-rear-ptr! new-pair)
               dispatch)
              (else 
                (set-cdr! rear-ptr new-pair)
                (set-rear-ptr! new-pair)
                dispatch))))
    
    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE! called with an empty queue" dispatch))
            (else
              (set-front-ptr! (cdr front-ptr))
              dispatch)))
    
    (define (print-queue)
      (display front-ptr)
      (newline))
    
    (define (dispatch m)
      (cond ((eq? m 'front-ptr) front-ptr)
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) delete-queue!)
            ((eq? m 'print-queue) print-queue)
            (else (error "Undefined operation -- MAKE-QUEUE" m))))
    dispatch))

(define (front-queue queue) ((queue 'front-queue)))
(define (insert-queue! queue item) ((queue 'insert-queue!) item))
(define (delete-queue! queue) ((queue 'delete-queue!)))
(define (print-queue queue) ((queue 'print-queue)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define q1 (make-queue))

(insert-queue! (insert-queue! (insert-queue! q1 'a) 'b) 'c)
(print-queue q1)        ; (a b c)

(insert-queue! q1 'd) 
(print-queue q1)        ; (a b c d)

(delete-queue! q1)    
(print-queue q1)        ; (b c d)

(delete-queue! q1)    
(print-queue q1)        ; (c d)

(delete-queue! (delete-queue! q1))
(print-queue q1)        ; ()
