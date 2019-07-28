## P29 - [练习 1.15]

将程序翻译成 Lua, 并在 p 中添加 print 输出。

``` Lua
function abs(x)
    if x < 0 then 
        return -x
    else
        return x
    end
end

function sine(x)
    function cube(x)
        return x * x * x
    end
    function p(x)
        print(string.format("call p, arg = %f", x))
        return 3 * x - 4 * cube(x)
    end

    if abs(x) < 0.1 then 
        return x
    else 
        return p(sine(x / 3.0))
    end
end

print(sine(12.15))
```

输出

```
call p, arg = 0.050000
call p, arg = 0.149500
call p, arg = 0.435135
call p, arg = 0.975847
call p, arg = -0.789563
-0.39980345741334
```

a) 可以看到求值 `sine(12.15)` 时，p 被调用了 5 次。

-------

b) 求值 `sine(a)` 时，每次 a 被除以 3.0。而 sine 是个递归过程，每次递归 a / 3.0。可知 sine 的空间和时间，复杂度为 `O(logA)`，对数增长。每次 a 增加 3 倍，p 的调用次数增加 1。

```
sine(1),     p 调用 3  次。
sine(3),     p 调用 4  次。
sine(9),     p 调用 5  次。
sine(27),    p 调用 6  次。
sine(81),    p 调用 7  次。
sine(243),   p 调用 8  次。
sine(729),   p 调用 9  次。
sine(2187),  p 调用 10 次。
sine(6561),  p 调用 11 次。
sine(19683), p 调用 12 次。
```
