#lang sicp

;; P424 - [练习 5.42]

(#%require "ch5-compiler.scm")
(#%require "exercise_5_41.scm") ; for find-variable

(define (empty-compile-time-env) '())
(define (extend-compile-time-environment formals env) (cons formals env))

(define (compile exp target linkage env)
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
        ((application? exp)
         (compile-application exp target linkage env))
        (else
         (error "Unknown expression type -- COMPILE" exp))))

;; 使用了 (op get-global-environment) 来获取全局环境
(define (compile-variable exp target linkage env)
  (let ((address (find-variable exp env)))
    (if (eq? address 'not-found)
        (end-with-linkage linkage
          (make-instruction-sequence '(env) (list target 'env)
            `((assign env (op get-global-environment))
              (assign ,target (op lookup-variable-value) (const ,exp) (reg env)))))
        
        (end-with-linkage linkage
          (make-instruction-sequence '(env) (list target)
            `((assign ,target (op lexical-address-lookup) (const ,address) (reg env))))))))

(define (compile-assignment exp target linkage env)
  (let ((var (assignment-variable exp))
        (get-value-code (compile (assignment-value exp) 'val 'next env)))
    (let ((address (find-variable var env)))
      (if (eq? address 'not-found)
          (end-with-linkage linkage
            (preserving '(env)
              get-value-code
              (make-instruction-sequence '(env val) (list target 'env)
                `((assign env (op get-global-environment))
                  (perform (op set-variable-value!) (const ,var) (reg val) (reg env))
                  (assign ,target (const ok))))))
          (end-with-linkage linkage
            (preserving '(env)
              get-value-code
              (make-instruction-sequence '(env val) (list target)
                `((perform (op lexical-address-set!) (const ,address) (reg val) (reg env))
                  (assign ,target (const ok))))))))))

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
  '((lambda (x y)
      (lambda (a b c d e)
        ((lambda (y z) (* x y z))
         (* a b x)
         (+ c d x))))
    3
    4)
  'val
  'next
  (empty-compile-time-env))

