#lang sicp

;; P187 - [练习 3.25 - 解法 a]

; 完全就是一维表格的代码，假如有多个 key-1, key-2, key-3, 就将其
; 变成列表 (list key-1 key-2 key-3) 作为 key。这种方式虽然有点取巧，但简单通用，也完全符合题目要求。
; 不过这种解法，可能并非作者的意图。作者可能是想考察递归，递归解法见 [练习 3.25 - 解法 b]

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        false)))

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
(insert! 'a 1 t)
(insert! 'b 2 t)
(insert! (list 'a 'b 'c) 3 t)

(lookup 'a t)
(lookup 'b t)
(lookup (list 'a 'b 'c) t)

(insert! (list 'a 'b 'c) 10 t)
(lookup (list 'a 'b 'c) t)

; 插入三个键
(insert! (list 'key1 'key2 'key3) 123 t)
(lookup (list 'key1 'key2 'key3) t)

; 修改三个键
(insert! (list 'key1 'key2 'key3) 'hello-world t)  
(lookup (list 'key1 'key2 'key3) t)

