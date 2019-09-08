## P36 - [练习 1.25]

``` Scheme
(define (expmod base exp m)
  (remainder (fast-expt base exp) m)) 
```

`expmod` 这样写理论上是对的，但实际运行却有问题。`fast-expt` 算阶乘，会导致数字越来越大。

计算机表示数字是有精度的，比如 64 位整数值。当超出计算机的精度范围，一种情况是会数据溢出，计算就不准确了。另一种情况是，使用程序去模拟大整数的运算。在计算机精度范围内，两个数字相乘，花费的计算时间差别不大。但当超出精度范围，需要使用程序去模拟，数字越大，计算就会越慢。

于是上述 `expmod` 的实现当中，数字越来越大。一种可能结果是，数据溢出，计算不准确。另一种可能结果是，计算越来越慢。

------

而原来的 `expmod` 实现

``` Scheme
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))
```

`(expmod base exp m)` 里面使用 `remainder` 取余数，计算结果不会超过 m。而实现过程是递归的，出现下面运算。

``` Scheme
(square (expmod base (/ exp 2) m))
(* base (expmod base (- exp 1) m)
```

整个计算过程，可能出现的最大数字不会超过 `m * m` 和 `base * m`。只要控制好初始输入值，结果就不会溢出，也会快得多。







