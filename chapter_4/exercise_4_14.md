## P266 - [练习 4.14]

### 复现问题

我们首先复现题目所描述的问题。只考虑一个列表的情况，简化 map 可实现如下：

``` Scheme
(define (map op sequence)
  (if (null? sequence)
      '()
      (cons (op (car sequence)) (map op (cdr sequence)))))
```

运行 [mceval.scm](./mceval.scm), 输入上述的 map 实现，再输入最简单的测试代码

``` Scheme
(map + (list 1 2 3))
```

可以运行成功。自定义 map 可运行成功，这点很正常，不成功才奇怪。

----

之后在 [mceval.scm](./mceval.scm) 的 `primitive-procedures` 列表中添加

``` Scheme
(list 'map map)
```

安装系统的基本过程 map。再输入测试代码

``` Scheme
(map + (list 1 2 3))
```

这时出现运行错误。

``` Scheme
application: not a procedure;
 expected a procedure that can be applied to arguments
  given: (primitive #<procedure:+>)
  arguments...:
```  

### 原因

在环境中安装基础函数的时候，会添加 primitive 标记。map 和 + 符号对应的值

``` Scheme
('primitive #<procedure:map>)   ; map 符号对应的值
('primitive #<procedure:+>)     ; + 符号对应的值
```

`#<procedure:map>` 这种记法，是指系统的基础过程 map。

`(map + (list 1 2 3))` 最终会调用 `apply-primitive-procedure`，proc 和 args 对应的值为
 
``` Scheme
(primitive #<procedure:map>)
((primitive #<procedure:+>) (1 2 3))
```

于是最终相当于执行系统基础过程

``` Scheme
(#<procedure:map> (`primitive #<procedure:+>) (1 2 3))
```
 
注意 map 的第一个参数，期望是个过程，但实际却是个列表。于是就运行出错了。

同理测试代码

``` Scheme
(map (lambda (x) (+ x 1)) (list 1 2))
```

也会让基本过程 map 执行错误。

``` Scheme
application: not a procedure;
 expected a procedure that can be applied to arguments
  given: (procedure (x) ((+ x 1)) (((false true car cdr list cons null? display xxxx
  arguments...:
```

这是因为自定义的 lambda，在求值器的实现中，表示方式是携带了环境的列表，也并非是原始的系统过程。

