## P35 - [练习 1.21]

``` Lua
function square(x) 
    return x * x
end

function remainder(n, b)
    return n % b
end

function smallest_divisor(n)
    function divides(a, b)
        return remainder(b, a) == 0
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

    return find_divisor(n, 2)
end


print(smallest_divisor(199))    -- 199
print(smallest_divisor(1999))   -- 1999
print(smallest_divisor(19999))  -- 7
```

199 和 1999 的最小因子为自身，它们都是素数。

19999 的最小因子是 7，它是合数。`19999 = 7 * 2857`

