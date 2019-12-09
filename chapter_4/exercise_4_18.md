## P270 - [练习 4.18]

可以在 P241 - [3.5.4](../chapter_3/delayed_stream.scm) 的基础上修改测试。改写 solve 函数。

``` Scheme
(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

(define (solve2 f y0 dt)
  (let ((y '*unassigned*)
        (dy '*unassigned*))
    (set! y (integral (delay dy) y0 dt))
    (set! dy (stream-map f y))
    y))

(define (solve3 f y0 dt)
  (let ((y '*unassigned*)
        (dy '*unassigned*))
    (let ((a (integral (delay dy) y0 dt))
          (b (stream-map f y)))
      (set! y a)
      (set! dy b))
    y))  
```

其中 solve 是原始的函数，solve2 是正文使用的转换，solve3 是本题目使用的转换。

测试后可知道，solve2 可以正确工作。而 solve3 会失败，返回错误信息

``` 
car: contract violation
  expected: pair?
  given: '*unassigned
```

### 原因

solve3 的错误信息，发生在内层的 let 语句中。  

``` Scheme
(let ((a (integral (delay dy) y0 dt))
      (b (stream-map f y))) ;; 这条语句发生错误
  xxx)   
```

`(stream-map f y)` 尽管里面使用 delay, 但还是需要立即求值第一个元素，于是也就需要求值 `(car y)`。但是这时 y 还没有被赋值，y 的值还是 `*unassigned*`, 因此就发生了错误。

solve2 可以正确工作。下面语句依次执行

``` Scheme
(set! y (integral (delay dy) y0 dt))
(set! dy (stream-map f y))
```
当调用 `(stream-map f y)` ，需要求值 `(car y)` 时, 这时候 y 已经被正确赋值了。

注意到，solve2、solve3 中的 `(integral (delay dy) y0 dt)` 语句都不会发生错误。因为 `(delay dy)` 语句中的 dy 并不需要立即求值。


