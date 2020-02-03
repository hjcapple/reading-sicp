#lang sicp

;; P424 - [练习 5.40]

;; 主要修改 compile-lambda-body，扩展编译时环境。compile 过程也添加了 env 参数，传递下去。

(#%require "ch5-compiler.scm")

(define (empty-compile-time-env) '())
(define (extend-compile-time-environment formals env) (cons formals env))

(define (compile exp target linkage env)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage env))
        ((if? exp) (compile-if exp target linkage env))
        ((lambda? exp) (compile-lambda exp target linkage env))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage
                           env))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ((application? exp)
         (compile-application exp target linkage env))
        (else
         (error "Unknown expression type -- COMPILE" exp))))

(define (compile-definition exp target linkage env)
  (let ((var (definition-variable exp))
        (get-value-code
         (compile (definition-value exp) 'val 'next env)))
    (end-with-linkage linkage
     (preserving '(env)
      get-value-code
      (make-instruction-sequence '(env val) (list target)
       `((perform (op define-variable!)
                  (const ,var)
                  (reg val)
                  (reg env))
         (assign ,target (const ok))))))))


(define (compile-if exp target linkage env)
  (let ((t-branch (make-label 'true-branch))
        (f-branch (make-label 'false-branch))                    
        (after-if (make-label 'after-if)))
    (let ((consequent-linkage
           (if (eq? linkage 'next) after-if linkage)))
      (let ((p-code (compile (if-predicate exp) 'val 'next env))
            (c-code
             (compile
              (if-consequent exp) target consequent-linkage env))
            (a-code
             (compile (if-alternative exp) target linkage env)))
        (preserving '(env continue)
         p-code
         (append-instruction-sequences
          (make-instruction-sequence '(val) '()
           `((test (op false?) (reg val))
             (branch (label ,f-branch))))
          (parallel-instruction-sequences
           (append-instruction-sequences t-branch c-code)
           (append-instruction-sequences f-branch a-code))
          after-if))))))

;;; sequences
(define (compile-sequence seq target linkage env)
  (if (last-exp? seq)
      (compile (first-exp seq) target linkage env)
      (preserving '(env continue)
       (compile (first-exp seq) target 'next env)
       (compile-sequence (rest-exps seq) target linkage env))))

;;;lambda expressions
(define (compile-lambda exp target linkage env)
  (let ((proc-entry (make-label 'entry))
        (after-lambda (make-label 'after-lambda)))
    (let ((lambda-linkage
           (if (eq? linkage 'next) after-lambda linkage)))
      (append-instruction-sequences
       (tack-on-instruction-sequence
        (end-with-linkage lambda-linkage
         (make-instruction-sequence '(env) (list target)
          `((assign ,target
                    (op make-compiled-procedure)
                    (label ,proc-entry)
                    (reg env)))))
        (compile-lambda-body exp proc-entry env))
       after-lambda))))

;; 主要是这里，需要扩展编译时环境
(define (compile-lambda-body exp proc-entry env)
  (let ((formals (lambda-parameters exp)))
    (append-instruction-sequences
     (make-instruction-sequence '(env proc argl) '(env)
      `(,proc-entry
        (assign env (op compiled-procedure-env) (reg proc))
        (assign env
                (op extend-environment)
                (const ,formals)
                (reg argl)
                (reg env))))
     (compile-sequence (lambda-body exp) 
                       'val 
                       'return 
                       (extend-compile-time-environment formals env)))))

(define (compile-application exp target linkage env)
  (let ((proc-code (compile (operator exp) 'proc 'next env))
        (operand-codes
         (map (lambda (operand) (compile operand 'val 'next env))
              (operands exp))))
    (preserving '(env continue)
     proc-code
     (preserving '(proc continue)
      (construct-arglist operand-codes)
      (compile-procedure-call target linkage)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(compile
  '(begin (define (factorial n)
     (if (= n 1)
         1
         (* (factorial (- n 1)) n))))
  'val
  'next
  (empty-compile-time-env))

