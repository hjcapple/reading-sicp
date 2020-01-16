## P340 - [练习 4.78]

* [完整的代码在这里](./exercise_4_78.scm)

修改了 `query-driver-loop` 循环，支持 `try-again`。也需要修改 `qeval`，在 `analyze` 分派各个语法。

``` Scheme
(define (qeval query frame succeed fail)
  ((analyze query frame) succeed fail))

(define (analyze exp frame)
  (cond ((tagged-list? exp 'and) (conjoin (contents exp) frame))
        ((tagged-list? exp 'lisp-value) (lisp-value (contents exp) frame))
        ((tagged-list? exp 'not) (negate (contents exp) frame))
        ((tagged-list? exp 'or) (disjoin (contents exp) frame))
        ((tagged-list? exp 'always-true) (always-true (contents exp) frame))
        (else (simple-query exp frame))))
```

可以对比一下 `simple-query` 的写法

``` Scheme
;; 原来的写法
(define (simple-query query-pattern frame-stream)
  (stream-flatmap
    (lambda (frame)
      (stream-append-delayed
        (find-assertions query-pattern frame)
        (delay (apply-rules query-pattern frame))))
    frame-stream))
    
;; 非确定性写法
(define (simple-query query-pattern frame)
  (lambda (succeed fail)
    ((find-assertions query-pattern frame)
     succeed
     (lambda ()
       ((apply-rules query-pattern frame) succeed fail)))))
```

用非确定性写法，替代了原来的流式写法。原来的一系列流操作，都可去掉。

### 简单测试

``` Scheme
;;; Query input:
(supervisor ?x (Bitdiddle Ben))

;;; Starting a new query 
;;; Query results:
(supervisor (Tweakit Lem E) (Bitdiddle Ben))

;;; Query input:
try-again

;;; Query results:
(supervisor (Fect Cy D) (Bitdiddle Ben))

;;; Query input:
try-again

;;; Query results:
(supervisor (Hacker Alyssa P) (Bitdiddle Ben))

;;; Query input:
try-again

;;; There are no more values of
(supervisor ?x (Bitdiddle Ben))
```

可知查询 `(supervisor ?x (Bitdiddle Ben))` 总共有三条结果

``` Scheme
(supervisor (Tweakit Lem E) (Bitdiddle Ben))
(supervisor (Fect Cy D) (Bitdiddle Ben))
(supervisor (Hacker Alyssa P) (Bitdiddle Ben))
```

跟原始使用流实现的查询系统，结果保存一致。可运行试验 and、or、lisp-value 等复杂查询。



