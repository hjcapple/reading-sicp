## P429 - [练习 5.48]

* [完整代码在这里](./exercise_5_48.scm)

### 代码

在原始 [编译器-求值器](./ch5-eceval-compiler.scm) 基础上，添加过程

``` Scheme
(define (compile-scheme expression)
  (assemble (statements
              (compile expression 'val 'return))
            eceval))

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (compile-and-run? exp)
  (tagged-list? exp 'compile-and-run))

(define (compile-and-run-exp exp)
  (cadadr exp))

...

(define eceval-operations
  (list
    (list 'compile-and-run? compile-and-run?)
    (list 'compile-scheme compile-scheme)
    (list 'compile-and-run-exp compile-and-run-exp)
    ...))
```

再在求值器中添加指令

``` Scheme
eval-dispatch
  ...
  (test (op compile-and-run?) (reg exp))
  (branch (label ev-compile-and-run))
  ...
ev-compile-and-run
  (assign val (op compile-and-run-exp) (reg exp))  
  (assign val (op compile-scheme) (reg val))
  (goto (label external-entry))
```  

### 测试

``` Scheme
;;; EC-Eval input:
(compile-and-run 
  '(define (factorial n) 
     (if (= n 1) 
         1 
         (* (factorial (- n 1)) n)))) 

(total-pushes = 0 maximum-depth = 0)
;;; EC-Eval value:
ok

;;; EC-Eval input:
(factorial 5)

(total-pushes = 31 maximum-depth = 14)
;;; EC-Eval value:
120
```
 
