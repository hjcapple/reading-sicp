## P396 - [练习 5.29]

使用[求值器](./ch5-eceval.scm)执行下面代码

``` Scheme
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

(fib 2)   ; (total-pushes = 72 maximum-depth = 13)
(fib 3)   ; (total-pushes = 128 maximum-depth = 18)
(fib 4)   ; (total-pushes = 240 maximum-depth = 23)
(fib 5)   ; (total-pushes = 408 maximum-depth = 28)
(fib 6)   ; (total-pushes = 688 maximum-depth = 33)
(fib 7)   ; (total-pushes = 1136 maximum-depth = 38)
(fib 8)   ; (total-pushes = 1864 maximum-depth = 43) 
(fib 9)   ; (total-pushes = 3040 maximum-depth = 48)
(fib 10)  ; (total-pushes = 4944 maximum-depth = 53)
```

得到 `total-pushes` 和 `maximum-depth` 的信息。

列个表格。为了方便回答 b，第三行也列出斐波那契的计算结果。

|  n               | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
|--------------    |----|----|----|----|----|----|----|----|----|
| maximum-depth    | 13 | 18 | 23 | 28 | 33 | 38 | 43 | 48 | 53 |
| total-pushes     | 72 | 128| 240| 408| 688|1136|1864|3040|4944|
| Fib(n)           | 1  | 2  | 3  | 5  | 8  | 13 | 21 | 34 | 55 |

### a)

从表格可以看出，maximum-depth 的值是个等差数列，两项间相差 5，可以推算出

```
maximum-depth = 13 + (n - 2) * 5 = 5 * n + 3
```

其中 n >= 2。

### b)

为了方便表示，我们用 S(n) 来表示 `total-pushes`，其中 n >= 2。于是有

```
S(2) = 72
S(3) = 128
S(4) = 240
S(5) = 408
S(6) = 688
....
```

根据上面的数值，可以推算出

```
S(n) = S(n - 1) + S(n - 2) + 40 ; n >= 4
```

比较 S(n) 和 Fib(n+1) 的数值

|  n       | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  |
|--------- |----|----|----|----|----|----|----|----|
| S(n)     | 72 | 128| 240| 408| 688|1136|1864|3040|
| Fib(n+1) | 2  | 3  | 5  | 8  | 13 | 21 | 34 | 55 |

根据题目提示，两者是线性关系。列个方程，可以求出

```
S(n) = 56 * Fib(n+1) - 40 ; n >= 2
```

### c)

现在来证明 b) 中 `S(n)` 和 `Fib(n+1)` 的线性关系。采用数学归纳法。

首先 n = 2 和 n = 3 时候，基础情况下，关系成立。

```
S(2) = 56 * Fib(3) - 40 = 56 * 2 - 40 = 72
S(3) = 56 * Fib(4) - 40 = 56 * 3 - 40 = 128
```

于是递归情况下，有

```
S(n) = S(n - 1) + S(n - 2) + 40
=> S(n) = [56 * Fib(n) - 40] + [56 * Fib(n - 1) - 40] + 40
=> S(n) = 56 * [Fib(n) + Fib(n - 1)] - 40
=> S(n) = 56 * Fib(n+1) - 40
```

所以，在递归情况下，关系也成立。因而下面线性关系成立。

```
S(n) = 56 * Fib(n+1) - 40 ; n >= 2
```
