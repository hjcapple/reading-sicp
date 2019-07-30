## P36 - [练习 1.24]

将[练习 1.22](./exercise_1_22.md) 和 [费马检测](./fermat_test.md) 的程序合起来，修改为

``` Lua
function square(x) 
    return x * x
end

function remainder(n, b)
    return n % b
end

function expmod(base, exp, m)
    function even(n)
        return n % 2 == 0
    end

    if exp == 0 then 
        return 1
    elseif even(exp) then
        local tmp = expmod(base, exp / 2, m)
        return remainder(square(tmp), m)
    else
        local tmp = expmod(base, exp - 1, m)
        return remainder(base * tmp, m)
    end 
end

function fermat_test(n)
    function try_it(a)
        return expmod(a, n, n) == a 
    end
    return try_it(math.random(1, n - 1))
end

function fast_prime(n, times)
    if times == 0 then
        return true 
    elseif fermat_test(n) then 
        return fast_prime(n, times - 1)
    else 
        return false
    end 
end

function timed_prime_test(n)
    function start_prime_test(n, start_time)
        if fast_prime(n, 100) then 
            report_prime(os.clock() - start_time)
            return true
        end
        return false
    end

    function report_prime(elapsed_time)
        print(string.format("%d is prime: %f", n, elapsed_time * 1000))
    end

    return start_prime_test(n, os.clock())
end

function search_for_primes(n, count)
    function make_odd(n)
        if n % 2 == 0 then 
            return n + 1
        else 
            return n
        end
    end

    function iter_even(n, count)
        if count == 0 then 
            return
        elseif timed_prime_test(n) then
            iter_even(n + 2, count - 1)
        else 
            iter_even(n + 2, count)
        end
    end

    return iter_even(make_odd(n), count)
end

search_for_primes(1000, 3)
search_for_primes(10000, 3)
search_for_primes(100000, 3)
search_for_primes(1000000, 3)
search_for_primes(10000000, 3)
search_for_primes(100000000, 3)

```

输出

```
1009 is prime: 0.678000
1013 is prime: 0.581000
1019 is prime: 0.661000
10007 is prime: 0.703000
10009 is prime: 0.671000
10037 is prime: 0.706000
100003 is prime: 0.799000
100019 is prime: 0.835000
100043 is prime: 0.808000
1000003 is prime: 1.010000
1000033 is prime: 0.903000
1000037 is prime: 0.934000
10000019 is prime: 1.075000
10000079 is prime: 1.116000
10000103 is prime: 1.163000
100000007 is prime: 1.360000
100000037 is prime: 1.306000
100000039 is prime: 1.362000
```

将 3 个素数时间值取平均数，做成表格

| n 附近       | 1000  | 10000  | 100000  | 1000000  | 10000000 | 100000000 |
|-------------|-------|--------|---------|----------|----------|-----------|
| 时间(ms)     | 0.64 | 0.693  | 0.814  | 0.949   |1.118     | 1.3427     |
| 跟前面时间差值 | -  |  0.053 | 0.121 | 0.135 | 0.169 | 0.2247 |

因为算法复杂度为 O(logN)，会预期每次增加 10 倍，时间只会递增一个常数值。注意上表是在算差值，而不是比值。

但可以看到，这里并非严格的常数值，会有所偏差。

在此例中，虽然算法复杂度为 O(logN)，但程序当中会计算随机值作为指数的阶，这个随机值会影响 `expmod` 的执行速度。

计算机实际的运行时间受到多方面的影响，比如计算机的当前 CPU 和内存占用，解释器运行状况，时间会有所波动。现代的计算机执行速度很快，而计算机运行越快，程序本身运行时间越短，波动影响就会越大。

算法复杂度分析，可以描述了增长速度的快慢，会对速度的长期增长有个估算。但并非真正的绝对时间。






