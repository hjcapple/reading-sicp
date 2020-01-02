## P290 - [练习 4.36]

[练习 4.35](./exercise_4_35.scm) 的程序中，假如使用 `an-integer-starting-from` 来替代 `integer-between`, i、j、k 都会有无穷的选择。特别是对于 k，需要搜索无穷的选择，i、j 就得不到更新。而条件

``` Scheme
(require (= (+ (* i i) (* j j)) (* k k)))
```
又得不到满足，就会一直死循环。

正确的方式是将 k 放到最前面。而使用 `an-integer-between` 来搜索 i、j，这样 i、j 都会有停止条件。代码如下：

``` Scheme
(define (a-pythagorean-triple)
  (let ((k (an-integer-starting-from 1)))
    (let ((j (an-integer-between 1 k)))
      (let ((i (an-integer-between 1 j)))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))
```

完整的程序[在这里](./exercise_4_36.scm)。

