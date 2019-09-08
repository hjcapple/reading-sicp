## P48 - [练习 1.39]

正切的连分数里面是减号

<img src="http://latex.codecogs.com/svg.latex?tan(x)=\frac{x}{1-\frac{x^{2}}{3-\frac{x^{2}}{5-...}}}"/>

而 [练习 1.37](exercise_1_37.md) 连分数中是加号，似乎有点不同。

<img src="http://latex.codecogs.com/svg.latex?f(x)=\frac{N_{1}}{D_{1}+\frac{N_{2}}{D_{2}+\frac{N_{3}}{D_{3}+...}}}"/>

最简单的方式是将 练习 1.37 的 `cont_frac` 复制一次，将加号改成减号。但实际项目中，不建议复制粘贴代码。

可以将 tan(x) 的连分数中，改写成如下形式。就可以复用 `cont_frac`。

<img src="http://latex.codecogs.com/svg.latex?tan(x)=\frac{x}{1+\frac{-x^{2}}{3+\frac{-x^{2}}{5+...}}}"/>

-----

代码如下：

``` Scheme
#lang racket

(define (cont-frac n-fn d-fn k)
  (define (impl i)
    (if (= i k)
        (/ (n-fn i) (d-fn i))
        (/ (n-fn i) (+ (d-fn i) (impl (+ i 1))))))
  (impl 1))

(define (tran-cf x k)
  (define (n-fn i)
    (if (= i 1)
        x
        (- (* x x))))
  (define (d-fn i)
    (- (* 2 i) 1))
  (cont-frac n-fn d-fn k))

;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (define (for-loop n last op)
    (cond ((<= n last)
           (op n)
           (for-loop (+ n 1) last op))))
  
  (define (test-n n)
    (let ((x (/ n (* 2 3.1415926))))
      (check-= (tran-cf x 100) (tan x) 0.0001)))
  
  (for-loop 0 360 test-n)
)

```

