#lang sicp

;; P420 - [练习 5.34]

(#%require "ch5-compiler.scm")

(compile
  '(define (factorial n)
     (define (iter product counter)
       (if (> counter n)
           product
           (iter (* counter product)
                 (+ counter 1))))
     (iter 1))
  'val
  'next)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define compiled-code
  '(
    ; 定义 factorial 过程
    ((assign val (op make-compiled-procedure) (label entry1) (reg env))
     (goto (label after-lambda2))
     
     ;; factorial 入口
   entry1
     (assign env (op compiled-procedure-env) (reg proc))
     (assign env (op extend-environment) (const (n)) (reg argl) (reg env))
     
     ; 定义 iter 过程
     (assign val (op make-compiled-procedure) (label entry3) (reg env))
     (goto (label after-lambda4))
      
     ; iter 入口
   entry3
     (assign env (op compiled-procedure-env) (reg proc))
     (assign env (op extend-environment) (const (product counter)) (reg argl) (reg env))
     
     (save continue)
     (save env)
     
     ; (> counter n)
     (assign proc (op lookup-variable-value) (const >) (reg env))
     (assign val (op lookup-variable-value) (const n) (reg env))
     (assign argl (op list) (reg val))
     (assign val (op lookup-variable-value) (const counter) (reg env))
     (assign argl (op cons) (reg val) (reg argl))
     (test (op primitive-procedure?) (reg proc))
     (branch (label primitive-branch8))
   compiled-branch9
     (assign continue (label after-call10))
     (assign val (op compiled-procedure-entry) (reg proc))
     (goto (reg val))
   primitive-branch8
     (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
   after-call10
     (restore env)
     (restore continue)
     
     ; 判断 (if (> counter n)
     (test (op false?) (reg val))
     (branch (label false-branch6))
     
   true-branch5
     ; product
     (assign val (op lookup-variable-value) (const product) (reg env))
     (goto (reg continue))
     
   false-branch6
      ; 查找 iter 运算符
     (assign proc (op lookup-variable-value) (const iter) (reg env))
     (save continue)
     
     (save proc)
     (save env)
     
     ; (+ counter 1)
     (assign proc (op lookup-variable-value) (const +) (reg env))
     (assign val (const 1))
     (assign argl (op list) (reg val))
     (assign val (op lookup-variable-value) (const counter) (reg env))
     (assign argl (op cons) (reg val) (reg argl))
     (test (op primitive-procedure?) (reg proc))
     (branch (label primitive-branch14))
   compiled-branch15
     (assign continue (label after-call16))
     (assign val (op compiled-procedure-entry) (reg proc))
     (goto (reg val))
   primitive-branch14
     (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
   after-call16
   
     ; argl 收集第一个参数
     (assign argl (op list) (reg val))
     (restore env)
     (save argl)
     
     ; (* counter product)
     (assign proc (op lookup-variable-value) (const *) (reg env))
     (assign val (op lookup-variable-value) (const product) (reg env))
     (assign argl (op list) (reg val))
     (assign val (op lookup-variable-value) (const counter) (reg env))
     (assign argl (op cons) (reg val) (reg argl))
     (test (op primitive-procedure?) (reg proc))
     (branch (label primitive-branch11))
   compiled-branch12
     (assign continue (label after-call13))
     (assign val (op compiled-procedure-entry) (reg proc))
     (goto (reg val))
   primitive-branch11
     (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
   after-call13
     (restore argl)
     
     ; argl 收集第二个参数
     (assign argl (op cons) (reg val) (reg argl))
     (restore proc)
     (restore continue)
     
     ; 尾递归调用 (iter (* counter product) (+ counter 1))))，
     ; 注意这里设置好 proc 和 argl 后，直接跳转，并不用将寄存器保存到堆栈中。
     ; 堆栈只使用常量空间
     (test (op primitive-procedure?) (reg proc))
     (branch (label primitive-branch17))
   compiled-branch18
     (assign val (op compiled-procedure-entry) (reg proc))
     (goto (reg val))
   primitive-branch17
     (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
     (goto (reg continue))
   after-call19
   after-if7
     
   after-lambda4
      ; (define (iter xx)) 的最后，设置名字
     (perform (op define-variable!) (const iter) (reg val) (reg env))
     (assign val (const ok))
     
     ; 调用 (iter 1)
     (assign proc (op lookup-variable-value) (const iter) (reg env))
     (assign val (const 1))
     (assign argl (op list) (reg val))
     (assign val (const 1))
     (assign argl (op cons) (reg val) (reg argl))
     (test (op primitive-procedure?) (reg proc))
     (branch (label primitive-branch20))
   compiled-branch21
     (assign val (op compiled-procedure-entry) (reg proc))
     (goto (reg val))
   primitive-branch20
     (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
     (goto (reg continue))
     after-call22
     
   after-lambda2
      ; (define (factorial xx)) 的最后，设置名字
     (perform (op define-variable!) (const factorial) (reg val) (reg env))
     (assign val (const ok)))))
