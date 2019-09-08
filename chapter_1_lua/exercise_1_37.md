## P47 - [练习 1.37, 连分数]

将连分数的截断公式记为

<img src="http://latex.codecogs.com/svg.latex?f(i,%20k)%20=%20\frac{N_{i}}{D_{i}+\frac{N_{i+1}}{...+\frac{N_{k}}{D_{k}}}}"/>

于是就有

<img src="http://latex.codecogs.com/svg.latex?\begin{aligned}&f(1,%20k)=\frac{N_{1}}{D_{1}+\frac{N_{2}}{...+\frac{N_{k}}{D_{k}}}}=\frac{N_{1}}{D_{1}+f(2,%20k)}\\&f(2,%20k)=\frac{N_{2}}{D_{2}+\frac{N_{3}}{...+\frac{N_{k}}{D_{k}}}}=\frac{N_{2}}{D_{2}+f(3,%20k)}%20\\&...%20\\&f(k,%20k)=\frac{N_{k}}{D_{k}}\end{aligned}"/>

也就是有递归公式：

<img src="http://latex.codecogs.com/svg.latex?\begin{aligned}&f(i,%20k)=\frac{N_{i}}{D_{i}+f(i%20+%201,%20k)}\\&f(k,%20k)=\frac{N_{k}}{D_{k}}\end{aligned}"/>


要得到迭代版本，可以将顺序反过来。依次计算序列

```
f(k, k) -> f(k - 1, k) -> f(k - 2, k) ... f(1, k)
```

代码如下

``` Lua
-- 递归版本
function cont_frac(n_fn, d_fn, k)
    function impl(i)
        if i == k then 
            return n_fn(i) / d_fn(i)
        else
            return n_fn(i) / (d_fn(i) + impl(i + 1))
        end
    end
    return impl(1)
end

-- 迭代版本
function cont_frac_2(n_fn, d_fn, k)
    function iter(i, ret)
        if i < 1 then 
            return ret
        else 
            return iter(i - 1, n_fn(i) / (d_fn(i) + ret))
        end
    end
    return iter(k - 1, n_fn(k) / d_fn(k))
end

function golden_ratio(n)
    function fn(x)
        return 1
    end
    return cont_frac(fn, fn, n)
end

function golden_ratio_2(n)
    function fn(x)
        return 1
    end
    return cont_frac_2(fn, fn, n)
end

---------------------
function equal(a, b, tolerance)
    local abs = math.abs
    return abs(a - b) < tolerance
end
assert(equal(golden_ratio(10), golden_ratio_2(10), 0.0001))
```

见 [练习 1.13](./exercise_1_13.md)

<img src="http://latex.codecogs.com/svg.latex?\frac{1}{\phi}=\frac{2}{1+\sqrt{5}}=\phi-1"/> 的精确值为

```
0.61803398874989
```

而

```
golden_ratio(10) = 0.61797752808989
golden_ratio(11) = 0.61805555555556
```

只要 k = 11, 计算结果的前面 4 个小数位就完全相同。

