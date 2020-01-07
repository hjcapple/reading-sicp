## P303 - [练习 4.51]

### a)

在 [ambeval.scm](./ambeval.scm) 的基础上修改测试。`analyze` 添加判断

``` Scheme
((permanent-assignment? exp) (analyze-permanent-assignment exp))
```

`permanent-set!` 实现如下：

``` Scheme
(define (permanent-assignment? exp) (tagged-list? exp 'permanent-set!))
(define (analyze-permanent-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)
               (set-variable-value! var val env)
               (succeed 'ok fail2))
             fail))))
```

### b)

假如代码使用 `set!`，而不是 `permanent-set!`，结果如下

``` Scheme
(define count 0)
(let ((x (an-element-of '(a b c)))
      (y (an-element-of '(a b c))))
  (set! count (+ count 1))
  (require (not (eq? x y)))
  (list x y count))
;;; Starting a new problem
;;; Amb-Eval value:
(a b 1)
;;; Amb-Eval input:
try-again
;;; Amb-Eval value:
(a c 1)
;;; Amb-Eval input:
try-again
;;; Amb-Eval value:
(b a 1)
```

无论 try-again 多少次。输出的 count 都为 1。

