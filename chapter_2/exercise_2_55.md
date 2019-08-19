## P99 - [练习 2.55]

P97 页的注释中有提及，'a 只是 (quote a) 的简写方式。因此

``` Scheme
(car ''abracadabra)
```

其实等价于

``` Scheme
(car (quote (quote abracadabra)))
```

上面这种形式可能还不明显。只展开一个引号，保留另一个引号。也可以写成

``` Scheme
(car '(quote abracadabra))
```

于是 car 用于取出表中首个元素，就打印出 quote。

