#lang sicp

;; P183 - [一维表格]

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

;;;;;;;;;;;;;;;;;;;;;;;
(define t (make-table))
(insert! 'c 3 t)
(insert! 'b 2 t)
(insert! 'a 1 t)

(lookup 'a t)
(lookup 'b t)
(lookup 'c t)

t

