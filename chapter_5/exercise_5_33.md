## P419 - [练习 5.33]

### 编译

我们分别编译 `factorial` 和 `factorial-atl`

``` Scheme
#lang sicp
(#%require "ch5-compiler.scm")

(compile
  '(define (factorial n)
     (if (= n 1)
         1
         (* (factorial (- n 1)) n))) ;; 求值顺序不同
  'val
  'next)
  
(compile
  '(define (factorial-atl n)
     (if (= n 1)
         1
         (* n (factorial-atl (- n 1))))) ;; 求值顺序不同
  'val
  'next)  
```

它们除了过程名字，唯一的不同就是乘法(*) 的参数求值顺序不同。编译结果如下

* [factorial 的编译结果](./exercise_5_33_a.scm)
* [factorial-atl 的编译结果](./exercise_5_33_b.scm)

### 对比

使用文件比较工具，来对比两个编译结果。只有几行不同，不同之处如下:

```
;; factorial 的编译结果
false-branch4
  ...
  (assign val (op lookup-variable-value) (const n) (reg env))
  (assign argl (op list) (reg val))
  (save argl)
  (assign proc (op lookup-variable-value) (const factorial) (reg env))
  ...
after-call14
  (restore argl)
  ...
```

```
;; factorial-atl 的编译结果
false-branch4
   ...
  (save env)
  (assign proc (op lookup-variable-value) (const factorial-atl) (reg env))
  ...
after-call14
  (assign argl (op list) (reg val))
  (restore env)
  (assign val (op lookup-variable-value) (const n) (reg env))
  ...
```

### 解释

对比 `factorial` 的源码和编译结果，可知编译器对参数的求值顺序是从右到左。

``` Scheme
(* (factorial (- n 1)) n)
```
会先求值 `n`，再求值 `(factorial (- n 1))`。先求值 n, 并不用保存环境 env, 但递归求值 `factorial` 过程中，可能会改变参数寄存器 `argl`，于是需要保存恢复 `argl`。

而 `factorial-atl` 刚好相反

``` Scheme
(* n (factorial-atl (- n 1)))
```
会先求值 `(factorial-atl (- n 1))`，再求值 `n`。因为递归求值 `factorial-atl` 时是第一个参数，这时并不用保存 argl。但 `factorial-atl` 可能改变 env, 从而影响之后 n 的求值。这时需要保存 env。

### 结论

1. 编译器对参数的求值顺序是从右到左。
2. 编译 `factorial` 的乘法表达式时，需要保存恢复 `argl`，并不需要保存恢复 `env`。
3. 编译 `factorial-atl` 的乘法表达式时，需要保存恢复 `env`，并不需要保存恢复 `argl`。
4. 两者保存恢复的寄存器数目相同，效率一样。










