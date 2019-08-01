## P44 - [练习 1.34]

``` Scheme
(define (f g)
    (g 2))
```

执行表达式 (f f) 会发生错误：

``` Scheme
;The object 2 is not applicable.
```

意思是说 2 不可被应用。将 (f f) 的计算过程展开，为

``` Scheme
(f f)
(f 2)
(2 2)	; Error, The object 2 is not applicable.
```

-----

将其翻译成 Lua

``` Lua
function f(g)
    return g(2)
end 

f(f)
```

也发生相同的错误，只是错误描述有所不同。

```
attempt to call a number value (local 'g')
```
