#lang sicp

;; P425 - [练习 5.44]

;; 主要是修改 open-code? 函数。

(#%require "ch5support.scm")    ; for redefine
(#%require "exercise_5_41.scm") ; for find-variable
(#%require "exercise_5_43.scm")
(#%provide (all-defined) statements compile)

;; P421 - [练习 5.38]
(define (open-code? exp env)
  (and (pair? exp)
       (memq (operator exp) '(+ * - =))
       (eq? (find-variable (operator exp) env) 'not-found)))

(define (compile-open-code exp target linkage env)
  (let ((proc (operator exp))
      (first-operand (car (operands exp)))
      (rest-operands (cdr (operands exp))))
    (preserving '(env continue)
      (compile first-operand 'arg1 'next env)
      (compile-open-coded-rest-args proc rest-operands target linkage env))))

(define (compile-open-coded-rest-args proc operands target linkage env)
  (if (null? (cdr operands))
      (preserving '(arg1 continue)
        (compile (car operands) 'arg2 'next env)
        (end-with-linkage linkage
          (make-instruction-sequence '(arg1 arg2) (list target)
            `((assign ,target (op ,proc) (reg arg1) (reg arg2))))))
      (preserving '(env continue)
        (preserving '(arg1)
          (compile (car operands) 'arg2 'next env)
          (make-instruction-sequence '(arg1 arg2) '(arg1)
            `((assign arg1 (op ,proc) (reg arg1) (reg arg2)))))
        (compile-open-coded-rest-args proc (cdr operands) target linkage env))))
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(redefine (compile exp target linkage env)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage env))
        ((assignment? exp)
         (compile-assignment exp target linkage env))
        ((definition? exp)
         (compile-definition exp target linkage env))
        ((if? exp) (compile-if exp target linkage env))
        ((lambda? exp) (compile-lambda exp target linkage env))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage
                           env))
        ((cond? exp) (compile (cond->if exp) target linkage env))
        ((open-code? exp env) (compile-open-code exp target linkage env))
        ((let? exp) (compile (let->combination exp) target linkage env))
        ((application? exp)
         (compile-application exp target linkage env))
        (else
         (error "Unknown expression type -- COMPILE" exp))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(#%require (only racket module*))
(module* main #f
  (compile
    '(begin
       (+ 1 2 3 4)
       (* x (f x) y (+ 1 2)))
    'val
    'next
    (empty-compile-time-env))

  (compile
    '(lambda (+ * a b x y)
       (+ (* a x) (* b y)))
    'val
    'next
    (empty-compile-time-env))
)
