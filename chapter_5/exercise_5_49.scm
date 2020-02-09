#lang sicp

;; P429 - [练习 5.49]

(#%require "ch5-compiler.scm")
(#%require "ch5-regsim.scm")
(#%require "ch5-eceval-support.scm")

(define (compile-scheme expression)
  (assemble (statements
              (compile expression 'val 'return))
            eceval))

(define (user-print object)
  (cond ((compound-procedure? object)
         (display (list 'compound-procedure
                        (procedure-parameters object)
                        (procedure-body object)
                        '<procedure-env>)))
        ((compiled-procedure? object)
         (display '<compiled-procedure>))
        (else (display object))))

(define eceval-operations
  (list
    (list 'compile-scheme compile-scheme)
    
    ;;primitive Scheme operations
    (list 'read read)			;used by eceval
    
    ;;used by compiled code
    (list 'list list)
    (list 'cons cons)
    
    ;;operations in eceval-support.scm
    (list 'true? true?)
    (list 'false? false?)		;for compiled code
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
    
    ;;for compiled code (also in eceval-support.scm)
    (list 'make-compiled-procedure make-compiled-procedure)
    (list 'compiled-procedure? compiled-procedure?)
    (list 'compiled-procedure-entry compiled-procedure-entry)
    (list 'compiled-procedure-env compiled-procedure-env)
    ))

(define eceval
  (make-machine
   '(exp env val proc argl continue unev)
   eceval-operations
  '(
read-eval-print-loop
  (perform (op initialize-stack))
  (perform (op prompt-for-input) (const ";;; EC-Eval input:"))
  (assign exp (op read))
  (assign env (op get-global-environment))
  (assign continue (label print-result))
    
  (assign val (op compile-scheme) (reg exp))
  (goto (reg val))
  
print-result
;;**following instruction optional -- if use it, need monitored stack
  (perform (op print-stack-statistics))
  (perform (op announce-output) (const ";;; EC-Eval value:"))
  (perform (op user-print) (reg val))
  (goto (label read-eval-print-loop))
   )))

(#%require (only racket module*))
(module* main #f
   (start eceval)
)

