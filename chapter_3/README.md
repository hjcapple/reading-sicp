## 第3章 模块化、对象和状态

### 3.1 赋值和局部状态

* P150 - [3.1.1 局部状态变量](./withdraw.scm)
	* P154 - [练习 3.1](./exercise_3_1.scm)
	* P154 - [练习 3.2](./exercise_3_2.scm)
	* P154 - [练习 3.3](./exercise_3_3.scm)
	* P154 - [练习 3.4](./exercise_3_4.scm)
* P154 - [3.1.2 引进赋值带来的利益](./monte_carlo.scm)
	* [monte-carlo、cesaro-test 简述](./monte_carlo_and_cesaro.md)
	* P157 - [练习 3.5](./exercise_3_5.scm)
	* P157 - [练习 3.6](./exercise_3_6.scm)
* P157 - 3.1.3 引进赋值的代价
	* P161 - [练习 3.7](./exercise_3_7.scm)
	* P162 - [练习 3.8](./exercise_3_8.scm)

### 3.2 求值的环境模型

* P163 - 3.2.1 求值规则
* P165 - 3.2.2 简单过程的应用
	* P167 - [练习 3.9](./exercise_3_9.md)
* P167 - 3.2.3 将框架看作局部状态的展台
	* P170 - [练习 3.10](./exercise_3_10.md)
* P171 - 3.2.4 内部定义
	* P172 - [练习 3.11](./exercise_3_11.md)

### 3.3 用变动数据做模拟

* P173 - 3.3.1 变动的表结构
	* P175 - [练习 3.12](./exercise_3_12.md)
	* P176 - [练习 3.13](./exercise_3_13.md)
	* P176 - [练习 3.14](./exercise_3_14.md)
	* P178 - [练习 3.15](./exercise_3_15.md)
	* P178 - [练习 3.16](./exercise_3_16.md)
	* P178 - [练习 3.17](./exercise_3_17.scm)
	* P179 - [练习 3.18](./exercise_3_18.scm)
	* P179 - [练习 3.19](./exercise_3_19.scm)
	* P179 - [练习 3.20](./exercise_3_20.md)
* P180 - [3.3.2 队列的表示](./queue.scm)
	* P183 - [练习 3.21](./exercise_3_21.md)
	* P183 - [练习 3.22](./exercise_3_22.scm)
	* P183 - [练习 3.23](./exercise_3_23.md)
* P183 - 3.3.3 表格的表示
	* P183 - [一维表格](./table_1d.scm)
	* P185 - [二维表格](./table_2d.scm)
	* P186 - [局部表格](./table_local.scm)
	* P187 - [练习 3.24](./exercise_3_24.scm)
	* P187 - [练习 3.25 - 解法 a](./exercise_3_25_a.scm)
	* P187 - [练习 3.25 - 解法 b](./exercise_3_25_b.scm)
	* P187 - [练习 3.26](./exercise_3_26.scm)
	* P188 - [练习 3.27](./exercise_3_27.md)
* P188 - [3.3.4 数字电路的模拟器](./digital_circuit.scm)
	* P192 - [练习 3.28](./exercise_3_28.md)
	* P192 - [练习 3.29](./exercise_3_29.md)
	* P192 - [练习 3.30](./exercise_3_30.md)
	* P195 - [练习 3.31](./exercise_3_31.md)
	* P197 - [练习 3.32](./exercise_3_32.md)
* P198 - [3.3.5 约束的传播](./constraints.scm)
	* P205 - [练习 3.33](./exercise_3_33.scm)
	* P205 - [练习 3.34](./exercise_3_34.md)
	* P205 - [练习 3.35](./exercise_3_35.scm)
	* P205 - [练习 3.36](./exercise_3_36.md)
	* P205 - [练习 3.37](./exercise_3_37.scm)

### 3.4 并发：时间是一个本质问题

