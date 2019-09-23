#lang sicp

;; P187 - [练习 3.26]

; 树的递归查找和插入，跟 [练习 2.66] 相似。但有几个地方不同
; 1. 将 key value left right 放在一起，省去中间的 entry。
; 2. make-table 中 添加了 compare-key 过程作为参数，可以定制比较函数。
; 3. insert-tree! 可修改树节点。
; 4. make-table 中定义局部对象 local-tree。

(define (make-tree key value left right)
  (cons (cons key value) (cons left right)))

(define (tree-key t) (car (car t)))
(define (tree-value t) (cdr (car t)))
(define (tree-left-branch t) (car (cdr t)))
(define (tree-right-branch t) (cdr (cdr t)))

(define (set-tree-value! t value) (set-cdr! (car t) value))
(define (set-tree-left-branch! t left) (set-car! (cdr t) left))
(define (set-tree-right-branch! t right) (set-cdr! (cdr t) right))

(define (make-table compare-key)
  (let ((local-tree '()))
    (define (lookup-tree key tree)
      (if (null? tree)
          false
          (let ((compare-result (compare-key key (tree-key tree))))
            (cond ((eq? '= compare-result) (tree-value tree))
                  ((eq? '< compare-result) (lookup-tree key (tree-left-branch tree)))
                  ((eq? '> compare-result) (lookup-tree key (tree-right-branch tree)))))))
    
    (define (insert-tree! key value tree)
      (if (null? tree)
          (make-tree key value '() '())
          (let ((compare-result (compare-key key (tree-key tree))))
            (cond ((eq? '= compare-result) 
                   (set-tree-value! tree value))
                  ((eq? '< compare-result)
                   (set-tree-left-branch! tree (insert-tree! key value (tree-left-branch tree))))
                  ((eq? '> compare-result)
                   (set-tree-right-branch! tree (insert-tree! key value (tree-right-branch tree)))))
            tree)))
    
    (define (lookup key) (lookup-tree key local-tree))
    (define (insert! key value) 
      (set! local-tree (insert-tree! key value local-tree)))
    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define (insert! key value t) ((t 'insert-proc!) key value))
(define (lookup key t) ((t 'lookup-proc) key))

;;;;;;;;;;;;;;;;;;;;;
(define (compare-number x y)
  (cond ((= x y) '=)
        ((> x y) '>)
        ((< x y) '<)))

(define t (make-table compare-number))
(for-each (lambda (pair)
            (insert! (car pair) (cdr pair) t))
          '((1 "Yellow")
            (3 "Red")
            (9 "Green")
            (4 "White")
            (2 "Blue")))

(lookup 9 t)
(lookup 10 t)
(lookup 4 t)

(insert! 4 "Black" t)
(lookup 4 t)
