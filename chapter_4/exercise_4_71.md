## P338 - [练习 4.71]

`simple-query` 和 `disjoin` 的情况很类似，我们用 `simple-query` 为例。

原始的 `simple-query` 会将流除了 car 的部分都会延迟求值。但修改后

``` Scheme
(define (simple-query query-pattern frame-stream)
  (stream-flatmap
    (lambda (frame)
      (stream-append 
        (find-assertions query-pattern frame)
        (apply-rules query-pattern frame))) ;; apply-rules 会被求值，原来是延迟求值的
    frame-stream))
```

这时 `apply-rules` 会立即被求值。有时 `apply-rules` 的求值结果是浪费的，有时也会产生额外的问题。

### a)

如 P322 的无穷循环规则

``` Scheme
(assert! (married Minnie Mickey)) 
(assert! (rule (married ?x ?y) 
               (married ?y ?x)))
(married Mickey ?who)
```

在原始的实现中，会无穷循环。但因为 `apply-rules` 被延迟，`simple-query` 会返回。最起码会显示出结果，虽然结果是无穷流

``` Scheme
(married Mickey Minnie) 
(married Mickey Minnie) 
(married Mickey Minnie) 
....
``` 

但修改后的代码，会一直在 `simple-query` 中死循环。什么都没有显示。打印无穷流最起码会比卡住没有反应要好。

再如 not 语句查询

``` Scheme
(assert! (married Minnie Mickey)) 
(assert! (rule (married ?x ?y) 
               (married ?y ?x)))
(not (married Mickey ?who))
```

`(married Mickey ?who)` 返回无穷流，因而 not 可以立即返回(无穷流也是有值），查询结果为

``` Scheme
(not (married Mickey ?who))
```

但假如去掉 delay, 上述的查询语句会在 `simple-query` 中死循环。

### b)

`disjoin` 中使用 `delay` 的理由跟 `simple-query` 类似。假如查询

``` Scheme
(or P1 P2)
(not (or P1 P2))
```

其中 P2 返回无穷流。

去掉 `delay`, P2 的结果没有延迟求值，出现的问题跟 `simple-query` 类似。

