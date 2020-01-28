## P395 - [练习 5.26]

使用[求值器](./ch5-eceval.scm)执行下面代码

``` Scheme
(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

(factorial 1)  ; (total-pushes = 64 maximum-depth = 10)
(factorial 2)  ; (total-pushes = 99 maximum-depth = 10)
(factorial 3)  ; (total-pushes = 134 maximum-depth = 10)
(factorial 4)  ; (total-pushes = 169 maximum-depth = 10)
(factorial 5)  ; (total-pushes = 204 maximum-depth = 10)
(factorial 6)  ; (total-pushes = 239 maximum-depth = 10)
(factorial 7)  ; (total-pushes = 274 maximum-depth = 10)
(factorial 8)  ; (total-pushes = 309 maximum-depth = 10)
(factorial 9)  ; (total-pushes = 344 maximum-depth = 10)
(factorial 10) ; (total-pushes = 379 maximum-depth = 10)
```

得到 `total-pushes` 和 `maximum-depth` 的统计信息。

列个表格

|  n               | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
|--------------    |----|----|----|----|----|----|----|----|----|----|
| maximum-depth    | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10 |
| total-pushes     | 64 | 99 | 134| 169| 204| 239| 274| 309| 344| 379|

### a)

可以看出，最大堆栈深度 `maximum-depth` 跟 n 无关，都为 10。

### b)

从表格中，分析 total-pushes 的数值，可以看出 

```
99 - 64 = 35
134 - 99 = 35
169 - 134 = 35
...
```

于是 total-pushes 的数值为等差数列，两项间相差 35。可以推算出

```
total-pushes = 64 + 35 * (n - 1) = 35 * n + 29
```


