## P396 - [练习 5.27]

使用[求值器](./ch5-eceval.scm)执行下面代码

``` Scheme
(define (factorial n)
  (if (= n 1)
      1
      (* (factorial (- n 1)) n)))

(factorial 1)   ; (total-pushes = 16 maximum-depth = 8)
(factorial 2)   ; (total-pushes = 48 maximum-depth = 13)
(factorial 3)   ; (total-pushes = 80 maximum-depth = 18)
(factorial 4)   ; (total-pushes = 112 maximum-depth = 23)
(factorial 5)   ; (total-pushes = 144 maximum-depth = 28)
(factorial 6)   ; (total-pushes = 176 maximum-depth = 33)
(factorial 7)   ; (total-pushes = 208 maximum-depth = 38)
(factorial 8)   ; (total-pushes = 240 maximum-depth = 43) 
(factorial 9)   ; (total-pushes = 272 maximum-depth = 48)
(factorial 10)  ; (total-pushes = 304 maximum-depth = 53)
```

得到 `total-pushes` 和 `maximum-depth` 的统计信息。

列个表格

|  n               | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
|--------------    |----|----|----|----|----|----|----|----|----|----|
| maximum-depth    | 8 | 13 | 18 | 23 | 28 | 33 | 38 | 43 | 48 | 53 |
| total-pushes     | 16 | 48 | 80| 112| 144| 176| 208| 240| 272| 304|

### a)

`maximum-depth` 的数值为等差数列，两项间相差 5。可以推算出

```
maximum-depth = 8 + (n - 1) * 5 = 5 * n + 3
``` 

### b)

`maximum-depth` 的数值为等差数列，两项间相差 32。可以推算出

```
total-pushes = 16 + 32 * (n - 1) = 32 * n - 16
```

### c) 

结合 [练习 5.26](./exercise_5_26.md) 的结果，可以得到表格

|                           | maximum-depth  | total-pushes  | 
|---------------------------|----------------|---------------|
| 递归的阶乘(练习 5.27 的代码)  | 5 * n + 3      | 32 * n - 16   |
| 迭代的阶乘(练习 5.26 的代码)  | 10             | 35 * n + 29   |

