## P237 - [练习 3.68]

Louis 的修改是有问题的。

``` Scheme
(define (pairs s t)
  (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                t)
    (pairs (stream-cdr s) (stream-cdr t))))
```    

使用 Louis 定义的 pairs 求值 `(pairs integers integers)`，程序会死循环。

因为 Lousi 定义的 `pairs` 会调用 `interleave`。而调用 `interleave` 时，需要先求值各个参数。于是就需要求值 `(pairs (stream-cdr s) (stream-cdr t))`。

这样又再调用 `interleave`，于是又再调用 `pairs`，又再调用 `interleave` ... 。`integers` 是无穷流，这种递归调用过程不会停止，于是程序就死循环了。

而原来的 `pairs` 定义中，使用了 `cons-stream`，后面的 `interleave` 会延迟求值。当取到足够的项，调用就会自然停止下来。

