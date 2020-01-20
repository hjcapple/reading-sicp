## P371 - [练习 5.11]

### a)

[斐波那契机器](./fib-machine.scm) 中，`afterfib-n-2` 标记中的代码如下

``` Scheme
afterfib-n-2                         ; upon return, val contains Fib(n - 2)
  (assign n (reg val))               ; n now contains Fib(n - 2)
  (restore val)                      ; val now contains Fib(n - 1)
  (restore continue)
  (assign val                        ;  Fib(n - 1) +  Fib(n - 2)
          (op +) (reg val) (reg n)) 
```

上述代码，n 存放 Fib(n - 2)，val 存放 Fib(n - 1)，再将其相加。可以用一条指令，替代最前面两条指令。修改为

``` Scheme
afterfib-n-2                        ; upon return, val contains Fib(n - 2)
  (restore n)                       ; n now contains Fib(n - 1)
  (restore continue)
  (assign val                       ; Fib(n - 2) + Fib(n - 1)
          (op +) (reg val) (reg n)) 
```

上述代码，将 n 存放 Fib(n - 1)，val 存放 Fib(n - 2)，再将其相加。结果是一样的。

### b)

在 [ch5-regsim.scm](./ch5-regsim.scm) 的基础上，修改 `make-save` 和 `make-restore` 函数:

``` Scheme
(define (make-save inst machine stack pc)
  (let* ((reg-name (stack-inst-reg-name inst))
         (reg (get-register machine reg-name)))
    (lambda ()
      (push stack (cons reg-name (get-contents reg)))
      (advance-pc pc))))

(define (make-restore inst machine stack pc)
  (let* ((reg-name (stack-inst-reg-name inst))
         (reg (get-register machine reg-name)))
    (lambda ()
      (let ((top (pop stack)))
        (if (eq? reg-name (car top))
            (begin
              (set-contents! reg (cdr top))    
              (advance-pc pc))
            (error "The value is not from register:" reg-name))))))
```

### c)

在 [ch5-regsim.scm](./ch5-regsim.scm) 的基础上，最主要是修改 `make-register`, `make-save` 和 `make-restore` 函数，将堆栈放到寄存器内。

``` Scheme
(define (make-register name)
  (let ((contents '*unassigned*)
        (stack (make-stack)))
    (define (dispatch message)
      (cond ((eq? message 'stack) stack)
            ((eq? message 'get) contents)
            ((eq? message 'set)
             (lambda (value) (set! contents value)))
            (else
              (error "Unknown request -- REGISTER" message))))
    dispatch))
    
(define (make-save inst machine pc)
  (let ((reg (get-register machine 
                           (stack-inst-reg-name inst))))
    (lambda ()
      (push (reg 'stack) (get-contents reg))
      (advance-pc pc))))

(define (make-restore inst machine pc)
  (let ((reg (get-register machine
                           (stack-inst-reg-name inst))))
    (lambda ()
      (set-contents! reg (pop (reg 'stack)))    
      (advance-pc pc))))    
```

另外 `make-new-machine` 和 `make-execution-procedure` 也需要进行调整，删除原来 machine 中的堆栈。

[c) 完整的代码在这里](./exercise_5_11_c.scm)。

### 测试

下面的代码

``` Scheme
#lang sicp

(#%require "ch5-regsim.scm")
;; (#%require "exercise_5_11_c.scm")

(define test-machine
  (make-machine
    '(x y)
    (list)
    '(
      (save y)
      (save x)
      (restore y)
      (restore x)
      )))

(set-register-contents! test-machine 'x 100)
(set-register-contents! test-machine 'y 200)
(start test-machine)
(get-register-contents test-machine 'x)
(get-register-contents test-machine 'y)
```

按照 a) 实现的堆栈，最后 x = 200, y = 100。

按照 b) 实现的堆栈，会发出一个错误信息，`The value is not from register: y`。

按照 c) 实现的堆栈，最后 x = 100, y = 200。
