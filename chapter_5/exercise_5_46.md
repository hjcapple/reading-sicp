## P429 - [练习 5.46]

### 编译 fib

编译运行 [fib 的代码](./exercise_5_46_a.scm), 依次敲入

``` Scheme
(fib 2)   ; (total-pushes = 17 maximum-depth = 5)
(fib 3)   ; (total-pushes = 27 maximum-depth = 8)
(fib 4)   ; (total-pushes = 47 maximum-depth = 11)
(fib 5)   ; (total-pushes = 77 maximum-depth = 14)
(fib 6)   ; (total-pushes = 127 maximum-depth = 17)
(fib 7)   ; (total-pushes = 207 maximum-depth = 20)
(fib 8)   ; (total-pushes = 337 maximum-depth = 23) 
(fib 9)   ; (total-pushes = 547 maximum-depth = 26)
(fib 10)  ; (total-pushes = 887 maximum-depth = 26)
```

得到 `total-pushes` 和 `maximum-depth` 的信息。列个表格

|  n               | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
|--------------    |----|----|----|----|----|----|----|----|----|
| maximum-depth    | 5  | 8  | 11 | 14 | 17 | 20 | 23 | 26 | 26 |
| total-pushes     | 17 | 27 | 47 | 77 | 127| 207| 337| 547| 887|
| Fib(n+1)         | 2  | 3  | 5  | 8  | 13 | 21 | 34 | 55 | -  |

利用跟 [练习 5.29](./exercise_5_29.md) 类似的分析，得到

```
maximum-depth = 5 + (n - 2) * 3 = 3 * n - 1
total-pushes = 10 * Fib(n+1) - 3
```

### 专用 fib 机器

执行手工打造的[专用 fib 机器](./exercise_5_46_b.scm), 得到 `total-pushes` 和 `maximum-depth` 的信息。列个表格

|  n               | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
|--------------    |----|----|----|----|----|----|----|----|----|
| maximum-depth    | 2  | 4  | 6  | 8  | 10 | 12 | 14 | 16 | 18 |
| total-pushes     | 4  | 8  | 16 | 28 | 48 | 80 | 132| 216| 352|
| Fib(n+1)         | 2  | 3  | 5  | 8  | 13 | 21 | 34 | 55 | -  |

利用跟 [练习 5.29](./exercise_5_29.md) 类似的分析，得到

```
maximum-depth = 2 + (n - 2) * 2 = 2 * n - 2
total-pushes = 4 * Fib(n+1) - 4
```

### 解释 fib

从 [练习 5.29](./exercise_5_29.md) 得到，使用求值器解释运行 fib，其堆栈信息为

```
maximum-depth = 13 + (n - 2) * 5 = 5 * n + 3
total-pushes = 56 * Fib(n+1) - 40
```

### 对比

对比堆栈操作的利用率。手工打造的 fib 机器优于编译，而编译版本优于解释执行。
