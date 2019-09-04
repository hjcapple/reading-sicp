#lang racket

;; P137 - [练习 2.86]

(require "ch2support.scm")
(require (submod "complex_number_data_directed.scm" complex-op))

;;;;;;;;;;;;;;;;;;;;;;;;
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) (apply-generic 'equ? x y))
(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))
 
;;;;;;;;;;;;;;;;;;;;;;;;
; [见练习 2.78]
(define (attach-tag type-tag contents)
  (if (number? contents)
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (if (number? datum)
      'scheme-number
      (if (pair? datum)
          (car datum)
          (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (if (number? datum)
      datum
      (if (pair? datum)
          (cdr datum)
          (error "Bad tagged datum -- CONTENTS" datum))))

; [见练习 2.84]
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
          (drop (apply proc (map contents args)))
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

(define (project x)
  (let ((proc (get 'project (list (type-tag x)))))
    (if proc
        (proc (contents x))
        #f)))

(define (rational->integer? rat)
  (if (equal? 'rational (type-tag rat))
    (let ((v (/ (number (contents rat)) (denom (contents rat)))))
      (if (integer? v)
          v 
          #f))
    #f))

(define (drop x)
  (if (pair? x) ; 过滤 #t、#f 等没有 type-tag 的参数
      (let ((v (rational->integer? x)))
        (if v
            v
            (let ((x-project (project x)))
              (if (and x-project
                       (equ? (raise x-project) x))
                  (drop x-project)
                  x))))
      x))

(define (install-raise-package)
  (put 'raise '(rational)
       (lambda (x) (make-scheme-number (/ (number x) (denom x)))))
  (put 'raise '(scheme-number)
      (lambda (x) (make-complex-from-real-imag x 0)))
  'done)

(define (install-project-package)
  (define (real->rational x)
    (let ((rat (rationalize (inexact->exact x) 1/100)))
      (make-rational (numerator rat) (denominator rat))))
  (put 'project '(scheme-number) real->rational)
  (put 'project '(complex)
       (lambda (x) (make-scheme-number (real-part x))))
  'done)

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
  (define (sub-rat x y)
    (make-rat (- (* (number x) (denom y))
                 (* (number y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (number x) (number y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (number x) (denom y))
              (* (denom x) (number y))))
  (define (equal-rat? x y)
    (=  (* (number x) (denom y))
        (* (number y) (denom x))))
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'equ? '(rational rational)
       (lambda (x y) (equal-rat? x y)))
  (put 'sine '(rational)
       (lambda (x) (make-scheme-number (sin (/ (number x) (denom x))))))
  (put 'cosine '(rational)
       (lambda (x) (make-scheme-number (cos (/ (number x) (denom x))))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))

;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-scheme-number-package)
  (define (tag x)
    (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'equ? '(scheme-number scheme-number)
       (lambda (x y) (= x y)))
  (put 'sine '(scheme-number)
       (lambda (x) (tag (sin x))))
  (put 'cosine '(scheme-number)
       (lambda (x) (tag (cos x))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  'done)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-complex-package)
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag '(rectangular)) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang '(polar)) r a))
  (define (add-complex z1 z2)
    (make-from-real-imag (add (real-part z1) (real-part z2))
                         (add (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (sub (real-part z1) (real-part z2))
                         (sub (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (mul (magnitude z1) (magnitude z2))
                       (add (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (div (magnitude z1) (magnitude z2))
                       (sub (angle z1) (angle z2))))
  
  (define (equ-complex? z1 z2)
    (and (equ? (real-part z1) (real-part z2))
         (equ? (imag-part z1) (imag-part z2))))
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (x y) (tag (add-complex x y))))
  (put 'sub '(complex complex)
       (lambda (x y) (tag (sub-complex x y))))
  (put 'mul '(complex complex)
       (lambda (x y) (tag (mul-complex x y))))
  (put 'div '(complex complex)
       (lambda (x y) (tag (div-complex x y))))
  (put 'equ? '(complex complex)
       (lambda (x y) (equ-complex? x y)))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))
  
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))

;;;;;;;;;;;;;;;;;;;;;;;;;
(module* main #f
  (install-rectangular-package)
  (install-polar-package)
  (install-rational-package)
  (install-scheme-number-package)
  (install-complex-package)
  (install-raise-package)
  (install-project-package)
  
  (define complex-val (make-complex-from-real-imag (make-rational 1 2) (make-rational 1 2)))
  (define complex-val-2 (make-complex-from-real-imag (make-rational 1 2) -0.5))
  (add complex-val complex-val-2) ; 1
  (sub complex-val complex-val-2) ; '(complex rectangular 0 . 1.0)
  
  (add (make-rational 1 2) 0.5)   ; 1.0
  
  (sine 0.5)                      ; 0.479425538604203
  (cosine 0.5)                    ; 0.8775825618903728
  
  (sine (make-rational 1 2))      ; 0.479425538604203
  (cosine (make-rational 1 2))    ; 0.8775825618903728
)

