## P428 - [练习 5.45]

### a)

编译运行 [factorial 的代码](./eceval-compiler-example.scm), 依次敲入

``` Scheme
(factorial 1)   ; (total-pushes = 7 maximum-depth = 3)
(factorial 2)   ; (total-pushes = 13 maximum-depth = 5)
(factorial 3)   ; (total-pushes = 19 maximum-depth = 8)
(factorial 4)   ; (total-pushes = 25 maximum-depth = 11)
(factorial 5)   ; (total-pushes = 31 maximum-depth = 14)
(factorial 6)   ; (total-pushes = 37 maximum-depth = 17)
(factorial 7)   ; (total-pushes = 43 maximum-depth = 20)
(factorial 8)   ; (total-pushes = 49 maximum-depth = 23)
(factorial 9)   ; (total-pushes = 55 maximum-depth = 26)
(factorial 10)  ; (total-pushes = 61 maximum-depth = 29)
```

列个表格

|  n            | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 |
|-------------- |----|----|----|----|----|----|----|----|----|----|
| total-pushes  | 7  | 13 | 19 | 25 | 31 | 37 | 43 | 49 | 55 | 61 |
| maximum-depth | 3  | 5  | 8  | 11 | 14 | 17 | 20 | 23 | 26 | 29 |

观察知道，n >= 2 时，`total-pushes` 和 `maximum-depth` 都是等差数列

```
total-pushes = 13 + (n - 2) * 6 = 6 * n + 1
maximum-depth = 5 + (n - 2) * 3 = 3 * n - 1
```

对比 [练习 5.27](./exercise_5_27.md) 中的解释器版本。n 变大时，可忽略常数项，编译器和解释器的比率为：

```
total-pushes: (6 * n + 1) / (32 * n - 16) => 6/32 = 0.1875
maximum-depth: (3 * n - 1) / (5 * n + 3) => 3/5 = 0.6
```

对比 [练习 5.14](./exercise_5_14.md) 中，手工打造的阶乘专用机器。n 变大时，编译器和专用机器的比率为：

```
total-pushes: (6 * n + 1) / (2 * n - 2) => 6/2 = 3
maximum-depth: (3 * n - 1) / (2 * n - 2) => 3/2 = 1.5
```

从上面的对比可知，手工打造的专用机器优于编译器版本，编译器版本优于解释器版本。

### b)

要使编译器生成的代码跟手工版本接近。可以先应用 [练习 5.38](./exercise_5_38.scm) 的开放代码。这假设 `+ * - =` 都是基本函数。

应用开放代码后，编译生成的阶乘代码在最后面，其堆栈利用率为

```
total-pushes = 2 * n + 3
maximum-depth = 2 * n - 2
```

已经跟手工打造的代码有点接近了。主要还有两点不同

1. 手工打造的代码，`n` 和 `factorial` 直接存放在寄存器中。编译生成的代码，这两个数据放到了环境 `env` 中，有个查找环境的过程。
2. 手工打造的代码，对 `factorial` 的递归调用是直接跳转。编译生成的代码，有一个查找 `factorial`，显式调用的过程。

我们可以根据上述两点，对编译器进行修改。

1. 改进编译器的寄存器使用方式。优先将数据放到寄存器中，而不是放到环境中。
2. 编译递归调用时，直接跳转到入口处。避免显式查找环境，再调用的过程。


``` Scheme
'((assign val (op make-compiled-procedure) (label entry1) (reg env))
  (goto (label after-lambda2))
  entry1
  (assign env (op compiled-procedure-env) (reg proc))
  (assign env (op extend-environment) (const (n)) (reg argl) (reg env))
  (assign arg1 (op lookup-variable-value) (const n) (reg env))
  (assign arg2 (const 1))
  (assign val (op =) (reg arg1) (reg arg2))
  (test (op false?) (reg val))
  (branch (label false-branch4))
  true-branch3
  (assign val (const 1))
  (goto (reg continue))
  false-branch4
  (save continue)
  (save env)
  (assign proc (op lookup-variable-value) (const factorial) (reg env))
  (assign arg1 (op lookup-variable-value) (const n) (reg env))
  (assign arg2 (const 1))
  (assign val (op -) (reg arg1) (reg arg2))
  (assign argl (op list) (reg val))
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-branch6))
  compiled-branch7
  (assign continue (label proc-return9))
  (assign val (op compiled-procedure-entry) (reg proc))
  (goto (reg val))
  proc-return9
  (assign arg1 (reg val))
  (goto (label after-call8))
  primitive-branch6
  (assign arg1 (op apply-primitive-procedure) (reg proc) (reg argl))
  after-call8
  (restore env)
  (restore continue)
  (assign arg2 (op lookup-variable-value) (const n) (reg env))
  (assign val (op *) (reg arg1) (reg arg2))
  (goto (reg continue))
  after-if5
  after-lambda2
  (perform (op define-variable!) (const factorial) (reg val) (reg env))
  (assign val (const ok)))
```