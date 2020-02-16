## P396 - [练习 5.30]

* [完整代码在这里](./exercise_5_30.scm)

### a)

``` Scheme
(define (error-code info) (cons '*error-code* info))
(define (error-code? obj) (and (pair? obj) (eq? (car obj) '*error-code*)))
(define (error-code-info obj) (cdr obj))

(define (lookup-variable-value-e var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error-code (list "Unbound variable" var))
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))
  
...

(define eceval-operations
  (list
    ...
    (list 'error-code? error-code?)
    (list 'error-code-info error-code-info)
    (list 'lookup-variable-value-e lookup-variable-value-e)
    ))  
```

模拟器指令修改如下

``` Scheme
error-happen
  (assign val (op error-code-info) (reg val))
  (goto (label signal-error))  

signal-error
  (perform (op user-print) (reg val))
  (goto (label read-eval-print-loop))
  
...

ev-variable
  (assign val (op lookup-variable-value-e) (reg exp) (reg env))
  (test (op error-code?) (reg val))
  (branch (label error-happen))
  (goto (reg continue)) 
```

### b)

为 `car`, `cdr`, `/` 这个三个基本过程添加错误处理

``` Scheme
(define (car-e pair)
  (if (pair? pair)
      (car pair)
      (error-code "expected pair? -- CAR")))

(define (cdr-e pair)
  (if (pair? pair)
      (car pair)
      (error-code "expected pair? -- CDR")))

(define (div-e a b)
  (if (zero? b)
      (error-code "zero division error")
      (/ a b)))

...
      
(define primitive-procedures
  (list (list 'car car-e)
        (list 'cdr cdr-e)
        (list '/ div-e)
        ...
        ))
```

模拟器指令修改如下

``` Scheme
primitive-apply
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (test (op error-code?) (reg val))
  (branch (label error-happen))
  (restore continue)
  (goto (reg continue))
```

### 测试

``` Scheme
;;; EC-Eval input:
a
(Unbound variable a)

;;; EC-Eval input:
(car 1)
expected pair? -- CAR

;;; EC-Eval input:
(cdr 1)
expected pair? -- CDR

;;; EC-Eval input:
(/ 10 0)
zero division error

;;; EC-Eval input:
(car (cons 1 2))

(total-pushes = 13 maximum-depth = 8)
;;; EC-Eval value:
1
```
              
