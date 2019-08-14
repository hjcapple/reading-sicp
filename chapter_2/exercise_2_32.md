## P76 - [练习 2.32]

``` Scheme
#lang racket

(define (subsets s)
  (if (null? s)
      (list null)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x))
                          rest)))))

;;;;;;;;;;;;;;;;;;;;;;;;;
(subsets (list 1 2 3))
```

上面递归代码中。先计算 (cdr s) 的子集，记为 rest，于是 rest 就不会包含 (car s)。将 rest 每个元素添加 (car s)，就一定会包含 (car s)。递归过程将 s 的子集分为两部分，一部分不包含 (car s), 一部分包含 (car s)。两部分合起来，自然就是 s 的子集。

比如要计算 s = '(1 2 3) 的子集。先计算好 (cdr s) = '(2 3) 的子集（这里是递归）, 得到

``` Scheme
'(() (3) (2) (2 3)) ;; 1
```

将其使用 map，添加上 (car s) = 1, 得到

``` Scheme
'((1) (1 3) (1 2) (1 2 3)) ;; 2
```

之后将列表 1 和 2 使用 append 合并起来。就得到 s = '(1 2 3) 的子集。

``` Scheme
'(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
```

而要计算 '(2 3) 的子集，又会先计算 '(3) 的子集。如此类推。每次列表数目减少 1，到达终止条件。