* [并发](./concurrency.md)
* P207 - 3.4.1 并发系统中时间的性质
	* P210 - [练习 3.38](./exercise_3_38.md)
* P210 - 3.4.2 控制并发的机制
	* P212 - [练习 3.39](./exercise_3_39.md)
	* P212 - [练习 3.40](./exercise_3_40.md)
	* P213 - [练习 3.41](./exercise_3_41.md)
	* P213 - [练习 3.42](./exercise_3_42.md)
	* P215 - [练习 3.43](./exercise_3_43.md)
	* P216 - [串行化的实现](./serializer.scm)
	* P215 - [练习 3.44](./exercise_3_44.md)
	* P216 - [练习 3.45](./exercise_3_45.md)
	* P217 - [练习 3.46](./exercise_3_46.md)
	* P218 - [练习 3.47](./exercise_3_47.scm)
	* P219 - [练习 3.48](./exercise_3_48.scm)
	* P219 - [练习 3.49](./exercise_3_49.md)

### 3.5 流

* P220 - [3.5.1 流作为延时的表](stream.scm)
	* P225 - [练习 3.50](./exercise_3_50.scm)
	* P226 - [练习 3.51](./exercise_3_51.md)
	* P226 - [练习 3.52](./exercise_3_52.md)

* P226 - [3.5.2 无穷流](./infinite_stream.scm)
	* P230 - [练习 3.53](./exercise_3_53.md)
	* P230 - [练习 3.54](./exercise_3_54.scm)
	* P230 - [练习 3.55](./exercise_3_55.scm)
	* P230 - [练习 3.56](./exercise_3_56.scm)
	* P231 - [练习 3.57](./exercise_3_57.md)
	* P231 - [练习 3.58](./exercise_3_58.md)
	* P231 - [练习 3.59, e^x, sinx, cosx 幂级数展开](./exercise_3_59.scm)
	* P232 - [练习 3.60, mul-series](./exercise_3_60.scm)
	* P232 - [练习 3.61, invert-unit-series](./exercise_3_61.scm)
	* P232 - [练习 3.62, div-series, tan-series](./exercise_3_62.scm)

* P232 - 3.5.3 流计算模式的使用
	* P232 - [系统地将迭代操作方式表示为流过程](./stream_iterations.scm)
	* P235 - [练习 3.63](./exercise_3_63.md)
	* P235 - [练习 3.64](./exercise_3_64.scm)
	* P235 - [练习 3.65](./exercise_3_65.scm)
	* P235 - [序对的无穷流](./pairs_stream.scm)
	* P237 - [练习 3.66](./exercise_3_66.md)
	* P237 - [练习 3.67](./exercise_3_67.scm)
	* P237 - [练习 3.68](./exercise_3_68.md)
	* P238 - [练习 3.69](./exercise_3_69.scm)
	* P238 - [练习 3.70](./exercise_3_70.scm)
	* P238 - [练习 3.71, Ramanujan数](./exercise_3_71.scm)
	* P238 - [练习 3.72](./exercise_3_72.scm)
	* P239 - [练习 3.73](./exercise_3_73.scm)
	* P240 - [练习 3.74](./exercise_3_74.scm)
	* P240 - [练习 3.75](./exercise_3_75.scm)
	* P240 - [练习 3.76](./exercise_3_76.scm)

* P241 - [3.5.4 流和延时求值](./delayed_stream.scm)
	* P242 - [练习 3.77](./exercise_3_77.scm)
	* P242 - [练习 3.78](./exercise_3_78.scm)
	* P243 - [练习 3.79](./exercise_3_79.scm)
	* P243 - [练习 3.80](./exercise_3_80.md)

* P245 - [3.5.5 函数式程序的模块化和对象的模块化](./monte_carlo_stream.scm)
	* P246 - [练习 3.81](./exercise_3_81.scm)
	* P246 - [练习 3.82](./exercise_3_82.scm)



