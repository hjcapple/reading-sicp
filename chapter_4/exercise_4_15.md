## P268 - [练习 4.15]

这是著名的停机问题。采用反证法。

假设可以正确实现 `halt?`, `(halt? try try)` 就会返回 true 或者 false。

### 情况 1

假如 `(halt? try try)` 返回 true, 就表示 `(try try)` 会停机。但我们展开 `(try try)` 的计算过程为

``` Scheme
(if (halt? try try)	; true
    (run-forever)
    'halted)
```

很明显，判断后，会进入 `(run-forever)`, `(try try)` 是不会停机的。跟 `(halt? try try)` 返回 true 矛盾。

### 情况 2

假如 `(halt? try try)` 返回 false，就表示 `(try try)` 不会停机。但我们展开 `(try try)` 的计算过程为：

``` Scheme
(if (halt? try try)	; false
    (run-forever)
    'halted)
```

很明显，判断后，会返回 'halted，`(try try)` 会停机。跟 `(halt? try try)` 返回 false 矛盾。

### 结论

`(halt? try try)` 无论返回 true，还是返回 false 都会产生矛盾。因而，最原始的假设不成立，并不能正确实现 `halt?` 函数。万能的停机 `halt?` 函数不存在。

