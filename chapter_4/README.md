## 第4章 元语言抽象

### 各求值器

* [Metacircular Evaluator](./mceval.scm), 4.1.1 到 4.1.4 小节
* [Analyzing Evaluator](./analyzingmceval.scm), 4.1.7 小节
* [Lazy Evaluator](./lazyeval.scm), 4.2 节
* [Amb Evaluator](./ambeval.scm), 4.3 节
* [Query Evaluator](./queryeval.scm), 4.4 节

### 4.1 元循环求值器

* P252 - 4.1.1 求值器的内核
	* P255 - [练习 4.1](./exercise_4_1.md)
* P255 - 4.1.2 表达式的表示
	* P259 - [练习 4.2](./exercise_4_2.md)
	* P259 - [练习 4.3](./exercise_4_3.md)
	* P259 - [练习 4.4](./exercise_4_4.md)
	* P259 - [练习 4.5](./exercise_4_5.md)
	* P259 - [练习 4.6](./exercise_4_6.md)
	* P260 - [练习 4.7](./exercise_4_7.md)
	* P260 - [练习 4.8](./exercise_4_8.md)
	* P260 - [练习 4.9](./exercise_4_9.md)
	* P260 - [练习 4.10](./exercise_4_10.md)
* P260 - 4.1.3 求值器数据结构
	* P263 - [练习 4.11](./exercise_4_11.md)
	* P263 - [练习 4.12](./exercise_4_12.md)
	* P264 - [练习 4.13](./exercise_4_13.md)
* P264 - 4.1.4 作为程序运行这个求值器
	* P266 - [练习 4.14](./exercise_4_14.md)
* P266 - 4.1.5 将数据作为程序
	* P268 - [练习 4.15, 停机问题](./exercise_4_15.md)
* P269 - 4.1.6 内部定义
	* P270 - [练习 4.16](./exercise_4_16.md)
	* P270 - [练习 4.17](./exercise_4_17.md)
	* P270 - [练习 4.18](./exercise_4_18.md)
	* P271 - [练习 4.19](./exercise_4_19.md)
	* P271 - [练习 4.20](./exercise_4_20.md)
	* P272 - [练习 4.21](./exercise_4_21.md)
* P273 - [4.1.7 将语法分析与执行分离](./analyzingmceval.scm)
	* P276 - [练习 4.22](./exercise_4_22.md)
	* P276 - [练习 4.23](./exercise_4_23.md)
	* P276 - [练习 4.24](./exercise_4_24.md)

### 4.2 Scheme 的变形——惰性求值	

* P277 - 4.2.1 正则序和应用序
	* P278 - [练习 4.25](./exercise_4_25.md)
	* P278 - [练习 4.26](./exercise_4_26.md)
* P278 - 4.2.2 一个采用惰性求值的解释器
	* P282 - [练习 4.27](./exercise_4_27.md)
	* P282 - [练习 4.28](./exercise_4_28.md)
	* P282 - [练习 4.29](./exercise_4_29.md)
	* P282 - [练习 4.30](./exercise_4_30.md)
	* P283 - [练习 4.31](./exercise_4_31.scm)
* P284 - [4.2.3 将流作为惰性的表](./streams_as_lazy_list.scm)
	* P286 - [练习 4.32](./exercise_4_32.md)
	* P286 - [练习 4.33](./exercise_4_33.md)
	* P286 - [练习 4.34](./exercise_4_34.scm)

### 4.3 Scheme 的变形——非确定计算

* P287 - 4.3.1 [amb 和搜索](./amb_and_search.scm)
	* 注：amb 的意思是 ambiguous
	* P290 - [练习 4.35](./exercise_4_35.scm)
	* P290 - [练习 4.36](./exercise_4_36.md)
	* P290 - [练习 4.37](./exercise_4_37.md)
* P290 - 4.3.2 非确定性程序的实例
	* P290 - [逻辑谜题](./multiple_dwelling.scm)
	* P291 - [练习 4.38](./exercise_4_38.md)
	* P291 - [练习 4.39](./exercise_4_39.md)
	* P291 - [练习 4.40](./exercise_4_40.md)
	* P292 - [练习 4.41](./exercise_4_41.scm)
	* P292 - [练习 4.42](./exercise_4_42.scm)
	* P292 - [练习 4.43](./exercise_4_43.scm)
	* P292 - [练习 4.44, 八皇后问题](./exercise_4_44.scm)
	* P292 - [自然语言的语法分析](./parsing_natural_language.scm)
	* P295 - [练习 4.45](./exercise_4_45.md)
	* P295 - [练习 4.46](./exercise_4_46.md)
	* P295 - [练习 4.47](./exercise_4_47.md)
	* P296 - [练习 4.48](./exercise_4_48.md)
	* P296 - [练习 4.49](./exercise_4_49.md)
* P296 - 4.3.3 实现 amb 求值器
	* [continuation-passing style](./cps.md)
	* P303 - [练习 4.50](./exercise_4_50.md)
	* P303 - [练习 4.51](./exercise_4_51.md)
	* P304 - [练习 4.52](./exercise_4_52.md)
	* P304 - [练习 4.53](./exercise_4_53.md)
	* P304 - [练习 4.54](./exercise_4_54.md)

### 4.4 逻辑程序设计

* P306 - 4.4.1 演绎信息检索
	* P309 - [练习 4.55](./exercise_4_55.md)
	* P311 - [练习 4.56](./exercise_4_56.md)
	* P312 - [练习 4.57](./exercise_4_57.md)
	* P312 - [练习 4.58](./exercise_4_58.md)
	* P312 - [练习 4.59](./exercise_4_59.md)
	* P312 - [练习 4.60](./exercise_4_60.md)
	* P313 - [将逻辑看做程序](./logic_as_programs.scm)
	* P314 - [练习 4.61](./exercise_4_61.scm)
	* P314 - [练习 4.62](./exercise_4_62.scm)
	* P314 - [练习 4.63](./exercise_4_63.scm)
* P315 - 4.4.2 查询系统如何工作
* P321 - 4.4.3 逻辑程序设计是数理逻辑吗
	* P323 - [练习 4.64](./exercise_4_64.md)
	* P323 - [练习 4.65](./exercise_4_65.md)
	* P324 - [练习 4.66](./exercise_4_66.md)
	* P324 - [练习 4.67](./exercise_4_67.md)
	* P324 - [练习 4.68](./exercise_4_68.md)
	* P324 - [练习 4.69](./exercise_4_69.scm)
* P324 - 4.4.4 查询系统的实现
	* P335 - [练习 4.70](./exercise_4_70.md)
	* P338 - [练习 4.71](./exercise_4_71.md)
	* P338 - [练习 4.72](./exercise_4_72.md)
	* P339 - [练习 4.73](./exercise_4_73.md)
	* P339 - [练习 4.74](./exercise_4_74.md)
	* P339 - [练习 4.75](./exercise_4_75.md)
	* P340 - [练习 4.76](./exercise_4_76.md)
	* P340 - [练习 4.77](./exercise_4_77.md)
	* P340 - [练习 4.78, 非确定性写法实现查询](./exercise_4_78.md)
	* P340 - 练习 4.79 Pass















	



