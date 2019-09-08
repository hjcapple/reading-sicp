## P47 - [练习 1.38]

这题主要是找到 D 的规律，

```
i = 1 2 3 4 5 6 7 8 9 10 11 12 13 14 ....
D = 1 2 1 1 4 1 1 6 1 1  8  1  1  10 ....
```

D 每隔 3 个数字，其中的偶数就会累增。i 和 D 的关系为

``` Scheme
(define (d-fn i)
  (if (= (remainder (+ i 1) 3) 0) ; (i + 1) % 3 == 0
      (/ (* 2 (+ i 1)) 3)         ; 2 * (i + 1) / 3
      1))
```

代码如下

``` Scheme
#lang racket

(define (cont-frac n-fn d-fn k)
  (define (impl i)
    (if (= i k)
        (/ (n-fn i) (d-fn i))
        (/ (n-fn i) (+ (d-fn i) (impl (+ i 1))))))
  (impl 1))

(define (compute-e k)
  (define (n-fn i) 1)
  (define (d-fn i)
    (if (= (remainder (+ i 1) 3) 0)
        (/ (* 2 (+ i 1)) 3)
        1))
  (+ (cont-frac n-fn d-fn k) 2))

;;;;;;;;;;;;;
(exact->inexact (compute-e 100))
```

计算得到 e 的结果为

```
2.718281828459045
```

而 e 的精确结果为

```
2.7182818284590452353602874713526624977572470936999595749669.....
```
