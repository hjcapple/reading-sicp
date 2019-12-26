## P282 - [练习 4.29]

### a)

修改 [lazyeval.scm](./lazyeval.scm)，在 `driver-loop` 中添加计时。

``` Scheme
(#%require (only racket current-inexact-milliseconds))

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read))
        (star-time (current-inexact-milliseconds)))
    (let ((output
            (actual-value input the-global-environment)))
      (announce-output (- (current-inexact-milliseconds) star-time))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
```

下面的测试代码

``` Scheme
(begin
  (define (power x n)
    (if (= n 1)
        x
        (* x (power x (- n 1)))))
  
  (power (power 1 100) 1000)
)
```

在同一机器上，分别打开和关闭 `force-it` 的记忆功能。

* 在有记忆功能下，求值时间为 0.014 秒。
* 在没有记忆功能下，求值时间为 22.203 秒。


### b)

``` Scheme
(define count 0)
(define (id x)
  (set! count (+ count 1))
  x)

(define (square x)
  (* x x))
```

在有记忆功能时

``` Scheme
;;; L-Eval input:
(square (id 10))
;;; L-Eval value:
100
;;; L-Eval input:
count
;;; L-Eval value:
1
```

在没有记忆功能时

``` Scheme
;;; L-Eval input:
(square (id 10))
;;; L-Eval value:
100
;;; L-Eval input:
count
;;; L-Eval value:
2
```

* 在有记忆功能下，`(id 10)` 只被调用 1 次，count 为 1。
* 在没有记忆功能时，`(id 10)` 被调用了 2 次，count 为 2。

