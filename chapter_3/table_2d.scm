#lang sicp

;; P185 - [二维表格]

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (lookup key-1 key-2 table)
  (let ((subtable (assoc key-1 (cdr table))))
    (if subtable
        (let ((record (assoc key-2 (cdr subtable))))
          (if record
              (cdr record)
              false))
        false)))


(define (insert! key-1 key-2 value table)
  (let ((subtable (assoc key-1 (cdr table))))
    (if subtable
        (let ((record (assoc key-2 (cdr subtable))))
          (if record
              (set-cdr! record value)
              (set-cdr! subtable 
                        (cons (cons key-2 value) (cdr subtable)))))
        (set-cdr! table
                  (cons (list key-1 (cons key-2 value))
                        (cdr table))))))

(define (make-table)
  (list '*table*))

;;;;;;;;;;;;;;;;;;;;;;;;
; 这些数字是 ASCII 码，+ 符号是 43, a 符号是 97 等
(define t (make-table))
(insert! 'math '+ 43 t)
(insert! 'math '- 45 t)
(insert! 'math '* 42 t)

(insert! 'letters 'a 97 t)
(insert! 'letters 'b 98 t)

t

(lookup 'math '- t)
(lookup 'letters 'b t)
