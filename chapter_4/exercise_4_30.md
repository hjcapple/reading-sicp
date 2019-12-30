## P282 - [练习 4.30]

### a)

在求值 `eval-sequence` 时，序列的每个表达式都被 `eval`。而下面的语句中

``` Scheme
(proc (car items)
```

是一个过程调用，会对 proc 应用 `actual-value`，从而强制求值 proc，在此例中就是那个 lambda 表达式。

对 proc 应用 `actual-value` 而不是 `eval` 的理由见 [练习 4.28](./exercise_4_28.md)。

对 lambda 求值，又会再次触发 `eval-sequence`。`newline` 和 `display` 都是系统基本过程。在求值 `display` 基本过程时，每个参数都会被 `actual-value` 来求值，`actual-value` 会调用 `force-it`，获取到 x 的真正值。
 
### b)

对于原来的 `eval-sequence`，两个表达式的结果如下

``` Scheme
(p1 1)  ;; (1 2)
(p2 1)  ;; 1
```

按照 Cy 的建议修改后的 `eval-sequence`，结果如下

``` Scheme
(p1 1)  ;; (1 2)
(p2 1)  ;; (1 2)
```

两者结果的差异在于 p2 中 e 语句的处理不同。

``` Scheme
(define (p2 x)
  (define (p e)
    e	; 这里的处理不同
    x)
  (p (set! x (cons x '(2)))))
```

e 对应于 `(set! x (cons x '(2)))` 语句，被延迟求值了。这个 e 本身有副作用。

对于原来的 `eval-sequence`，e 被调用 eval，e 对应于一个 thunk，并没有被真正求值。于是没有触发副作用来改变 x, x 仍然是原来 1。

而 Cy 的建议修改后的 `eval-sequence`，e 会被调用 `actual-value`，真正求值。触发了副作用，修改了 x，于是 x 的结果为 `(cons 1 '(2))`。也就是列表 `(1 2)`。

### c)

正如 a) 所解释的，`for-each` 中传入的 proc 参数，作为过程调用。

``` Scheme
(proc (car items)
```

对于过程调用的，proc 本身会被使用 `actual-value`，而不是应用 `eval`。而类似 b) 中的 e 表达式，只会使用 `eval`。

正是这点区别，让 Cy 的修改，对于类似 a) 中的 `for-each` 实例，其结果是一样的。

Cy 的修改，显示地让整个表达式 `(proc (car items)` 求值。而原来的实现，对 proc（对应传进来的 lambda）使用 `actual-value` 求值。两者都会触发对 lambda 内部的实现来求值。

### d)

我更喜欢原来的 `eval-sequence` 实现。

Cy 的方式有点激进，让序列中的中间表达式都强值求值，很可能导致本来并不需要求值的也被求值，就没有惰性的效果。

实际上，书中原始实现已经足够好。原始实现和 Cy 的建议，两者对于 for-each 的运行结果也是一致的。

for-each 这种代码很常见，而

``` Scheme
(define (p2 x)
  (define (p e)
    e
    x)
  (p (set! x (cons x '(2)))))
```

这种代码本身就有点难以理解，现实中的程序是不建议这样写的。让过程参数带有副作用，本身就不好。

为了迁就本身就不够好的代码，而采用激进的方式，影响所有的序列求值效果。我认为是不值得的。
