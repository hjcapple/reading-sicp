#lang racket

;; P137 - [练习 2.84]

(require "ch2support.scm")
(require (submod "complex_number_data_directed.scm" complex-op))
 
;;;;;;;;;;;;;;;;;;;;;;;;
(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))

(define (raise-into x type)
  (let ((x-type (type-tag x)))
    (if (equal? x-type type)
        x
        (let ((x-raise (raise x)))
          (if x-raise
              (raise-into x-raise type)
              #f)))))
        
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (and (= (length args) 2)
                   (not (equal? (car type-tags) (cadr type-tags)))) ; 防止 a1、a2 类型相同时死循环，见[练习 2.81]
              (let ((a1 (car args))
                    (a2 (cadr args)))
                (let ((a1-raise (raise-into a1 (type-tag a2))))
                  (if a1-raise
                      (apply-generic op a1-raise a2)
                      (let ((a2-raise (raise-into a2 (type-tag a1))))
                        (if a2-raise
                            (apply-generic op a1 a2-raise)
                            (error "No method for these types -- APPLY-GENERIC"
                                     (list op type-tags)))))))
              (error "No method for these types -- APPLY-GENERIC"
                     (list op type-tags)))))))

;;;;;;;;;;;;;;;;;;;;;;;;
(define (raise x) 
  (let ((raise-proc (get 'raise (list (type-tag x)))))
    (if raise-proc
        (raise-proc (contents x))
        #f)))

(define (add x y) (apply-generic 'add x y))

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
  (put 'add '(integer integer)
       (lambda (x y) (tag (+ x y))))
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
  (define (add-rat x y)
    (make-rat (+ (* (number x) (denom y))
                 (* (number y) (denom x)))
              (* (denom x) (denom y))))
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))

;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-real-package)
  (define (tag x) (attach-tag 'real x))
  (put 'add '(real real)
       (lambda (x y) (tag (+ x y))))
  (put 'make 'real
       (lambda (x) (tag x)))
  'done)

(define (make-real n)
  ((get 'make 'real) n))

;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-complex-package)
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag '(rectangular)) x y))
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (x y) (tag (add-complex x y))))
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

  ;; 用于测试是否死循环
  ; (apply-generic 'exp int-val)
  ; (apply-generic 'exp int-val int-val)
  
  (add int-val int-val)
  (add rat-val rat-val)
  (add real-val real-val)
  (add complex-val complex-val)
  
  (add int-val complex-val)
  (add complex-val int-val)

  (add int-val real-val)
  (add real-val int-val)
)
