## P210 - [练习 3.38]

* [问题 a 完整程序](./exercise_3_38_a.scm)
* [问题 b 完整程序](./exercise_3_38_b.scm)

### a)

Peter、Paul、Mary 三个进程按某种顺序运行，其排列有 6 种。比如顺序 `(Peter Paul Mary)`，相当于执行下面代码：

``` Scheme
#lang racket

(define balance 100)

(set! balance (+ balance 10))             ; 'Peter
(set! balance (- balance 20))             ; 'Paul
(set! balance (- balance (/ balance 2)))  ; 'Mary

(display balance)
```

balance 的最后结果为 45。

但为避免手动调整代码顺序，可生成 `(list 'Peter 'Paul 'Mary)` 每个排列，遍历每种顺序。

[完整程序在这里](./exercise_3_38_a.scm)。

输出为:

```
(Peter Paul Mary): 45
(Peter Mary Paul): 35
(Paul Peter Mary): 45
(Paul Mary Peter): 50
(Mary Peter Paul): 40
(Mary Paul Peter): 40
```

根据时序不同，balance 的可能值为 45、35、50、40。

### b)

假如允许每个进程交错进行。每个进程都可分为 3 步：

1. 获取 balance。
2. 计算新值。
3. 设置 balance。

3 步随时可被其它进程打断。为得到全部结果，我们需要遍历每种可能的顺序。

观察到第 2 步（计算新值）是每个进程独立的，其顺序并不会影响最终结果。因此为了简化计算，可以简化成 2 步。

1. 获取 balance。
2. 计算新值，设置 balance。

于是我们生成 

`(list 'Peter-Get 'Peter-Set 'Paul-Get 'Paul-Set 'Mary-Get 'Mary-Set)`

的全部排列，6 项的排列共有 720 种情况。

但需要注意每个进程中，必须先执行 get, 再执行 set。因此

* 'Peter-Get 必须排在 'Peter-Set 前面
* 'Paul-Get 必须排在 'Paul-Set 前面
* 'Mary-Get 必须排在 'Mary-Set 前面

过滤掉某些排列，最后的可能情况为 `720 / (2! * 2! * 2!) = 90` 种。原始排列中，'Peter-Get、'Peter-Set 顺序不固定，两者谁在前的可能性一样。因此过滤掉每种强制顺序，都需要除以 2!。有 3 种强制顺序，也就除以 (2! * 2! * 2!)。

注意这里有个细节，Mary 的进程为

``` Scheme
(set! balance (- balance (/ balance 2))
```

根据解释器的实现，Mary 可能需要获取 balance 两次，也可能被优化成只获取 balance 一次。假如是两次的情况，就需要拆分成 Mary-Get-1、Mary-Get-2 进行排列，并且 Mary-Get-1 在 Mary-Get-2 前面。

这样就会出现 7 项排列共 5040 种情况，再过滤掉强制顺序，可能情况为 `5040 / (2! * 2! * 3!) = 210` 种。

我们按照 Mary 进程只获取 balance 一次，共 6 项排列进行分析。会稍微简单些，方便画图，实际书中后续章节是按照多次访问变量来计算的，跟这里有点不同。[完整程序在这里](./exercise_3_38_b.scm)。

输出如下（输出太长，没有全部列出):

```
(Peter-Get Peter-Set Paul-Get Paul-Set Mary-Get Mary-Set): 45
(Peter-Get Peter-Set Paul-Get Mary-Get Paul-Set Mary-Set): 55
(Peter-Get Peter-Set Paul-Get Mary-Get Mary-Set Paul-Set): 90
(Peter-Get Peter-Set Mary-Get Paul-Get Paul-Set Mary-Set): 55
(Peter-Get Peter-Set Mary-Get Paul-Get Mary-Set Paul-Set): 90
(Peter-Get Peter-Set Mary-Get Mary-Set Paul-Get Paul-Set): 35
(Peter-Get Paul-Get Peter-Set Paul-Set Mary-Get Mary-Set): 40
....
(Mary-Get Paul-Get Mary-Set Paul-Set Peter-Get Peter-Set): 90
(Mary-Get Mary-Set Peter-Get Peter-Set Paul-Get Paul-Set): 40
(Mary-Get Mary-Set Peter-Get Paul-Get Peter-Set Paul-Set): 30
(Mary-Get Mary-Set Peter-Get Paul-Get Paul-Set Peter-Set): 60
(Mary-Get Mary-Set Paul-Get Peter-Get Peter-Set Paul-Set): 30
(Mary-Get Mary-Set Paul-Get Peter-Get Paul-Set Peter-Set): 60
(Mary-Get Mary-Set Paul-Get Paul-Set Peter-Get Peter-Set): 40
'(60 30 50 110 80 40 35 90 55 45)
```

根据顺序不同，最终 balance 的可能值为 `(60 30 50 110 80 40 35 90 55 45)`。

假如 Mary 进程获取 balance 两次，原理是一样的，稍微改改程序。定义 mary-balance-1、mary-balance-2 两个变量。最终 balance 的可能值为 `(50 60 30 110 70 80 25 40 90 55 35 45)`。[完整程序在这里](./exercise_3_38_b_2.scm)。

### 画图

不可能每种情况都画出来，只画

```
(Mary-Get Paul-Get Mary-Set Paul-Set Peter-Get Peter-Set): 90
```

这种情况的时序图。

<img src="./exercise_3_38.png"/>

