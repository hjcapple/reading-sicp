## P195 - [练习 3.31]

<img src="./half-adder.svg"/>

根据半加器的连接，当 A = 1, B = 0 时，正确的 S 应该为 1。

添加如下的测试代码

``` Scheme
(define input-a (make-wire))
(define input-b (make-wire))
(define sum (make-wire))
(define carry (make-wire))
(half-adder input-a input-b sum carry)

(set-signal! input-a 1)
(propagate)

(get-signal sum)
```

使用原来的 `accept-action-procedure!` 定义，上述测试代码中。`(get-signal sum)` 正确返回 1。

但假如修改为

```
(define (accept-action-procedure! proc)
  (set! action-procedures (cons proc action-procedures)))
```

上述的测试代码中，`(get-signal sum)` 错误返回 0。

## 原因

accept-action-procedure! 是 add-action! 触发的。当用线路连接 or-gate、and-gate、inverter 这些基本元件时，会调用 add-action!，从而触发 accept-action-procedure!。

原来的 accept-action-procedure! 实现中，调用了一次 (proc), 会调用 after-delay, 在延迟一段时间后，将线路的值初始化。这样在连接各基本元件时，信号传递，将整个电路都自动初始化了。

假如 accept-action-procedure! 不调用 (proc), 线路并不会被正确初始化。

于是半加器中，当 A = 1, B = 0 时，调用 `(propagate)` 后下面的第一个 and-gate 输出仍然为 0，不会触发 inverter 输出改变。E 线路仍然错误地停留在没有初始好的值 0。但实际上 E 线路的值应该为 1。

