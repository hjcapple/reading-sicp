## P137 - [练习 2.86]

[完整代码点这里](./exercise_2_86.scm)。代码综合了前面习题的结果，一些细节后面解释。

### scheme-number

[练习 2.78](./exercise_2_78.scm) 修改 `attach-tag`，`type-tag`，`contents` 的实现，对 number 特殊处理。于是普通的数字可以参与通用计算，更加方便。比如

``` Scheme
(add 1 2)
(sub 0.2 0.1)	
```

### 类型塔

[练习 2.85](./exercise_2_85.scm) 中，在类型塔中 raise 和 project 来实现 drop 函数。以简化计算结果。
原始的类型塔为

```
integer(整数) -> rational(有理数) -> real(实数) -> complex(复数)
```

原生的 scheme-number 被特殊处理，去掉标记。于是 integer 和 real 不再区分，统一成 scheme-number。类型塔就变为

```
rational -> scheme-number -> complex
```

### 错误的类型塔

原来设想是保留 integer 类型，对于 integer? 为真的情况特殊处理。还是有 4 层类型塔。为

```
scheme-number(integer? 为 #t) -> rational -> scheme-number -> complex
```

但这样的类型塔会会出现问题。设想 scheme-number 为 1。当

``` Scheme
(raise 1)
```
上升一层，变为 `'(rational 1 . 1)`。而再想上升一层，分子除以分母，又还原成 1。要记住，为了方便使用，我们已经将 scheme-number 特殊处理，不再在前面添加特殊的标记了。

于是整数的 1 和实数的 1 不可区分。

于是在这种错误的类型塔上，调用 

``` Scheme
(raise-into 1 'complex)
```

想让 1 爬升到复数，就会无限递归。

### drop

[练习 2.85](./exercise_2_85.scm) 只使用 raise 和 project 来实现 drop 函数。但在我们的类型塔中，rational 已是最底层。于是 `'(rational 1 . 1)` 就不能再被简化。但实际上，这种情况下应该简化为 1。因此对于 rational 特殊处理一下，以便化简。

``` Scheme
(define (rational->integer? rat)
  (if (equal? 'rational (type-tag rat))
    (let ((v (/ (number (contents rat)) (denom (contents rat)))))
      (if (integer? v)
          v 
          #f))
    #f))

(define (drop x)
  (if (pair? x) ; 过滤 #t、#f 等没有 type-tag 的参数
      (let ((v (rational->integer? x)))
        (if v
            v
            (let ((x-project (project x)))
              (if (and x-project
                       (equ? (raise x-project) x))
                  (drop x-project)
                  x))))
      x))
```

### 复数(complex)化简过程

``` Scheme
(define (add-complex z1 z2)
	(make-from-real-imag (add (real-part z1) (real-part z2))
	                     (add (imag-part z1) (imag-part z2))))
```

类似修改，将本来的 + 号，换成了通用函数 add。之后复数就实部和虚部都可使用常规数或有理数。比如下面代码

``` Scheme
(add (make-complex-from-real-imag (make-rational 1 2) (make-rational 1 2))
     (make-complex-from-real-imag (make-rational 1 2) -0.5))
```

实部相加 

``` Scheme
(add (make-rational 1 2) (make-rational 1 2))
(make-rational 1 1)
```

于是 drop 函数将其化简为 1。

虚部相加

``` Scheme
(add (make-rational 1 2) -0.5)
(add 0.5 -0.5) ;; 提升到实数
0				  ;; 实数计算结果
```

因此上面复数计算结果为

``` Scheme
(make-from-real-imag 1 0)
```

这个复数又被 drop 函数化简，于是最终结果为 1。






