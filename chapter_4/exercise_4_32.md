## P286 - [练习 4.32]

### a)

本节实现的惰性表，连表中第一个元素 car，也可惰性求值。第三章实现的流，第一个元素是需要立即求值的。

比如 [练习 4.18](./exercise_4_18.md) 中，将 `solve` 改写成：

``` Scheme
(define (solve f y0 dt)
  (let ((y '*unassigned*)
        (dy '*unassigned*))
    (let ((a (integral (delay dy) y0 dt))
          (b (stream-map f y)))
      (set! y a)
      (set! dy b))
    y))
```

`(stream-map f y)` 在流中需要立即求值 y 的第一个元素。因而发生错误。

而惰性表实现的相应版本：

``` Scheme
(define (solve f y0 dt)
  (let ((y '*unassigned*)
        (dy '*unassigned*))
    (let ((a (integral dy y0 dt))
          (b (map f y)))
      (set! y a)
      (set! dy b))
    y))
```   

是可以正常求值的。在惰性表中，`(map f y)`的第一个元素也被延迟求值了。

### b)

惰性表的第一个元素也是惰性的，我们可以改变表中的初始值，从而修改整个序列。比如库中预先写好随机数序列

``` Scheme
(define random-init 7)
(define random-numbers
  (cons random-init
        (map rand-update random-numbers)))
```

这个随机数序列，默认情况下，初始化值为 7。有时我们想在使用的时候，设置另一个初始值。可以这样写

``` Scheme
(set! random-init 100)
(list-ref random-numbers 10)
```

用户就可以根据不同用途，设置初始值。

