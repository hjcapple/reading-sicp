#lang sicp

(#%require "ch5support.scm")
(#%require "ch5-regsim.scm")

(#%provide make-machine set-register-contents! start get-register-contents)

(redefine (make-register name)
  (let ((contents '*unassigned*)
        (stack (make-stack)))
    (define (dispatch message)
      (cond ((eq? message 'stack) stack)
            ((eq? message 'get) contents)
            ((eq? message 'set)
             (lambda (value) (set! contents value)))
            (else
              (error "Unknown request -- REGISTER" message))))
    dispatch))

(redefine (make-new-machine)
  (let* ((pc (make-register 'pc))
         (flag (make-register 'flag))
         (the-instruction-sequence '())
         (register-table
           (list (list 'pc pc) (list 'flag flag))))
    (let ((the-ops
            (list (list 'initialize-stack
                        (lambda () 
                          (for-each (lambda (reg-pair)
                                      (let ((stack ((cdr reg-pair) 'stack)))
                                        (stack 'initialize))
                                      register-table))))
                  ;;**next for monitored stack (as in section 5.2.4)
                  ;;  -- comment out if not wanted
                  (list 'print-stack-statistics
                        (lambda () 
                          (for-each (lambda (reg-pair)
                                      (let ((stack ((cdr reg-pair) 'stack)))
                                        (stack 'print-statistics))
                                      register-table)))))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiply defined register: " name)
            (set! register-table
                  (cons (list name (make-register name))
                        register-table)))
        'register-allocated)
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              (error "Unknown register:" name))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                ((instruction-execution-proc (car insts)))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'operations) the-ops)
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(redefine (update-insts! insts labels machine)
  (let ((pc (get-register machine 'pc))
        (flag (get-register machine 'flag))
        (ops (machine 'operations)))
    (for-each
      (lambda (inst)
        (set-instruction-execution-proc! 
          inst
          (make-execution-procedure
            (instruction-text inst) labels machine
            pc flag ops)))
      insts)))

(define (make-execution-procedure inst labels machine
                                  pc flag ops)
  (cond ((eq? (car inst) 'assign)
         (make-assign inst machine labels ops pc))
        ((eq? (car inst) 'test)
         (make-test inst machine labels ops flag pc))
        ((eq? (car inst) 'branch)
         (make-branch inst machine labels flag pc))
        ((eq? (car inst) 'goto)
         (make-goto inst machine labels pc))
        ((eq? (car inst) 'save)
         (make-save inst machine pc))
        ((eq? (car inst) 'restore)
         (make-restore inst machine pc))
        ((eq? (car inst) 'perform)
         (make-perform inst machine labels ops pc))
        (else (error "Unknown instruction type -- ASSEMBLE"
                     inst))))

(define (make-save inst machine pc)
  (let ((reg (get-register machine 
                           (stack-inst-reg-name inst))))
    (lambda ()
      (push (reg 'stack) (get-contents reg))
      (advance-pc pc))))

(define (make-restore inst machine pc)
  (let ((reg (get-register machine
                           (stack-inst-reg-name inst))))
    (lambda ()
      (set-contents! reg (pop (reg 'stack)))    
      (advance-pc pc))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define test-machine
  (make-machine
    '(x y)
    (list)
    '(
      (save y)
      (save x)
      (restore y)
      (restore x)
      )))

(set-register-contents! test-machine 'x 100)
(set-register-contents! test-machine 'y 200)
(start test-machine)
(get-register-contents test-machine 'x)
(get-register-contents test-machine 'y)

