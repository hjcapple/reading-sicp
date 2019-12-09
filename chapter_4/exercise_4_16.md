## P270 - [练习 4.16]

将[练习 4.6](./exercise_4_6.md) 的代码合并到 [mceval.scm](./mceval.scm) 中，再进一步修改测试。

### a)

`lookup-variable-value` 中添加一个判断，改动如下：

``` Scheme
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (if (eq? (car vals) '*unassigned*)       ; 修改了这里
                 (error "variable is unassigned" var)
                 (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))
```

### b)

`scan-out-defines` 实现如下，使用了 P78 的 `filter` 函数。

``` Scheme
(define (filter predicate sequence)
  (if (null? sequence)
      '()
      (if (predicate (car sequence))
          (cons (car sequence) (filter predicate (cdr sequence)))
          (filter predicate (cdr sequence)))))

(define (scan-out-defines body)
  (define (body-defines body)
    (filter definition? body))
  (define (name-unassigned defines)
    (map (lambda (exp)
           (list (definition-variable exp) ''*unassigned*))
         defines))
  (define (defines->let-body body)
    (map (lambda (exp)
           (if (definition? exp)
               (list 'set! (definition-variable exp) (definition-value exp))
               exp))
         body))
  (let ((defines (body-defines body)))
    (if (null? defines)
        body
        (list (append (list 'let (name-unassigned defines))
                      (defines->let-body body))))))
```

上面实现中，会保留 define 和 其它表达式的顺序。比如

``` Scheme
(
 (define a 1)
 (+ a b)
 (define b 1)
)
```

转换为

``` Scheme
(
 (let ((a '*unassigned*)
       (b '*unassigned*)) 
   (set! a 1)  ;; 保持顺序
   (+ a b) 
   (set! b 1))
)
```

而不是转换为
 
``` Scheme
(
 (let ((a '*unassigned*)
       (b '*unassigned*)) 
   (set! a 1)  ;; 将转换的 set! 都放到前面了(这样不好)
   (set! b 1) 
   (+ a b))
)
``` 

保留顺序后，执行下面代码，会返回出错信息, 这样更加合理。

``` Scheme
(define (f)
  (define a 1)
  (+ a b)  ;; variable is unassigned b
  (define b 1))
(f)
```

### c)

在 `make-procedure` 中安装 `scan-out-defines`，这样只需要转换一次。假如安装在 `procedure-body` 中，每次获取 body，都需要重复调用 `scan-out-defines`。

`make-procedure` 的实现修改为：
 
``` Scheme
(define (make-procedure parameters body env)
  (list 'procedure parameters (scan-out-defines body) env))
```  
