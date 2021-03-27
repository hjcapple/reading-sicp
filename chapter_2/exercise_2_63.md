## P108 - [练习 2.63]

``` Scheme
#lang racket

(define (entry tree)
  (car tree))

(define (left-branch tree)
  (cadr tree))

(define (right-branch tree)
  (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (tree->list-1 tree)
  (if (null? tree)
      null 
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree) result-list)))))
  (copy-to-list tree null))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define a (make-tree 7
                     (make-tree 3
                                (make-tree 1 null null)
                                (make-tree 5 null null))
                     (make-tree 9
                                null 
                                (make-tree 11 null null))))
(define b (make-tree 3
                     (make-tree 1 null null)
                     (make-tree 7
                                (make-tree 5 null null)
                                (make-tree 9
                                           null
                                           (make-tree 11 null null)))))

(define c (make-tree 5
                     (make-tree 3
                                (make-tree 1 null null)
                                null)
                     (make-tree 9
                                (make-tree 7  null null)
                                (make-tree 11 null null))))

(tree->list-1 a) ; '(1 3 5 7 9 11)
(tree->list-2 a) ; '(1 3 5 7 9 11)

(tree->list-1 b) ; '(1 3 5 7 9 11)
(tree->list-2 b) ; '(1 3 5 7 9 11)

(tree->list-1 c) ; '(1 3 5 7 9 11)
(tree->list-2 c) ; '(1 3 5 7 9 11)
```

### a)

分析 `tree->list-1` 的递归实现，使用了 append 和 cons 连接起列表。最终列表的顺序是 left-branch，entry，right-branch。

同样 `tree->list-2` 中的 `(copy-to-list tree result-list)` 目的是将从 tree 收集到的表，放在 result-list 前面。里面也使用 cons。最终列表的顺序也是 left-branch，entry，right-branch。

因此 `tree->list-1` 和 `tree->list-2` 的实现中，列表顺序是相同的。先收集 left-branch 的数据，再收集 entry，之后收集 right-branch 的数据。

而在二叉树的表示中，根据定义，left-branch 的数据比 entry 要小，right-branch 的数据比 entry 要大。于是 P106 页中的二叉树，无论它的具体结构如何，收集到的列表，数据肯定是从小到大排列。

结论是，`tree->list-1` 和 `tree->list-2` 对所有的树都有相同的结果。更进一步，图 2-16 中的不同结构的树，都有相同的结果，都是从小到大排列的列表，为 `(1 3 5 7 9 11)`。

### b)

假设树中节点数目为 N。

`tree->list-1` 中每遍历一个节点，调用 1 次 append 和 1 次 cons，总调用了 N 次 append 和 cons。单个 cons 的时间复杂度为 O(1)，而 append 随着列表长度增大而增大，这样似乎 `tree->list-1` 的时间复杂度为 O(N ^ 2)。

但是注意到，每次 append 都是左右子树，而平衡树左右子树的节点并非线性增长，而是每次的节点都被砍了一半。于是 tree->list-1 的复杂度应该是 O(N * logN)。

`tree->list-2` 中遍历一个节点，调用了 1 次 cons, 总调用了 N 次 cons。cons 的时间复杂度为 O(1), 于是 `tree->list-2` 的时间复杂度为 O(N)。

结论是，`tree->list-1` 的时间复杂度为 O(N * logN)，`tree->list-2` 的时间复杂度为 O(N)。`tree->list-2` 执行时间增长慢一些。

