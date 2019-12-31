#lang sicp

;; P286 - [练习 4.34]

(#%require "ch4support.scm")
(#%require "lazyeval.scm")

;; cons 使用了 *lazy-cons-m* 这个特别的名字，用于作为标记
(define (install-lazy-cons)
  (actual-value '(begin 
                   (define (cons x y) (lambda (*lazy-cons-m*) (*lazy-cons-m* x y)))
                   (define (car z) (z (lambda (p q) p)))
                   (define (cdr z) (z (lambda (p q) q))))
                the-global-environment))

(define (lazy-cons? p)
  (and (compound-procedure? p)
       (pair? (procedure-parameters p))
       (eq? (car (procedure-parameters p)) '*lazy-cons-m*)))

;; 假如列表元素太多，会用 ... 省略后面的。
;; 比如 (define ones (cons 1 ones)) ones，会打印出 (1 1 1 1 1 1 1 1 1 1 1 ...)
(define (lazy-cons-print object level)
  (if (> level 10) 
      (display "...") 
      (let* ((env (procedure-environment object)) 
             (first (force-it (lookup-variable-value 'x env)))
             (rest (force-it (lookup-variable-value 'y env))))
        (user-print first)
        (cond ((lazy-cons? rest) 
               (display " ")
               (lazy-cons-print rest (+ level 1)))
              ((not (null? rest)) 
               (display " . ")
               (user-print rest))))))

(define (user-print object)
  (if (compound-procedure? object)
      (if (lazy-cons? object)
          (begin
            (display "(")
            (lazy-cons-print object 0)
            (display ")")
            )
          (display (list 'compound-procedure
                         (procedure-parameters object)
                         (procedure-body object)
                         '<procedure-env>)))
      (display object)))

(define (driver-loop)
  (install-lazy-cons)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output
            (actual-value input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(#%require (only racket module*))
(module* main #f     
  (driver-loop)
  'LAZY-EVALUATOR-LOADED
)
