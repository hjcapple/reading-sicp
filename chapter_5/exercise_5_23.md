## P392 - [练习 5.23]

* [完整代码在这里](./exercise_5_23.scm)

我们实现 cond 和 let、let* 语法。其中 

* [练习 4.6](../chapter_4/exercise_4_6.md) 已实现了 `let->combination`。
* [练习 4.7](../chapter_4/exercise_4_7.md) 已实现了 `let*->nested-lets`。

这些可以作为求值器的基础过程。在 [ch5-eceval.scm](./ch5-eceval.scm) 的基础上修改。注册基础过程

``` Scheme
(list 'cond? cond?)
(list 'cond->if cond->if)
(list 'let? let?)
(list 'let->combination let->combination)
(list 'let*? let*?)
(list 'let*->nested-lets let*->nested-lets)
```    

机器指令中 `eval-dispatch` 标签添加

``` Scheme
eval-dispatch
  ...
  (test (op cond?) (reg exp))
  (branch (label ev-cond))
  (test (op let?) (reg exp))
  (branch (label ev-let))
  (test (op let*?) (reg exp))
  (branch (label ev-let*))
  (test (op lambda?) (reg exp))
  ...
ev-cond
  (assign exp (op cond->if) (reg exp))
  (goto (label eval-dispatch))
ev-let 
  (assign exp (op let->combination) (reg exp))
  (goto (label eval-dispatch))
ev-let*
  (assign exp (op let*->nested-lets) (reg exp))
  (goto (label eval-dispatch))  
```


### 测试代码

``` Scheme
;; cond
(define x 0)
(cond ((> x 0) x)
      ((= x 0) (display 'zero) 0)
      (else (- x)))

;; let
(define (f a) a)
(let ((a (f 'Hello))
      (b (f 'World)))
  (display a)
  (display b))

;; let*  
(let* ((x 3)
       (y (+ x 2))
       (z (+ x y 5)))
  (* x z))
```
