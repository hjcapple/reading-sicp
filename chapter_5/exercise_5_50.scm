#lang sicp

;; P429 - [练习 5.50]

(#%require "ch5-compiler.scm")
(#%require "ch5-regsim.scm")
(#%require "ch5-eceval-support.scm")

;; 4.1 节的求值器代码
(define metacircular-code
  '(begin
    (define (eval exp env)
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
            ((let? exp) (eval (let->combination exp) env))
            ((application? exp)
             (apply (eval (operator exp) env)
                    (list-of-values (operands exp) env)))
            (else
              (error "Unknown expression type -- EVAL" exp))))
    
    (define (apply procedure arguments)
      (cond ((primitive-procedure? procedure)
             (apply-primitive-procedure procedure arguments))
            ((compound-procedure? procedure)
             (eval-sequence
               (procedure-body procedure)
               (extend-environment
                 (procedure-parameters procedure)
                 arguments
                 (procedure-environment procedure))))
            (else
              (error
                "Unknown procedure type -- APPLY" procedure))))
    
    
    (define (list-of-values exps env)
      (if (no-operands? exps)
          '()
          (cons (eval (first-operand exps) env)
                (list-of-values (rest-operands exps) env))))
    
    (define (eval-if exp env)
      (if (true? (eval (if-predicate exp) env))
          (eval (if-consequent exp) env)
          (eval (if-alternative exp) env)))
    
    (define (eval-sequence exps env)
      (cond ((last-exp? exps) (eval (first-exp exps) env))
            (else (eval (first-exp exps) env)
                  (eval-sequence (rest-exps exps) env))))
    
    (define (eval-assignment exp env)
      (set-variable-value! (assignment-variable exp)
                           (eval (assignment-value exp) env)
                           env)
      'ok)
    
    (define (eval-definition exp env)
      (define-variable! (definition-variable exp)
                        (eval (definition-value exp) env)
                        env)
      'ok)
    
    ;; SECTION 4.1.2
    (define (self-evaluating? exp)
      (cond ((number? exp) true)
            ((string? exp) true)
            ((boolean? exp) true)
            (else false)))
    
    (define (quoted? exp)
      (tagged-list? exp 'quote))
    
    (define (text-of-quotation exp) (cadr exp))
    
    (define (tagged-list? exp tag)
      (if (pair? exp)
          (eq? (car exp) tag)
          false))
    
    (define (variable? exp) (symbol? exp))
    
    (define (assignment? exp)
      (tagged-list? exp 'set!))
    
    (define (assignment-variable exp) (cadr exp))
    
    (define (assignment-value exp) (caddr exp))
    
    
    (define (definition? exp)
      (tagged-list? exp 'define))
    
    (define (definition-variable exp)
      (if (symbol? (cadr exp))
          (cadr exp)
          (caadr exp)))
    
    (define (definition-value exp)
      (if (symbol? (cadr exp))
          (caddr exp)
          (make-lambda (cdadr exp)
                       (cddr exp))))
    
    (define (lambda? exp) (tagged-list? exp 'lambda))
    
    (define (lambda-parameters exp) (cadr exp))
    (define (lambda-body exp) (cddr exp))
    
    (define (make-lambda parameters body)
      (cons 'lambda (cons parameters body)))
    
    
    (define (if? exp) (tagged-list? exp 'if))
    
    (define (if-predicate exp) (cadr exp))
    
    (define (if-consequent exp) (caddr exp))
    
    (define (if-alternative exp)
      (if (not (null? (cdddr exp)))
          (cadddr exp)
          'false))
    
    (define (make-if predicate consequent alternative)
      (list 'if predicate consequent alternative))
    
    
    (define (begin? exp) (tagged-list? exp 'begin))
    
    (define (begin-actions exp) (cdr exp))
    
    (define (last-exp? seq) (null? (cdr seq)))
    (define (first-exp seq) (car seq))
    (define (rest-exps seq) (cdr seq))
    
    (define (sequence->exp seq)
      (cond ((null? seq) seq)
            ((last-exp? seq) (first-exp seq))
            (else (make-begin seq))))
    
    (define (make-begin seq) (cons 'begin seq))
    
    
    (define (application? exp) (pair? exp))
    (define (operator exp) (car exp))
    (define (operands exp) (cdr exp))
    
    (define (no-operands? ops) (null? ops))
    (define (first-operand ops) (car ops))
    (define (rest-operands ops) (cdr ops))
    
    
    (define (cond? exp) (tagged-list? exp 'cond))
    
    (define (cond-clauses exp) (cdr exp))
    
    (define (cond-else-clause? clause)
      (eq? (cond-predicate clause) 'else))
    
    (define (cond-predicate clause) (car clause))
    
    (define (cond-actions clause) (cdr clause))
    
    (define (cond->if exp)
      (expand-clauses (cond-clauses exp)))
    
    ;; 练习 4.6
    (define (let? exp) (tagged-list? exp 'let))
    
    (define (let->combination exp)
      (define (let-body exp) (cddr exp))
      (define (let-vars exp) (map car (cadr exp)))
      (define (let-exps exp) (map cadr (cadr exp)))
      (cons (make-lambda (let-vars exp) 
                         (let-body exp)) 
            (let-exps exp)))
    
    (define (expand-clauses clauses)
      (if (null? clauses)
          'false                          ; no else clause
          (let ((first (car clauses))
                (rest (cdr clauses)))
            (if (cond-else-clause? first)
                (if (null? rest)
                    (sequence->exp (cond-actions first))
                    (error "ELSE clause isn't last -- COND->IF"
                           clauses))
                (make-if (cond-predicate first)
                         (sequence->exp (cond-actions first))
                         (expand-clauses rest))))))
    
    ;; SECTION 4.1.3
    (define (true? x)
      (not (eq? x false)))
    
    (define (false? x)
      (eq? x false))
    
    (define (make-procedure parameters body env)
      (list 'procedure parameters body env))
    
    (define (compound-procedure? p)
      (tagged-list? p 'procedure))
    
    (define (procedure-parameters p) (cadr p))
    (define (procedure-body p) (caddr p))
    (define (procedure-environment p) (cadddr p))
    
    (define (enclosing-environment env) (cdr env))
    
    (define (first-frame env) (car env))
    
    (define the-empty-environment '())
    
    (define (make-frame variables values)
      (cons variables values))
    
    (define (frame-variables frame) (car frame))
    (define (frame-values frame) (cdr frame))
    
    (define (add-binding-to-frame! var val frame)
      (set-car! frame (cons var (car frame)))
      (set-cdr! frame (cons val (cdr frame))))
    
    (define (extend-environment vars vals base-env)
      (if (= (length vars) (length vals))
          (cons (make-frame vars vals) base-env)
          (if (< (length vars) (length vals))
              (error "Too many arguments supplied" vars vals)
              (error "Too few arguments supplied" vars vals))))
    
    (define (lookup-variable-value var env)
      (define (env-loop env)
        (define (scan vars vals)
          (cond ((null? vars)
                 (env-loop (enclosing-environment env)))
                ((eq? var (car vars))
                 (car vals))
                (else (scan (cdr vars) (cdr vals)))))
        (if (eq? env the-empty-environment)
            (error "Unbound variable" var)
            (let ((frame (first-frame env)))
              (scan (frame-variables frame)
                    (frame-values frame)))))
      (env-loop env))
    
    (define (set-variable-value! var val env)
      (define (env-loop env)
        (define (scan vars vals)
          (cond ((null? vars)
                 (env-loop (enclosing-environment env)))
                ((eq? var (car vars))
                 (set-car! vals val))
                (else (scan (cdr vars) (cdr vals)))))
        (if (eq? env the-empty-environment)
            (error "Unbound variable -- SET!" var)
            (let ((frame (first-frame env)))
              (scan (frame-variables frame)
                    (frame-values frame)))))
      (env-loop env))
    
    (define (define-variable! var val env)
      (let ((frame (first-frame env)))
        (define (scan vars vals)
          (cond ((null? vars)
                 (add-binding-to-frame! var val frame))
                ((eq? var (car vars))
                 (set-car! vals val))
                (else (scan (cdr vars) (cdr vals)))))
        (scan (frame-variables frame)
              (frame-values frame))))
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; SECTION 4.1.4
    (define primitive-procedures
      (list (list 'car car)
            (list 'cdr cdr)
            (list 'cons cons)
            (list 'null? null?)
            (list 'pair? pair?)
            (list '= =)
            (list '+ +)
            (list '- -)
            (list '* *)
            (list '/ /)
            (list '< <)))
    
    (define (primitive-procedure-names)
      (map car
           primitive-procedures))
    
    (define (primitive-procedure-objects)
      (map (lambda (proc) (list 'primitive (cadr proc)))
           primitive-procedures))
    
    (define (setup-environment)
      (let ((initial-env
              (extend-environment (primitive-procedure-names)
                                  (primitive-procedure-objects)
                                  the-empty-environment)))
        (define-variable! 'true true initial-env)
        (define-variable! 'false false initial-env)
        initial-env))
    
    (define (primitive-procedure? proc)
      (tagged-list? proc 'primitive))
    
    (define (primitive-implementation proc) (cadr proc))
    
    (define (apply-primitive-procedure proc args)
      (apply-in-underlying-scheme
        (primitive-implementation proc) args))
    
    (define input-prompt "M-Eval input:")
    (define output-prompt "M-Eval value:")
    
    (define (driver-loop)
      (prompt-for-input input-prompt)
      (let ((input (read)))
        (let ((output (eval input the-global-environment)))
          (announce-output output-prompt)
          (user-print output)))
      (driver-loop))
    
    (define (prompt-for-input string)
      (newline) (newline) (display string) (newline))
    
    (define (announce-output string)
      (newline) (display string) (newline))
    
    (define (user-print object)
      (if (compound-procedure? object)
          (display (list 'compound-procedure
                         (procedure-parameters object)
                         (procedure-body object)
                         '<procedure-env>))
          (display object)))
    
    ; 一些额外函数，直接实现，避免注册到环境中
    (define (map op sequence)
      (if (null? sequence)
          '()
          (cons (op (car sequence)) (map op (cdr sequence)))))
    
    (define (cadr lst) (car (cdr lst)))
    (define (cddr lst) (cdr (cdr lst)))
    (define (caadr lst) (car (car (cdr lst))))
    (define (caddr lst) (car (cdr (cdr lst))))
    (define (cdadr lst) (cdr (car (cdr lst))))
    (define (cdddr lst) (cdr (cdr (cdr lst))))
    (define (cadddr lst) (car (cdr (cdr (cdr lst)))))
    (define (not x) (if x false true))
    
    (define (length items)
      (if (null? items)
          0
          (+ 1 (length (cdr items)))))
    
    
    
    ;;;Following are commented out so as not to be evaluated when
    ;;; the file is loaded.
    (define the-global-environment (setup-environment))
    
    (driver-loop)
    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 设置环境
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)
        ;;above from book -- here are some more
        (list 'display display)
        (list 'newline newline)
        (list '+ +)
        (list '- -)
        (list '* *)
        (list '= =)
        (list '/ /)
        (list '> >)
        (list '< <)
        
        (list 'list list)
        (list 'pair? pair?)
        (list 'eq? eq?)
        (list 'set-car! set-car!)
        (list 'set-cdr! set-cdr!)
        (list 'read read)
        (list 'number? number?)
        (list 'string? string?)
        (list 'symbol? symbol?)
        (list 'boolean? boolean?)
        (list 'apply-in-underlying-scheme apply-primitive-procedure)
        (list 'error error)
        ))

(define (primitive-procedure-names)
  (map car primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))

(define (setup-environment)
  (let ((initial-env (extend-environment (primitive-procedure-names)
                                         (primitive-procedure-objects)
                                         the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define eceval-operations
  (list
    ;;used by compiled code
    (list 'list list)
    (list 'cons cons)
    
    ;;operations in eceval-support.scm
    (list 'true? true?)
    (list 'false? false?)   ;for compiled code
    (list 'make-procedure make-procedure)
    (list 'compound-procedure? compound-procedure?)
    (list 'procedure-parameters procedure-parameters)
    (list 'procedure-body procedure-body)
    (list 'procedure-environment procedure-environment)
    (list 'extend-environment extend-environment)
    (list 'lookup-variable-value lookup-variable-value)
    (list 'set-variable-value! set-variable-value!)
    (list 'define-variable! define-variable!)
    (list 'primitive-procedure? primitive-procedure?)
    (list 'apply-primitive-procedure apply-primitive-procedure)
    (list 'prompt-for-input prompt-for-input)
    (list 'announce-output announce-output)
    (list 'user-print user-print)
    (list 'empty-arglist empty-arglist)
    (list 'adjoin-arg adjoin-arg)
    (list 'last-operand? last-operand?)
    (list 'no-more-exps? no-more-exps?) ;for non-tail-recursive machine
    (list 'get-global-environment get-global-environment)
    
    ;;for compiled code (also in eceval-support.scm)
    (list 'make-compiled-procedure make-compiled-procedure)
    (list 'compiled-procedure? compiled-procedure?)
    (list 'compiled-procedure-entry compiled-procedure-entry)
    (list 'compiled-procedure-env compiled-procedure-env)
    ))

;; 编译代码
(define (compile-scheme expression)
  (statements (compile expression 'val 'return)))

;; 编译运行求值器
(define eceval-machine
  (make-machine
    '(exp env val proc argl continue unev)
    eceval-operations
    (compile-scheme metacircular-code)
    ))

(set-register-contents! eceval-machine 'env (setup-environment))
(start eceval-machine)

