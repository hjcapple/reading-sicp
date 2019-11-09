## P259 - [练习 4.2]

a)

修改前，`application?` 判断放到最后。之前的判断都不成立，才会触发 `application?` 判断。假如将 `application?` 放到前面，define、if、quote 等关键字本身有自己的语意，也会被错误当成过程调用。比如语句

``` Scheme
(define x 3)
```

在修改前 `definition?` 先成立，执行 `eval-definition`。但修改后，就会试图在环境中寻找名字为 `define` 的过程，将 x 和 3 当成参数赋值给它。但环境中没有名字为 `define` 的过程，就运行出错了。

b)

可以在 [mceval.scm](./mceval.scm) 的基础上修改测试。修改如下：

``` Scheme
(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp)
         (make-procedure (lambda-parameters exp)
                         (lambda-body exp)
                         env))
        ((begin? exp) 
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        (else
          (error "Unknown expression type -- EVAL" exp))))
          
(define (application? exp) (tagged-list? exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))
```
