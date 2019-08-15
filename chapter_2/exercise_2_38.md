## P82 - [练习 2.38]

``` Scheme
#lang racket

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

;;;;;;;;;;;;;
(fold-right / 1 (list 1 2 3))
(fold-left / 1 (list 1 2 3))
(fold-right list null (list 1 2 3))
(fold-left list null (list 1 2 3))
(fold-right cons null (list 1 2 3))
(fold-left cons null (list 1 2 3))
(fold-left (lambda (x y) (cons y x)) null (list 1 2 3))
```

要使得 op 保证 fold-right 和 fold-left 对任何序列都产生同样的效果，op 必须具有交换律。也就是 (op x y) 恒等于 (op y x)。

比如加法(+)或者乘法(*)，and 或者 or，都满足交换律。fold-right 和 fold-left 的求值结果就会相同。


