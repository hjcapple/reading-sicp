#lang sicp

;; P373 - [练习 5.18]

(#%require "ch5support.scm")
(#%require "ch5-regsim.scm")

(redefine (make-register name)
  (let ((contents '*unassigned*)
        (trace? false))
    (define (set value)
      (cond (trace?
              (display name)
              (display ": ")
              (display contents)
              (display " -> ")
              (display value)
              (newline)))
      (set! contents value))
    
    (define (dispatch message)
      (cond ((eq? message 'trace-on) (set! trace? true))
            ((eq? message 'trace-off) (set! trace? false))
            ((eq? message 'get) contents)
            ((eq? message 'set) set)
            (else
              (error "Unknown request -- REGISTER" message))))
    dispatch))

(define (trace-on-register! machine reg-name)
  ((get-register machine reg-name) 'trace-on))

(define (trace-off-register! machine reg-name)
  ((get-register machine reg-name) 'trace-off))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define fact-machine
  (make-machine
    '(continue n val)
    (list (list '= =) (list '- -) (list '* *))
    '(
      (assign continue (label fact-done))     ; set up final return address
      fact-loop
      (test (op =) (reg n) (const 1))
      (branch (label base-case))
      ;; Set up for the recursive call by saving n and continue.
      ;; Set up continue so that the computation will continue
      ;; at after-fact when the subroutine returns.
      (save continue)
      (save n)
      (assign n (op -) (reg n) (const 1))
      (assign continue (label after-fact))
      (goto (label fact-loop))
      after-fact
      (restore n)
      (restore continue)
      (assign val (op *) (reg n) (reg val))   ; val now contains n(n - 1)!
      (goto (reg continue))                   ; return to caller
      base-case
      (assign val (const 1))                  ; base case: 1! = 1
      (goto (reg continue))                   ; return to caller
      fact-done
      )))

(set-register-contents! fact-machine 'n 10)
(trace-on-register! fact-machine 'n)
(trace-on-register! fact-machine 'val)
(start fact-machine)
(get-register-contents fact-machine 'val)

