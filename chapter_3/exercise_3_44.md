## P215 - [练习 3.44]

Louis 说得不对。

``` Scheme
(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))
```

上面的 transfer 函数，假如 `from-account` 和 `to-account` 的余额都单独受串行化保护。就可以分解成两部分

```
1. ((from-account 'withdraw) amount)
2. ((to-account 'deposit) amount)
```

1、2 两部分可看成不可分解的整体。只要 1、2 两部分都执行完成，无论中间插入任何的其它操作，都可以保证 transfer 前后总余额不变。

总余额不变，这正是转账(transfer) 操作的不变量。这点类似 [练习 3.43](./exercise_3_43.md) c) 中的分析。

只要账号单独受串行保护，并且保证 1、2 都可以完成，transfer 的实现就是正确的。

transfer 和 exchange，区别在于 exchange 需要读取两个账号的余额，计算差值，最后再调用两账号的 withdraw 和 deposit。于是 exchange 的实现中，每个账号都有读取和修改过程。假如 exchange 中途被打断，其它进程修改账号余额。exchange 之前计算出的差值就出错了。

而 transfer 并不用额外读取余额，其隐含在 withdraw、deposit 内部的读取操作也受到串行化保护。因此 exchange 的正确实现需要更精细的保护，transfer 并不需要。

### 题外话

transfer 也并不能用于现实的银行转账中。前面已经说了，要保证转账后总余额不变，1、2 必须都完成。假如执行完 1 后，程序突然崩溃，2 就没有被执行。这样转账就处于中间状态，总余额凭空多了 amount。

也可能转账是通过网络进行，1 执行后，网络突然断了，导致 2 执行失败。也使得转账并不完整。

1、2 之间可以被打断，插入其它操作。但是 1、2 必须都执行，或者都不执行，不能只执行一个，另一个不执行。

现实中的转账系统，必须通过额外的方式保证账号不能处于中间状态。假如 1 执行完成，2 完成不了，就必须回滚 1 的操作。让两个账号恢复到转账之前。

