#lang racket

;; P138 - [2.5.3 符号代数]
;; P143 - [练习 2.87]

;; 为避免引入过多代码，通用函数只考虑数字和多项式，

(define (number->poly variable n)
  (make-poly variable (adjoin-term (make-term 0 n) (the-empty-termlist))))

(define (add x y)
  (cond ((and (number? x) (number? y)) (+ x y))
        ((and (number? x) (not (number? y))) (add-poly (number->poly (variable y) x) y))
        ((and (not (number? x)) (number? y)) (add-poly x (number->poly (variable x) y)))
        (else (add-poly x y))))

(define (mul x y)
  (cond ((and (number? x) (number? y)) (* x y))
        ((and (number? x) (not (number? y))) (mul-poly (number->poly (variable y) x) y))
        ((and (not (number? x)) (number? y)) (mul-poly x (number->poly (variable x) y)))
        (else (mul-poly x y))))

(define (=zero? x)
  (cond ((number? x) (= x 0))
        (else (=zero-poly? x))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (same-variable? v1 v2)
  (define (variable? x) (symbol? x))
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-poly variable term-list)
  (cons variable term-list))

(define (variable p) (car p))
(define (term-list p) (cdr p))

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

;; 练习 2.86
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
  (define (=number? x num)
    (and (number? x) (= x num)))
  (define (print-val val)
    (if (number? val)
        (if (> val 0)
            (display val)
            (begin 
               (display "(")
               (display val)
               (display ")")))
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
    
  (define (print-term-list variable term-list)
    (cond ((not (null? term-list))
          (print-term variable (car term-list))
          (cond ((> (length term-list) 1) (display " + ")))
          (print-term-list variable (cdr term-list)))))
  
  (display "(")
  (print-term-list (variable poly) (term-list poly))
  (display ")"))

(define (print-poly poly)
  (display poly)
  (newline)
  (print-poly-impl poly)
  (newline)
  (newline))

;;;;;;;;;;;;;;;;;;;;;;;;;
(module* main #f
  (define a (make-poly 'x '((5 1) (4 2) (2 3) (1 -2) (0 -5))))
  (define b (make-poly 'x '((100 1) (2 2) (0 1))))

  (print-poly a)
  (print-poly b)
  
  (print-poly (add-poly a b))
  (print-poly (mul-poly a b))
  
  (define y0 (make-poly 'y '((1 1) (0 1))))
  (define y1 (make-poly 'y '((2 1) (0 1))))
  (define y2 (make-poly 'y '((1 1) (0 -1))))
  (define c (make-poly 'x (list (list 2 y0) (list 1 y1) (list 0 y2))))
  (print-poly c)
  
  (define y4 (make-poly 'y '((1 1) (0 -2))))
  (define y5 (make-poly 'y '((3 1) (0 7))))
  (define d (make-poly 'x (list (list 1 y4) (list 0 y5))))
  (print-poly d)
  
  (print-poly (add-poly c d))
  (print-poly (mul-poly c d))
  
  (print-poly (add-poly a c))
  (print-poly (mul-poly a c))
  
  (=zero? 0)
  (=zero? 1)
  (=zero? (make-poly 'x '((100 0) (99 0))))
  (=zero? a)
)

