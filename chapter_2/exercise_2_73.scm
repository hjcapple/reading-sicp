#lang racket

;; P125 - [练习 2.73]

;;;;;;;;;;
;; put get 简单实现
(define *op-table* (make-hash))

(define (put op type proc)
  (hash-set! *op-table* (list op type) proc))

(define (get op type)
  (hash-ref *op-table* (list op type) #f))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a) 
; 原始表达式为 (+ a1 a2) 或 (* a1 a2) 因此 (car exp) 用于取出公式的运算符，(cdr exp) 用于取出公式的参数。
; 于是 deriv 的实现中，使用运算符作为分派依据，将相应参数传到对应的求导公式中。
; number? 和 variable? 没有使用数据导向，主要原因是数字和变量没有对应的运算符。而我们是以运算符作为分发依据的，
; 没有运算符，就不能分发了。假如一定要写成数据导向，就需要为其添加运算符。
; 比如数字写成 '(num 10)，变量写成 '(var x)，但这样实现的话。
; 原来的公式 '(+ x 3)，就需要写成 '(+ (var x) (num 3)。反而将事情弄复杂了。

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp) var))))

; b)、c)
; 这里为了测试 deriv-2 和 install-deriv-package-2 更方便些。将一些函数写在外面。
; 实际上，可以将 deriv-sum、deriv-product 等函数放在 install-deriv-package 内部，避免污染名字空间。
; 或者每个求导公式拆开，写成 install-deriv-sum-package、install-deriv-product-package 等多个安装函数。

(define (install-deriv-package)  
  (put 'deriv '+  deriv-sum)
  (put 'deriv '*  deriv-product)
  (put 'deriv '** deriv-exponentiation)
  'done)

;; d) 
;; 只需要在 put 中，将第一个和第二个参数互换。

(define (deriv-2 exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get (operator exp) 'deriv) (operands exp) var))))

(define (install-deriv-package-2)  
  (put '+  'deriv deriv-sum)
  (put '*  'deriv deriv-product)
  (put '** 'deriv deriv-exponentiation)
  'done)

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (deriv-sum args var)
  (define (addend s) (car s))
  (define (augend s) (cadr s))
  (make-sum (deriv (addend args) var)
            (deriv (augend args) var)))

(define (deriv-product args var)
  (define (multiplier s) (car s))
  (define (multiplicand s) (cadr s))
  (make-sum
    (make-product (multiplier args)
                   (deriv (multiplicand args) var))
    (make-product (deriv (multiplier args) var)
                   (multiplicand args))))

(define (deriv-exponentiation args var)
  (define (base s) (car s))
  (define (exponent s) (cadr s))
  (make-product
    (make-product (exponent args)
                  (make-exponentiation (base args) 
                                       (make-sum (exponent args) -1)))
    (deriv (base args) var)))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2) (+ a1 a2)))
        (else (list '+ a1 a2))))
  
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2) (* m1 m2)))
        (else (list '* m1 m2))))

(define (make-exponentiation b e)
  (cond ((=number? e 0) 1)
        ((=number? e 1) b)
        (else (list '** b e))))

;;;;;;;;;;;;;;;;;;;;;;
(install-deriv-package)
(deriv '(** x 4) 'x)
(deriv '(** x y) 'x)
(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)

(newline)

(install-deriv-package-2)
(deriv-2 '(** x 4) 'x)
(deriv-2 '(** x y) 'x)
(deriv-2 '(+ x 3) 'x)
(deriv-2 '(* x y) 'x)
(deriv-2 '(* (* x y) (+ x 3)) 'x)
