## P323 - [练习 4.64]

### a)

Louis 将规则错误修改成

``` Scheme
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (outranked-by ?middle-manager ?boss)
               (supervisor ?staff-person ?middle-manager))))
```

查询

``` Scheme
(outranked-by (Bitdiddle Ben) ?who)
```             
的时候，`?staff-person` 会约束到 `(Bitdiddle Ben)`。`?boss` 约束到 `?who`。运行到递归规则

``` Scheme
(outranked-by ?middle-manager ?boss)
```

时，这时 `?boss` 约束到 `?who`, `?middle-manager` 没有约束，于是又会再次查询

``` Scheme
(outranked-by ?middle-manager ?who)
```

这样再引起递归查询，不断循环，没有停止条件。

### b)

原来正确的规则是

``` Scheme
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (supervisor ?staff-person ?middle-manager)
               (outranked-by ?middle-manager ?boss))))
```

跟错误的规则比较，只是 and 中语句顺序不同。这时查询

``` Scheme
(outranked-by (Bitdiddle Ben) ?who)
```

会先模式匹配

``` Scheme
(supervisor (Bitdiddle Ben) ?middle-manager)
```

假如模式匹配不成功，根本就不会再次查询递归规则 `outranked-by`。而假如匹配成功后，`?middle-manager` 就会有约束值了。此例中 `?middle-manager` 约束为 `(Warbucks Oliver)`。之后继续查询

``` Scheme
(outranked-by (Warbucks Oliver) ?who)
```

可以看出，仅仅改变规则中 and 中语句的顺序。程序的查询行为也会大大不同。

