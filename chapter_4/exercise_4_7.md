## P260 - [练习 4.7]

在 [mceval.scm](./mceval.scm) 的 [练习 4.6](exercise_4_6.md) 基础上修改测试。`eval` 函数中添加一个判断。

``` Scheme
((let*? exp) (eval (let*->nested-lets exp) env))
```

`let*` 实现为

``` Scheme
(define (let*? exp) (tagged-list? exp 'let*))

(define (let*->nested-lets exp)
  (define (make-let vars body)
    (cons 'let (cons vars body)))
  
  (define (expand-let*-vars vars body)
    (cond ((null? vars) (make-let vars body))
          ((null? (cdr vars)) (make-let vars body))
          (else (make-let (list (car vars))
                          (list (expand-let*-vars (cdr vars) body))))))
  
  (define (let*-body exp) (cddr exp))
  (define (let*-vars exp) (cadr exp))
  
  (expand-let*-vars (let*-vars exp)
                    (let*-body exp)))
```

测试代码:

``` Scheme
(let* ((x 3)
       (y (+ x 2))
       (z (+ x y 5)))
  (* x z))
```

会被转换为 let 的嵌套

``` Scheme
(let ((x 3)) 
  (let ((y (+ x 2))) 
    (let ((z (+ x y 5))) 
      (* x z))))
```

`let*` 可以作为 `let` 的派生实现。

