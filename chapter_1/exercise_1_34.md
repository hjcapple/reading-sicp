## P44 - [练习 1.34]

``` Scheme
(define (f g)
  (g 2))
```

在 DrRacket 执行表达式 `(f f)` 会发生错误：

```
application: not a procedure;
 expected a procedure that can be applied to arguments
  given: 2
  arguments...:
```

而在 Mit-Scheme 中执行 `(f f)`，发生相同的错误，只是错误描述有所不同。

``` Scheme
;The object 2 is not applicable.
```

将 (f f) 的计算过程展开，为

``` Scheme
(f f)
(f 2)
(2 2)	; Error, The object 2 is not applicable.
```

