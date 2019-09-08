## P34 - [费马检查]

### 同余运算

以数学符号来描述，假如 <img src="http://latex.codecogs.com/svg.latex?a\bmod%20n%20==%20b\bmod%20n"/>，两者同余，记为 

<img src="http://latex.codecogs.com/svg.latex?a\equiv%20b\mod%20n"/>

同余符号是三个横线的等号。另外数学符号 `a mod n` 是一个整体，表示 a 对 n 求模（取余数），没有像函数调用那样记成 `mod(a, n)`。

同余有些很好的性质。有加法原理和乘法原理。

<img src="http://latex.codecogs.com/svg.latex?(a+b)\bmod%20n%20=%20[(a\bmod%20n)+(b\bmod%20n)]\bmod%20n"/>

<img src="http://latex.codecogs.com/svg.latex?ab\bmod%20n%20=%20[(a\bmod%20n)(b\bmod%20n)]\bmod%20n"/>

mod 运算，可看成是时钟转圈，超出一圈又会绕到原来的地方。

在同余的公式中，经常会出现 mod 运算，似乎很复杂。但只要将 a 看成是跟 `a mod n` 等价，公式就会很自然了。

出现 mod 都是为了让 a 转几圈之后，重新落入到 [0, n) 的区间之下。这样参与运算的数字会在 [0, n) 中，结果也会封闭在 [0, n) 中，永远不会超出这个范围。

比如乘法性质，先将 a 看成等价的 `a mod n`, b 看成等价的 `b mod n`，之后再相乘，乘出来的结果再算 mod, 重新落入 [0, n) 区间中。

只要将 a 看成是跟 `a mod n` 等价，同余的很多运算性质几乎就跟普通整数运算一样。

### 快速幂取模

代码 `expmod` 计算幂取模运算，其实应用了同余的乘法原理。

当 b 为奇数时

<img src="http://latex.codecogs.com/svg.latex?a^b\bmod%20n%20=%20aa^{b-1}\bmod%20n=%20[(a\bmod%20n)(a^{b-1}\bmod%20n)]\bmod%20n"/>

当 b 为偶数时

<img src="http://latex.codecogs.com/svg.latex?a^b\bmod%20n%20=%20a^{b/2}a^{b/2}\bmod%20n=%20(a^{b/2}\bmod%20n)^{2}\bmod%20n"/>

### 费马小定理

费马小定理说，当 n 为素数，a < n 时，那么有

<img src="http://latex.codecogs.com/svg.latex?a^{n}\equiv%20a\mod%20n"/>

我们通常会变换一下公式

<img src="http://latex.codecogs.com/svg.latex?a^{n-1}\equiv%201\mod%20n"/>

---

要证明费马小定理，先要证明一个结论。假如 n 是一个素数，a < n, 这样排列 1、2、3、4、5 .. n - 1, 乘以 a, 再取 n 的余数，结果也是 1 到 n - 1 的排列，但是顺序会打乱。

举个例子 n = 5, a = 3。

* 1、2、3、4	(原始排列)
* 3、6、9、12 (原始排列乘以 a = 3)
* 3、1、4、2 (取 5 的余数）

可以看到，余数仍然是 1 到 4 之间，没有重复，只是顺序打乱了。

反证法。假如结论不成立的话，就会有 i, j 两个数字，使得

<img src="http://latex.codecogs.com/svg.latex?i%20*%20a%20\equiv%20j%20*%20a\mod%20n"/>

不妨假设 i > j，将上式移动一下位置，就会有

<img src="http://latex.codecogs.com/svg.latex?(i%20-%20j)%20*%20a%20\equiv%200\mod%20n"/>

换句话说，就是 (i - j) * a 可以整除 n。而 n 是素数，那么 (i - j) 或者 a 其中之一就必须包含因子 n。但 (i - j) 和 a 都比 n 要小，显然不可能包含因子 n。于是结论得证。

---

因为乘以 a 再 mod n，只是 1 到 n - 1 的重新排列，数字并不会重复。于是我们就可以知道

<img src="http://latex.codecogs.com/svg.latex?(1%20*%202%20*%203%20....%20n%20-%201)%20=%20(a\bmod%20n)(2a\bmod%20n)(3a\bmod%20n)%20...%20((n-1)a\bmod%20n)"/>

应用同余的乘法原理，使用同余的记号，可以将上式记为

<img src="http://latex.codecogs.com/svg.latex?(1%20*%202%20*%203%20....%20n%20-%201)%20\equiv%20a%20*%202a%20*%203a%20*%20...%20(n-1)a\mod%20n"/>

将上式同时除以 <img src="http://latex.codecogs.com/svg.latex?(1 * 2 * 3 .... n - 1)"/>，费马小定理得证

<img src="http://latex.codecogs.com/svg.latex?a^{n-1}\equiv%201\mod%20n"/>

### 代码

``` Scheme
#lang racket

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))  

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (for-each (lambda (num)
             (check-true (fast-prime? num 100)))
           '(2 3 5 7 11 13 17 19 23))
  (for-each (lambda (num)
             (check-false (fast-prime? num 100)))
           '(36 25 9 16 4))
)
```
