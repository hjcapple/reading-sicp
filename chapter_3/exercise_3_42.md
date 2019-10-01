## P213 - [练习 3.42]

查看书中后面章节，`make-serializer`

``` Scheme
(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serialized-p . args)
        (mutex 'acquire)
        (let ((val (apply p args)))
          (mutex 'release)
          val))
      serialized-p)))
```

可以判断修改后的 make-account 实现，还是安全的。无论修改前每次返回新过程，还是修改后返回同一个串行化过程。只要使用同一个 `serializer`, 过程间就可使用同一个 mutex。mutex 可保证时序互斥，不会被随机打断。
 
比如 P1 正在执行 `(protected-withdraw 10)`, 获取到 mutex。之后被打断切换到 P2 执行 `(protected-withdraw 20)`，这时 P2 会试图获取同一个 mutex。但 mutext 已经被 P1 获取了，P2 获取失败，就会等待 P1 释放 mutex。P1 执行完 withdraw 函数，释放 mutex 后，P2 才能获取 mutex 继续执行下去。因而 P1 执行 withdraw 时就不可能被 P2 打断。

修改后，在并发性方面，make-account 的两个版本之间没有任何区别。

唯一区别只是出于性能的考虑。假如 account 的函数被频繁调用，修改后的版本，不用重复创建过程，相对会快一些。而修改好后的版本一开始就创建额外的两个串行化过程，make-account 函数初始化时稍微慢一些。假如 account 被创建后，其函数并不会被调用，这个串行化过程仍然需要被保存，就浪费了。


