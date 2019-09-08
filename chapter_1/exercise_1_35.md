## P47 - [练习 1.35]

黄金分割率 φ 的值为

<img src="http://latex.codecogs.com/svg.latex?\phi=\frac{1+\sqrt{5}}{2}"/>

满足方程：

<img src="http://latex.codecogs.com/svg.latex?\phi^{2}=\phi+1"/>

变换之后，为

<img src="http://latex.codecogs.com/svg.latex?\phi=1+\frac{1}{\phi}"/>

根据不动点的定义, φ 就为方程 `f(x) = 1 + 1/x` 的不动点。

------

``` Scheme
#lang racket

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (let ((tolerance 0.00001))
      (< (abs (- v1 v2)) tolerance)))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;;;;;;;;;;;;;;;;;;;;
(fixed-point (lambda (x) (+ 1 (/ 1 x)))
             1.0)
```

计算得到结果

```
1.6180327868852458
```
