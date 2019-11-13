## P259 - [练习 4.4]

在 [mceval.scm](./mceval.scm) 的基础上修改，eval 增加 `and?` 和 `or?` 的判断。

``` Scheme
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((and? exp) (eval-and exp env))
        ((or? exp) (eval-or exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp) 
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))
```

### a)

`eval-if` 和 `eval-and` 的实现为

``` Scheme
(define (and? exp) (tagged-list? exp 'and))

(define (eval-and exp env)
  (define (loop exps env)
    (let ((first (eval (first-exp exps) env)))
      (cond ((last-exp? exps) first)
            (first (loop (rest-exps exps) env))
            (else #f))))
  (if (null? (cdr exp))
      #t
      (loop (cdr exp) env)))

(define (or? exp) (tagged-list? exp 'or))

(define (eval-or exp env)
  (define (loop exps env)
    (let ((first (eval (first-exp exps) env)))
      (cond ((last-exp? exps) first)
            (first first)
            (else (loop (rest-exps exps) env)))))
  (if (null? (cdr exp))
      #f
      (loop (cdr exp) env)))
```

注意这里 or 的实现并没有完全按照题意。

按照题意，`(or 'a 'b)` 应该返回 #t。但这里按照 DrRacket 的习惯，`(or 'a 'b)` 返回 'a。假如非要按照题意，改改返回值就行。

### b)

and 和 or 也可以实现为 if 的派生表达式。比如

``` Scheme
(and a b c)
(or a b c)
```

可以写成

``` Scheme
(if a
    (if b
        c
        #f)
    #f)
    
(if a
    #t
    (if b
        #t
        c)
```

根据这个思路，代码可写成

``` Scheme
(define (and? exp) (tagged-list? exp 'and))

(define (eval-and exp env)
  (define (expand-and-clauses exps)
    (if (last-exp? exps)
        (first-exp exps)
        (make-if (first-exp exps)
                 (expand-and-clauses (rest-exps exps))
                 #f)))
  (if (null? (cdr exp))
      #t
      (eval (expand-and-clauses (cdr exp)) env)))

(define (or? exp) (tagged-list? exp 'or))

(define (eval-or exp env)
  (define (expand-or-clauses exps)
    (if (last-exp? exps)
        (first-exp exps)
        (make-if (first-exp exps)
                 #t
                 (expand-or-clauses (rest-exps exps)))))
  (if (null? (cdr exp))
      #f
      (eval (expand-or-clauses (cdr exp)) env)))
```     

### 对比讨论

对比 a)、b) 中 or 的实现，两者其实并非完全等价的。比如

* a) 中，`(or 'a 'b)` 会返回 'a。
* b) 中，`(or 'a 'b)` 会返回 #t。

这是 b) 的实现中，将其转换为 if 语句求值, `(or 'a 'b)` 会转换为

``` Scheme
(if 'a
    #t
    'b)
```

而不是转换为

``` Scheme
(if 'a
    'a
    'b)
```

这是因为 `(or (f a) (f b))` 这种语句，假如转换成

``` Scheme
(if (f a)
    (f a)
    (f b))
```

`(f a)` 表达式就有可能被求值两次，不符合 or 的语意。另外 b) 的实现中，其实也没有完全按照题意。

* 按照题意 `(or #f 'a)` 应该返回 #t。
* 而 b) 中的实现。`(or #f 'a)` 会返回 'a。

我想让表达式求值尽量向 DrRacket 的方式靠拢。只是转换成 if 语句，又要单次求值，没有办法做到完全一致。

