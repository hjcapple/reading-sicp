#lang sicp

;; P283 - [练习 4.31]

;; 在 lazyeval.scm 的基础上，修改了下面函数
;; * apply
;; * procedure-parameters
;; * list-of-delayed-args
;; * delay-it
;; * force-it

(#%require "ch4support.scm")
(#%require "mceval.scm")

;; redefine 见 ch4support.scm 中的注释
(redefine (eval exp env)    
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
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
        ((application? exp)             ; clause from book
         (apply (actual-value (operator exp) env)
                (operands exp)
                env))
        (else
          (error "Unknown expression type -- EVAL" exp))))

(define (actual-value exp env)
  (force-it (eval exp env)))

(define (apply procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure
           procedure
           (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (procedure-parameters procedure)
             (list-of-delayed-args (cadr procedure) arguments env) ; 改了这里
             (procedure-environment procedure))))
        (else
          (error
            "Unknown procedure type -- APPLY" procedure))))

(define (list-of-arg-values exps env)
  (if (no-operands? exps)
      '()
      (cons (actual-value (first-operand exps) env)
            (list-of-arg-values (rest-operands exps)
                                env))))

(define (lazy-parameter? x)
  (and (pair? x) (eq? (cadr x) 'lazy)))

(define (lazy-memo-parameter? x)
  (and (pair? x) (eq? (cadr x) 'lazy-memo)))

(define (procedure-parameters p)
  (map (lambda (x) 
         (cond ((lazy-parameter? x) (car x))
               ((lazy-memo-parameter? x) (car x))
               (else x)))
       (cadr p)))

(define (list-of-delayed-args parameters exps env)
  (if (no-operands? exps)
      '()
      (cons (delay-it (car parameters) (first-operand exps) env)
            (list-of-delayed-args (cdr parameters)
                                  (rest-operands exps)
                                  env))))

(define (eval-if exp env)
  (if (true? (actual-value (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))

(define input-prompt "Lazy-Eval input:")
(define output-prompt "Lazy-Eval value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output
            (actual-value input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

;;; Representing thunks
;; thunks
(define (delay-it parameter exp env)
  (cond ((lazy-parameter? parameter) (list 'thunk exp env))
        ((lazy-memo-parameter? parameter) (list 'thunk-memo exp env))
        (else (actual-value exp env))))

(define (thunk? obj) (tagged-list? obj 'thunk))
(define (thunk-memo? obj) (tagged-list? obj 'thunk-memo))

(define (thunk-exp thunk) (cadr thunk))
(define (thunk-env thunk) (caddr thunk))

;; "thunk" that has been forced and is storing its (memoized) value
(define (evaluated-thunk? obj)
  (tagged-list? obj 'evaluated-thunk))

(define (thunk-value evaluated-thunk) (cadr evaluated-thunk))

(define (force-it obj)
  (cond ((thunk? obj) 
         (actual-value (thunk-exp obj) (thunk-env obj)))
        ((thunk-memo? obj)
         (let ((result (actual-value (thunk-exp obj) (thunk-env obj))))
           (set-car! obj 'evaluated-thunk)
           (set-car! (cdr obj) result)  ; replace exp with its value
           (set-cdr! (cdr obj) '())     ; forget unneeded env
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        (else obj)))

(#%require (only racket module*))
(module* main #f
  (driver-loop)
  'LAZY-EVALUATOR-LOADED
)
