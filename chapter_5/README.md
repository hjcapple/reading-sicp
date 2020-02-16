## 第5章 寄存器机器里的计算

### 模拟器、求值器、编译器

* [Register-Machine Simulator](./ch5-regsim.scm), 5.2 节
* [Explicit-Control Evaluator](./ch5-eceval.scm), 5.4 节
* [Compiler](./ch5-compiler.scm), 5.5 节
* [Explicit-Control Evaluator, 运行编译后的代码](./ch5-eceval-compiler.scm), 5.5.7 小节

### 5.1 寄存器机器的设计

* P346 - [练习 5.1](./exercise_5_1.md)
* P346 - 5.1.1 一种描述寄存器机器的语言
	* P348 - [练习 5.2](./exercise_5_2.md)
* P348 - 5.1.2 机器设计的抽象
	* P349 - [练习 5.3](./exercise_5_3.md)
* P351 - 5.1.3 子程序
* P354 - 5.1.4 采用堆栈实现递归
	* P356 - [递归的阶乘机器](./fact-machine.scm)
	* P357 - [递归的斐波那契机器](./fib-machine.scm)
	* P357 - [练习 5.4](./exercise_5_4.md)
	* P358 - [练习 5.5](./exercise_5_5.md)
	* P358 - [练习 5.6](./exercise_5_6.md)

### 5.2 一个寄存器机器模拟器

* P360 - [gcd-machine](./gcd-machine.scm)
* P360 - [练习 5.7](./exercise_5_7.scm)
* P360 - 5.2.1 机器模型
* P364 - 5.2.2 汇编程序
	* P366 - [练习 5.8](./exercise_5_8.md)
* P366 - 5.2.3 为指令生成执行过程
	* P371 - [练习 5.9](./exercise_5_9.md)
	* P371 - [练习 5.10](./exercise_5_10.md)
	* P371 - [练习 5.11](./exercise_5_11.md)
	* P371 - [练习 5.12](./exercise_5_12.md)
	* P372 - [练习 5.13](./exercise_5_13.md)
* P372 - 5.2.4 监视机器执行
	* P373 - [练习 5.14](./exercise_5_14.md)
	* P373 - [练习 5.15](./exercise_5_15.scm)
	* P373 - [练习 5.16](./exercise_5_16.scm)
	* P373 - [练习 5.17](./exercise_5_17.scm)
	* P373 - [练习 5.18](./exercise_5_18.scm)
	* P373 - [练习 5.19](./exercise_5_19.scm)

### 5.3 存储分配和废料收集

* P374 - 5.3.1 将存储看作向量
	* P377 - [练习 5.20](./exercise_5_20.md)
	* P378 - [练习 5.21](./exercise_5_21.scm)
	* P378 - [练习 5.22](./exercise_5_22.scm)
* P378 - 5.3.2 维持一种无穷存储的假象

### 5.4 显式控制的求值器

* P384 - 5.4.1 显式控制求值器的内核
* P388 - 5.4.2 序列的求值和尾递归
* P381 - 5.4.3 条件、赋值和定义
	* P392 - [练习 5.23](./exercise_5_23.md)
	* P392 - [练习 5.24](./exercise_5_24.md)
	* P393 - [练习 5.25](./exercise_5_25.md)
* P393 - 5.4.4 求值器的运行
	* P395 - [练习 5.26](./exercise_5_26.md)
	* P396 - [练习 5.27](./exercise_5_27.md)
	* P396 - [练习 5.28](./exercise_5_28.md)
	* P396 - [练习 5.29](./exercise_5_29.md)
	* P396 - [练习 5.30](./exercise_5_30.md)

### 5.5 编译

* P399 - 5.5.1 编译器的结构
	* P402 - [练习 5.31](./exercise_5_31.md)
	* P402 - [练习 5.32](./exercise_5_32.md)
* P402 - 5.5.2 表达式的编译
* P407 - 5.5.3 组合式的编译
* P412 - 5.5.4 指令序列的组合
* P515 - [5.5.5 编译代码的实例](./compile-example.scm)
	* P419 - [练习 5.33](./exercise_5_33.md)
	* P420 - [练习 5.34](./exercise_5_34.scm)
	* P420 - [练习 5.35](./exercise_5_35.scm)
	* P421 - [练习 5.36](./exercise_5_36.md)
	* P421 - [练习 5.37](./exercise_5_37.md)
	* P421 - [练习 5.38](./exercise_5_38.scm)
* P422 - 5.5.6 词法地址
	* P424 - [练习 5.39](./exercise_5_39.scm)
	* P424 - [练习 5.40](./exercise_5_40.scm)
	* P424 - [练习 5.41](./exercise_5_41.scm)
	* P424 - [练习 5.42](./exercise_5_42.scm)
	* P424 - [练习 5.43](./exercise_5_43.md)
	* P425 - [练习 5.44](./exercise_5_44.scm)
* P425 - [5.5.7 编译代码与求值器的互连](./eceval-compiler-example.scm)
	* P428 - [练习 5.45](./exercise_5_45.md)
	* P429 - [练习 5.46](./exercise_5_46.md)
	* P429 - [练习 5.47](./exercise_5_47.md)
	* P429 - [练习 5.48](./exercise_5_48.md)
	* P429 - [练习 5.49](./exercise_5_49.scm)
	* P429 - [练习 5.50](./exercise_5_50.scm)
	* P430 - [练习 5.51, C 编写的 Scheme 求值器](./exercise_5_51/README.md)
	* P430 - [练习 5.52, 将 Scheme 编译成 C 指令](./exercise_5_52/README.md)



