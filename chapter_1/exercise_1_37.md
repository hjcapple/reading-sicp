## P47 - [练习 1.37, 连分数]

将连分数的截断公式记为

<img src="http://latex.codecogs.com/svg.latex?f(i,%20k)%20=%20\frac{N_{i}}{D_{i}+\frac{N_{i+1}}{...+\frac{N_{k}}{D_{k}}}}"/>

于是就有

<img src="http://latex.codecogs.com/svg.latex?\begin{aligned}&f(1,%20k)=\frac{N_{1}}{D_{1}+\frac{N_{2}}{...+\frac{N_{k}}{D_{k}}}}=\frac{N_{1}}{D_{1}+f(2,%20k)}\\&f(2,%20k)=\frac{N_{2}}{D_{2}+\frac{N_{3}}{...+\frac{N_{k}}{D_{k}}}}=\frac{N_{2}}{D_{2}+f(3,%20k)}%20\\&...%20\\&f(k,%20k)=\frac{N_{k}}{D_{k}}\end{aligned}"/>

也就是有递归公式：

<img src="http://latex.codecogs.com/svg.latex?\begin{aligned}&f(i,%20k)=\frac{N_{i}}{D_{i}+f(i%20+%201,%20k)}\\&f(k,%20k)=\frac{N_{k}}{D_{k}}\end{aligned}"/>


要得到迭代版本，可以将顺序反过来。依次计算序列

```
f(k, k) -> f(k - 1, k) -> f(k - 2, k) ... f(1, k)
```

代码如下

``` Scheme
#lang racket

; 递归版本
(define (cont-frac n-fn d-fn k)
  (define (impl i)
    (if (= i k)
        (/ (n-fn i) (d-fn i))
        (/ (n-fn i) (+ (d-fn i) (impl (+ i 1))))))
  (impl 1))

; 迭代版本
(define (cont-frac-2 n-fn d-fn k)
  (define (iter i ret)
    (if (< i 1)
        ret
        (iter (- i 1) 
              (/ (n-fn i) (+ (d-fn i) ret)))))
  (iter (- k 1) (/ (n-fn k) (d-fn k))))

(define (golden-ratio n)
  (define (fn x) 1)
  (cont-frac fn fn n))

(define (golden-ratio-2 n)
  (define (fn x) 1)
  (cont-frac-2 fn fn n))

;;;;;;;;;;;;;;;;;;;;;
(exact->inexact (golden-ratio 10))
(exact->inexact (golden-ratio 11))

(require rackunit)
(check-= (golden-ratio 10) (golden-ratio-2 10) 0.0001)
(check-= (golden-ratio 11) (golden-ratio-2 11) 0.0001)
```

见 [练习 1.13](./exercise_1_13.md)

<img src="http://latex.codecogs.com/svg.latex?\frac{1}{\phi}=\frac{2}{1+\sqrt{5}}=\phi-1"/> 的精确值为

```
0.61803398874989
```

而

```
(golden-ratio 10) = 0.6179775280898876
(golden-ratio 11) = 0.6180555555555556
```

只要 k = 11, 计算结果的前面 4 个小数位就完全相同。

