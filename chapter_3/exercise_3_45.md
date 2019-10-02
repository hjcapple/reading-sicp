## P216 - [练习 3.45]

Louis 修改得有问题。前文的 `serialized-exchange` 实现如下。

``` Scheme
(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))
    
(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    ((serializer1 (serializer2 exchange))
     account1
     account2)))
```

注意 `serialized-exchange` 中，需要分别使用 `serializer1`, `serializer2` 进行串行化。之后调用 exchange。

exchange 中调用 `(account1 'withdraw)`。假如按照 Louis 的修改，会调用 make-account 内部的

``` Scheme
(balance-serializer withdraw)
```

同理，`(account2 'deposit)` 会调用 make-account 内部的

``` Scheme
(balance-serializer deposit)
```

分析后知道。

* exchange 中的 `serializer1` 跟 `(account1 'withdraw)` 使用的 `balance-serializer`，是同一个 serializer。
* exchange 中的 `serializer2` 跟 `(account2 'deposit)` 使用的 `balance-serializer`，是同一个 serializer。

于是 exchange 的实现中，会出现下面过程

```
使用 serializer1 -> 使用 serializer2 -> 再次使用 serializer1 -> 再次使用 serializer2
```

按照本书下文 make-serializer 的实现，再次使用 serializer1 时，因为使用了同一个串行化，exchange 就会阻塞，产生死锁。

(准确地说，是否会产生死锁，需要看 mutex 的实现, 见题外话的描述)

### 题外话

书中下文使用 mutex 来实现 make-serializer。很多语言中的 mutex 实际细分成两种

* 普通的 mutext
* recursive_mutex

假如使用普通的 mutext， 同一个计算过程多次获取 mutex，会死锁。假如使用 `recursive_mutex`, 同一个计算过程可以多次获取 mutex, 并不会死锁。

所以上文说 Louis 修改后，exchange 就会阻塞，产生死锁。其实有点不准确的，需要看 `make-serializer` 的具体实现，里面所用到的 mutex 的类型。

但现实中的项目，建议只使用普通的 mutex, 就算同一个计算过程，也不要多次获取 mutex。

一来 `recursive_mutex` 有额外的性能损耗。

二来，假如需要使用 `recursive_mutex` 来避免死锁，通常表示程序设计得有问题。

