## P226 - [练习 3.51]

[完整测试代码](./exercise_3_51.scm)

### a)

在 DrRacket 中

``` Scheme
(define x (stream-map show (stream-enumerate-interval 0 10)))
```

会输出 0。在 stream-map 中，调用了一次 show 来得到 `(car x)` 的值，其它部分延迟求值。

### b)

``` Scheme
(stream-ref x 5)
```

会输出

```
1
2
3
4
5
5
```

前面的 1 - 5 是 `show` 函数中 `display-line` 的打印值。最后的 5 是 `(stream-ref x 5)` 的返回值。

从打印结果可以看到，stream-map 的实现中使用了 delay 延迟求值。调用 stream-map 时，不会直接调用 show。当使用 stream-ref 时，才真正会触发 show 函数。并且到达 5 时，得到想要的结果，就可停下来了。并没有继续打印 6 - 10.

### c)

``` Scheme
(stream-ref x 7)
```

会输出

```
6
7
7
```

前面的 6 - 7 是 `show` 函数中 `display-line` 的打印值。最后的 7 是 `(stream-ref x 7)` 的返回值。

`cons-stream` 使用的 delay 函数有记忆性过程。正如 P225 所说的，记忆性过程在第一次运行过程的时，将计算结果保存起来。在随后再次求值时，就可简单返回已有的结果。

`(stream-ref x 5)` 之前调用过，0 - 5 已经调用 show 得到结果。于是 `(stream-ref x 7)`, 对于 0 - 5 的，可以返回已有的结果，并不用再次调用 show。因此并不会再次打印出 0 - 5。只会打印出之前还没有求值的 6 - 7。

