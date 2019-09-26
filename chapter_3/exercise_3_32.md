## P197 - [练习 3.32]

与门的代码为

``` Scheme
(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)
```

假设开始时

```
a1 = 0
a2 = 1
```

要将其修改为 `(a1, a2) = (1, 0)`。可以有两种时序，分别为

``` Scheme
(set-signal! a1 1)
(set-signal! a2 0)
```

或者

``` Scheme
(set-signal! a2 0)
(set-signal! a1 1)
```

### 分析时序 1

我们先看前一种时序。

当调用 `(set-signal! a1 1)` 时，a1 = 1。但需要特别注意，此时 a2 还没有变化，仍然为 1。于是

```
a1 = 1
a2 = 1
```
此时 `logical-and` 的结果为 1。

之后再调用 `(set-signal! a2 0)`，此时 a1 = 1, a2 = 0, 于是 `logical-and` 结果为 0。因此时序

``` Scheme
(set-signal! a1 1)
(set-signal! a2 0)
```

会触发两个过程，添加到待处理表中，依次为

``` Scheme
(set-signal! output 1)
(set-signal! output 0)
```

并且他们的时间段是相同的。之后处理表中过程。

* 假如按照原来次序（先进先出）进行处理，最终 output 的结果为 0。
* 假如按照后进先出来处理，最终 output 的结果就为 1。

很显然，最终状态下 a1 = 1, a2 = 0。与门(and-gate) 的 output 正确结果为 0。因此按照后进先出来处理，结果就不对了。

### 分析时序 2

同理，我们来分析时序 2。开始时 a1 = 0, a2 = 1。如下时序

``` Scheme
(set-signal! a2 0)
(set-signal! a1 1)
```

先设置 a2 = 0, 特别注意，此时 a1 还没有变化, a1 = 0。于是 `logical-and` 结果为 0。

之后设置 a1 = 1, 此时 a2 = 0。于是 `logical-and` 结果为 0。于是会触发两条语句，添加到待处理列表中，依次为

``` Scheme
(set-signal! output 0)
(set-signal! output 0)
```

他们的时间段是一样的。很显然，这种时序下，无论先进后出，还是后进先出, 对于 and-gate 结果都是一样的。

但不要认为先设置 a2 后设置 a1 就永远是对的。这种时序下，对于 or-gate 来说，就错掉了。

* a2 = 0，a1 = 0, `logical-or` 结果为 0。
* a1 = 1，a2 = 0, `logical-or` 结果为 1。

对于 or-gate, 这种时序，就会触发语句

``` Scheme
(set-signal! output 0)
(set-signal! output 1)
```
于是，对于 or-gate, 按照后进先出来处理，结果仍然不对。

### 结论

数字电路模拟中，添加到待处理列表中的过程。假如时间段相同，必须严格按照次序（先进先出）来处理，不然最终状态会依赖设置时序，很可能出错。

