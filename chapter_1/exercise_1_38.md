## P47 - [练习 1.38]

这题主要是找到 D 的规律，

```
i = 1 2 3 4 5 6 7 8 9 10 11 12 13 14 ....
D = 1 2 1 1 4 1 1 6 1 1  8  1  1  10 ....
```

D 每隔 3 个数字，其中的偶数就会累增。i 和 D 的关系为

``` Lua
function d_fn(i)
    if (i + 1) % 3 == 0 then 
        return 2 * (i + 1) / 3
    else
        return 1 
    end
end
```

``` Lua
local d_factor = 0
function d_fn(i)
    if (i + 1) % 3 == 0 then 
        d_factor = d_factor + 2
        return d_factor
    else
        return 1 
    end
end
```

也可以加个计数值，来累增偶数。

代码如下

``` Lua
function cont_frac(n_fn, d_fn, k)
    function impl(i)
        if i == k then 
            return n_fn(i) / d_fn(i)
        else
            return n_fn(i) / (d_fn(i) + impl(i + 1, k))
        end
    end
    return impl(1)
end

function compute_e(k)
    function n_fn(i)
        return 1
    end

    local d_factor = 0
    function d_fn(i)
        if (i + 1) % 3 == 0 then 
            d_factor = d_factor + 2
            return d_factor
        else
            return 1 
        end
    end

    return cont_frac(n_fn, d_fn, k) + 2
end

print(compute_e(100))
```

计算得到 e 的结果为

```
2.718281828459
```

而 e 的精确结果为

```
2.7182818284590452353602874713526624977572470936999595749669.....
```
