## P47 - [练习 1.35]

黄金分割率 φ 的值为

<img src="http://latex.codecogs.com/svg.latex?\phi=\frac{1+\sqrt{5}}{2}"/>

满足方程：

<img src="http://latex.codecogs.com/svg.latex?\phi^{2}=\phi+1"/>

变换之后，为

<img src="http://latex.codecogs.com/svg.latex?\phi=1+\frac{1}{\phi}"/>

根据不动点的定义, φ 就为方程 `f(x) = 1 + 1/x` 的不动点。

------

``` Lua
function fixed_point(f, first_guess)
    function close_enough(x, y)
        local abs = math.abs
        local tolerance = 0.00001
        return abs(x - y) < tolerance
    end

    function try(guess)
        local next_guess = f(guess)
        if close_enough(guess, next_guess) then 
            return next_guess
        else 
            return try(next_guess)
        end
    end

    return try(first_guess)
end

print(fixed_point(function(x)
    return 1 + 1 / x
end, 1.0))
```

计算得到结果

```
1.6180327868852
```
