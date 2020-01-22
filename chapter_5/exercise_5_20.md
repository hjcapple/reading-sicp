## P377 - [练习 5.20]

``` Scheme
(define x (cons 1 2))
(define y (list x x))
```

的盒子指针图，和存储器向量图如下

<img src="./exercise_5_20.png"/>

y 相当于

``` Scheme
(cons x (cons x '()))
```

这里假设分配顺序是从右往左，先分配 `(const x '())`。因而 y 指向 Index = 3 的位置。

如果分配顺序是从左往右，Index 2、3 位置存储的具体数据会有所调整，y 就指向 Index = 2 的位置。

