## P358 - [练习 5.6]

在 afterfib-n-1 中，`(restore continue)` 和 `(save continue)` 可以去掉。

``` Scheme
afterfib-n-1
  (restore n)
  (restore continue) ;; 可以去掉
  (assign n (op -) (reg n) (const 2))
  (save continue)    ;; 可以去掉
  (assign continue (label afterfib-n-2))
  (save val)
  (goto (label fib-loop))
```

这两个指令，将 continue 从栈中取出，之后又再压入。


