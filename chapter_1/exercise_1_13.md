## P27 - [练习 1.13]

Fib 的定义如下：

```
Fib(0) = 0
Fib(1) = 1
Fib(n) = Fib(n - 1) + Fib(n - 2) 当 n >= 2 时
```

我们设

$$\phi=\frac{1+\sqrt{5}}{2}$$

$$\gamma=\frac{1-\sqrt{5}}{2}$$

先来证明 $Fib(n)=\frac{\phi^{n}-\gamma^{n}}{\sqrt{5}}$

--------

$$\frac{\phi^{0}-\gamma^{0}}{\sqrt{5}}=0=Fib(0)$$

$$\frac{\phi^{1}-\gamma^{1}}{\sqrt{5}}=\frac{\frac{1+\sqrt{5}}{2}-\frac{1-\sqrt{5}}{2}}{\sqrt{5}}=1=Fib(1)$$

可知基础情况成立。而假设 $Fib(n)=\frac{\phi^{n}-\gamma^{n}}{\sqrt{5}}$ 成立，有

$$\begin{align}Fib(n)=Fib(n-1)+Fib(n-2)=\frac{\phi^{n-1}-\gamma^{n-1}}{\sqrt{5}}+\frac{\phi^{n-2}-\gamma^{n-2}}{\sqrt{5}}=\frac{\phi^{n-1}(1+\frac{1}{\phi})-\gamma^{n-1}(1+\frac{1}{\gamma})}{\sqrt{5}}\notag\end{align}$$

而

$$\begin{align}1+\frac{1}{\phi}=1+\frac{2}{1+\sqrt{5}}=\frac{1+\sqrt{5}+2}{1+\sqrt{5}}=\frac{(3+\sqrt{5})(1-\sqrt{5})}{(1+\sqrt{5})(1-\sqrt{5})}=\frac{3+\sqrt{5} - 3\sqrt{5}-5}{1-5}=\frac{1+\sqrt{5}}{2}=\phi\notag\end{align}$$

$$\begin{align}1+\frac{1}{\gamma}=1+\frac{2}{1-\sqrt{5}}=\frac{1-\sqrt{5}+2}{1-\sqrt{5}}=\frac{(3-\sqrt{5})(1+\sqrt{5})}{(1-\sqrt{5})(1+\sqrt{5})}=\frac{3-\sqrt{5}+3\sqrt{5}-5}{1-5}=\frac{1-\sqrt{5}}{2}=\gamma\notag\end{align}$$

于是

$$Fib(n)=\frac{\phi^{n-1}(1+\frac{1}{\phi})-\gamma^{n-1}(1+\frac{1}{\gamma})}{\sqrt{5}}=\frac{\phi^{n-1}\phi-\gamma^{n-1}\gamma}{\sqrt{5}}=\frac{\phi^{n}-\gamma^{n}}{\sqrt{5}}$$

可知递归情况也成立。原命题得证。

-----------

`sqrt(5) > 2` 容易知道 γ 的绝对值

$$|\gamma|=|\frac{1-\sqrt{5}}{2}|<1$$

因此

$$|\gamma^{n}|<1$$

$$\frac{\gamma^{n}}{\sqrt{5}}|<0.5$$

而因为

$$Fib(n)=\frac{\phi^{n}-\gamma^{n}}{\sqrt{5}}$$

于是有

$$|Fib(n)-\frac{\phi^{n}}{\sqrt{5}}|=|\frac{\gamma^{n}}{\sqrt{5}}|<0.5$$

换句话说，`Fib(n)` 是最接近 $\frac{\phi^{n}}{\sqrt{5}}$ 整数。





