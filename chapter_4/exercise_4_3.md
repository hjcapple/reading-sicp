## P259 - [练习 4.3]

在 [mceval.scm](./mceval.scm) 的基础上，将 eval 修改为：

``` Scheme
(#%require "ch4support.scm")  ; for put、get

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((and (pair? exp) (get 'eval (car exp)))
         ((get 'eval (car exp)) exp env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (install-eval-package)
  (put 'eval 'quote (lambda (exp env) (text-of-quotation exp)))
  (put 'eval 'set! eval-assignment)
  (put 'eval 'define eval-definition)
  (put 'eval 'if eval-if)
  (put 'eval 'lambda (lambda (exp env)
                       (make-procedure (lambda-parameters exp)
                                       (lambda-body exp)
                                       env)))
  (put 'eval 'begin (lambda (exp env)
                      (eval-sequence (begin-actions exp) env)))
  (put 'eval 'cond (lambda (exp env)
                     (eval (cond->if exp) env)))
  
  'done)
```
