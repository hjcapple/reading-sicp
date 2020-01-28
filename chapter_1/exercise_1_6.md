## P16 - [练习 1.6]

``` Scheme
(define (new-if predicate then-caluse else-clause)
  (cond (predicate then-caluse)
        (else else-clause)))
```

上述定义中，`predicate`，`then-caluse`, `else-clause` 都是 `new-if` 的参数。

在应用序下，全部参数需要首先求值。于是

``` Scheme
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
```

不管 `good-enough?` 返回值如何，参数 `(sqrt-iter (improve guess x) x))` 都必须首先求值。这个求值又会再次触发 `new-if`，于是它的参数 `sqrt-iter` 又会再次需要求值。

也就是说 `sqrt-iter` 中，根本没有停止条件。这个递归过程不会停止，于是堆栈溢出。

特殊的 `if` 会先根据条件判断，当条件为真时，then-clause 分支会被求值，否则 else-clause 分支被求值。只会有一个分支求值。并不会像 `new-if` 一样，同时对两个分支求值。

因而自定义 `new-if` 并不能替代特殊的 `if`。

-------

而在正则序下，`(sqrt-iter (improve guess x) x))` 不会被求值。`sqrt-iter` 会每次展开一层，会先判断 `good-enough?`，再求值不同分支。

在正则序下 `new-if` 表现就跟原来的 `if` 一样，程序运行正常。

