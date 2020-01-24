## 第5章 寄存器机器里的计算

### 模拟器及求值器

* [Register-Machine Simulator](./ch5-regsim.scm), 5.2 节
* [Explicit-Control Evaluator](./ch5-eceval.scm), 5.4 节

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

* 5.4.1 显式控制求值器的内核
* 5.4.2 序列的求值和尾递归
* 5.4.3 条件、赋值和定义
	* P392 - [练习 5.23](./exercise_5_23.md)
	* P392 - [练习 5.24](./exercise_5_24.md)


