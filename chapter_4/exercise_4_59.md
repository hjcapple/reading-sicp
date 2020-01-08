## P312 - [练习 4.59]

运行 [queryeval.scm](./queryeval.scm) 测试。

### a)

``` Scheme
(meeting ?x (Friday ?t))
```

查询结果

``` Scheme
(meeting administration (Friday 1pm))
```

### b)

``` Scheme
(rule (meeting-time ?person ?day-and-time)
      (or (meeting whole-company ?day-and-time)
          (and (job ?person (?division . ?type))
               (meeting ?division ?day-and-time))))
```

### c)

``` Scheme
(meeting-time (Hacker Alyssa P) (Wednesday ?time))
```

查询结果

``` Scheme
(meeting-time (Hacker Alyssa P) (Wednesday 4pm))
(meeting-time (Hacker Alyssa P) (Wednesday 3pm))
```
