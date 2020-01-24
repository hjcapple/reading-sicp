## P392 - [练习 5.24]

* [完整代码在这里](./exercise_5_24.scm)

参考 [练习 4.5](../chapter_4/exercise_4_5.md) 中的 b)，我们先将 cond 实现为 Scheme 代码

``` Scheme
(define (eval-cond-clauses clauses env)
  (if (null? clauses)
      false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (eval-sequence (cond-actions first) env)
                (error "ELSE clause isn't last -- EVAL-COND" clauses))
            (let ((predicate-val (eval (cond-predicate first) env)))
              (if (true? predicate-val)
                  (eval-sequence (cond-actions first) env)
                  (eval-cond-clauses rest env))))))

(define (eval-cond exp env)
  (eval-cond-clauses (cond-clauses exp) env))
```

接下来手动将其翻译成求值器指令

``` Scheme
ev-cond
  (assign exp (op cond-clauses) (reg exp))
ev-cond-clauses
  (test (op null?) (reg exp))
  (branch (label ev-cond-null))
  
  (assign unev (op car) (reg exp))  ; first
  (assign exp (op cdr) (reg exp))   ; rest
  
  (test (op cond-else-clause?) (reg unev))
  (branch (label ev-cond-else))
  
  (save env)
  (save continue)
  (save exp)
  (save unev)
  (assign exp (op cond-predicate) (reg unev))
  (assign continue (label ev-cond-else-decide))
  (goto (label eval-dispatch))
ev-cond-else-decide
  (restore unev)
  (restore exp)
  (restore continue)
  (restore env)
  (test (op true?) (reg val))
  (branch (label ev-cond-sequence))
  (goto (label ev-cond-clauses))  
ev-cond-else
  (test (op null?) (reg exp))
  (branch (label ev-cond-sequence))
  (goto (label unknown-expression-type))
ev-cond-sequence
  (assign unev (op cond-actions) (reg unev))
  (save continue)
  (goto (label ev-sequence))
ev-cond-null
  (assign val (const false))
  (goto (reg continue))
```  

### 测试代码

``` Scheme
(define x 1)
(cond ((> x 0) x)
      ((= x 0) (display 'zero) 0)
      (else (- x)))
      
(define x 0)
(cond ((> x 0) x)
      ((= x 0) (display 'zero) 0)
      (else (- x)))
      
(define x -1)
(cond ((> x 0) x)
      ((= x 0) (display 'zero) 0)
      (else (- x)))
      
(define x -1)
(cond ((> x 0) x)
      ((= x 0) (display 'zero) 0))                  
```
