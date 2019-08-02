## P49 - [牛顿法]

### 牛顿法原理

求方程 g(x) = 0 的解。一种方法是 P44 页描述的[区间折半方法](./half_interval_method.lua)，也可称为二分法。另一种方法就是牛顿法，也可称为切线法。

牛顿法的基本原理如下。假设 x0 是方程的 `g(x) = 0` 一个猜测。那么对应在 g(x) 上的点 A 为 (x0, g(x0))，过 A 点作 g(x) 的切线。这条切线跟 x 轴的交点为 (x1, 0)。这个 x1 是 `g(x) = 0` 的更接近的猜测。

根据导数的几何定义，g(x) 的导数就是切线。于是过 A 点，g(x) 的切线为 g'(x0)。于是切线方程为

```
y - g(x0) = g'(x0)(x - x0)
```

跟 x 轴交点，y = 0，将 (x1, 0) 代入上面方程。于是就得到更好的猜测

```
x1 = x0 - g(x0) / g'(x0)
```

如此类推

```
x1 = x0 - g(x0) / g'(x0)
x2 = x1 - g(x1) / g'(x1)
x3 = x3 - g(x2) / g'(x2)
.....
```
直到解相当接近。根据不动点的定义，g(x) = 0 的解，就是

```
f(x) = x - g(x) / g'(x) 
```

的不动点。书中，只是使用 Dg(x) 来表示导数运算，相当于上述推到的 g'(x)。

### sqrt

第一章书中，出现几种求平方根 sqrt 的方法，其实速途同归。P14 页 [采用牛顿法求平方根](./newton_sqrt.lua), 这种不断猜测，直到足够接近，就是不动点的思想，只是当时还没有明确提到这个概念。

而 P15 页提到，假如有猜测值 y，那么 y 和 x / y 的平均值，就是更好的猜测。这实际就是 `y -> x / y` 的平均阻尼。

而平方根的定义为 `y = sqrt(x)` 于是 

```
=> y ^ 2 = x
=> y ^ 2 - x = 0
```

于是就相当于求 `f(y) = y ^ 2 - x = 0` 的解。根据上述的牛顿法，相当于下面方程的不动点

```
f(y) = y - f(y)/f'(y) = y - (y ^ 2 - x) / (2 * y) = (y + x/y) / 2
```

因此。P14 页，求 sqrt 的方法，只是牛顿法的一个具体应用。

### 代码

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

function deriv(g)
    local dx = 0.00001
    return function (x)
        return (g(x + dx) - g(x)) / dx
    end
end

function newton_transform(g)
    return function (x)
        return x - g(x) / deriv(g)(x)
    end
end

function newtons_method(g, guess)
    return fixed_point(newton_transform(g), guess)
end

function sqrt(x)
    return newtons_method(function(y) 
        return y * y - x
    end, 1.0)
end

function cube(x)
    return x * x * x
end 

print(deriv(cube)(5))   -- 75.00014999664

-------------------------
function unit_test()
    function assert_equal(a, b, tolerance)
        tolerance = tolerance or 0.0001
        assert(math.abs(a - b) < tolerance)
    end
    for i = 0, 100 do 
        assert_equal(sqrt(i), math.sqrt(i))
    end
end 
unit_test()
```
