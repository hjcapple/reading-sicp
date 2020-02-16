## P430 - [练习 5.52]

将 Scheme 代码编译成 C 指令序列。

* [`compiler.scm`](./compiler.scm), 修改后的编译器。将 Scheme 编译成 C 代码。
* [`exercise_5_52.scm`](./exercise_5_52.scm), 使用编译器编译 4.1 节的求值器，生成 C 写的 Scheme 解释器。

### 运行 Scheme

使用 DrRacket 打开 `exercise_5_52.scm`，运行后。会生成一个 [gen-scheme.hpp](./gen-scheme.hpp) 的 C 代码文件。

### C 代码文件

要执行 `gen-scheme.hpp` 中的代码。我们包含几个文件

* [scheme.c](./scheme.c), main 函数入口。
* [gen-scheme.hpp](./gen-scheme.hpp), 编译生成的 C 代码。

还需要 [练习 5.51](../exercise_5_51/README.md) 中实现的运行时支持。

| 文件                                    | 作用                  |
|----------------------------------------|-----------------------|
| [scheme_runtime.c](../exercise_5_51/scheme_runtime.c) | 练习 5.51 文件，实现 Scheme 的运行时，包含一个很简单的 GC |              |
| [eceval_support.c](../exercise_5_51/eceval_support.c) | 练习 5.51 文件, 对应 [ch5-eceval-support.scm](../ch5-eceval-support.scm)|
| [prime_libs.c](../exercise_5_51/prime_libs.c)         | 练习 5.51 文件, C 编写的，导出给 Scheme 代码使用的原生函数                    |

### 编译 C 代码

我只在 MacOS 上测试过代码，有个 Xcode 工程和一个 Makefile。在 MacOS 上面，可以直接打开 Xcode 工程编译。或者使用命令行

```
cd exercise_5_52
make
```

编译后产生一个 `scheme` 的可执行文件。使用

```
make clean
```
将会删除编译时产生的 .o 和可执行文件。

### 使用

敲入

```
./scheme
```

执行效果相当于 [`exercise_5_52.scm`](./exercise_5_52.scm) 要编译的原始 Scheme 代码。一个简单的求值器。

