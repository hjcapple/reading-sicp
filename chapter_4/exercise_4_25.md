## P278 - [练习 4.25]

题目中的完整代码为

``` Scheme
(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= n 1)
          (* n (factorial (- n 1)))
          1))

(factorial 5)
```

### a)

在常规的应用序 Scheme 中，计算 `(factorial 5)` 会引起死循环。

unless 是个函数，在应用序中求值函数需要预先计算参数的值。于是就需要计算 `(factorial (- n 1)`。但在计算 `factorial` 时，又碰到 unless 函数。于是又需要再次计算 `factorial`。这个过程不会停止。


### b)

在正则序的 Scheme 中，计算 `(factorial 5)` 会正确返回 120。可以在 [lazyeval.scm](./lazyeval.scm) 中验证正则序求值。

在正则序中，求值 unless 时，会对参数延迟求值。当 n 等于 1 时。下面代码

``` Scheme
(* n (factorial (- n 1))
```

并不会被真正求值。unless 根据条件可直接返回 1。于是 `factorial` 函数就有了一个停止条件，
