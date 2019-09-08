## P16 - [练习 1.7]

使用 [采用牛顿法求平方根](./newton_sqrt.scm) 中代码，来计算比较小的数字。

``` Scheme
(sqrt (* 0.03 0.03))
```

结果是 `0.04030062264654547`, 但正确结果应该是 `0.03`。这是因为 `good-enough?` 中的误差比较值只是 `0.001`。将误差值变少，计算结果会精确些，但对于更少的数字，精度还是不够。

假如计算比较大的数字

``` Scheme
(sqrt 100000000000000000.0)
```

结果是不会停止，但正确结果应该是 `316227766.016838`。这是因为 `guess = 316227766.01683795` 时。guess 的平方数很大，在浮点数中，对于特别大的数字，留给小数位的精度就不够。不足以表达两个大数字的差值。

于是 `(< (abs (- (square guess) x))` 总是大于误差值 0.001。而结果也不能再被改进了，于是就不断在 `guess = 316227766.01683795` 中循环，不会停下来。

--------

重新设计 `good-enough?`，检测新旧两次猜测值之间的比率。代码如下：

``` Scheme
#lang racket

(define (average x y) 
  (/ (+ x y) 2))

(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))

(define (square x) (* x x))

(define (sqrt-iter guess x)
  (if (new-good-enough? guess (improve guess x))
      guess
      (sqrt-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (new-good-enough? guess new-guess)
  (< (abs (/ (- guess new-guess) guess))
     0.001))

(define (sqrt x)
  (sqrt-iter 1.0 x))
```

修改之后，可以得出结果

```
(sqrt (* 0.03 0.03)) = 0.03002766742182557
(sqrt 100000000000000000.0) = 316228564.9222876
```

将 `new-good-enough?` 的误差精度提高，从 `0.001` 变为 `0.0000001`，计算结果精度也相应提高。

```
(sqrt (* 0.03 0.03)) = 0.030000000000002705
(sqrt 100000000000000000.0) = 316227766.01784706
```

跟 Scheme 自带的 sqrt 计算结果很接近了。


