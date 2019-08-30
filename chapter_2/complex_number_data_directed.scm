#lang racket

;; P122 - [2.4.3 数据导向的程序设计和可加性]

;; 可加性, 英文为 Additivity，指让程序更容易地，逐渐添加新的功能模块，而又不影响(或影响轻微)原有的功能。
;; 简单地说，就是让程序更容易修改，再原有的基础上添加新功能。
;; 数据导向的设计方法就相对容易修改。而前面的显式分派风格，每次假如新类型或者新操作都很麻烦，就难以修改。
;; 见 [练习 2.76] 的讨论。

(require "ch2support.scm")

(module* complex-op #f
  (provide install-polar-package install-rectangular-package)
  (provide real-part imag-part magnitude angle)
)

(module* data-directed #f
  (provide attach-tag type-tag contents apply-generic)
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error "No method for these types -- APPLY-GENERIC"
                 (list op type-tags))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
                       (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
                       (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))

(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (magnitude z)
    (sqrt (+ (square (real-part z)) (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-real-imag x y) (cons x y))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
  
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle     '(rectangular) angle)
  (put 'make-from-real-imag '(rectangular)
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang '(rectangular)
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (install-polar-package)
  ;; internal procedures
  (define (real-part z)
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))
  (define (make-from-mag-ang r a) (cons r a))
  
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'polar x))
  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle     '(polar) angle)
  (put 'make-from-real-imag '(polar)
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang '(polar)
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z)     (apply-generic 'angle z))

(define (make-from-real-imag x y)
  ((get 'make-from-real-imag '(rectangular)) x y))

(define (make-from-mag-ang r a)
  ((get 'make-from-mag-ang '(polar)) r a))

;;;;;;;;;;;;;;;;;;;
(module* main #f
  (install-polar-package)
  (install-rectangular-package)

  (define a (make-from-real-imag 10 20))
  (define b (make-from-real-imag 1 2))
  (define c (make-from-mag-ang (magnitude a) (angle a)))
  (define d (make-from-mag-ang (magnitude b) (angle b)))

  (add-complex a b)
  (sub-complex a b)
  (mul-complex a b)
  (div-complex a b)

  (add-complex c d)
  (sub-complex c d)
  (mul-complex c d)
  (div-complex c d)
)
