## P48 - [练习 1.39]

正切的连分数里面是减号

<img src="http://latex.codecogs.com/svg.latex?tan(x)=\frac{x}{1-\frac{x^{2}}{3-\frac{x^{2}}{5-...}}}"/>

而 [练习 1.37](exercise_1_37.md) 连分数中是加号，似乎有点不同。

<img src="http://latex.codecogs.com/svg.latex?f(x)=\frac{N_{1}}{D_{1}+\frac{N_{2}}{D_{2}+\frac{N_{3}}{D_{3}+...}}}"/>

最简单的方式是将 练习 1.37 的 `cont_frac` 复制一次，将加号改成减号。但实际项目中，不建议复制粘贴代码。

可以将 tan(x) 的连分数中，改写成如下形式。就可以复用 `cont_frac`。

<img src="http://latex.codecogs.com/svg.latex?tan(x)=\frac{x}{1+\frac{-x^{2}}{3+\frac{-x^{2}}{5+...}}}"/>

-----

代码如下：

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

function tran_cf(x, k)
    function n_fn(i)
        if i == 1 then
            return x
        else 
            return - x * x
        end
    end 

    function d_fn(i)
        return 2 * i - 1
    end

    return cont_frac(n_fn, d_fn, k)
end

-----------
function unit_test()
    function equal(a, b, tolerance)
        tolerance = tolerance or 0.0001
        return math.abs(a - b) < tolerance
    end
    for i = 0, 360 do 
        local n = i / (2 * math.pi)
        assert(equal(tran_cf(n, 100), math.tan(n)))
    end
end 
unit_test()
```

