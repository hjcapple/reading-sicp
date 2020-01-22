#lang sicp

;; P378 - [练习 5.22]

;; 将练习 3.12 的代码，转换成寄存器机器
(#%require "ch5-regsim.scm")

(define (append x y)
  (if (null? x)
      y 
      (cons (car x) (append (cdr x) y))))

(define append-machine
  (make-machine
    '(x y result continue)
    (list (list 'null? null?)
          (list 'car car) 
          (list 'cdr cdr) 
          (list 'cons cons))
    '(
      (assign continue (label append-done))
    append-loop
      (test (op null?) (reg x))
      (branch (label null-x))
      
      (save continue)
      (save x)
      
      (assign continue (label after-append-cdr))
      (assign x (op cdr) (reg x))
      (goto (label append-loop))
      
    after-append-cdr
      (restore x)
      (restore continue)
      (assign x (op car) (reg x))
      (assign result (op cons) (reg x) (reg result))
      (goto (reg continue))
      
    null-x
      (assign result (reg y))
      (goto (reg continue))
      
    append-done
      )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
      x 
      (last-pair (cdr x))))

(define append!-machine
  (make-machine
    '(x y result cdr-x iter-x)
    (list (list 'null? null?)
          (list 'cdr cdr) 
          (list 'set-cdr! set-cdr!))
    '(
      (assign iter-x (reg x))
      
    loop
      (assign cdr-x (op cdr) (reg iter-x))
      (test (op null?) (reg cdr-x))
      (branch (label do-append))
      
      (assign iter-x (reg cdr-x))
      (goto (label loop))
      
    do-append
      (perform (op set-cdr!) (reg iter-x) (reg y))
      (assign result (reg x))
      )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define x (list 'a 'b))
(define y (list 'c 'd))

;; (define z (append x y))
(set-register-contents! append-machine 'x x)
(set-register-contents! append-machine 'y y)
(start append-machine)
(define z (get-register-contents append-machine 'result))

z         ; (a b c d)
(cdr x)   ; (b)

;; (define w (append! x y))
(set-register-contents! append!-machine 'x x)
(set-register-contents! append!-machine 'y y)
(start append!-machine)
(define w (get-register-contents append!-machine 'result))

w         ; (a b c d)
(cdr x)   ; (b c d)

