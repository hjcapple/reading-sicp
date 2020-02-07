#lang sicp

;; P424 - [练习 5.43]

(#%require "ch5support.scm")
(#%require "ch5-compiler.scm")
(#%require "exercise_5_41.scm") ; for find-variable
(#%provide (all-defined) (all-from "ch5-compiler.scm"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; P259 - [练习 4.6]
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (let? exp) (tagged-list? exp 'let))

(define (let->combination exp)
  (define (let-body exp) (cddr exp))
  (define (let-vars exp) (map car (cadr exp)))
  (define (let-exps exp) (map cadr (cadr exp)))
  
  (cons (make-lambda (let-vars exp) 
                     (let-body exp)) 
        (let-exps exp)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; P270 - [练习 4.16]
(define (filter predicate sequence)
  (if (null? sequence)
      '()
      (if (predicate (car sequence))
          (cons (car sequence) (filter predicate (cdr sequence)))
          (filter predicate (cdr sequence)))))

(define (scan-out-defines body)
  (define (body-defines body)
    (filter definition? body))
  (define (name-unassigned defines)
    (map (lambda (exp)
           (list (definition-variable exp) ''*unassigned*))
         defines))
  (define (defines->let-body body)
    (map (lambda (exp)
           (if (definition? exp)
               (list 'set! (definition-variable exp) (definition-value exp))
               exp))
         body))
  (let ((defines (body-defines body)))
    (if (null? defines)
        body
        (list (append (list 'let (name-unassigned defines))
                      (defines->let-body body))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (empty-compile-time-env) '())
(define (extend-compile-time-environment formals env) (cons formals env))

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
        ((let? exp) (compile (let->combination exp) target linkage env))
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
     (compile-sequence (scan-out-defines (lambda-body exp)) ;; 修改了这里
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
(#%require (only racket module*))
(module* main #f
  (compile
    '(define (factorial n)
       (define (iter product counter)
         (if (> counter n)
             product
             (iter (* counter product)
                   (+ counter 1))))
       (iter 1))
    'val
    'next
    (empty-compile-time-env))
)

