#lang racket

;; P210 - [练习 3.38-a]

(define (remove item lst)
  (filter (lambda (x) (not (eq? x item)))
          lst))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (arrange lst)      
  (if (null? lst)
      (list '())
      (accumulate append '()
                  (map (lambda (x)
                         (map (lambda (sub) (append (list x) sub)) 
                              (arrange (remove x lst))))
                       lst))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (run orders)
  (let ((balance 100))
    (define (process x)
      (cond ((eq? x 'Peter)
             (set! balance (+ balance 10)))
            ((eq? x 'Paul)
             (set! balance (- balance 20)))
            ((eq? x 'Mary)
             (set! balance (- balance (/ balance 2))))))
    (for-each process orders)
    (display orders)
    (display ": ")
    (display balance)
    (newline)))

(define orders (arrange (list 'Peter 'Paul 'Mary)))
(for-each run orders)
