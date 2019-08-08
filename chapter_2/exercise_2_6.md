## P62 - [练习 2.6, Church 计数]

### one、two

``` Scheme
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
```

one 可以写成 `(add-1 zero)`，将其展开

``` Scheme
(add-1 zero)
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) x) x))))
(lambda (f) (lambda (x) (f x)))
```

two 可以写成 `(add-1 one)`, 将其展开为

``` Scheme
(add-1 one)
(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))
(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))
(lambda (f) (lambda (x) (f (f x))))
```

因此可以将 one 和 two 定义为：

``` Scheme
(define zero (lambda (f) (lambda (x) x)))
(define one  (lambda (f) (lambda (x) (f x))))
(define two  (lambda (f) (lambda (x) (f (f x)))))
```

我们可以合理猜测，所谓的 Church 数，就是对 x 应用 f 的次数。zero 将 f 应用 0 次。one 是将 f 应用 1 次。two 是将 f 应用 2 次。以此类推。为了验证这个猜测，我们可以试试手动展开 `(add-1 two)`，可以发现的确如此。

假如将 f 定义为 inc, x 为 0。那么有下面结果

``` Scheme
(define (inc x) (+ x 1))
((zero inc) 0)  ;; 对 0 应用 0 次 inc，结果为 0
((one inc) 0)   ;; 对 0 应用 1 次 inc，结果为 1
((two inc) 0)   ;; 对 0 应用 2 次 inc，结果为 2
``` 

### 加法

现在来定义 Church 数的加法。假如已经有了这个 add-church 函数，那么 `(add-church one two)` 应该就是将 f 应用 3 次。结果为

``` Scheme
(lambda (f) (lambda (x) (f (f (f x)))))
```

这个加法应该类似这样子

``` Scheme
(define (add-church a b)
  (lambda (f) 
    (lambda (x) 
      ....)))
```

但是我们还不知道具体内容，先来猜测一下。上面例子中，提到假设 f 为 inc, x 为 0，会有这样的形式。

``` Scheme
((two inc) 0)
```

我们猜测 add-church 内部，会有类似这样的形式。

``` Scheme
((a f) x)
```

根据 Church 的定义，上面计算展开就为

``` Scheme
(fa (fa (fa ... (fa x))))	;; 有 a 个 fa, fa 其实就是 f
```

同理，`((b f) x)` 展开，就为

``` Scheme
(fb (fb (fb ... (fb x))))	;; 有 b 个 fb，fb 其实就是 f
```

因此，将 `((a f) ((b f) x))` 的展开，就为

``` Scheme
(fa (fa (fa ... (fa ((b f) x)))))                  ;; 有 a 个 fa，((b f) x) 还没有展开
(fa (fa (fa ... (fa (fb (fb (fb ... (fb x))))))))  ;; 有 a + b 个 f
```

于是将上面的半猜测半分析结合起来，就得到 add 的定义

``` Scheme
(define (add-church a b) 
 (lambda (f) 
   (lambda (x) 
     ((a f) ((b f) x)))))
```

验证

``` Scheme
(((add-church one two) inc) 0) ;; 输出 3
```

### 代码

将上面的所有代码结合起来，有完整的 Church 数代码

``` Scheme
#lang racket

(define (make-church n)
  (define zero 
    (lambda (f) (lambda (x) x)))

  (define (add-1 a)
    (lambda (f) (lambda (x) (f ((a f) x)))))

  (if (= n 0) 
    zero
    (add-1 (make-church (- n 1)))))

(define (add-church a b) 
 (lambda (f) 
   (lambda (x) 
     ((a f) ((b f) x)))))

(define (int-from-church n)
  (define (inc x) (+ x 1))
  ((n inc) 0))

;;;;;;;;;;;;;;;;;;;;
(define a (make-church 10))
(define b (make-church 20))
(define c (add-church a b))

(int-from-church a)
(int-from-church b)
(int-from-church c)
```
