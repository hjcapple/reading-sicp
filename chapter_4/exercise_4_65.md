## P323 - [练习 4.65]

`(wheel ?who)` 查询结果中，`Warbucks Oliver` 出现多次。是因为他是大老板，有很多下属。

为了看得更清除，我们 wheel 规则修改为

``` Scheme
(rule (wheel ?x ?middle-manager ?person)
      (and (supervisor ?middle-manager ?person)
           (supervisor ?x ?middle-manager)))
```

查询 `(wheel ?x ?middle-manager ?who)` 结果为

``` Scheme
(wheel (Cratchet Robert) (Scrooge Eben) (Warbucks Oliver))
(wheel (Tweakit Lem E) (Bitdiddle Ben) (Warbucks Oliver))
(wheel (Reasoner Louis) (Hacker Alyssa P) (Bitdiddle Ben))
(wheel (Fect Cy D) (Bitdiddle Ben) (Warbucks Oliver))
(wheel (Hacker Alyssa P) (Bitdiddle Ben) (Warbucks Oliver))
```

上面查询结果中，显示出三层的上下级关系。可以看到，虽然 Warbucks Oliver 出现多次，但每次的上下级关系链都有所不同。假如不显示 ?x、?middle-manager，就查询最终的大人物，就会对应于题目中的查询结果。

``` Scheme
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))
(wheel (Bitdiddle Ben))
(wheel (Warbucks Oliver))
(wheel (Warbucks Oliver))
```

注：我使用 DrRacket，查询结果的顺序跟书中有点不同。


