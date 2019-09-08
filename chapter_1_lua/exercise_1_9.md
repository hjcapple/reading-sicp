## P23 - [练习 1.9]

``` Scheme
(define (+ a b)
  (if (= a 0) 
      b 
      (inc (+ (dec a) b))))
```

计算 `(+ 4 5)`，展开为

``` Scheme
(+ 4 5)
(inc (+ 3 5))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9
```

可以看出计算过程的形状，先展开再收缩。这个计算过程是递归的。

-------

``` Scheme
(define (+ a b)
  (if (= a 0) 
      b 
      (+ (dec a) (inc b))))
```

计算 `(+ 4 5)`，展开为

``` Scheme
(+ 4 5)
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 9)
9
```

计算过程只使用常量存储，只需跟踪 a、b 两个值，并且计算所需步骤正比于参数 a。这个计算过程是线性迭代的。

