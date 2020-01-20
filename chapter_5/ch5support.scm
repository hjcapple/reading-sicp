#lang racket

(provide redefineable redefine)

;; DrReacket 不可以在模块外重新定义函数。而为了测试方便，防止代码重复，有时需要重定义模块的某个函数。
;; 比如 analyzingmceval.scm 装载了 mceval.scm，又想重新实现其 eval 函数。于是用了一种 hack 的手法
;; 见 https://stackoverflow.com/questions/10789160/how-do-i-undefine-in-dr-racket
(define-for-syntax (make-current-name stx id)
  (datum->syntax 
   stx (string->symbol
        (format "current-~a" (syntax-e id)))))

(define-syntax (redefine stx)
  (syntax-case stx ()
    [(_ (name arg ...) body ...)
     (with-syntax ([current-name (make-current-name stx #'name)])
       #'(current-name (lambda (arg ...) body ...)))]))

(define-syntax (redefineable stx)
  (syntax-case stx ()
    [(_ name)
     (with-syntax ([current-name (make-current-name stx #'name)])
       #'(begin
           (define current-name (make-parameter (λ x (error 'undefined))))
           (define (name . xs)
             (apply (current-name) xs))))]))

