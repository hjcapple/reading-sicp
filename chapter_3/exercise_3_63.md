## P235 - [练习 3.63]

`sqrt-stream` 将迭代表示成流，要计算第 n 项的值，先要计算第 n - 1 项的值。

### a)

原始实现为

``` Scheme
(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)
```

`stream-map` 中传入相同的流 guesses。假如 delay 采用记忆过程的优化，guesses 的每项只会被计算一次。

而 Louis 的版本

``` Scheme
(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream x))))
```

`stream-map` 中每次返回不同的 `(sqrt-stream x)`，尽管其项的值相同，但因为是不同的流，计算结果就不可复用。Louis 的实现下，计算第 2 项时，需要计算第 1 项。计算第 3 项时，会重复计算第 2 项，又再重复计算第 1 项。之后计算第 4 项，又会再重复计算第 3、2、1 项。

在 delay 有记忆过程的优化下，原始实现效率为 O(n)。Louis 的版本，效率变为 O(n^2)。

### b)

当 delay 没有记忆过程优化时，原始的实现，尽管是同一个流 guesses，其结果都不可复用。这时每项都需要重复计算，效率变为 O(n^2)。

Louis 的版本，本身并没有享受记忆过程的好处，就算 delay 没有了记忆过程，也不受影响。效率仍然为 O(n^2)。

此时两个版本的效率没有差异。

### 验证

[完整的程序在这里](./exercise_3_63.scm)
                           
在 `sqrt-improve` 添加一些打印信息。

``` Scheme
(define (sqrt-improve guess x)
  (display "sqrt-improve: guess= ")
  (display guess)
  (newline)
  (average guess (/ x guess)))
```                             

在 delay 有记忆过程优化下。输出

```
(sqrt-stream 2)
1.0
sqrt-improve: guess= 1.0
1.5
sqrt-improve: guess= 1.5
1.4166666666666665
sqrt-improve: guess= 1.4166666666666665
1.4142156862745097
sqrt-improve: guess= 1.4142156862745097
============
(sqrt-stream-2 2)
1.0
sqrt-improve: guess= 1.0
1.5
sqrt-improve: guess= 1.0
sqrt-improve: guess= 1.5
1.4166666666666665
sqrt-improve: guess= 1.0
sqrt-improve: guess= 1.5
sqrt-improve: guess= 1.4166666666666665
1.4142156862745097
sqrt-improve: guess= 1.0
sqrt-improve: guess= 1.5
sqrt-improve: guess= 1.4166666666666665
sqrt-improve: guess= 1.4142156862745097
============
```

可见原始的版本(sqrt-stream), 每计算多一项，只会多调用一次 `sqrt-improve`。而 Louis 的版本(sqrt-stream-2)，每次都会重复计算，计算越靠后的项，调用 `sqrt-improve` 的次数就越多。

修改 [stream.scm](./stream.scm)，将 delay 切换到非记忆优化。这时程序输出。

```
(sqrt-stream 2)
1.0
sqrt-improve: guess= 1.0
1.5
sqrt-improve: guess= 1.0
sqrt-improve: guess= 1.5
1.4166666666666665
sqrt-improve: guess= 1.0
sqrt-improve: guess= 1.5
sqrt-improve: guess= 1.4166666666666665
1.4142156862745097
sqrt-improve: guess= 1.0
sqrt-improve: guess= 1.5
sqrt-improve: guess= 1.4166666666666665
sqrt-improve: guess= 1.4142156862745097
============
(sqrt-stream-2 2)
1.0
sqrt-improve: guess= 1.0
1.5
sqrt-improve: guess= 1.0
sqrt-improve: guess= 1.5
1.4166666666666665
sqrt-improve: guess= 1.0
sqrt-improve: guess= 1.5
sqrt-improve: guess= 1.4166666666666665
1.4142156862745097
sqrt-improve: guess= 1.0
sqrt-improve: guess= 1.5
sqrt-improve: guess= 1.4166666666666665
sqrt-improve: guess= 1.4142156862745097
============
```

可知 `sqrt-stream` 和 `sqrt-stream-2` 都重复计算了每项，输出信息没有差别。

