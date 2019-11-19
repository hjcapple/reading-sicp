## P260 - [练习 4.9]

### do 的语法定义

我们采用 Scheme 的 R5RS 标准，do 的语法定义为：

``` Scheme
(do ((<var1> <init1> <step1>)
     (<var2> <init2> <step2>)
     ...)
  (<test1> <exp1> <test2> <exp2> ...)
  <command> ...)
``` 

转为派生表达式等价于

``` Scheme
((lambda ()
   (define (do-iter <var1> <var2> ... <varN>)
     (cond (<test1> <exp1>)
           (<test2> <exp2>)
           ...
           (else
             <command> ...
             (do-iter <step1> <step2> ... <stepN>))))
   (do-iter <init1> <init2> ... <initN>)))
```

比如下面代码：

``` Scheme
(do ((i 0 (+ i 1)))
  ((> i 5) 'done)
  (display i)
  (newline))

(let ((x '(1 3 5 7 9)))
  (do ((x x (cdr x))
       (sum 0 (+ sum (car x))))
    ((null? x) sum))) 
```

等价于

``` Scheme
((lambda ()
   (define (do-iter i)
     (cond ((> i 5) 'done)
           (else
             (display i)
             (newline)
             (do-iter (+ i 1)))))
   (do-iter 0)))

(let ((x '(1 3 5 7 9)))
  ((lambda ()
     (define (do-iter x sum)
       (cond ((null? x) sum)
             (else
               (do-iter (cdr x) (+ sum (car x))))))
     (do-iter x 0))))
```

注意这里，将 `do-iter` 包在 `lambda` 里面, 防止重名。

### 实现

在 [mceval.scm](./mceval.scm) 的基础上修改测试。`eval` 添加判断

``` Scheme
((do? exp) (eval (do->combination exp) env))
```

实现代码
 
``` Scheme
(define (do? exp) (tagged-list? exp 'do))

(define (do->combination exp)
  (define (do-vars exp) (map car (cadr exp)))
  (define (do-inits exp) (map cadr (cadr exp)))
  (define (do-steps exp) (map caddr (cadr exp)))
  (define (do-command exp) (cdddr exp))
  (define (do-test-exps exp) 
    (define (loop lst)
      (if (null? lst)
          '()
          (cons (list (car lst) (cadr lst)) (loop (cddr lst)))))
    (loop (caddr exp)))
  
  (define (make-iter-else exp)
    (append (cons 'else (do-command exp))
            (list (cons 'do-iter (do-steps exp)))))
  (define (make-iter-cond exp)
    (append (cons 'cond (do-test-exps exp)) 
            (list (make-iter-else exp))))
  (define (make-do-iter exp)
    (list 'define (cons 'do-iter (do-vars exp))
          (make-iter-cond exp)))
  (define (make-let-iter-call exp)
    (list (make-do-iter exp)
          (cons 'do-iter (do-inits exp))))
  (cons (make-lambda '()
                     (make-let-iter-call exp))
        '()))
```        

