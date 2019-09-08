## P29 - [练习 1.15]

在 p 中打印输出。

``` Scheme
#lang racket

(define (cube x) (* x x x))

(define (p x)
  (display "call p, arg = ")
  (displayln x)
  (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

(sine 12.15)
```

输出

```
call p, arg = 0.049999999999999996
call p, arg = 0.1495
call p, arg = 0.4351345505
call p, arg = 0.9758465331678772
call p, arg = -0.7895631144708228
-0.39980345741334
```

a) 可以看到求值 `sine(12.15)` 时，p 被调用了 5 次。

-------

b) 求值 `sine(a)` 时，每次 a 被除以 3.0。而 sine 是个递归过程，每次递归 a / 3.0。可知 sine 的空间和时间，复杂度为 `O(logA)`，对数增长。每次 a 增加 3 倍，p 的调用次数增加 1。

```
(sine 1),     p 调用 3  次。
(sine 3),     p 调用 4  次。
(sine 9),     p 调用 5  次。
(sine 27),    p 调用 6  次。
(sine 81),    p 调用 7  次。
(sine 243),   p 调用 8  次。
(sine 729),   p 调用 9  次。
(sine 2187),  p 调用 10 次。
(sine 6561),  p 调用 11 次。
(sine 19683), p 调用 12 次。
```
