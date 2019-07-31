## P40 - [练习 1.29, Simpson 公式]

### 定积分

求定积分相当于求 f(x) 跟 x 轴所围成的面积。

求 f(x) 的定积分，基本思路是将 [a, b] 分成很小的区域，总共 n 份。每个区域长度为 `h = (b - a) / n` 每个区域的 x 坐标为 x0, x1, x2, x3 ... xn 。于是可以求得 f(x) 上面的多个函数点。

```
(x0, y0) = (x0, f(x0))
(x1, y1) = (x1, f(x1))
(x2, y2) = (x2, f(x2))
(x3, y3) = (x3, f(x3))
(x4, y4) = (x4, f(x4))
.....
```

接下来，每个区域都选取使用比 f(x) 简单得多的函数 P(x) 去插值这些函数点。当区域分得越小，P(x) 的结果就跟 f(x) 越接近。P(x) 所围的面积，就越接近 f(x) 的面积。

P(x) 比 f(x) 要简单得多，也就容易处理。比如每个区域，最简单的 P(x) 函数为一条水平线，有

```
P(x0) = y0
P(x1) = y1
P(x2) = y2
P(x3) = y3
....
```

于是就 P(x) 的面积为

```
A = P(x0) * h + P(x1) * h + P(x2) * h ... 
  = h * (y0 + y1 + y2 + ....)
  = h * [f(x0) + f(x1) + f(x2) + .... ]
```

这个公式就是 P39 页中的 integral 函数。用一条水平线线去逼近 f(x), 相当于将每个小区域当成矩形，上述公式也可称为<b>矩形法公式</b>。。

那 P(x) 还可以选择其它函数，比如选择 <img src="http://latex.codecogs.com/svg.latex?P(x) = qx + r"/>，就是每个区域用一条直线去逼近 f(x)。那么就相当于将每个小区域，当成梯形去处理，得到的相应公式可称为的<b>梯形法公式</b>。

### Simpson 公式推导

P(x) 也可以不选择直线，而是选择一条二次曲线 <img src="http://latex.codecogs.com/svg.latex?P(x)=px^{2}+qx+r"/>。二次曲线相对于直线，P(x) 更加接近于 f(x)，同样划分成 n 个区域，计算的精度也更高。同样，也可以采用三次曲线、四次曲线等等，但是更高次数的曲线，计算起来会很麻烦，精度提升也不明显，就有点不值得了。

二次曲线是计算量和精度的很好平衡。采用二次曲线去逼近 f(x), 得到的公式就是题目中说的<b>辛普森(Simpson)公式</b>。因为二次曲线是条抛物线，这个公式也可称为的定积分的<b>抛物线法公式</b>。我们就来推导一下。

<img width="320" src="./simpsons_method.svg"/>

求二次曲线需要三个点，也就需要跨两个区间。每个区间长度为 `h = (b - a) / n`。蓝色的 f(x) 为原来的函数，红色的 P(x) 为插值的二次曲线。我们求 P(x) 跟横轴所围成的面积，用 P(x) 的面积大致等于 f(x) 的面积。

为了方便计算面积 A，我们取 m 点横坐标 `x = 0`, 于是相应地 a 点 `x = -h`。f(x) 上有三个点

<img src="http://latex.codecogs.com/svg.latex?(-h, y_{a})、(0, y_{m})、(h, y_{b})"/>

这三个点坐标代入二次方程 <img src="http://latex.codecogs.com/svg.latex?y=P(x)=px^{2}+qx+r"/>，有

<img src="http://latex.codecogs.com/svg.latex?\left\{\begin{aligned}&y_{a}=ph^{2}-qh+r\\ &y_{m}=r \\ &y_{b}=ph^{2}+qh+r\end{aligned}"/>

于是 <img src="http://latex.codecogs.com/svg.latex?y_{a}-2y_{m}+y_{b}=2ph^{2}"/>

所求的面积

<img src="http://latex.codecogs.com/svg.latex?\begin{aligned}A%20&=%20\int_{-h}^{h}(px^{2}+qx+r)dx\\%20&=%20\left%20[\frac{1}{3}px^{3}+\frac{q}{2}x^{2}+rx%20%20\right%20]_{-h}^{h}%20=%20\frac{2}{3}ph^{3}+2rh%20\\%20&=\frac{1}{3}h(2ph^{2}+6r)=\frac{1}{3}h(y_{a}-2y_{m}+y_{b}+6y_{m})%20\\%20&=\frac{1}{3}h(y_{a}+4y_{m}+y_{b})%20\end{aligned}"/>

这就是两个区域的面积公式。因此过 `(x0, y0)、(x1, y1)、(x2, y2)` 的三点抛物线面积为

<img src="http://latex.codecogs.com/svg.latex?A_{0}=\frac{1}{3}h(y_{0}+4y_{1}+y_{2})"/>

`(x2, y2)、(x3, y3)、(x4, y4)` 的三点抛物线面积为，以此类推

<img src="http://latex.codecogs.com/svg.latex?A_{1}=\frac{1}{3}h(y_{2}+4y_{3}+y_{4})"/>

<img src="http://latex.codecogs.com/svg.latex?A_{2}=\frac{1}{3}h(y_{4}+4y_{5}+y_{6})"/>

.....

将所有面积加起来，就得到最终的公式。

<img src="http://latex.codecogs.com/svg.latex?A=\frac{1}{3}h[(y_{0}+y_{n})+2(y_{2}+y_{4}+...+y_{n-2})+4(y_{1}+y_{3}+...+y_{n-1})]"/>

头尾的两个点，倍数因子为 1；当为奇数点，倍数因子为 4；偶数点，倍数因子为 2。

### 代码

``` Lua
function sum(term, a, next, b)
    if a > b then 
        return 0
    else 
        return term(a) + sum(term, next(a), next, b)
    end 
end

function simpson_integral(f, a, b, n)
    function even(n)
        return n % 2 == 0
    end

    if not even(n) then 
        n = n + 1
    end

    local h = (b - a) / n
    function term(k)
        function factor(k)
            if k == 0 or k == n then 
                return 1
            elseif even(k) then 
                return 2
            else 
                return 4
            end 
        end
        return factor(k) * f(a + h * k)
    end

    function inc(n)
        return n + 1
    end

    return sum(term, 0, inc, n) * h / 3.0
end 

function cube(x)
    return x * x * x
end

print(simpson_integral(cube, 0, 1, 100))
print(simpson_integral(cube, 0, 1, 1000))
```

输出

```
0.25
0.25
```
可以看到比 P39 页的 integral 精度要高。
