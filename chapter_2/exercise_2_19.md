## P69 - [练习 2.19]

``` Scheme
#lang racket

(define (count-change amount coin-values)
  (cc amount coin-values))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else (+ (cc amount 
                     (except-first-denomination coin-values))
                 (cc (- amount 
                        (first-denomination coin-values))
                     coin-values)))))

(define no-more? null?)
(define except-first-denomination cdr)
(define first-denomination car)

;;;;;;;;;;;;;;;;;;

(define us-coins (list 50 25 10 5 1))
(count-change 100 us-coins)
(count-change 100 (list 10 25 50 1 5))
```

coin-values 的排列顺序并不会影响 cc 的计算答案。如上代码，传入两个不同顺序的列表，结果都是 292。

cc 的计算过程会展开整棵树，彻底遍历 coin-values 列表。树状展开的终止条件中，一个是 amount 数值，一个是 coin-values 列表的个数，跟 coin-values 列表中包含的具体数据无关。也就是说，无论传入的列表顺序如何，树状最终展开的具体树叶都是相同的，只是树叶的顺序有所不同。列表的顺序只会影响树叶的顺序，并不会影响树叶本身。而 cc 的最终计算结果，就是所有的树叶加起来，树叶的顺序并不会影响加起来的结果。因此列表的顺序，并不会影响 cc 最终的计算结果。

