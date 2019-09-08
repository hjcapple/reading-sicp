## P37 - [练习 1.28，Miller-Rabin 测试]

### 费马小定理

利用 [费马小定理](./fermat_test.md) 中描述的同余符号。费马小定理描述如下

如果 p 为素数，当 a < p 时，有

<img src="http://latex.codecogs.com/svg.latex?a^{p}\equiv%20a\pmod%20p" />

变换一下公式

<img src="http://latex.codecogs.com/svg.latex?a^{p-1}\equiv%201\pmod%20p" />

### Miller-Rabin 测试

题目的中文 "1 取模的非平凡平方根", 英文原文为 “nontrivial square root of 1 modulo n”。

英文中，trivial 这个词，意思是“不重要的”，“微不足道的", “琐琐碎碎" 的。用在数学中，是指某个结论或者性质显然易见，没有什么了不起。而 nontrivial 意思就跟 trivial 相反。

假设 x 是 1 取模的平方根（先不管 trivial 或者 nontrivial), 就有

<img src="http://latex.codecogs.com/svg.latex?x%20^%20{2}%20\equiv%201\pmod%20p"/>

上面公式可以转为

<img src="http://latex.codecogs.com/svg.latex?x%20^%20{2}%20-%201%20\equiv%20(x%20+%201)(x%20-%201)\equiv%200\pmod%20p"/>

于是一定包含两个解。

<img src="http://latex.codecogs.com/svg.latex?x%20\equiv%201\pmod%20p"/>

<img src="http://latex.codecogs.com/svg.latex?x%20\equiv%20-1\pmod%20p"/>

上面推导没有应用到 p 的性质。不管 p 是是素数还是合数，这两个解都一定会成立。于是这两个解，没有什么了不起的，不能用来区分 p 的性质。换句话说这两个解是 trivial 的。

除了上面两个解，根据 p 的性质，上面模方程还可能有其它的解。这些解才能用于区分 p 的性质，这些解是 nontrivial 的。

而 -1 在模运算中，跟 p - 1 等价(想象时钟 12 点时，向后拨动 -1 时，就变成 11 点了)。因此在 [0, p) 的范围内，平凡解(trivial) 就是 1 和 p - 1。非平凡解(nontrivial) 就是除了这两个解之外的其它解。

当 p 为素数时，因为 p 已经不可拆分。<img src="http://latex.codecogs.com/svg.latex?(x%20+%201)(x%20-%201)\equiv%200\pmod%20p"/> 只有两个平凡解。但当 p 为合数时，还可以有其它解。比如当 p 为 8，就有

<img src="http://latex.codecogs.com/svg.latex?3^{2}%20\equiv%201\pmod%208"/>

<img src="http://latex.codecogs.com/svg.latex?5^{2}%20\equiv%201\pmod%208"/>

3 和 5 就是非平凡解。

------

Miller-Rabin 检查除了应用费马小定理的变形公式

<img src="http://latex.codecogs.com/svg.latex?a^{p-1}\equiv%201\pmod%20p" />

还应用了上述结论，添加了额外的一个检查。假如 p 是素数，那么上面方程

<img src="http://latex.codecogs.com/svg.latex?x%20^%20{2}%20\equiv%201\pmod%20p"/>

一定没有非平凡解(nontrivial)。假如 [0, p) 的范围内，除了 1 和 p - 1 外，还有其它解，那么 p 就是合数。

### 代码

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

    function nontrivial(a, n)
        return (a ~= 1) and (a ~= n - 1) and remainder(square(a), n) == 1
    end

    if exp == 0 then 
        return 1
    elseif nontrivial(base, m) then 
        return 0
    elseif even(exp) then
        local tmp = expmod(base, exp / 2, m)
        return remainder(square(tmp), m)
    else
        local tmp = expmod(base, exp - 1, m)
        return remainder(base * tmp, m)
    end 
end

function miller_rabin_test(n)
    function try_it(a)
        return expmod(a, n - 1, n) == 1 
    end
    return try_it(math.random(1, n - 1))
end

function fast_prime(n, times)
    if times == 0 then
        return true 
    elseif miller_rabin_test(n) then 
        return fast_prime(n, times - 1)
    else
        return false
    end 
end

function unit_test()
    local nums = { 2, 3, 5, 7, 11, 13, 17, 19, 23 }
    for _, num in ipairs(nums) do 
        assert(fast_prime(num, 100))
    end
    local nums = { 36, 25, 9, 16, 4, 561, 1105, 1729, 2465 }
    for _, num in ipairs(nums) do 
        assert(not fast_prime(num, 100))
    end
end
unit_test()

```

注意看到，561, 1105, 1729, 2465 这几个 carmichael 数字也被检测出并非素数。

