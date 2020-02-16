## P430 - [练习 5.51]

一个 C 编写的简单 Scheme 求值器。性能和错误处理都有问题。各文件的如下:

| 文件                                    | 作用                  |
|----------------------------------------|-----------------------|
| [scheme_runtime.c](./scheme_runtime.c) | 实现 Scheme 的运行时，包含一个很简单的 GC |
| [scheme.c](./scheme.c)                 | 主程序，驱动求值循环                    |
| [eceval.c](./eceval.c)                 | 实现 `eval` 和 `apply` 核心函数。对应 [ch5-eceval.scm](../ch5-eceval.scm)|
| [eceval_support.c](./eceval_support.c) | 对应 [ch5-eceval-support.scm](../ch5-eceval-support.scm)|
| [syntax.c](./syntax.c)                 | 对应 [ch5-syntax.scm](../ch5-syntax.scm)                |
| [prime_libs.c](./prime_libs.c)         | C 编写的，导出给 Scheme 代码使用的原生函数                    |
| [scheme_libs.h](./scheme_libs.h)       | Scheme 编写的基础函数                                     |

### 编译

我只在 MacOS 上测试过代码，有个 Xcode 工程和一个 Makefile。在 MacOS 上面，可以直接打开 Xcode 工程编译。或者使用命令行

```
cd exercise_5_51
make
```

编译后产生一个 `scheme` 的可执行文件。使用

```
make clean
```
将会删除编译时产生的 .o 和可执行文件。

### 使用

下面命令可以解释求值 Scheme 源代码

```
./scheme test_code/huffman.scm
```

假如没有文件参数。直接敲入

```
./scheme
```

会等待用户输入，进入求值循环。

### TODO

这个简单的 Scheme 求值器还没有使用 `load`, 还不能从一个源文件中载入另一个源文件。这是个比较大的限制。


