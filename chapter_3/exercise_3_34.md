## P205 - [练习 3.34]

如下的[测试代码](./exercise_3_34.scm):

``` Scheme
#lang racket

(#%require "constraints.scm")

(define (squarer a b)
  (multiplier a a b))

;;;;;;;;;;;;;;;;;;;;;;;
(define a (make-connector))
(define b (make-connector))

(probe "a" a)
(probe "b" b)

(squarer a b)

(set-value! a 20 'user)
(forget-value! a 'user)

(set-value! b 400 'user)
```

其输出为

```
Probe: b = 400
Probe: a = 20
'done
Probe: b = ?
Probe: a = ?
'done
Probe: b = 400
```

可见 Louis 这样定义平方，当设置 a 时，可以推导出 b 值。但逆过来，当设置 b 时，却不能推导出 a 值。

### 原因

原因可参见 `multiplier` 的定义

``` Scheme
(define (multiplier m1 m2 product)
  (define (process-new-value)
    (cond ((or (and (has-value? m1) (= (get-value m1) 0))
               (and (has-value? m2) (= (get-value m2) 0)))
           (set-value! product 0 me))
          ((and (has-value? m1) (has-value? m2))
           (set-value! product
                       (* (get-value m1) (get-value m2))
                       me))
          ((and (has-value? product) (has-value? m1))
           (set-value! m2
                       (/ (get-value product) (get-value m1))
                       me))
          ((and (has-value? product) (has-value? m2))
           (set-value! m1
                       (/ (get-value product) (get-value m2))
                       me))))
  xxx)
```

Louis 的 `squarer` 定义中。m1、m2 参数相同，都为 a。

于是当设置 a 后，m1、m2 都有值，就可以推导出 product(也就是 b 值）。

但当设置了 b 值后，product 有值。m1、m2 都还没有值，

```
(has-value? product) = true
(has-value? m1) = false
(has-value? m2) = false
```

不满足 `cond` 中的任何条件。因而也就不能推导出 m1、m2 的值，也就是 a 值。尽管 m1、m2 相同，但 multiplier 却不知道。

