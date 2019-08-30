## P132 - [练习 2.77]

此题可在[通用型算数运算](./generic_arithmetic.scm) 的代码基础上修改验证。如下代码创建图 2-24 中的对象 z

``` Scheme
(define z (make-complex-from-real-imag 3 4))
z
```
在 DrRacket 中，显示如下

``` Scheme
'(complex rectangular 3 . 4)
```

相当于

``` Scheme
(cons 'complex (cons 'rectangular (cons 3 4)))
```

可以看到，这是两层 type-tag 嵌套。先是 type-tag 为 complex, 再嵌套 type-tag 为 rectangular。

假如还没有调用 `(put 'magnitude '(complex) magnitude)`，就去调用 `(magnitude z)`。会依次调用

``` Scheme
(magnitude z)
(magnitude '(complex rectangular 3 . 4))
(apply-generic 'magnitude '(complex rectangular 3 . 4))
(get 'magnitude (map type-tag '((complex rectangular 3 . 4))))
(get 'magnitude '(complex))
```
这时 `(get 'magnitude '(complex))` 就为 #f。于是就触发 `apply-generic` 中的错误信息。

```
No method for these types -- APPLY-GENERIC (magnitude (complex))
```
--------

假如在 complex 的安装包函数 `install-complex-package` 中添加 `(put 'magnitude '(complex) magnitude)`，我们可以跟踪一下函数调用

``` Scheme
(magnitude z)
(magnitude '(complex rectangular 3 . 4))
(apply-generic 'magnitude '(complex rectangular 3 . 4))
(get 'magnitude '(complex))
(apply magnitude (map contents '((complex rectangular 3 . 4))))

(magnitude '(rectangular 3 . 4))
(apply-generic 'magnitude '(rectangular 3 . 4))
(get 'magnitude '(rectangular))
(apply magnitude-rectangular (map contents '((rectangular 3 . 4))))
(magnitude-rectangular '(3 . 4))
5
```

上述函数调用中。`magnitude-rectangular` 是指 `install-rectangular-package` 中定义的 `magnitude` 函数，为了避免重名误导，记成`magnitude-rectangular`。

可以看到 `apply-generic` 被调用了两次。

* 一次是分派到 `(get 'magnitude '(complex))`
* 另一次分派到 `(get 'magnitude '(rectangular))`。
