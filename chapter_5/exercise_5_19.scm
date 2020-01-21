#lang sicp

;; P373 - [练习 5.19]

(#%require "ch5support.scm")
(#%require "ch5-regsim.scm")

(define (make-machine register-names ops controller-text)
  (let ((machine (make-new-machine)))
    (for-each (lambda (register-name)
                ((machine 'allocate-register) register-name))
              register-names)
    ((machine 'install-operations) ops)
    (let ((result (assemble controller-text machine)))
      ((machine 'install-instruction-sequence) (car result))
      ((machine 'install-instruction-labels) (cdr result)))
    machine))

(define (filter predicate sequence)
  (if (null? sequence)
      '()
      (if (predicate (car sequence))
          (cons (car sequence) (filter predicate (cdr sequence)))
          (filter predicate (cdr sequence)))))

(define (remove item lst)
  (filter (lambda (x) (not (eq? x item)))
          lst))

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (the-instruction-labels '())
        (the-breakpoint-instructions '()))
    (let ((the-ops
            (list (list 'initialize-stack
                        (lambda () (stack 'initialize)))
                  ;;**next for monitored stack (as in section 5.2.4)
                  ;;  -- comment out if not wanted
                  (list 'print-stack-statistics
                        (lambda () (stack 'print-statistics)))))
          (register-table
            (list (list 'pc pc) (list 'flag flag))))
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
      
      ;; 打印在断点时的一些信息
      (define (print-breakpoint breakpoint inst)
        (display "break on ")
        (display (car breakpoint))
        (display ":")
        (display (cdr breakpoint))
        (display " ")
        (display (instruction-text inst))
        (newline)
        (display "register: ")
        (for-each (lambda (reg)
                    (let ((name (car reg))
                          (val (get-contents (cadr reg))))
                      (cond ((number? val)
                             (display name)
                             (display " = ")
                             (display val)
                             (display ", ")))))
                  register-table)
        (newline))
      
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (let ((breakpoint (instruction-breakpoint (car insts))))
                (if (null? breakpoint)
                    (begin
                      ((instruction-execution-proc (car insts)))
                      (execute))
                    (print-breakpoint breakpoint (car insts)))))))
      
      (define (set-breakpoint label n)
        (let* ((insts (lookup-label the-instruction-labels label))
               (inst (list-ref insts (- n 1))))
          (cond ((null? (instruction-breakpoint inst))
                 (set! the-breakpoint-instructions (cons inst the-breakpoint-instructions))
                 (set-instruction-breakpoint! inst (cons label n))))))
      
      (define (cancel-breakpoint label n)
        (let* ((insts (lookup-label the-instruction-labels label))
               (inst (list-ref insts (- n 1))))
          (cond ((not (null? (instruction-breakpoint inst)))
                 (set! the-breakpoint-instructions (remove inst the-breakpoint-instructions))
                 (set-instruction-breakpoint! inst '())))))
      
      (define (cancel-all-breakpoints)
        (for-each (lambda (inst)
                    (set-instruction-breakpoint! inst '()))
                  the-breakpoint-instructions)
        (set! the-breakpoint-instructions '()))
      
      (define (proceed)
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
              ((eq? message 'install-instruction-labels)
               (lambda (labels) (set! the-instruction-labels labels)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              ((eq? message 'set-breakpoint) set-breakpoint)
              ((eq? message 'cancel-breakpoint) cancel-breakpoint)
              ((eq? message 'cancel-all-breakpoints) cancel-all-breakpoints)
              ((eq? message 'proceed) proceed)
              (else (error "Unknown request -- MACHINE" message))))
      dispatch)))

(define (set-breakpoint machine label n)
  ((machine 'set-breakpoint) label n))

(define (cancel-breakpoint machine label n)
  ((machine 'cancel-breakpoint) label n))

(define (cancel-all-breakpoints machine)
  ((machine 'cancel-all-breakpoints)))

(define (proceed-machine machine)
  ((machine 'proceed)))

(define (assemble controller-text machine)
  (extract-labels controller-text
                  (lambda (insts labels)
                    (update-insts! insts labels machine)
                    (cons insts labels))))

(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels (cdr text)
                      (lambda (insts labels)
                        (let ((next-inst (car text)))
                          (if (symbol? next-inst)
                              (receive insts
                                       (cons (make-label-entry next-inst
                                                               insts)
                                             labels))
                              (receive (cons (make-instruction next-inst)
                                             insts)
                                       labels)))))))

(define (update-insts! insts labels machine)
  (let ((pc (get-register machine 'pc))
        (flag (get-register machine 'flag))
        (stack (machine 'stack))
        (ops (machine 'operations)))
    (for-each
      (lambda (inst)
        (set-instruction-execution-proc! 
          inst
          (make-execution-procedure
            (instruction-text inst) labels machine
            pc flag stack ops)))
      insts)))

(define (make-instruction text)
  (list text '() '()))

(define (instruction-text inst)
  (car inst))

(define (instruction-execution-proc inst)
  (cadr inst))

(define (set-instruction-execution-proc! inst proc)
  (set-car! (cdr inst) proc))

(define (instruction-breakpoint inst)
  (caddr inst))

(define (set-instruction-breakpoint! inst breakpoint)
  (set-car! (cddr inst) breakpoint))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define gcd-machine
  (make-machine
    '(a b t)
    (list (list 'rem remainder) (list '= =))
    '(test-b
       (test (op =) (reg b) (const 0))
       (branch (label gcd-done))
       (assign t (op rem) (reg a) (reg b))
       (assign a (reg b))
       (assign b (reg t))
       (goto (label test-b))
       gcd-done)))

(set-register-contents! gcd-machine 'a 206)
(set-register-contents! gcd-machine 'b 40)
(set-breakpoint gcd-machine 'test-b 4)
(set-breakpoint gcd-machine 'test-b 5)

(start gcd-machine)
;break on test-b:4 (assign a (reg b))
;register: t = 6, b = 40, a = 206, 

(get-register-contents gcd-machine 'a)  ; 206
(get-register-contents gcd-machine 'b)  ; 40

(cancel-breakpoint gcd-machine 'test-b 4)
(proceed-machine gcd-machine)
;break on test-b:5 (assign b (reg t))
;register: t = 6, b = 40, a = 40, 

(get-register-contents gcd-machine 'a)  ; 40

(cancel-all-breakpoints gcd-machine)
(proceed-machine gcd-machine)           ; done
(get-register-contents gcd-machine 'a)  ; 2
