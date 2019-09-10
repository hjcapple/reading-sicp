## monte-carlo、cesaro-test 简述

书中 [3.1.2](./monte_carlo.scm) 使用了两个函数，一个是 monte-carlo，一个是 cesaro-test。

### 蒙特卡罗方法

蒙特卡罗(Monte Carlo)是摩纳哥的一座城市，有很多赌场。

蒙特卡罗方法也称统计模拟方法，生成大量随机数去测试系统，通过概率统计得到问题的解。

此方法诞生于上个世纪40年代美国的"曼哈顿计划"，主要由斯塔尼斯拉夫·乌拉姆(Stanislaw Marcin Ulam) 和 冯·诺伊曼(John von Neumann) 提出。

乌拉姆的叔叔，经常在摩纳哥的蒙特卡洛的赌场输钱。这种方法基于概率，于是以蒙特卡罗(Monte Carlo)命名。

### 切萨罗

Ernesto Cesàro 是位意大利数学家。cesaro-test 求 pi 实现如下

``` Scheme
(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))
  
(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))
```

cesaro-test 求 pi 的数学原理是：随机选择两个数字，他们互质的概率是 (pi^2)/6。[初步证明参考这里](http://www.pi314.net/eng/cesaro.php)

假如两个数字互质。

那么他们并非都是 2 的倍数。都是 2 的倍数的概率为 (1/2) * (1/2), 并非都是 2 的倍数，概率就为 [1 - (1/2)^2]

同理

* 他们并非都是 3 的倍数，概率就为 [1 - (1/3)^2]。
* 他们并非都是 5 的倍数，概率就为 [1 - (1/5)^2]。
* 他们并非都是 7 的倍数，概率就为 [1 - (1/7)^2]。
* ....

两数互质，他们并非都是任何素数的倍数，并且同时成立。于是其概率为

```
P = [1 - (1/2)^2] * [1 - (1/3)^2] * [1 - (1/5)^2] * [1 - (1/7)^2] ....
```

根据[欧拉乘积公式](https://zh.wikipedia.org/wiki/欧拉乘积)，将素数乘法和自然数加法关联起来。（额外参考[黎曼ζ函数](https://zh.wikipedia.org/wiki/黎曼ζ函數))。

<img src="euler_product.svg"/>

于是随机两数互质的概率为

```
P = 1 + (1/2)^2 + (1/3)^2 + (1/4)^2 .....
```

这要求所有自然数平方的倒数和，是著名的[巴塞尔问题](https://zh.wikipedia.org/wiki/巴塞尔问题)。第一个给出上式精确值的也是欧拉，为 (pi^2)/6。




