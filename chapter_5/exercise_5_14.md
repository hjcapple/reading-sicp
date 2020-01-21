## P373 - [练习 5.14]

* [完整的代码在这里](./exercise_5_14.scm)

在[阶乘机器](./fact-machine.scm)的基础上，循环设置 n，打印堆栈的统计信息。打印出来的信息如下:

```
n: 1
(total-pushes = 0 maximum-depth = 0)
n: 2
(total-pushes = 2 maximum-depth = 2)
n: 3
(total-pushes = 4 maximum-depth = 4)
n: 4
(total-pushes = 6 maximum-depth = 6)
n: 5
(total-pushes = 8 maximum-depth = 8)
n: 6
(total-pushes = 10 maximum-depth = 10)
n: 7
(total-pushes = 12 maximum-depth = 12)
n: 8
(total-pushes = 14 maximum-depth = 14)
n: 9
(total-pushes = 16 maximum-depth = 16)
n: 10
(total-pushes = 18 maximum-depth = 18)
```

做个表格

|  n            | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
|-------------- |----|----|----|----|----|----|----|----|----|----|
| total-pushes  | 0  | 2  | 4  | 6  | 8  | 10 | 12 | 14 | 16 | 18 |
| maximum-depth | 0  | 2  | 4  | 6  | 8  | 10 | 12 | 14 | 16 | 18 |

观察后，可以得到其关系

* `total-pushes = 2 * (n - 1)`
* `maximum-depth = 2 * (n - 1)`

