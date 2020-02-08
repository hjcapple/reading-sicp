#lang sicp

;; P429 - [练习 5.46], 专用 fib 机器

(#%require "ch5-regsim.scm")

(define fib-machine
  (make-machine
    '(continue n val)
    (list (list '< <)
          (list '- -)
          (list '+ +)
          )
    '(
      (perform (op initialize-stack))
      (assign continue (label fib-done))
    fib-loop
      (test (op <) (reg n) (const 2))
      (branch (label immediate-answer))
      ;; set up to compute Fib(n - 1)
      (save continue)
      (assign continue (label afterfib-n-1))
      (save n)                           ; save old value of n
      (assign n (op -) (reg n) (const 1)); clobber n to n - 1
      (goto (label fib-loop))            ; perform recursive call
    afterfib-n-1                         ; upon return, val contains Fib(n - 1)
      (restore n)
      (restore continue)
      ;; set up to compute Fib(n - 2)
      (assign n (op -) (reg n) (const 2))
      (save continue)
      (assign continue (label afterfib-n-2))
      (save val)                         ; save Fib(n - 1)
      (goto (label fib-loop))
    afterfib-n-2                         ; upon return, val contains Fib(n - 2)
      (assign n (reg val))               ; n now contains Fib(n - 2)
      (restore val)                      ; val now contains Fib(n - 1)
      (restore continue)
      (assign val                        ;  Fib(n - 1) +  Fib(n - 2)
              (op +) (reg val) (reg n)) 
      (goto (reg continue))              ; return to caller, answer is in val
    immediate-answer
      (assign val (reg n))               ; base case:  Fib(n) = n
      (goto (reg continue))
    fib-done
      (perform (op print-stack-statistics))
      )))

(define (loop start end f)
  (cond ((<= start end) 
         (f start)
         (loop (+ start 1) end f))))

(loop 2 10 (lambda (n)
             (newline)
             (display "n: ")
             (display n)
             (set-register-contents! fib-machine 'n n)
             (start fib-machine)
             (get-register-contents fib-machine 'val)
             ))
