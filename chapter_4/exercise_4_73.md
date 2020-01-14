## P339 - [练习 4.73]

写成题目中的样子，就需要立即调用

``` Scheme
(flatten-stream (stream-cdr stream))
```
又再次递归调用 `flatten-stream`。需要立即将 `stream` 的所有元素都遍历完。没有达到流延迟求值的效果。

按照题目的修改，设想 `stream` 是个无穷流，这时 `flatten-stream` 就会死循环。
