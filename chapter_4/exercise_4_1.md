## P255 - [练习 4.1]

首先写一小段测试代码，

``` Scheme
(define (f a)
  (display a)
  (newline)
  a)

(+ (f 1) (f 2) (f 3))
```

稍微修改 [mceval.scm](./mceval.scm) 中的 `list-of-values` 函数。运行后，将上面测试代码粘贴到输入中。

假如依次打印出参数 1、2、3，就表示 `list-of-values` 从左往右求值。假如打印出参数 3、2、1，就表示 `list-of-values` 从右往左求值。

### 从左往右求值

``` Scheme
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((first (eval (first-operand exps) env)))
        (cons first (list-of-values (rest-operands exps) env)))))
```

### 从右往左求值

``` Scheme
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((rest (list-of-values (rest-operands exps) env)))
        (cons (eval (first-operand exps) env) rest))))
```

#### 细节

注意上面当中，let 语句中只定义了 first 或者 rest 一个变量。假如写成下面形式，let 中定义了两个变量。

``` Scheme
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((first (eval (first-operand exps) env))
            (rest (list-of-values (rest-operands exps) env)))
        (cons first rest))))
```

first 和 rest 也就依赖了 let 的参数的求值顺序，也有可能是不确定的。


