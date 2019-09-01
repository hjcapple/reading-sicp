#lang racket

;; P137 - [练习 2.83]

(require "ch2support.scm")
(require (submod "complex_number_data_directed.scm" complex-op))
(require (submod "complex_number_data_directed.scm" data-directed))
 
;;;;;;;;;;;;;;;;;;;;;;;;
(define (raise x) 
  (let ((raise-proc (get 'raise (list (type-tag x)))))
    (if raise-proc
        (raise-proc (contents x))
        #f)))

(define (install-raise-package)
  (put 'raise '(integer)
       (lambda (x) (make-rational x 1)))
  (put 'raise '(rational)
       (lambda (x) (make-real (/ (number x) (denom x)))))
  (put 'raise '(real)
       (lambda (x) (make-complex-from-real-imag x 0)))
  'done)

;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-integer-package)
  (define (tag x) (attach-tag 'integer x))
  (put 'make 'integer
       (lambda (x) (tag x)))
  'done)

(define (make-integer n)
  ((get 'make 'integer) n))

;;;;;;;;;;;;;;;;;;;;;;;;;
(define (number x) (car x))
(define (denom x) (cdr x))
  
(define (install-rational-package)
  (define (make-rat n d) 
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (tag x) (attach-tag 'rational x))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))

;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-real-package)
  (define (tag x) (attach-tag 'real x))
  (put 'make 'real
       (lambda (x) (tag x)))
  'done)

(define (make-real n)
  ((get 'make 'real) n))

;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-complex-package)
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag '(rectangular)) x y))
  (define (tag z) (attach-tag 'complex z))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  'done)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(module* main #f
  (install-rectangular-package)
  (install-integer-package)
  (install-rational-package)
  (install-real-package)
  (install-complex-package)
  (install-raise-package)
  
  (define int-val (make-integer 10))
  (define rat-val (make-rational 1 2))
  (define real-val (make-real 3.14))
  (define complex-val (make-complex-from-real-imag 10 20))
  
  (raise int-val)
  (raise rat-val)
  (raise real-val)
  (raise complex-val)
)
