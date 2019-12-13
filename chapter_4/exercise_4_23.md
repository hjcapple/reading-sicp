## P276 - [练习 4.23]

Alyssa 实现的版本中，序列中每个表达式虽然经过分析，但序列本身并没有经过分析，计算时需要动态循环序列本身。

正文给出的版本，序列中的表达式经过分析，序列本身也经过分析。计算序列时，并不需要循环，计算序列那个循环被优化了。

这样说，可能不够清楚。举些例子。

### a) 序列只有一个表达式

假如序列只有一个最简单的表达式

``` Scheme
'Hello
```

这个表达式本身，在两个版本中都被分析为

``` Scheme
(lambda (env) 'Hello)
```

Alyssa 实现的版本，分析序列后，返回相当于

``` Scheme
(lambda (env) (execute-sequence (list
                                  (lambda (env) 'Hello)
                                  ) 
                                env))
```

可以看到，`execute-sequence` 传入分析后表达式列表，求值 `execute-sequence` 需要循环列表本身。

而正文中实现的版本，分析序列的结果为

``` Scheme
(lambda (env) 'Hello)
```
可以看到，直接返回序列中的表达式本身，不需要经过任何循环。

### b) 序列有两个表达式

假如序列有两个表达式

``` Scheme
'Hello
'World
```

表达式本身，在两个版本中都被分析为

``` Scheme
(lambda (env) 'Hello)
(lambda (env) 'World)
```

Alyssa 实现的版本，分析序列后，返回相当于

``` Scheme
(lambda (env) (execute-sequence (list
                                  (lambda (env) 'Hello)
                                  (lambda (env) 'World)
                                  ) 
                                env))
```

跟一个表达式时，没有太大区别，`execute-sequence` 需要循环列表。

而正文中实现的版本，分析序列后，会将分析后的表达式连锁起来。返回

``` Scheme
(lambda (env)
  ((lambda (env) 'Hello) env)
  ((lambda (env) 'World) env))
```

### c) 序列有更多表达式

``` Scheme
'Hello
'World
'Hello
'World
```
Alyssa 实现的版本，就算更多表达式，也跟之前差不多。`execute-sequence` 需要循环列表。

而正文的版本，连锁表达式后，分析结果相当于

``` Scheme
(lambda (env)
  ((lambda (env)
     ((lambda (env)
        ((lambda (env) 'Hello) env)
        ((lambda (env) 'World) env)) env)
     ((lambda (env) 'Hello) env)) env)
  ((lambda (env) 'World) env))
```  

正文的版本，就算有再多的表达式，也会将分析后的表达式连锁起来。其分析结果是完全没有循环的，直接调用，将循环表达式优化掉了。



