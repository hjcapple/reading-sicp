## P335 - [练习 4.70]

let 约束中 `old-assertions` 用于保存 `THE-ASSERTIONS` 的当前值，构造新流，将 assertion 插在流的最前面。这样构造出的新流是有限的。

假如不要 let 约束，下面的语句

``` Scheme
(set! THE-ASSERTIONS
      (cons-stream assertion THE-ASSERTIONS))
```

`THE-ASSERTIONS` 会引用自身，将自身拼接在流的后面。这种递归引用会产生一个无穷流。

这类似 P226 中的 ones 定义
 
``` Scheme
(define ones (cons-stream 1 ones))
```

假如我们将其稍微改改

``` Scheme
(define ones '())
(set! ones (cons-stream 1 ones))
```

就跟题目中的写法一致了。书中原文为

> 这种定义方式就像是在定义一个递归过程：这里的 ones 是一个序对，它的 car 是 1，而 cdr 是求值 ones 的一个允诺。对于其 cdr 的求值又给了我们一个 1 和求值 ones 的一个允诺，并这样继续下去。

