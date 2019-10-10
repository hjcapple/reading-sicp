## P231 - [练习 3.57]

``` Scheme
(define fibs 
  (cons-stream 0
               (cons-stream 1
                            (add-streams (stream-cdr fibs) 
                                         fibs))))
```                                        

根据 fibs 的定义，要计算第 n 个数的值，需要先计算第 n - 1 和 n - 2 的值。有

```
(stream-ref fibs 0) = 0                                        
(stream-ref fibs 1) = 1                                        
(stream-ref fibs 2) = (stream-ref fibs 1) + (stream-ref fibs 0)
(stream-ref fibs 3) = (stream-ref fibs 2) + (stream-ref fibs 1)
(stream-ref fibs 4) = (stream-ref fibs 3) + (stream-ref fibs 2)
...
(stream-ref fibs n) = (stream-ref fibs (- n 1)) + (stream-ref fibs (- n 2))
```

### a)

对于具有记忆过程的 delay, 对于每个 i， `(stream-ref fibs i)` 只会被计算一次，再次计算直接返回结果。因而计算第 n 个斐波拉契数字，只会比第 n - 1 个数，多一次加法。将计算第 n 个数（从 0 开始数) 需要的加法次数记为 A(n), 而第 0、1 个数直接给出，并不需要加法。于是有

```
A(0) = 0
A(1) = 0
A(2) = 1
A(3) = 2
A(4) = 3
....
A(n) = n - 1
```

### b)

没有记忆过程的 delay，对于每个 i， `(stream-ref fibs i)` 每次调用都会被重复计算。
```
(stream-ref fibs n) = (stream-ref fibs (- n 1)) + (stream-ref fibs (- n 2))
```

此时所需的加法次数 A(n) 就会有

```
A(0) = 0
A(1) = 0
A(2) = A(1) + A(0) + 1 = 1
...
A(n) = A(n - 1) + A(n - 2) + 1 ; 需要将前面两个 fib 数字加起来，因而需要额外加 1
```

注意最后的递归公式跟 Fibs 的定义很相似，只是额外加 1。对比正式的 Fib 定义

```
Fib(0) = 0
Fib(1) = 1
Fib(2) = Fib(1) + Fib(0) = 1
...
Fib(n) = Fib(n - 1) + Fib(n - 2)
```

列个表

```
n   0   1   2   3   4   5   6   7   8   9   10  11  12
--------------------------------------------------------
A   0   0   1   2   4   7   12  20  33  54  88  143 --
Fib 0   1   1   2   3   5   8   13  21  34  55  89  144
```

从表格中可以作出合理猜测，有 

```
A(n) = Fib(n + 1) - 1	; n >= 0
```

用数学归纳法证明上式。

```
A(0) = 0, Fib(1) - 1 = 0
A(1) = 0, Fib(2) - 1 = 0
```

显然基础情况，公式成立。假设公式对于 n 成立，对于 n + 1 时，有

```
A(n + 1) = A(n) + A(n - 1) + 1
         = Fib(n + 1) - 1 + Fib(n) - 1 + 1
         = Fib(n + 1) + Fib(n) - 1
         = Fib(n + 2) - 1
```

可知递归情况也成立。原式得到证明。

见 [练习 1.13 的证明](../chapter_1/exercise_1_13.md), `Fib(n)` 是最接近 <img src="http://latex.codecogs.com/svg.latex?\frac{\phi^{n}}{\sqrt{5}}"/> 整数。也就是 n 的指数增长。

于是在没有记忆过程情况下，计算第 n 个斐波拉契数字所需要的加法。

```
A(n) = Fib(n + 1) - 1
```

也是 n 的指数增长。

