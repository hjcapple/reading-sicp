#lang racket

;; P138 - [2.5.3 符号代数]
;; P143 - [练习 2.87]

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
(define (mul x y) (apply-generic 'mul x y))
(define (=zero? x) (apply-generic '=zero? x))

(define (install-scheme-number-package)
  (define (tag-2-args op)
    (lambda (x y) (attach-tag 'scheme-number (op x y))))
  (put 'add '(scheme-number scheme-number) (tag-2-args +))
  (put 'mul '(scheme-number scheme-number) (tag-2-args *))
  (put '=zero? '(scheme-number)
       (lambda (x) (= x 0)))
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

(define (mul-poly p1 p2)
  (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (mul-terms (term-list p1) (term-list p2)))
      (error "Polys not in same var -- MUL-POLY" (list p1 p2))))

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

;; 练习 2.87
(define (=zero-poly? poly)
  (define (coeff-all-zero? term-list)
    (if (empty-termlist? term-list)
        #t
        (if (=zero? (coeff (first-term term-list)))
            (coeff-all-zero? (rest-terms term-list))
            #f)))
  (coeff-all-zero? (term-list poly)))
        
(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (cons term term-list)))

(define (the-empty-termlist) '())
(define (first-term term-list) (car term-list))
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

;;;;;;;;;;;;;;;;;;;;;;;;;
(module* main #f
  (install-scheme-number-package)
  (install-polynomial-package)         
         
  (define a (make-poly 'x '((5 1) (4 2) (2 3) (1 -2) (0 -5))))
  (define b (make-poly 'x '((100 1) (2 2) (0 1))))

  (print-poly "a" a)
  (print-poly "b" b)
  
  (print-poly "a + b" (add-poly a b))
  (print-poly "a * b" (mul-poly a b))
  
  (define y0 (make-poly 'y '((1 1) (0 1))))
  (define y1 (make-poly 'y '((2 1) (0 1))))
  (define y2 (make-poly 'y '((1 1) (0 -1))))
  (define c (make-poly 'x (list (list 2 y0) (list 1 y1) (list 0 y2))))
  (print-poly "c" c)
  
  (define y4 (make-poly 'y '((1 1) (0 -2))))
  (define y5 (make-poly 'y '((3 1) (0 7))))
  (define d (make-poly 'x (list (list 1 y4) (list 0 y5))))
  (print-poly "d" d)
  
  (print-poly "c + d" (add-poly c d))
  (print-poly "c * d" (mul-poly c d))
  
  (print-poly "a + c" (add-poly a c))
  (print-poly "a * c" (mul-poly a c))
  
  (=zero? 0)
  (=zero? 1)
  (=zero? (make-poly 'x '((100 0) (99 0))))
  (=zero? a)
)

