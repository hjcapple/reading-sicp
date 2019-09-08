## P14 - [练习 1.5]

``` Scheme
(define (p) (p))
```

无限递归，假如 (p) 需要求值，程序并不会停止。Scheme 有尾递归优化，堆积也不会溢出。

根据书中 P10, 应用序和正则序的描述。

假如是应用序，需要先求参数值，于是 `(test 0 (p))` 需要先求值 (p)。因而在应用序下，`(test 0 (p))` 不会停止。

假如是正则序，会完全展开再归约，于是 `(test 0 (p))` 会先展开成。

``` Scheme
(if (= 0 0)
    0
    (p))
```

而因为 (= 0 0) 为真，会直接得到结果 0，并不会调用 (p)。因而在正则序下，`(test 0 (p))` 结果为 0。

结论就是，假如解释器采用应用序，`(test 0 (p))` 不会停止。假如采用正则序，`(test 0 (p))` 结果为 0。

------

将这个测试翻译成 Lua，可看到也不会停止。

``` Lua
function p()
    return p()
end

function test(x, y)
    if x == 0 then 
        return 0
    else
        return y 
    end 
end

print(test(0, p()))
```

而正则序，大致相当于如下代码，返回 0。

``` Lua
function p()
    return p()
end

function test(x, y)
    if x == 0 then 
        return 0
    else
        return y()
    end 
end

print(test(0, p))
```
