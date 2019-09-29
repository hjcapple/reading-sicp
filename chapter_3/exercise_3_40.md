## P212 - [练习 3.40]

* [完整程序](./exercise_3_40.scm)

### a) 

为方便描述，标记两个进程。

```
p1: (set! x (* x x))
p2: (set! x (* x x x))
```

p1 获取 x 两次，设置 1 次。p2 获取 x 三次，设置 1 次。类似 [练习 3.38](./exercise_3_38.md) 的分析。我们将 

* p1 拆分成基本操作 p1-get-1、p1-get-2、p1-set
* p2 拆分成基本操作 p2-get-1、p2-get-2、p2-get-3、p2-set

每个操作都可交错进行。生成下面列表的全部排列

``` Scheme
(list 'p1-get-1 'p1-get-2 'p1-set 'p2-get-1 'p2-get-2 'p2-get-3 'p2-set)
```
7 项排列有 7! = 5040 种情况。但 get 必须在 set 之前。有下面的强制顺序

* p1-get-1、p1-get-2、p1-set
* p2-get-1、p2-get-2、p2-get-3、p2-set

于是过滤掉一些排列，全部可能的情况为 `7! / (3! * 4!) = 35` 种。

我们用程序模拟这 35 种不同顺序，[完整程序在这里](./exercise_3_40.scm)。

输出

```
(p1-get-1 p1-get-2 p1-set p2-get-1 p2-get-2 p2-get-3 p2-set): 1000000
(p1-get-1 p1-get-2 p2-get-1 p1-set p2-get-2 p2-get-3 p2-set): 100000
(p1-get-1 p1-get-2 p2-get-1 p2-get-2 p1-set p2-get-3 p2-set): 10000
.....
(p2-get-1 p2-get-2 p2-get-3 p1-get-1 p1-get-2 p2-set p1-set): 100
(p2-get-1 p2-get-2 p2-get-3 p1-get-1 p2-set p1-get-2 p1-set): 10000
(p2-get-1 p2-get-2 p2-get-3 p2-set p1-get-1 p1-get-2 p1-set): 1000000
'(100 1000 10000 100000 1000000)
```

因此 x 的所有可能结果为 `(100 1000 10000 100000 1000000)`。

### b)

当改成串行化过程，p1 和 p2 都是不可分割的整体。于是就只剩两种顺序

```
x = 10
p1: (set! x (* x x))
p2: (set! x (* x x x))
```

这种顺序，x 最后结果为 1000000。

```
x = 10
p2: (set! x (* x x x))
p1: (set! x (* x x))
```
这种顺序，x 最后结果为 1000000。

因此改用串行化过程后，x 最后是唯一的结果 1000000。
