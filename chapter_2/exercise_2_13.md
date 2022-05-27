## P64 - [练习 2.13]

假设区间 A、B 所有数字都为正，他们可以表示为

$$\begin{aligned}&a \pm w_{a} \\
& b \pm w_{b}\end{aligned}$$

其中 A, B 的误差为

$$\begin{aligned}& P_{ a}=\frac{w_{a}}{a} \\
& P_{b}=\frac{w_{b}}{b} \\
\end{aligned}$$

注意上面算误差，没有乘以 100 变成百分比，这样容易算一些。A B 两区间相乘得到

$$\begin{aligned}C=AB&=[(a-w_{a})(b-w_{b}), (a+w_{a})(b+w_{b})] \\
&= [(ab+w_{a}w_{b})-(aw_{b}+bw_{a}),(ab+w_{a}w_{b})+(aw_{b}+bw_{a})]\end{aligned}$$

因而区间 A、B 相乘的结果 C，可以表示为

$$(ab+w_{a}w_{b})\pm(aw_{b}+bw_{a})$$

于是它的比率为

$$P_{c}=\frac{aw_{b}+bw_{a}}{ab+w_{a}w_{b}}$$

上面式子分子分母同时除 $w_{a}w_{b}$, 得到

$$P_{c}=\frac{aw_{b}+bw_{a}}{ab+w_{a}w_{b}}=\frac{\frac{a}{w_{a}}+\frac{b}{w_{b}}}{\frac{ab}{w_{a}w_{b}}+1}=\frac{P_{a}+P_{b}}{P_{a}P_{b}+1}$$

最终得到结论，假如区间 A、B 的误差为 Pa, Pb，他们相乘的误差为

$$P = \frac{P_{a}+P_{b}}{P_{a}P_{b}+1}$$
