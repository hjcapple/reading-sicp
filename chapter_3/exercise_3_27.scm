#lang sicp

;; P188 - [练习 3.27]

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        false)))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table 
                  (cons (cons key value) (cdr table))))))

(define (make-table)
  (list '*table*))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      ;(display "memoize ")
      ;(display x)
      ;(newline)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

(define memo-fib
  (memoize (lambda (n)
             (display "memo-fib ")
             (display n)
             (newline)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))

(define (fib n)
  (display "call fib ")
  (display n)
  (newline)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(define memo-fib-2 (memoize fib))
;(set! fib memo-fib-2)

;;;;;;;;;;;;;;;;;;;;;;;
(memo-fib 5)
(memo-fib-2 5)

