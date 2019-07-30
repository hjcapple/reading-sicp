## P35 - [练习 1.22]

``` Lua
function square(x) 
    return x * x
end

function remainder(n, b)
    return n % b
end

function prime(n)
    function smallest_divisor(n)
        return find_divisor(n, 2)
    end

    function find_divisor(n, test_divisor)
        if square(test_divisor) > n then 
            return n
        elseif divides(test_divisor, n) then 
            return test_divisor
        else
            return find_divisor(n, test_divisor + 1)
        end
    end

    function divides(a, b)
        return remainder(b, a) == 0
    end

    return smallest_divisor(n) == n
end

function timed_prime_test(n)
    function start_prime_test(n, start_time)
        if prime(n) then 
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

现代的机器比以前快得多，我多寻找了几个素数。执行 Lua 程序，在我的机器上结果如下，时间单位是毫秒。

```
1009 is prime: 0.010000
1013 is prime: 0.011000
1019 is prime: 0.011000
10007 is prime: 0.032000
10009 is prime: 0.034000
10037 is prime: 0.033000
100003 is prime: 0.107000
100019 is prime: 0.104000
100043 is prime: 0.085000
1000003 is prime: 0.274000
1000033 is prime: 0.281000
1000037 is prime: 0.271000
10000019 is prime: 0.850000
10000079 is prime: 0.872000
10000103 is prime: 0.840000
100000007 is prime: 2.595000
100000037 is prime: 2.531000
100000039 is prime: 2.511000
```

3 个素数时间值取平均数，耗时

| n 附近   | 1000  | 10000  | 100000  | 1000000  | 10000000 | 100000000 |
|---------|-------|--------|---------|----------|----------|-----------|
| 时间(ms) | 0.011 | 0.033  | 0.0987  | 0.2753   |0.854     | 2.546     |
| 跟前面时间比值 | - | 3.09  | 2.99  | 2.79   |3.1     | 2.98     |

每次 n 增加 10 倍，时间增加 3 倍左右。而 `sqrt(10) = 3.1622`。

实际测量时间跟 sqrt(10) 并非严格相等，但还是比较接近的。计算机本身速度快慢，资源占用，解释器运行状况，会影响测量时间，实际上也不可能跟 sqrt(10) 严格相等。但算法复杂度分析，可以脱离计算机的具体环境，较好地描述了增长速度的快慢。

