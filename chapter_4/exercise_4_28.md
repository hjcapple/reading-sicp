## P282 - [练习 4.28]

在 [lazyeval.scm](./lazyeval.scm) 中修改测试。按照题目意思将 `eval` 中的 `application?` 分支修改成：

``` Scheme
((application? exp)
 (apply (eval (operator exp) env) ; 将 actual-value 改成 eval
        (operands exp)
        env))
```

下面测试代码就会出错

``` Scheme
(define (f op)
  op)
((f +) 1 2)
```

在惰性求值中 `(f +)` 的返回被封装成 thunk。

``` Scheme
('thunk + env)
```

假如直接使用 `eval` 而不是 `actual-value`，测试代码会触发 `apply` 中的 error。

```
Unknown procedure type -- APPLY (thunk + #0=(( xxxxx
```
