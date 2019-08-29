## P128 - [练习 2.76]

### 显式分派

[显式分派](./complex_number_tagged.scm)风格，每添加一种新类型，都需要编写新类型自身的操作函数，并在每个通用操作函数的 cond 中，添加一个新的分支。

比如要添加一种新的复数表示，需要添加 `real-part-new`、`imag-part-new` 等自身的操作函数，也需要 `real-part`，`imag-part` 这些通用函数中添加新的 `(new? z)` 分支。

而添加新的操作，除了编写新的通用操作函数，还需要为每个类型添加类型相关的操作函数。

因而无论是添加类型，还是添加新的操作，需要改动的地方都不少。并且原有的类型和操作越多，添加新的类型和新操作就会越麻烦。

另外显式分派，还需要在新类型的操作函数时，添加前缀或者后缀，防止名字冲突。我们可以改进这点，将函数包装起来，达到类似名字空间的作用，比如

``` Scheme
(define (rectangular op)
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  
  (cond ((eq? op 'real-part) real-part)
        ((eq? op 'real-part) real-part)
        (else (error "Unkown op -- RECTANGULAR" op))))

((rectangular 'real-part) z)
```
这个 `rectangular` 就类似名字空间，`(rectangular 'real-part)` 将相应的函数取出。

### 数据导向

[数据导向](./complex_number_data_directed.scm)风格，添加一种新类型时，只需要添加相应的 `install-new-package` 函数，在一个地方编写好新类型自身的操作函数。通过隐含的表格进行分发管理，通用函数本身不用做任何修改。

而添加新操作，需要在每个包中添加相应的类型操作函数，并注册到表格中。但假如稍微组织一下代码，让新操作本身作为安装包。比如

``` Scheme
(define (install-complex-newop-package)
  (define (complex-newop-rectangular z)
    (do-using-complex-1 z))
  
  (define (complex-newop-polar z)
    (do-using-complex-2 z))
  
  (put 'complex-newop '(rectangular) complex-newop-rectangular)
  (put 'complex-newop '(polar) complex-newop-polar))

(define (complex-newop z) (apply-generic 'complex-newop z))
```
这样组织代码，添加新操作的修改都集中到一个地方，并不用修改原有的代码。

因而数据导向的风格，以隐含的表格作为中介，无论是添加新类型，还是添加新操作，都变得相对容易。

### 消息传递

[消息传递](./exercise_2_75.scm)风格，原则上跟数据导向风格相似，只是分发的方式不同。

数据导向使用隐含的表格，用表格的信息作为分发的依据。而消息传递，使用一个动态的函数作为分发的依据。简单地来，数据导向使用静态的数据，消息传递使用动态的代码。但正如这章前面所说的，数据和代码的差别是很微妙的。见[序对的过程性表示](./exercise_2_4.md), [Church 计数](./exercise_2_6.md)。

消息传递没有隐含的表格，没有表格注册查找，实现更干净。但返回相对动态的过程，而不是相对静态的数据，使得打印信息和调试更麻烦。

要为消息传递风格添加新的类型，只需要为新类型添加一个分发函数。但要添加新的操作，就需要在每个类型的分发函数中，添加一个新的分支，原有类型越多，添加新操作修改的地方就越多，分散在各处。

因而消息传递的风格，添加新类型会相对容易，添加新操作就会变得相对麻烦。

### 总结

* 显式分派风格，添加新类型，新操作都会很麻烦。代码上直观，最容易想到。
* 数据导向风格，添加新类型，新操作都会相对容易。有隐含的表格，需要进行表格注册和查找。
* 消息传递风格，添加新类型相对容易，添加新操作相对麻烦（但没有显式分派麻烦）。代码实现比数据导向干净。






