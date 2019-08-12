## P64 - [练习 2.14]

Lem 是对的，如下代码：

``` Scheme
(define (part1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (part2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define A (make-center-percent 20 2))
(define B (make-center-percent 10 2))

(print-interval A)
(print-interval B)
(print-interval (part1 A B))
(print-interval (part2 A B))
(print-interval (div-interval A A))
(print-interval (div-interval A B))
```

代码中，

```
A = [19.6, 20.4]
B = [9.8, 10.2]
```

计算得到 

``` 
(part1 A B) = [6.277124183006538, 7.077551020408162]
(part2 A B) = [6.533333333333334, 6.799999999999999]
```

可以看到 part1 和 part2 的计算结果是不同的。part2 的区间范围更窄，是更好的估计值。

-----

另外可以看到

```
A / A = [0.9607843137254903, 1.040816326530612]
A / B = [1.9215686274509807, 2.081632653061224]
```

理论上说 A/A 应该精确为 [1, 1], 但实际上会有所偏差。
