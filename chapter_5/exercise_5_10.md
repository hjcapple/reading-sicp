## P371 - [练习 5.10]

### 新语法

新语法使用前缀，来表示特定的功能。对比如下

| 功能   | 前缀  | 原来语法              | 新语法         |
|-------|------|----------------------|----------------|
| label | :    | `(label fact-done)`  | `:fact-done`   |
| reg   | %    | `(reg n)`            | `%n`           |
| op    | @    | `(op =)`             | `@=`           |
| const | 无   | `(const 1)`          | 1             |

### 代码

为实现新语法，在 [ch5-regsim.scm](./ch5-regsim.scm) 的基础上，修改下面函数:

``` Scheme
(define (symbol-starting-with? symbol prefix)
  (and (symbol? symbol)
       (equal? (substring (symbol->string symbol) 0 1) prefix)))

(define (symbol-without-prefix symbol)
  (string->symbol (substring (symbol->string symbol) 1)))

(define (register-exp? exp) (symbol-starting-with? exp "%"))
(define (register-exp-reg exp) (symbol-without-prefix exp))

(define (constant-exp? exp) 
  (and (not (pair? exp))
       (not (register-exp? exp))
       (not (label-exp? exp))
       (not (operation-exp? exp))))

(define (constant-exp-value exp) exp)

(define (label-exp? exp) (symbol-starting-with? exp ":"))
(define (label-exp-label exp) (symbol-without-prefix exp))

(define (operation-exp? exp) 
  (and (pair? exp) 
       (symbol-starting-with? (car exp) "@")))
(define (operation-exp-op operation-exp) 
  (symbol-without-prefix (car operation-exp)))
(define (operation-exp-operands operation-exp) 
  (cdr operation-exp))
```

### 测试

使用新语法改写 [原来的阶乘机器](./fact-machine.scm)，如下:

``` Scheme
#lang sicp

(#%require "ch5-regsim.scm")

(define fact-machine
  (make-machine
    '(continue n val)
    (list (list '= =) (list '- -) (list '* *))
    '(
      (assign continue :fact-done)     ; set up final return address
    fact-loop
      (test @= %n 1)
      (branch :base-case)
      ;; Set up for the recursive call by saving n and continue.
      ;; Set up continue so that the computation will continue
      ;; at after-fact when the subroutine returns.
      (save continue)
      (save n)
      (assign n @- %n 1)
      (assign continue :after-fact)
      (goto :fact-loop)
    after-fact
      (restore n)
      (restore continue)
      (assign val @* %n %val)   ; val now contains n(n - 1)!
      (goto %continue)          ; return to caller
    base-case
      (assign val 1)            ; base case: 1! = 1
      (goto %continue)          ; return to caller
    fact-done
      )))

(set-register-contents! fact-machine 'n 10)
(start fact-machine)
(get-register-contents fact-machine 'val)
```
可正确得到结果 3628800。

