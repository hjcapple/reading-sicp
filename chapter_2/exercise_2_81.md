## P136 - [练习 2.81]

此题完整的[测试验证代码见这里](exercise_2_81.scm)。

### a)

假如按照 Louis 的修改，为 complex 安装了到自身的强制过程 `complex->complex`。当 exp 操作不存在时，比如下面语句

``` Scheme
(exp (make-complex-from-real-imag 10 0) (make-complex-from-real-imag 10 0))
```

使得程序死循环。在 `apply-generic` 中添加打印一些信息，会不断输出

```
apply-generic: op = exp, args =((complex rectangular 10 . 0) (complex rectangular 10 . 0))
apply-generic: op = exp, args =((complex rectangular 10 . 0) (complex rectangular 10 . 0))
apply-generic: op = exp, args =((complex rectangular 10 . 0) (complex rectangular 10 . 0))
apply-generic: op = exp, args =((complex rectangular 10 . 0) (complex rectangular 10 . 0))
apply-generic: op = exp, args =((complex rectangular 10 . 0) (complex rectangular 10 . 0))
apply-generic: op = exp, args =((complex rectangular 10 . 0) (complex rectangular 10 . 0))
....
```

可以看到修改后的程序，以相同的参数不断重复调用 `apply-generic`，死循环了。

### b)

Louis 并没有纠正相同类型参数强制的问题，反而使得问题更加严重。当没有添加 `complex->complex`，复数求 exp 时，程序会直接退出，输出错误信息

```
No method for these types -- APPLY-GENERIC (exp (complex complex))
```
Louis 的修改反而会引发死循环。

这是修改后，`(get-coercion 'complex 'complex)` 可以从表格找到强制函数，于是 cond 中的条件 `t1->t2` 就会成立。于是执行

``` Scheme
(apply-generic op (t1->t2 a1) a2)
```
而 `t1->t2` 会返回自身， `(t1->t2 a1)` 结果为 a1。因此就会不断循环执行

``` Scheme
(get-coercion 'complex 'complex)
(apply-generic op (t1->t2 a1) a2)
(apply-generic op a1 a2)

(get-coercion 'complex 'complex)
(apply-generic op (t1->t2 a1) a2)
(apply-generic op a1 a2)

(get-coercion 'complex 'complex)
(apply-generic op (t1->t2 a1) a2)
(apply-generic op a1 a2)

(....)
```

而修改前，并不能从表格中找到 complex 的强制函数，程序退出并输出错误信息。

### c)

为 `apply-generic` 添加一个判断。

``` Scheme
(define (apply-generic op . args)
  (define (handle-error type-tags)
    (error "No method for these types -- APPLY-GENERIC"
       (list op type-tags)))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (if (equal? type1 type2)  ;; 练习 2.81 -c 添加此判断
                    (handle-error type-tags)
                    (let ((t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
                            (t2->t1 (apply-generic op a1 (t2->t1 a2)))
                            (else (handle-error type-tags))))))
              (handle-error type-tags))))))
```
