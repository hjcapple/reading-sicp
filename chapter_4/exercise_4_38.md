## P291 - [练习 4.38]

中文翻译错了。原文为

> Modify the multiple-dwelling procedure to omit the requirement that Smith and Fletcher do not live on adjacent floors. How many solutions are there to this modified puzzle?

是指忽略掉，Smith 和 Fletcher 不住相邻层的要求。也就是在 [multiple_dwelling.scm](./multiple_dwelling.scm) 的基础上，删除

``` Scheme
(require (not (= (abs (- smith fletcher)) 1)))
```
这个条件。

删除条件后，谜题有下面 5 组解。

```
((baker 1) (cooper 2) (fletcher 4) (miller 3) (smith 5)) 
((baker 1) (cooper 2) (fletcher 4) (miller 5) (smith 3)) 
((baker 1) (cooper 4) (fletcher 2) (miller 5) (smith 3)) 
((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1)) 
((baker 3) (cooper 4) (fletcher 2) (miller 5) (smith 1))
```
