## P402 - [练习 5.31]

### a)

``` Scheme
(f 'x 'y)
```

不需要 save 和 restore 任何寄存器。

### b)

``` Scheme
((f) 'x 'y)
```

也不需要 save 和 restore 任何寄存器。

### c)

``` Scheme
(f (g 'x) y)
```

在求值 `(g 'x)` 时候需要用到 proc 和 argl 寄存器。因而 proc 和 argl 需要 save 和 restore。

环境寄存器 env, 需要分两种情况考虑。假如参数的求值顺序是从左到右，先后求值

``` Scheme
(g 'x) 
y
```

这种情况下，env 也需要 save 和 restore。

假如参数的求值顺序是从右到左，先后求值

``` Scheme
y
(g 'x) 
```
这种情况下，env 不需要保护。

结论：

1. 假如参数的求值顺序是从左到右，需要 save 和 restore 三个寄存器：proc、argl、env。
2. 假如参数的求值顺序是右到左，需要 save 和 restore 两个寄存器：proc、argl。

### d)

``` Scheme
(f (g 'x) 'y)
```

需要 save 和 restore 两个寄存器：proc、argl。不需要保护环境寄存器 env。

