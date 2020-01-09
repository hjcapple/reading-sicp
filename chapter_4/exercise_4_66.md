## P324 - [练习 4.66]

### a)

正如 [练习 4.65](./exercise_4_65.md) 所示，查询结果可以会重复。比如 `(wheel ?who)` 的查询结果中，`Warbucks Oliver` 出现多次。相应地下面查询工资的语句

``` Scheme
(and (wheel ?who) (salary ?who ?amount))
```

结果为

``` Scheme
(and (wheel (Warbucks Oliver)) (salary (Warbucks Oliver) 150000))
(and (wheel (Warbucks Oliver)) (salary (Warbucks Oliver) 150000))
(and (wheel (Bitdiddle Ben)) (salary (Bitdiddle Ben) 60000))
(and (wheel (Warbucks Oliver)) (salary (Warbucks Oliver) 150000))
(and (wheel (Warbucks Oliver)) (salary (Warbucks Oliver) 150000))
```

Warbucks Oliver 的工资结果也会出现多次。假设已实现了 sum、average 等统计函数，下面统计语句

``` Scheme
(sum ?amount 
     (and (wheel ?who) 
          (salary ?who ?amount)))
```

就会将 Warbucks Oliver 的工资统计多次。这样的结果是不对的。

### b)

可以为查询系统添加剔除重复的语句，比如名字叫 distinct。将上述的统计工资语句写成

``` Scheme
(sum ?amount 
     (and (distinct (wheel ?who))
          (salary ?who ?amount)))
```          
