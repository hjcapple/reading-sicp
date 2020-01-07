## P309 - [练习 4.55]

运行 [queryeval.scm](./queryeval.scm) 测试。

### a)

``` Scheme
(supervisor ?x (Bitdiddle Ben))
```

查询结果

```
(supervisor (Tweakit Lem E) (Bitdiddle Ben))
(supervisor (Fect Cy D) (Bitdiddle Ben))
(supervisor (Hacker Alyssa P) (Bitdiddle Ben))
```

### b)

``` Scheme
(job ?x (accounting . ?type)) 
```

查询结果

```
(job (Cratchet Robert) (accounting scrivener))
(job (Scrooge Eben) (accounting chief accountant))
```

### c)

``` Scheme
(address ?x (Slumerville . ?where)) 
```

查询结果

```
(address (Aull DeWitt) (Slumerville (Onion Square) 5))
(address (Reasoner Louis) (Slumerville (Pine Tree Road) 80))
(address (Bitdiddle Ben) (Slumerville (Ridge Road) 10))
```
