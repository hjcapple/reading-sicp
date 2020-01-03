#lang racket

(provide get put)
(provide redefineable redefine)
(provide prime?)
(provide permutations)

;; put get 简单实现
(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) #f))

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


;; P33 - 1.2.6 实例： 素数检测, [寻找因子]
(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))


;; P82 - [嵌套映射]
(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (remove item lst)
  (filter (lambda (x) (not (eq? x item)))
          lst))

(define (permutations s)
  (if (null? s)
      (list null)
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (remove x s))))
               s)))


