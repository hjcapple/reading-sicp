## P393 - [练习 5.25]

* [完整代码在这里](./exercise_5_25.scm)

参考第 4 章的 [惰性求值器](../chapter_4/lazyeval.scm), 需要增改：

* 改动标记 `ev-application`， 对应 `eval` 函数中的 `application?` 分支。
* 改动标记 `apply-dispatch`， 对应 `apply` 过程。
* 增加标记 `actual-value`，对应 `actual-value` 过程。
* 增加标记 `ev-map-operands`, 对应 `list-of-arg-values` 和 `list-of-delayed-args`。

原始代码中 `list-of-arg-values` 和 `list-of-delayed-args` 可以改写成如下样子

``` Scheme
(define (map-operands exps proc env)
  (if (no-operands? exps)
      '()
      (cons (proc (first-operand exps) env)
            (map-operands (rest-operands exps) proc env))))

(define (list-of-arg-values exps env)
  (map-operands exps actual-value env))

(define (list-of-delayed-args exps env)
  (map-operands exps delay-it env))
```

### 测试代码

使用 [练习 4.25](../chapter_4/exercise_4_25.md) 和 [练习 4.28](../chapter_4/exercise_4_28.md) 的测试代码:

``` Scheme
(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(define (factorial n)
  (unless (= n 1)
          (* n (factorial (- n 1)))
          1))

(factorial 5)

(define (f op)
  op)
((f +) 1 2)
```
