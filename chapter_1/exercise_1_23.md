## P36 - [练习 1.23]

将 [练习 1.22](./exercise_1_22.md) 中的程序修改一下，`prime` 函数写成：

``` Lua
function prime(n)
    function smallest_divisor(n)
        return find_divisor(n, 2)
    end

    function next_divisor(n)
        if n == 2 then 
            return 3
        else 
            return n + 2
        end 
    end

    function find_divisor(n, test_divisor)
        if square(test_divisor) > n then 
            return n
        elseif divides(test_divisor, n) then 
            return test_divisor
        else
            return find_divisor(n, next_divisor(test_divisor))
        end
    end

    function divides(a, b)
        return remainder(b, a) == 0
    end

    return smallest_divisor(n) == n
end
```

运行程序，打印出结果。

```
1009 is prime: 0.004000
1013 is prime: 0.005000
1019 is prime: 0.005000
10007 is prime: 0.013000
10009 is prime: 0.013000
10037 is prime: 0.014000
100003 is prime: 0.040000
100019 is prime: 0.059000
100043 is prime: 0.050000
1000003 is prime: 0.164000
1000033 is prime: 0.145000
1000037 is prime: 0.165000
10000019 is prime: 0.401000
10000079 is prime: 0.391000
10000103 is prime: 0.416000
100000007 is prime: 1.322000
100000037 is prime: 1.273000
100000039 is prime: 1.292000
```

而 [练习 1.22](./exercise_1_22.md) 中的程序在同一机器上打印出结果为如下。

```
1009 is prime: 0.008000
1013 is prime: 0.007000
1019 is prime: 0.008000
10007 is prime: 0.033000
10009 is prime: 0.024000
10037 is prime: 0.021000
100003 is prime: 0.075000
100019 is prime: 0.094000
100043 is prime: 0.073000
1000003 is prime: 0.245000
1000033 is prime: 0.220000
1000037 is prime: 0.247000
10000019 is prime: 0.668000
10000079 is prime: 0.652000
10000103 is prime: 0.662000
100000007 is prime: 2.150000
100000037 is prime: 2.045000
100000039 is prime: 2.100000
```

3 个素数时间值取平均数。做出表格作为对比。

| n 附近            | 1000  | 10000  | 100000  | 1000000  | 10000000 | 100000000 |
|-------------------|-------|--------|---------|----------|----------|-----------|
| 练习 1.22 时间(ms) | 0.00767 | 0.026  | 0.08067  | 0.23733   |0.66067     | 2.09834 |
| 修改后程序时间(ms)  | 0.00467 | 0.01333  | 0.0497  | 0.158   |0.4027     | 1.2957    |
| 效率提升倍数       | 1.6428   | 1.95    | 1.6241  | 1.5021   |1.6407     | 1.6195    |

可见速度提升在 1.6 左右，并没有达到 2。

注意到在 n = 10000 附近，倍数为 1.95，显得特别高。这是 10007 这个素数时间值特别高，估计是计算机运行环境的波动。

```
10007 is prime: 0.033000
10009 is prime: 0.024000
10037 is prime: 0.021000
```

这个 10007 的异常值被剔除后。重新计算到效率提升是 1.687。

--------

修改算法后，速度提升在 1.6 左右，并没有达到 2。

计算机实际的运行时间受到多方面的影响，比如计算机的当前 CPU 和内存占用，解释器运行状况，时间会有所波动。现代的计算机执行速度很快，而计算机运行越快，程序本身运行时间越短，波动影响就会越大。

抛开时间波动不谈，并非每一行代码计算所需的时间都是相同的，当将 `test_divisor + 1` 修改成 `next_divisor(test_divisor)` 后。实际变成了一个函数调用，而 next_divisor 中也包含了判断。因此 `next_divisor(test_divisor)` 的实际执行行时间会比 `test_divisor + 1` 要长。

我们知道 `search_for_primes` 测试奇数，在 prime(n) 外面就已保证传入来的 n 不会被 2 整除。假如将代码临时修改成下面样子，避免 `next_divisor` 函数调用自身的影响。测量到的时间提升就会跟 2 比较接近了。

``` Lua
function prime(n)
    function smallest_divisor(n)
        return find_divisor(n, 3)  -- 预先知道 n 不为偶数，因此从 3 开始
    end

    function find_divisor(n, test_divisor)
        if square(test_divisor) > n then 
            return n
        elseif divides(test_divisor, n) then 
            return test_divisor
        else
            return find_divisor(n, test_divisor + 2) -- 直接 + 2
        end
    end

    function divides(a, b)
        return remainder(b, a) == 0
    end

    return smallest_divisor(n) == n
end
```


