## P36 - [练习 1.23]

将 [练习 1.22](./exercise_1_22.md) 中的程序修改一下，`prime?` 函数写成：

``` Scheme
(define (smallest-divisor n)
  (find-divisor n 2))

(define (next-divisor n)
  (if (= n 2)
      3
      (+ n 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next-divisor test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))
```

运行程序，打印出结果。

```
1009 is prime: 0.002197265625
1013 is prime: 0.001953125
1019 is prime: 0.001953125
10007 is prime: 0.005126953125
10009 is prime: 0.00390625
10037 is prime: 0.00390625
100003 is prime: 0.01318359375
100019 is prime: 0.012939453125
100043 is prime: 0.012939453125
1000003 is prime: 0.0400390625
1000033 is prime: 0.041015625
1000037 is prime: 0.040771484375
10000019 is prime: 0.128173828125
10000079 is prime: 0.12890625
10000103 is prime: 0.1279296875
100000007 is prime: 0.404052734375
100000037 is prime: 0.405029296875
100000039 is prime: 0.420166015625
```

而 [练习 1.22](./exercise_1_22.md) 中的程序在同一机器上打印出结果为如下。

```
1009 is prime: 0.001953125
1013 is prime: 0.0029296875
1019 is prime: 0.001953125
10007 is prime: 0.007080078125
10009 is prime: 0.008056640625
10037 is prime: 0.008056640625
100003 is prime: 0.02197265625
100019 is prime: 0.02197265625
100043 is prime: 0.023193359375
1000003 is prime: 0.071044921875
1000033 is prime: 0.070068359375
1000037 is prime: 0.06982421875
10000019 is prime: 0.21923828125
10000079 is prime: 0.219970703125
10000103 is prime: 0.220947265625
100000007 is prime: 0.672119140625
100000037 is prime: 0.696044921875
100000039 is prime: 0.68994140625
```

3 个素数时间值取平均数。做出表格作为对比。

| n 附近            | 1000  | 10000  | 100000  | 1000000  | 10000000 | 100000000 |
|-------------------|-------|--------|---------|----------|----------|-----------|
| 练习 1.22 时间(ms) | 0.002279 | 0.007731  | 0.022380  | 0.0703125   | 0.220052     | 0.686035 |
| 修改后程序时间(ms)  | 0.002035 | 0.004313  | 0.013021  | 0.040609   |0.128337     | 0.409749    |
| 效率提升倍数       | 1.119902   | 1.792488    | 1.718762  | 1.731451   |1.714642     | 1.674281    |

可见速度提升在 1.7 左右，并没有达到 2。

注意到在 n = 1000 附近，倍数为 1.119902，显得特别低。并且“练习 1.22” 中 1013 这个素数时间值有点偏高，估计是计算机运行环境的波动。而当 n 的数值越小，计算机执行得很快，环境波动的影响就越大。

```
1009 is prime: 0.001953125
1013 is prime: 0.0029296875
1019 is prime: 0.001953125
```

--------

修改算法后，速度提升在 1.7 左右，并没有达到 2。

计算机实际的运行时间受到多方面的影响，比如计算机的当前 CPU 和内存占用，解释器运行状况，时间会有所波动。现代的计算机执行速度很快，而计算机运行越快，程序本身运行时间越短，波动影响就会越大。

抛开时间波动不谈，并非每一行代码计算所需的时间都是相同的，当将 `(+ test-divisor 1)` 修改成 `(next-divisor test-divisor)` 后。实际变成了一个函数调用，而 next-divisor 中也包含了判断。因此 `(next-divisor test-divisor)` 的实际执行行时间会比 `(+ test-divisor 1)` 要长。

我们知道 `search-for-primes` 测试奇数，在 `(prime? n)` 外面就已保证传入来的 n 不会被 2 整除。假如将代码临时修改成下面样子，避免 `next-divisor` 函数调用自身的影响。测量到的时间提升就会跟 2 比较接近了。

``` Scheme
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ 2 test-divisor))))) ; 直接 + 2

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))
```


