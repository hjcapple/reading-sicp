#lang sicp

;; P393 - [练习 5.25]

(#%require "ch5-regsim.scm")
(#%require "ch5-eceval-support.scm")

;; 练习 5.25 改动
(define (delay-it exp env) (list 'thunk exp env))
(define (thunk? obj) (tagged-list? obj 'thunk))
(define (thunk-exp thunk) (cadr thunk))
(define (thunk-env thunk) (caddr thunk))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define eceval-operations
  (list
    ;;primitive Scheme operations
    (list 'read read)
    
    ;;operations in syntax.scm
    (list 'self-evaluating? self-evaluating?)
    (list 'quoted? quoted?)
    (list 'text-of-quotation text-of-quotation)
    (list 'variable? variable?)
    (list 'assignment? assignment?)
    (list 'assignment-variable assignment-variable)
    (list 'assignment-value assignment-value)
    (list 'definition? definition?)
    (list 'definition-variable definition-variable)
    (list 'definition-value definition-value)
    (list 'lambda? lambda?)
    (list 'lambda-parameters lambda-parameters)
    (list 'lambda-body lambda-body)
    (list 'if? if?)
    (list 'if-predicate if-predicate)
    (list 'if-consequent if-consequent)
    (list 'if-alternative if-alternative)
    (list 'begin? begin?)
    (list 'begin-actions begin-actions)
    (list 'last-exp? last-exp?)
    (list 'first-exp first-exp)
    (list 'rest-exps rest-exps)
    (list 'application? application?)
    (list 'operator operator)
    (list 'operands operands)
    (list 'no-operands? no-operands?)
    (list 'first-operand first-operand)
    (list 'rest-operands rest-operands)
    
    ;;operations in eceval-support.scm
    (list 'true? true?)
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
    (list 'no-more-exps? no-more-exps?)	;for non-tail-recursive machine
    (list 'get-global-environment get-global-environment)
    
    ;; 练习 5.25 改动
    (list 'delay-it delay-it)
    (list 'thunk? thunk?)
    (list 'thunk-env thunk-env)
    (list 'thunk-exp thunk-exp)
    (list 'print display)
))

(define eceval
  (make-machine
   '(exp env val proc argl continue unev)
   eceval-operations
  '(
;;SECTION 5.4.4
read-eval-print-loop
  (perform (op initialize-stack))
  (perform
   (op prompt-for-input) (const ";;; EC-Eval input:"))
  (assign exp (op read))
  (assign env (op get-global-environment))
  (assign continue (label print-result))
  (goto (label actual-value))
print-result
;;**following instruction optional -- if use it, need monitored stack
  (perform (op print-stack-statistics))
  (perform
   (op announce-output) (const ";;; EC-Eval value:"))
  (perform (op user-print) (reg val))
  (goto (label read-eval-print-loop))

unknown-expression-type
  (assign val (const unknown-expression-type-error))
  (goto (label signal-error))

unknown-procedure-type
  (restore continue)
  (assign val (const unknown-procedure-type-error))
  (goto (label signal-error))

signal-error
  (perform (op user-print) (reg val))
  (goto (label read-eval-print-loop))

;;SECTION 5.4.1
eval-dispatch
  (test (op self-evaluating?) (reg exp))
  (branch (label ev-self-eval))
  (test (op variable?) (reg exp))
  (branch (label ev-variable))
  (test (op quoted?) (reg exp))
  (branch (label ev-quoted))
  (test (op assignment?) (reg exp))
  (branch (label ev-assignment))
  (test (op definition?) (reg exp))
  (branch (label ev-definition))
  (test (op if?) (reg exp))
  (branch (label ev-if))
  (test (op lambda?) (reg exp))
  (branch (label ev-lambda))
  (test (op begin?) (reg exp))
  (branch (label ev-begin))
  (test (op application?) (reg exp))
  (branch (label ev-application))
  (goto (label unknown-expression-type))

ev-self-eval
  (assign val (reg exp))
  (goto (reg continue))
ev-variable
  (assign val (op lookup-variable-value) (reg exp) (reg env))
  (goto (reg continue))
ev-quoted
  (assign val (op text-of-quotation) (reg exp))
  (goto (reg continue))
ev-lambda
  (assign unev (op lambda-parameters) (reg exp))
  (assign exp (op lambda-body) (reg exp))
  (assign val (op make-procedure)
              (reg unev) (reg exp) (reg env))
  (goto (reg continue))

;; 练习 5.25 改动  
ev-application
  (save continue)
  (save env)
  (assign unev (op operands) (reg exp))
  (save unev)
  (assign exp (op operator) (reg exp))
  (assign continue (label ev-appl-did-operator))
  (goto (label actual-value))
ev-appl-did-operator
  (restore unev)
  (restore env)
  (assign proc (reg val))
  (goto (label apply-dispatch))

apply-dispatch
  (test (op primitive-procedure?) (reg proc))
  (branch (label primitive-apply))
  (test (op compound-procedure?) (reg proc))
  (branch (label compound-apply))
  (goto (label unknown-procedure-type))
primitive-apply
  (save proc)
  (assign proc (label actual-value))
  (assign continue (label primitive-apply-after-args))
  (goto (label ev-map-operands))
primitive-apply-after-args
  (restore proc)
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (restore continue)
  (goto (reg continue))
compound-apply
  (save continue)
  (save proc)
  (assign proc (label delay-it))
  (assign continue (label compound-apply-after-args))
  (goto (label ev-map-operands))
compound-apply-after-args
  (restore proc)
  (restore continue)
  (assign unev (op procedure-parameters) (reg proc))
  (assign env (op procedure-environment) (reg proc))
  (assign env (op extend-environment) (reg unev) (reg argl) (reg env))
  (assign unev (op procedure-body) (reg proc))
  (goto (label ev-sequence))
  
;; input: exp、env
;; ouput: val
actual-value
  (save continue)
  (assign continue (label actual-value-after-eval))
  (goto (label eval-dispatch))
actual-value-after-eval
  (restore continue)
  (assign exp (reg val))
  (goto (label force-it))
  
;; 为了简化实现，这里的 force-it 没有记忆功能  
force-it
  (test (op thunk?) (reg exp))
  (branch (label force-it-thunk))
  (goto (reg continue))
force-it-thunk
  (assign env (op thunk-env) (reg exp))
  (assign exp (op thunk-exp) (reg exp))
  (goto (label actual-value))  
  
;; input: exp, env
;; output: val
delay-it
  (assign val (op delay-it) (reg exp) (reg env))
  (goto (reg continue))

;; input: unev, proc, env
;; ouput: argl
ev-map-operands
  (assign argl (op empty-arglist))
  
ev-map-operand-loop  
  (test (op no-operands?) (reg unev))
  (branch (label ev-map-no-args))
  
  (save continue)
  (save proc)
  (save argl)
  (save env)
  (save unev)
   
  (assign exp (op first-operand) (reg unev))
  (assign continue (label ev-map-accumulate-arg))
  (goto (reg proc))
  
ev-map-accumulate-arg
  (restore unev)
  (restore env)
  (restore argl)
  (restore proc)
  (restore continue)
  
  (assign argl (op adjoin-arg) (reg val) (reg argl))
  (assign unev (op rest-operands) (reg unev))
  (goto (label ev-map-operand-loop))
  
ev-map-no-args
  (goto (reg continue))
  
    
;;;SECTION 5.4.2
ev-begin
  (assign unev (op begin-actions) (reg exp))
  (save continue)
  (goto (label ev-sequence))

ev-sequence
  (assign exp (op first-exp) (reg unev))
  (test (op last-exp?) (reg unev))
  (branch (label ev-sequence-last-exp))
  (save unev)
  (save env)
  (assign continue (label ev-sequence-continue))
  (goto (label eval-dispatch))
ev-sequence-continue
  (restore env)
  (restore unev)
  (assign unev (op rest-exps) (reg unev))
  (goto (label ev-sequence))
ev-sequence-last-exp
  (restore continue)
  (goto (label eval-dispatch))

;;;SECTION 5.4.3

ev-if
  (save exp)
  (save env)
  (save continue)
  (assign continue (label ev-if-decide))
  (assign exp (op if-predicate) (reg exp))
  (goto (label actual-value))
ev-if-decide
  (restore continue)
  (restore env)
  (restore exp)
  (test (op true?) (reg val))
  (branch (label ev-if-consequent))
ev-if-alternative
  (assign exp (op if-alternative) (reg exp))
  (goto (label eval-dispatch))
ev-if-consequent
  (assign exp (op if-consequent) (reg exp))
  (goto (label eval-dispatch))

ev-assignment
  (assign unev (op assignment-variable) (reg exp))
  (save unev)
  (assign exp (op assignment-value) (reg exp))
  (save env)
  (save continue)
  (assign continue (label ev-assignment-1))
  (goto (label eval-dispatch))
ev-assignment-1
  (restore continue)
  (restore env)
  (restore unev)
  (perform
   (op set-variable-value!) (reg unev) (reg val) (reg env))
  (assign val (const ok))
  (goto (reg continue))

ev-definition
  (assign unev (op definition-variable) (reg exp))
  (save unev)
  (assign exp (op definition-value) (reg exp))
  (save env)
  (save continue)
  (assign continue (label ev-definition-1))
  (goto (label eval-dispatch))
ev-definition-1
  (restore continue)
  (restore env)
  (restore unev)
  (perform
   (op define-variable!) (reg unev) (reg val) (reg env))
  (assign val (const ok))
  (goto (reg continue))
  
   )))

(#%require (only racket module*))
(module* main #f
  (start eceval)
  '(EXPLICIT CONTROL EVALUATOR LOADED)
)  
