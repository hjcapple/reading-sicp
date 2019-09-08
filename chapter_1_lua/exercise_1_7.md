## P16 - [练习 1.7]

使用 [采用牛顿法求平方根](./newton_sqrt.lua) 中的 Lua 代码，来计算比较小的数字。

``` Lua
sqrt(0.03 * 0.03)
```

结果是 `0.031345847606569`, 但正确结果应该是 `0.03`。这是因为 `good_enough` 中的误差比较值只是 `0.001`。将误差值变少，计算结果会精确些，但对于更少的数字，精度还是不够。

假如计算比较大的数字

``` Lua
sqrt(100000000000000000.0)
```

结果是不会停止，但正确结果应该是 `316227766.016838`。这是因为 `guess = 316227766.01684` 时。guess 的平方数很大，在浮点数中，对于特别大的数字，留给小数位的精度就不够。不足以表达两个大数字的差值。

于是 `abs(square(guess) - x)` 总是大于误差值 0.001。而结果也不能再被改进了，于是就不断在 `guess = 316227766.01684` 中循环，不会停下来。

上面以 Lua 为例，对于 Scheme 代码，道理是一样的。

--------

重新设计 `good_enough`，检测新旧两次猜测值之间的比率。代码如下：

``` Lua
function average(x, y)
    return (x + y) / 2
end

function abs(x)
    if x < 0 then 
        return -x
    else
        return x
    end
end

function square(x)
    return x * x
end

function sqrt_iter(guess, x)
    local new_guess = improve(guess, x)
    if new_good_enough(guess, new_guess) then 
        return guess
    else 
        return sqrt_iter(new_guess, x)
    end
end

function improve(guess, x)
    return average(guess, x / guess)
end

function new_good_enough(guess, new_guess)
    local d = (guess - new_guess) / guess
    return abs(d) < 0.001
end

function sqrt(x)
    return sqrt_iter(1.0, x)
end
```

修改之后，可以得出结果

```
sqrt(0.03 * 0.03) = 0.030027667421826
sqrt(100000000000000000.0) = 316228564.92229
```

将 `new_good_enough` 的误差精度提高，从 `0.001` 变为 `0.0000001`，计算结果精度也相应提高。

```
sqrt(0.03 * 0.03) = 0.030000000000003
sqrt(100000000000000000.0) = 316227766.01785
```

跟 C 代码的 sqrt 计算结果很接近了。


