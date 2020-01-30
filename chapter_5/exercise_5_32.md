## P402 - [练习 5.32]

### a)

[修改后的求值器在这里](./exercise_5_32.scm)。

新增 `ev-simple-application` 标记

```
ev-simple-application
  (save continue)
  (assign unev (op operands) (reg exp))
  (assign proc (op operator) (reg exp))
  (assign proc (op lookup-variable-value) (reg proc) (reg env))
  (assign argl (op empty-arglist))
  (test (op no-operands?) (reg unev))
  (branch (label apply-dispatch))
  (save proc)
  (goto (label ev-appl-operand-loop))
```  

### b)

我觉得 Alyssa P.Hacker 说得不对，求值器无论识别多少特殊情况，也不能完全剔除编译器的优势。

首先，假如求值器考虑的特殊情况越多，求值器就会变得越复杂，越难以维护。

其次，求值器要识别特殊情况，必然需要做判断，并且每次解释代码的时候都需要做判断。做判断本身也需要时间。假如判断本身过多，对于非特殊的情况，反而会拖慢运行速度。

而编译器只需要做一次编译，就可以多次运行。并且编译和执行阶段可以分开。预先编译，对特殊情况做了优化，真正执行时就不用做过多判断，速度就可提升。


