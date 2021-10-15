## P49 - [牛顿法]

### 牛顿法原理

求方程 g(x) = 0 的解。一种方法是 P44 页描述的[区间折半方法](./half_interval_method.scm)，也可称为二分法。另一种方法就是牛顿法，也可称为切线法。

牛顿法的基本原理如下。假设 x0 是方程的 `g(x) = 0` 一个猜测。那么对应在 g(x) 上的点 A 为 (x0, g(x0))，过 A 点作 g(x) 的切线。这条切线跟 x 轴的交点为 (x1, 0)。这个 x1 是 `g(x) = 0` 的更接近的猜测。

根据导数的几何定义，g(x) 的导数就是切线。于是过 A 点，g(x) 的切线为 g'(x0)。于是切线方程为

```
y - g(x0) = g'(x0)(x - x0)
```

跟 x 轴交点，y = 0，将 (x1, 0) 代入上面方程。于是就得到更好的猜测

```
x1 = x0 - g(x0) / g'(x0)
```

如此类推

```
x1 = x0 - g(x0) / g'(x0)
x2 = x1 - g(x1) / g'(x1)
x3 = x3 - g(x2) / g'(x2)
.....
```
直到解相当接近。根据不动点的定义，g(x) = 0 的解，就是

```
f(x) = x - g(x) / g'(x) 
```

的不动点。书中，只是使用 Dg(x) 来表示导数运算，相当于上述推到的 g'(x)。

### sqrt

第一章书中，出现几种求平方根 sqrt 的方法，其实速途同归。P14 页 [采用牛顿法求平方根](./newton_sqrt.scm), 这种不断猜测，直到足够接近，就是不动点的思想，只是当时还没有明确提到这个概念。

而 P15 页提到，假如有猜测值 y，那么 y 和 x / y 的平均值，就是更好的猜测。这实际就是 `y -> x / y` 的平均阻尼。

而平方根的定义为 `y = sqrt(x)` 于是 

```
=> y ^ 2 = x
=> y ^ 2 - x = 0
```

于是就相当于求 `f(y) = y ^ 2 - x = 0` 的解。根据上述的牛顿法，相当于下面方程的不动点

```
f(y) = y - f(y)/f'(y) = y - (y ^ 2 - x) / (2 * y) = (y + x/y) / 2
```

因此。P14 页，求 sqrt 的方法，只是牛顿法的一个具体应用。

### 代码

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


(define (deriv g)
  (let ((dx 0.00001))
    (lambda (x)
      (/ (- (g (+ x dx)) (g x))
         dx))))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (sqrt x)
  (newtons-method (lambda (y) (- (square y) x))
                  1.0))

(define (square x) (* x x))
(define (cube x) (* x x x))

;;;;;;;;;;;;;;;;;;;;;;;;;;
((deriv cube) 5)  ; 75.00014999664018

(module* test #f
  (require rackunit)
  (define (for-loop n last op)
    (cond ((<= n last)
           (op n)
           (for-loop (+ n 1) last op))))
  
  (define (check-n n)
    (check-= (sqrt n) (expt n (/ 1 2)) 0.0001))
    
  (for-loop 0 100 check-n)
)
```
