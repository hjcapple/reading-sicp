## P259 - [练习 4.5]

在 [mceval.scm](./mceval.scm) 的基础上修改。

### a)

一种方式保持原来的做法，将 cond 转成 if 的派生表达式。`expand-clauses` 修改为：

``` Scheme
(define (cond-not-else-actions clauses)
  (if (eq? '=> (cadr clauses))
      (list (list (caddr clauses) (cond-predicate clauses))) ; 注意这里有两个 list
      (cdr clauses)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false                          ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"
                       clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-not-else-actions first)) ; 这里改了
                     (expand-clauses rest))))))
```

可以简单敲入下面代码测试。

``` Scheme
(cond ('a 'b))
(cond ('a => display))
```

不过这种实现方式有个问题，比如下面代码中

``` Scheme
(define (f a)
  (display a)
  (newline)
  a)
(cond ((f 'Hello) => display))
```
会被转换成

``` Scheme
(if (f 'Hello)
    (display (f 'Hello))
    false)
```

于是 `(f 'Hello)` 被求值了两次。

### b)

为了避免重复求值，可以直接实现 `eval-cond`, 而不是将其当成 if 的派生表达式。

``` Scheme
(define (eval-cond-clauses clauses env)
  (if (null? clauses)
      false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (eval (sequence->exp (cond-actions first)) env)
                (error "ELSE clause isn't last -- EVAL-COND" clauses))
            (let ((predicate-val (eval (cond-predicate first) env)))
              (if (true? predicate-val)
                  (if (eq? '=> (cadr first))
                      (apply (eval (caddr first) env) (list predicate-val))
                      (eval-sequence (cond-actions first) env))
                  (eval-cond-clauses rest env)))))))

(define (eval-cond exp env)
  (eval-cond-clauses (cond-clauses exp) env))
```

`eval-cond-clauses` 的实现，其实跟 `expand-clauses` 很类似。
