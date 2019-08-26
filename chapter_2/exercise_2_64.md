## P108 - [练习 2.64]

``` Scheme
#lang racket

(define (make-tree entry left right)
  (list entry left right))

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
            
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(list->tree '(1 3 5 7 9 11)) ;; '(5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))
```

### a)

partial-tree 的输入是个排序的列表。其实现中，将数据分为左右两边，取出中间数值。递归调用 partial-tree，将左边数据变为平衡二叉树，再将右边数据变成平衡二叉树，之后使用中间数值创建出新的树节点。输入是排序的列表，中间数值必然会比左边数据大，而比右边数据小。而划分时，让左右数据尽量相等（至多相差 1），于是整个递归过程，就产生出平衡二叉树。

`(list->tree '(1 3 5 7 9 11))` 产生的树为

```
         5 
        / \
       /   \
      /     \
     /       \
    1         9
   / \       / \
  /   \     /   \
null   3   7    11
```

### b)

假设列表长度为 N。list-tree 调用 partial-tree，每次将节点数分为左右两半，而每次都需要递归调用 partial-tree，分别处理左右两半。因而算法的复杂度为 O(N)。实际上每个列表元素都调用了一次 make-tree。

