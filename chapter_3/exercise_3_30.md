## P192 - [练习 3.30]

[完整测试代码](./exercise_3_30.scm)

### 代码

``` Scheme
(define (ripple-carry-adder A B S c-out)
  (define (helper A B S c-in c-out)
    (if (null? (cdr A))
        (full-adder (car A) (car B) c-in (car S) c-out)
        (let ((wire (make-wire)))
          (helper (cdr A) (cdr B) (cdr S) c-in wire)
          (full-adder (car A) (car B) wire (car S) c-out))))
  
  (let ((c-in (make-wire)))
    (set-signal! c-in 0)
    (helper A B S c-in c-out)
    'ok))
```

### 延迟分析

级联进位加法器电路图中，信号 A、B 直接从外部设置，本身没有延迟。n 位加法器，由 n 个全加器串联而成，一个全加器的 c-in 是另一个全加器的 c-out。延迟主要由 c 引起。

要分析级联进位加法器的延迟，首先要分析全加器的延迟。而全加器又由半加器组合而成，又要分析半加器的延迟。

### 半加器

<img src="./half-adder.svg"/>

上图是半加器的连接图，A、B 信号到 S 信号经过 or-gate、and-gate，也可以经过 and-gate、inverter、or-gate。两者的延迟分别为

``` CS
delay-1 = or-gate-delay + and-gate-delay
delay-2 = and-gate-delay + inverter-delay + and-gate-delay
```

因此 S 的最大延迟为

``` C
half-adder-delay-S = max(or-gate-delay, and-gate-delay + inverter-delay) 
                    + and-gate-delay
```
信号到达 C，只经过 and-gate，因此 C 的延迟为

```
half-adder-delay-C = and-gate-delay
```

### 全加器

<img src="./full-adder.svg"/>

为了分析 C-out 的最大延迟，我们寻找产生最大延迟的连接路径。最大延迟路径为，经过一个半加器，从半加器的 S 出，再经过一个半加器，从半加器 C 出，再经过一个 or-gate。

于是全加器 C-out 的延迟为

```
full-adder-delay-C = half-adder-delay-S + half-adder-delay-C + or-gate-delay
                   = max(or-gate-delay, and-gate-delay + inverter-delay) 
                     + 2 * and-gate-delay + or-gate-delay
```

同理全加器的 Sum 延迟为

```
full-adder-delay-Sum = half-adder-delay-S + half-adder-delay-S
                     = 2 * max(or-gate-delay, and-gate-delay + inverter-delay) 
                       + 2 * and-gate-delay
```

显然 

```
full-adder-delay-C < full-adder-delay-Sum < 2 * full-adder-delay-C
```

### 级联进位加法器

n 位的加法器由 n 个全加器的 c 串联而成。前 n - 1 个全加器的 C 串联延迟为 

```
(n - 1) * full-adder-delay-C
```

最后一个全加器，Sum 出口也依赖于前面的 C 进位，并且 Sum 的延迟更大。

因此整个进位加法器的最大延迟为

```
delay = (n - 1) * full-adder-delay-C + full-adder-delay-Sum
      = (n + 1) * max(or-gate-delay, and-gate-delay + inverter-delay) 
        + 2 * n * and-gate-delay + (n - 1) * or-gate-delay  
```

### 验证

[digital_circuit.scm](./digital_circuit.scm) 模拟程序定义了各门的延迟值。

``` Scheme
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)
```

按照上面分析，4 位加法器的最大延迟应该为

``` C
(n + 1) * 5 + 2 * n * 3 + (n - 1) * 5 = 64
```

在[测试代码](./exercise_3_30.scm)中，将 (A B) 先设置为 `((1 1 1 1) (0 0 0 0))`, 再设置为 `((1 1 1 1) (0 0 0 1))`, 强迫最高位和 c-out 改变。

``` Scheme
(run-simulate '(
                ((1 1 1 1) (0 0 0 0))
                ((1 1 1 1) (0 0 0 1))
                ((1 1 1 1) (0 0 0 0))
                ))
```    

打印输出为

```
==========
time: 8
a: (1 1 1 1)
b: (0 0 0 0)
s: (1 1 1 1)
c-out: 0
==========
time: 72
a: (1 1 1 1)
b: (0 0 0 1)
s: (0 0 0 0)
c-out: 1
==========
time: 136
a: (1 1 1 1)
b: (0 0 0 0)
s: (1 1 1 1)
c-out: 0
```

两个时间点，72 - 8 = 136 - 72 = 64。4 位加法器的延迟得到验证。    

同理可以验证 8 位加法器的延迟为

``` C
(n + 1) * 5 + 2 * n * 3 + (n - 1) * 5 = 128
```



