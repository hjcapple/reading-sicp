#lang sicp

;; P421 - [练习 5.38]

(#%require "ch5support.scm")
(#%require "ch5-compiler.scm")

(redefine (compile exp target linkage)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage))
        ((if? exp) (compile-if exp target linkage))
        ((lambda? exp) (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp)
                           target
                           linkage))
        ((cond? exp) (compile (cond->if exp) target linkage))
        ((open-code? exp) (compile-open-code exp target linkage))
        ((application? exp)
         (compile-application exp target linkage))
        (else
          (error "Unknown expression type -- COMPILE" exp))))

(define (open-code? exp)
  (and (pair? exp)
       (memq (operator exp) '(+ * - =))))

; a)
(define (spread-arguments operands)
  (let ((operand-code1 (compile (car operands) 'arg1 'next))
        (operand-code2 (compile (cadr operands) 'arg2 'next)))
    (preserving '(env arg1)
      operand-code1
      operand-code2)))

; b) 所有的基本过程 =、*、-、+ 都可共用这个函数。只处理两个参数。
(define (compile-open-code-two-args exp target linkage)
  (preserving '(env continue)
    (spread-arguments (operands exp))
    (end-with-linkage linkage
      (make-instruction-sequence '(arg1 arg2) (list target)
        `((assign ,target (op ,(operator exp)) (reg arg1) (reg arg2)))))))

; d) 
; 可处理多个参数, 主要为了 + *。比如 (+ 1 2 3 4) 会编译成
; ((assign arg1 (const 1))
;  (assign arg2 (const 2))
;  (assign arg1 (op +) (reg arg1) (reg arg2))
;  (assign arg2 (const 3))
;  (assign arg1 (op +) (reg arg1) (reg arg2))
;  (assign arg2 (const 4))
;  (assign val (op +) (reg arg1) (reg arg2)))
; 可重复使用 arg1 寄存器
(define (compile-open-code-many-args exp target linkage)
  (let ((proc (operator exp))
      (first-operand (car (operands exp)))
      (rest-operands (cdr (operands exp))))
    (preserving '(env continue)
      (compile first-operand 'arg1 'next)
      (compile-open-coded-rest-args proc rest-operands target linkage))))

(define (compile-open-coded-rest-args proc operands target linkage)
  (if (null? (cdr operands))
      (preserving '(arg1 continue)
        (compile (car operands) 'arg2 'next)
        (end-with-linkage linkage
          (make-instruction-sequence '(arg1 arg2) (list target)
            `((assign ,target (op ,proc) (reg arg1) (reg arg2))))))
      (preserving '(env continue)
        (preserving '(arg1)
          (compile (car operands) 'arg2 'next)
          (make-instruction-sequence '(arg1 arg2) '(arg1)
            `((assign arg1 (op ,proc) (reg arg1) (reg arg2)))))
        (compile-open-coded-rest-args proc (cdr operands) target linkage))))
  
(define (compile-open-code exp target linkage)
  (if (memq (operator exp) '(+ *))
      (compile-open-code-many-args exp target linkage)
      (compile-open-code-two-args exp target linkage)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; c) 
(#%require (only racket pretty-print))
(pretty-print (compile
                '(define (factorial n)
                   (if (= n 1)
                       1
                       (* (factorial (- n 1)) n)))
                'val
                'next))

(pretty-print (compile
                '(begin
                   (+ 1 2 3 4)
                   (* x (f x) y (+ 1 2)))
                'val
                'next))
