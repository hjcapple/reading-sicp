#lang sicp 

;; P360 - [练习 5.7]

(#%require "ch5-regsim.scm")

(define expt-machine
  (make-machine
    '(val b n continue)
    (list (list '- -) (list '= =) (list '* *))
    '(
      (assign continue (label expt-done))
      expt-loop
      (test (op =) (reg n) (const 0))
      (branch (label base-case))
      
      (save continue)
      (assign n (op -) (reg n) (const 1))
      (assign continue (label after-expt))
      (goto (label expt-loop))
      
      after-expt
      (restore continue)
      (assign val (op *) (reg b) (reg val))
      (goto (reg continue))
      
      base-case
      (assign val (const 1))
      (goto (reg continue))  
      expt-done
      )))

(set-register-contents! expt-machine 'b 2)
(set-register-contents! expt-machine 'n 10)
(start expt-machine)
(get-register-contents expt-machine 'val) ;; 1024

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define expt-machine-2
  (make-machine
    '(product b n continue)
    (list (list '- -) (list '= =) (list '* *))
    '(
      (assign product (const 1))
      
      expt-loop  
      (test (op =) (reg n) (const 0))
      (branch (label expt-done))
      
      (assign product (op *) (reg b) (reg product))
      (assign n (op -) (reg n) (const 1))
      (goto (label expt-loop))
      expt-done
      )))

(set-register-contents! expt-machine-2 'b 2)
(set-register-contents! expt-machine-2 'n 10)
(start expt-machine-2)
(get-register-contents expt-machine-2 'product) ;; 1024
