## P339 - [练习 4.75]

在 [queryeval.scm](./queryeval.scm) 的基础上修改测试。

### a)

``` Scheme
(define (uniquely-asserted operands frame-stream)
  (define (stream-unique? s)
    (and (not (stream-null? s))
         (stream-null? (stream-cdr s))))
  
  (stream-flatmap
    (lambda (frame)
      (let ((s (qeval (car operands) (singleton-stream frame))))
        (if (stream-unique? s)
            s
            the-empty-stream)))
    frame-stream))
``` 

### b)

这里中文翻译错了，原文为

> Test your implementation by forming a query that lists all people who supervise precisely one person.

意思是：找出所有的上级，他们只管理唯一的员工。也就是上级，底下只有一个员工。

``` Scheme
(and (supervisor ?x ?boss) 
     (unique (supervisor ?anyone ?boss)))
```

查询结果为：

``` Scheme
(and (supervisor (Cratchet Robert) (Scrooge Eben)) 
     (unique (supervisor (Cratchet Robert) (Scrooge Eben))))
(and (supervisor (Reasoner Louis) (Hacker Alyssa P)) 
     (unique (supervisor (Reasoner Louis) (Hacker Alyssa P))))
```
