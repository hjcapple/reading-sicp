#lang racket

;; P143 - [练习 2.91]

; 有个小细节，不能让 div-poly 同时返回商式和余式。因为 div-terms 的实现中，使用了
; 通用函数 div。要让 div-poly 安装到通用函数中，div-terms 处理递归 coeff 嵌套的情况。
; div-poly 也需要根据 div 的原始定义，只返回一个商式。
; 为此将除法相关运算，拆分成三个函数
; * div-poly, 返回商式。
; * rem-poly, 返回余式。
; * div-rem-poly, 同时返回商式和余式。

(require "ch2support.scm")

;; 为避免引入过多代码，数字和多项式特殊处理
(define (attach-tag type-tag contents)
  (if (or (number? contents) (polynomial? contents))
      contents
      (cons type-tag contents)))
  
(define (contents datum)
  (if (or (number? datum) (polynomial? datum))
      datum
      (cdr datum)))
  
(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
        ((polynomial? datum) 'polynomial)
        (else (car datum))))
        
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error "No method for these types -- APPLY-GENERIC"
                 (list op type-tags))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (rem x y) (apply-generic 'rem x y))
(define (neg x)   (apply-generic 'neg x))
(define (=zero? x) (apply-generic '=zero? x))

(define (install-scheme-number-package)
  (define (tag-2-args op)
    (lambda (x y) (attach-tag 'scheme-number (op x y))))
  (define (tag x) (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number) (tag-2-args +))
  (put 'sub '(scheme-number scheme-number) (tag-2-args -))
  (put 'mul '(scheme-number scheme-number) (tag-2-args *))
  (put 'div '(scheme-number scheme-number) (tag-2-args /))
  (put 'rem '(scheme-number scheme-number) (tag-2-args remainder))
  (put 'neg '(scheme-number) (lambda (x) (tag (- x))))
  (put '=zero? '(scheme-number) (lambda (x) (= x 0)))
  )

(define (install-polynomial-package)
  (define (number->poly variable n)
    (make-poly variable (adjoin-term (make-term 0 n) (the-empty-termlist))))
  (define (tag x) (attach-tag 'polynomial x))
  (define (put-op name op)
    (put name '(polynomial polynomial)
         (lambda (x y) (tag (op x y))))
    (put name '(polynomial scheme-number)
         (lambda (x y) (tag (op x (number->poly (variable x) y)))))
    (put name '(scheme-number polynomial)
         (lambda (x y) (tag (op (number->poly (variable y) x) y)))))
  (put-op 'add add-poly)
  (put-op 'mul mul-poly)
  (put-op 'sub sub-poly)
  (put-op 'div div-poly)
  (put-op 'rem rem-poly)
  (put 'neg '(polynomial) (lambda (x) (tag (neg-poly x))))
  (put '=zero? '(polynomial) =zero-poly?)
  )
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (same-variable? v1 v2)
  (define (variable? x) (symbol? x))
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (polynomial? p)
  (and (pair? p) 
       (eq? (car p) 'polynomial)))

(define (make-poly variable term-list)
  (cons 'polynomial (cons variable term-list)))

(define (variable p) (car (cdr p)))
(define (term-list p) (cdr (cdr p)))

(define (add-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (add-terms (term-list p1) (term-list p2)))
      (error "Polys not in same var -- ADD-POLY" (list p1 p2))))

(define (sub-poly p1 p2)
  (add-poly p1 (neg p2)))

(define (mul-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (mul-terms (term-list p1) (term-list p2)))
      (error "Polys not in same var -- MUL-POLY" (list p1 p2))))

(define (div-rem-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (let ((result (div-terms (term-list p1) (term-list p2))))
        (list (make-poly (variable p1) (car result))
              (make-poly (variable p1) (cadr result))))
      (error "Polys not in same var -- MUL-POLY" (list p1 p2))))

(define (div-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (car (div-terms (term-list p1) (term-list p2))))
      (error "Polys not in same var -- DIV-POLY" (list p1 p2))))

(define (rem-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (cadr (div-terms (term-list p1) (term-list p2))))
      (error "Polys not in same var -- REM-POLY" (list p1 p2))))

(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))
              (if (=zero? new-c)  ;; 需要判断商为 0 的情况(coeff也为多项式时可能出现),不然会无限循环
                  (list (the-empty-termlist) L1)
                  (let ((new-t (make-term new-o new-c)))
                    (let ((new-L1 (sub-terms L1 (mul-term-by-all-terms new-t L2))))
                      (let ((rest-of-result (div-terms new-L1 L2)))
                        (list (adjoin-term new-t (car rest-of-result))
                              (cadr rest-of-result)))))))))))
                    
(define (add-terms L1 L2)
  (cond ((empty-termlist? L1) L2)
        ((empty-termlist? L2) L1)
        (else 
          (let ((t1 (first-term L1))
                (t2 (first-term L2)))
            (cond ((> (order t1) (order t2))
                   (adjoin-term t1 (add-terms (rest-terms L1) L2)))
                  ((< (order t1) (order t2))
                   (adjoin-term t2 (add-terms L1 (rest-terms L2))))
                  (else
                    (adjoin-term (make-term (order t1)
                                            (add (coeff t1) (coeff t2)))
                                 (add-terms (rest-terms L1)
                                            (rest-terms L2)))))))))

(define (sub-terms L1 L2)
  (add-terms L1 (neg-terms L2)))

(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms (rest-terms L1) L2))))

(define (mul-term-by-all-terms t1 L)
  (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L)))
        (adjoin-term (make-term (+ (order t1) (order t2))
                                (mul (coeff t1) (coeff t2)))
                     (mul-term-by-all-terms t1 (rest-terms L))))))

(define (=zero-poly? poly)
  (define (coeff-all-zero? term-list)
    (if (empty-termlist? term-list)
        #t
        (if (=zero? (coeff (first-term term-list)))
            (coeff-all-zero? (rest-terms term-list))
            #f)))
  (coeff-all-zero? (term-list poly)))

(define (neg-poly p)
  (make-poly (variable p)
             (neg-terms (term-list p))))
  
(define (neg-terms L)
  (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t (first-term L)))
        (adjoin-term (make-term (order t) (neg (coeff t)))
                     (neg-terms (rest-terms L))))))
          
(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))

(define (first-term term-list) (car term-list))
(define (the-empty-termlist) '())
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 使用中缀方式打印多项式，方便查看结果
(define (print-poly-impl poly)
  (define (print-val val)
    (if (number? val)
        (if (negative? val)
            (display-brackets val)
            (display val))
        (print-poly-impl val)))
  
  (define (print-term variable term)
    (cond ((and (not (=number? (coeff term) 1))
                (not (=number? (order term) 0)))
           (print-val (coeff term))
           (display "*")))
    (cond ((=number? (order term) 0) (print-val (coeff term)))
          ((=number? (order term) 1) (display variable))
          (else (begin
                  (display variable)
                  (display "^")
                  (print-val (order term))))))
    
  (define (print-terms variable terms)
    (cond ((not (null? terms))
          (print-term variable (car terms))
          (cond ((> (length terms) 1) (display " + ")))
          (print-terms variable (cdr terms)))))
  
  (define (nonzero-terms term-list)
    (if (empty-termlist? term-list)
        '()
        (let ((t (first-term term-list)))
          (if (=zero? (coeff t))
              (nonzero-terms (rest-terms term-list))
              (cons t (nonzero-terms (rest-terms term-list)))))))
          
  (display "(")
  (print-terms (variable poly) (nonzero-terms (term-list poly)))
  (display ")"))

(define (print-poly info poly)
  (displayln info)
  (displayln poly)
  (print-poly-impl poly)
  (newline)
  (newline))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (make-term-list pairs)
  (if (null? pairs)
      (the-empty-termlist)
      (let ((pair (car pairs)))
        (adjoin-term (make-term (car pair) (cadr pair))
                     (make-term-list (cdr pairs))))))

(module* main #f
  (install-scheme-number-package)
  (install-polynomial-package)         
  
  (define a (make-poly 'x (make-term-list '((5 1) (0 -1)))))
  (define b (make-poly 'x (make-term-list '((2 1) (0 -1)))))
  
  (print-poly "a" a)
  (print-poly "b" b)
  (print-poly "a / b" (div a b))
  (print-poly "a % b" (rem a b))
    
  (define y0 (make-poly 'y '((1 1) (0 1))))
  (define y1 (make-poly 'y '((2 1) (0 1))))
  (define y2 (make-poly 'y '((1 1) (0 -1))))
  (define c (make-poly 'x (list (list 2 y0) (list 1 y1) (list 0 y2))))
  
  (define y4 (make-poly 'y '((1 1) (0 -2))))
  (define y5 (make-poly 'y '((3 1) (0 7))))
  (define d (make-poly 'x (list (list 1 y4) (list 0 y5))))
  
  (print-poly "c" c)
  (print-poly "d" d)
  (print-poly "c * d" (mul c d))
  (print-poly "(c * d) / c" (div (mul c d) c))
  (print-poly "(c * d) / d" (div (mul c d) d))
  (print-poly "(c / d)" (div c d))
  
  (define e (make-poly 'x (make-term-list '((2 1) (1 -9) (0 -27)))))
  (define f (make-poly 'x (make-term-list '((1 1) (0 -3)))))
  (print-poly "e" e)
  (print-poly "f" f)
  (print-poly "(e * f - 123) / f" (div (sub (mul e f) 123) f))
  (print-poly "(e * f - 123) % f" (rem (sub (mul e f) 123) f))
)

