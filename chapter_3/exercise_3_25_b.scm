#lang sicp

;; P187 - [练习 3.25 - 解法 b]

; 递归解法，沿用二维表格思路。当插入 (list 'key1 'key2 'key3) value 时，可能会递归创建子表格。
; 但这种递归解法有缺陷。

; 比如下面代码就会让程序崩溃
; (define t (make-table))
; (insert! 'a 1000 t)  
; (insert! (list 'a 'b) 1000 t)  
; 先插入了 key = 'a 这条记录。当插入 keys = (list 'a 'b) 时，因为 'a 记录已经存在。程序会错误地将 'a 记录当成是
; 子表格，再在其中寻找 'b 记录。但实际上 key = 'a 对应的记录是 1000，而非子表格。

; 而这段代码
; (define t (make-table))
; (insert! (list 'a 'b) 1000 t)  
; (insert! 'a 1000 t)  
; 就会错误地冲掉 keys = (list 'a 'b) 的记录。因为第二条语句，会将 key = 'a 的记录直接修改成 1000，这样就丢失了原来的子表格。

; 递归创建子表格，会出现上述的崩溃或者冲掉记录，根本原因是 keys 的个数不固定。于是每一层都可能是最终记录，也可能是子表格，
; 要统一处理两者会很麻烦，甚至是不可能的。
; 这种解法，虽然可以传入不同个数的 keys。但同一个表格中每个 keys 的个数最好相同，不适合在同一个表格中混用不同个数的 keys。
; [练习 3.25 - 解法 a] 反而会更简单，也更通用。

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (lookup key-list table)
  (if (list? key-list)
      (let ((record-or-subtable (assoc (car key-list) (cdr table))))
        (if record-or-subtable
            (if (null? (cdr key-list))  ; 判断记录或者子表格。没有多余的 keys, 是记录。有多余的 keys, 就是表格。
                (cdr record-or-subtable)
                (lookup (cdr key-list) record-or-subtable))
            false))
      (lookup (list key-list) table)))  ; 将单个键转换成列表

(define (insert! key-list value table)
  (define (insert-record! record table)
    (set-cdr! table (cons record (cdr table))))
  
  (if (list? key-list)
      (let ((record-or-subtable (assoc (car key-list) (cdr table))))
        (if (null? (cdr key-list))      ; 判断记录或者子表格。没有多余的 keys, 是记录。有多余的 keys, 就是表格。
            (let ((record record-or-subtable))
              (if record
                  (set-cdr! record value)
                  (insert-record! (cons (car key-list) value) table)))
            
            (let ((subtable record-or-subtable))
              (if subtable
                  (insert! (cdr key-list) value subtable)
                  (let ((new-subtable (list (car key-list))))
                    (insert! (cdr key-list) value new-subtable)
                    (insert-record! new-subtable table))))))
      (insert! (list key-list) value table))) ; 将单个键转换成列表

(define (make-table)
  (list '*table*))

;;;;;;;;;;;;;;;;;;;;;;;
(define t (make-table))
(insert! 'a 1000 t)  
(lookup 'a t)

; 插入三个键
(insert! (list 'key1 'key2 'key3) 123 t)
(lookup (list 'key1 'key2 'key3) t)

; 修改三个键
(insert! (list 'key1 'key2 'key3) 'hello-world t)  
(lookup (list 'key1 'key2 'key3) t)

