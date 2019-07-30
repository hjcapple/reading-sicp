## P36 - [练习 1.27]

下面程序搜索前 10 个 carmichael 数字。即通过了所有费马检查，但又不是素数。

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

function carmichael_test(n)
    function fermat_test(n, a)
        return expmod(a, n, n) == a 
    end

    function iter(n, a)
        if a == 0 then 
            return true
        elseif fermat_test(n, a) then 
            return iter(n, a - 1)
        else 
            return false
        end
    end 
    return iter(n, n - 1)
end

function search_for_carmichael(n, count)
    if count == 0 then 
        return
    end
    if not prime(n) and carmichael_test(n) then 
        count = count - 1
        print(string.format("%d", n))
    end
    search_for_carmichael(n + 1, count)
end

search_for_carmichael(1, 10)
```

输出如下。

```
561
1105
1729
2465
2821
6601
8911
10585
15841
29341
```

其因式分解为

```
561 = 3 × 11 × 17
1105 = 5 × 13 × 17
1729 = 7 × 13 × 19
2465 = 5 × 17 × 29
2821 = 7 × 13 × 31
6601 = 7 × 23 × 41
8911 = 7 × 19 × 67
10585 = 5 × 29 × 73
15841 = 7 × 31 × 73
29341 = 13 × 37 × 61
```

上面程序中，假如将 `search_for_carmichael` 的判断翻转过来写成 `carmichael_test(n) and not prime(n)` 就会慢很多。这是因为判断 `prime` 要比`carmichael_test` 快。而当是素数时，`carmichael_test` 一定为真，就包含了多余的运算。

Lua 的判断是短路求值，当写成 `not prime(n) and carmichael_test(n))` 时。假如是素数，`carmichael_test` 就会被跳过。

