#lang racket

;; P137 - [练习 2.82]

(require "ch2support.scm")
 
; 现在我们的策略还不够一般，只能直接转换，不能间接转换。
; 比如 A、B、C 三种类型，A 可以转换成 B (A->B), B 可以转换成 C (B->C)
; A -> B
; A -> C
; 原则上 A 经过中间类型 B, 可以转换成 C。但我们的策略不能处理这种情况。

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

(define (all-the-same? items)
  (cond ((null? items) #t)
        ((= (length items) 1) #t)
        (else (if (equal? (car items) (cadr items))
                  (all-the-same? (cdr items))
                  #f))))

(define (for-each-map ops items)
  (if (null? ops)
      '()
      (cons ((car ops) (car items))
            (for-each-map (cdr ops) (cdr items)))))

(define (map-all-or-false op items)
  (if (null? items)
    '()
    (let ((first-ret (op (car items))))
      (if first-ret
          (let ((second-ret (map-all-or-false op (cdr items))))
            (if second-ret
                (cons first-ret second-ret)
                #f))
          #f))))

;; 查找转换函数，其中某个参数转换不了，就返回 #f
(define (get-coercion-list type-tags to-type)
  (define (identity x) x)
  (map-all-or-false (lambda (type)
                      (if (equal? type to-type)
                          identity
                          (get-coercion type to-type)))
                    type-tags))

;; 转换参数
(define (try-coercion-args type-tags args-list)
  (define (try-single type-tags args-list to-types)
    (if (null? to-types)
        #f
        (let ((coercion-list (get-coercion-list type-tags (car to-types))))
          (if coercion-list
              (for-each-map coercion-list args-list)
              (try-single type-tags args-list (cdr to-types))))))
  
  (if (all-the-same? type-tags)  ;; 如果类型都相同，就转换失败。避免类似练习 2.81 中的不断循环
      #f
      (try-single type-tags args-list type-tags)))
      
(define (apply-generic-list op args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((coercion-args (try-coercion-args type-tags args)))
            (if coercion-args
                (apply-generic-list op coercion-args)
                (error "No method for these types -- APPLY-GENERIC" (list op type-tags))))))))
  
(define (apply-generic op . args)
  (apply-generic-list op args))
          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (add . args) (apply-generic-list 'add args))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-scheme-number-package)
  (define (tag x) (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'add '(scheme-number scheme-number scheme-number)
       (lambda (x y z) (tag (+ x y z))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number
       (lambda (x) (tag x)))
  'done)

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (number x) (car x))
(define (denom x) (cdr x))
  
(define (install-rational-package)
  ;; internal procedures
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
  
  ;; interface to the rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'add '(rational rational rational)
       (lambda (x y z) (tag (add-rat (add-rat x y) z))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'make 'rational
       (lambda (n d) (tag (make-rat n d))))
  'done)

(define (make-rational n d)
  ((get 'make 'rational) n d))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (install-coercion-package)
  (define (rational->scheme-number n)
    (let ((x (contents n)))
      (make-scheme-number (/ (number x) (denom x)))))
  (put-coercion 'rational 'scheme-number rational->scheme-number)
  'done)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(module* main #f
  (install-scheme-number-package)
  (install-rational-package)
  (install-coercion-package)
  
  (define num-a (make-scheme-number 2))
  (define rat-a (make-rational 1 2))
  
  (add num-a num-a)
  (add num-a num-a num-a)
    
  (add rat-a rat-a)
  (add rat-a rat-a rat-a)
  
  (add num-a rat-a)
  (add rat-a num-a)
  (add num-a rat-a num-a)
)
