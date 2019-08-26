#lang racket

;; P108 - [练习 2.65]

(define (entry tree)
  (car tree))

(define (left-branch tree)
  (cadr tree))

(define (right-branch tree)
  (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x null null))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

;; 集合作为排序列表中的代码
(define (intersection-set-orderlist set1 set2)
  (if (or (null? set1) (null? set2)) 
      '()
      (let ((x1 (car set1))
            (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set-orderlist (cdr set1) (cdr set2))))
              ((< x1 x2)
               (intersection-set-orderlist (cdr set1) set2))
              ((< x2 x1)
               (intersection-set-orderlist set1 (cdr set2)))))))

;; 练习 2.62
(define (union-set-orderlist set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else 
          (let ((x1 (car set1))
                (x2 (car set2)))
              (cond ((= x1 x2)
               (cons x1 (union-set-orderlist (cdr set1) (cdr set2))))
              ((< x1 x2)
               (cons x1 (union-set-orderlist (cdr set1) set2)))
              ((< x2 x1)
               (cons x2 (union-set-orderlist set1 (cdr set2)))))))))

;; 练习 2.63
(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree) result-list)))))
  (copy-to-list tree null))


;; 练习 2.64
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons null elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts) right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

;; 此实现利用了之前章节和习题的程序
;; 1) 见 [练习 2.63] 中的分析。tree-list 返回一个排序列表。
;; 2) 执行排序列表的 union-set, 返回一个排序列表
;; 3) 执行 list->tree，将列表重新转换为树。
;; 三个步骤的时间复杂度都为 O(N), 因而三个步骤依次执行，总复杂度也是 O(N)
(define (union-set set1 set2)
  (list->tree (union-set-orderlist (tree->list set1)
                                   (tree->list set2))))

(define (intersection-set set1 set2)
  (list->tree (intersection-set-orderlist (tree->list set1)
                                          (tree->list set2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define a (list->tree '(2 4 6 8 10)))
(define b (list->tree '(3 4 5 6 7 8 9)))

(element-of-set? 3 a)
(element-of-set? 9 b)

(adjoin-set 7 a)
(adjoin-set 10 a)
(adjoin-set 11 a)
(intersection-set a b)
(union-set a b)
