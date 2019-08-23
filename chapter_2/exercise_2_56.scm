#lang racket

;; P102 - [练习 2.56]

(define (deriv exp var)
  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))
  
  (define (deriv-product exp var)
    (make-sum
      (make-product (multiplier exp)
                     (deriv (multiplicand exp) var))
      (make-product (deriv (multiplier exp) var)
                     (multiplicand exp))))
  
  (define (deriv-exponentiation exp var)
    (make-product
      (make-product (exponent exp)
                    (make-exponentiation (base exp) 
                                         (make-sum (exponent exp) -1)))
      (deriv (base exp) var)))
    
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp) (deriv-sum exp var))
        ((product? exp) (deriv-product exp var))
        ((exponentiation? exp) (deriv-exponentiation exp var))
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

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier s) (cadr s))

(define (multiplicand s) (caddr s))

(define (exponentiation? s)
  (and (pair? s) (eq? (car s) '**)))

(define (base s) (cadr s))

(define (exponent s) (caddr s))

;;;;;;;;;;;;;;;;;;;;;]
(deriv '(** x 4) 'x)
(deriv '(** x 4) 'x)
(deriv '(** x y) 'x)
(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)
