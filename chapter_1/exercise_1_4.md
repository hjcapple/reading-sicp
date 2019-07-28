## P13 - [练习 1.4]

``` Scheme
(define (a-plus-abs-b a b)
    ((if (> b 0) + -) a b))
```

* 假如 b > 0，相当于 `(+ a b)`。
* 否则，相当于 `(- a b)`。

于是式子相当于 a 加上 b 的绝对值。这实际是高阶函数的一个例子。翻译成 Lua，大概为

``` Lua
function add(a, b)
    return a + b 
end 

function minus(a, b)
    return a - b
end

function a_plus_abs_b(a, b)
    local op = (b > 0) and add or minus
    return op(a, b)
end

assert(a_plus_abs_b(1, 2) == 3)
assert(a_plus_abs_b(1, -2) == 3)
```

Scheme 可以直接使用 +、- 符号，而 Lua 要将其定义成 add、minus 函数。Scheme 更加简洁。
