## P324 - [练习 4.68]

运行 [queryeval.scm](./queryeval.scm)，测试查询。

### a)

``` Scheme
(assert! (rule (append-to-form () ?y ?y)))
(assert! (rule (append-to-form (?u . ?v) ?y (?u . ?z))
               (append-to-form ?v ?y ?z)))

(assert! (rule (reverse () ())))
(assert! (rule (reverse (?x . ?y) ?z)
               (and (reverse ?y ?u)
                    (append-to-form ?u (?x) ?z))))
```

查询 `(reverse (1 2 3) ?x)`，结果为

``` Scheme
;; Query results:
(reverse (1 2 3) (3 2 1))
```

但是查询 `(reverse ?x (1 2 3))` 时，会无穷循环。

### b)

将 and 中判断顺序反过来，写成

``` Scheme
(assert! (rule (reverse () ())))
(assert! (rule (reverse (?x . ?y) ?z)
               (and (append-to-form ?u (?x) ?z)
                    (reverse ?y ?u))))
```

这时查询行为也正好相反了。查询 `(reverse (1 2 3) ?x)`，会无穷循环。

查询 `(reverse ?x (1 2 3))`，结果为

``` Scheme
;; Query results:
(reverse (3 2 1) (1 2 3))
```                   

### c)

但是，实现不了一个规则 reverse，让其回答双向查询

``` Scheme
(reverse (1 2 3) ?x)
(reverse ?x (1 2 3))
```
