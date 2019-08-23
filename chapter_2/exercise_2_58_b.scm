#lang racket

;; P102 - [练习 2.58 - b]

;; 这道题主要是要解决加法和乘法的二义性问题。比如 (x + y * z) 
;; 可以解释成 (x + y) * z 也可以解释成 x + (y * z)
;; 这里使用最简单的方案，先在列表中用 memq 查找 + 号，找到就是加法。假如找不到 + 号就再找 *, 找到就是乘法。
;; 找到 + 符号后，就可以根据 + 号将列表分为两截。于是 (x + y * z) ，就可以看成是 (x + (y * z))
;; 这种方案是最简单的，deriv 函数不用修改。其实更正规的方法是将中缀表达式转为前缀表达式。

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        (else
          (error "unknown expression type -- DERIV" exp))))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2) (+ a1 a2)))
        (else (list a1 '+ a2))))
  
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2) (* m1 m2)))
        (else (list m1 '* m2))))

(define (find-operation s)
  (cond ((memq '+ s) '+)
        ((memq '* s) '*)
        (else 'unknown)))

(define (take-until stop-symbol lst)
  (cond ((null? lst) null)
        ((equal? (car lst) stop-symbol) null)
        (else (cons (car lst) (take-until stop-symbol (cdr lst))))))

;; 去掉多余的括号。比如 (a) 会简化为 a。(a + b) 仍然是 (a + b)
(define (simplify lst)
  (if (and (pair? lst) (= (length lst) 1))
    (simplify (car lst))
    lst))
  
(define (sum? x)
  (and (pair? x) (eq? (find-operation x) '+)))

;; 取出 + 号前面部分
(define (addend s) 
  (simplify (take-until '+ s)))

;; 取出 + 号后面部分
(define (augend s)
  (simplify (cdr (memq '+ s))))

(define (product? x)
  (and (pair? x) (eq? (find-operation x) '*)))

;; 取出 * 号前面部分
(define (multiplier s) 
  (simplify (take-until '* s)))

;; 取出 * 号后面部分
(define (multiplicand s)
  (simplify (cdr (memq '* s))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deriv '(x + (3 * (x + (y + 2)))) 'x)
(deriv '(x + 3 * (x + y + 2)) 'x)

