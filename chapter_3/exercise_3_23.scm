#lang sicp

;; P183 - [练习 3.23]

(define (make-queue-node item prev next) (cons item (cons prev next)))

(define (set-node-prev! node prev) (set-car! (cdr node) prev))
(define (set-node-next! node next) (set-cdr! (cdr node) next))

(define (node-item node) (car node))
(define (node-prev node) (car (cdr node)))
(define (node-next node) (cdr (cdr node)))

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

(define (rear-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (rear-ptr queue))))

(define (base-insert-queue! queue item link-op)
  (let ((new-node (make-queue-node item '() '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-node)
           (set-rear-ptr! queue new-node)
           queue)
          (else 
            (link-op new-node)
            queue))))

(define (front-insert-queue! queue item)
  (define (link-op new-node)
    (set-node-next! new-node (front-ptr queue))
    (set-node-prev! (front-ptr queue) new-node)
    (set-front-ptr! queue new-node))
  (base-insert-queue! queue item link-op))

(define (rear-insert-queue! queue item)
  (define (link-op new-node)
    (set-node-prev! new-node (rear-ptr queue))
    (set-node-next! (rear-ptr queue) new-node)
    (set-rear-ptr! queue new-node))
  (base-insert-queue! queue item link-op))

(define (base-delete-queue! queue delete-op)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        ((eq? (front-ptr queue) (rear-ptr queue))
         (set-front-ptr! queue '())
         (set-rear-ptr! queue '())
         queue)
        (else
          (delete-op)
          queue)))

(define (front-delete-queue! queue)
  (define (delete-op)
    (set-front-ptr! queue (node-next (front-ptr queue)))
    (set-node-prev! (front-ptr queue) '()))
  (base-delete-queue! queue delete-op))

(define (rear-delete-queue! queue)
  (define (delete-op)
    (set-rear-ptr! queue (node-prev (rear-ptr queue)))
    (set-node-next! (rear-ptr queue) '()))
  (base-delete-queue! queue delete-op))

(define (print-queue queue)
  (define (print-node node)
    (cond ((not (null? node))
           (display (node-item node))
           (cond ((not (null? (node-next node)))
                  (display " ")))
           (print-node (node-next node)))))
  (display "(")
  (print-node (front-ptr queue))
  (display ")")
  (newline))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define q (make-queue))
(print-queue q)

(front-insert-queue! q 'a)
(print-queue q)

(front-insert-queue! q 'b)
(print-queue q)

(rear-insert-queue! q 'b)
(print-queue q)

(rear-insert-queue! q 'c)
(print-queue q)

(front-delete-queue! q)
(print-queue q)

(front-delete-queue! q)
(print-queue q)

(rear-delete-queue! q)
(print-queue q)

(rear-delete-queue! q)
(print-queue q)

