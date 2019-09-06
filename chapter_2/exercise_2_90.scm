#lang racket

;; P143 - [练习 2.90]

; 正文已给出稀疏(sparse)表示的实现，结合[练习 2.89]的稠密(dense)表示的实现。
; 可以提取出通用函数，使得多项式计算可以分别在两种表示方法中切换。

; 要同时使用两种表示，需要一种机制挑选那种表示最合适。为此添加了 2 个通用函数
; * nonzero-terms-ratio 用于计算 term-list 中非 0 项所占的比例
; * trans-termlist 用于在两种表示中自由转换。
; 这时就可以修改 make-poly 函数。假如非 0 项较多(占比超过 0.5)，就转换到稠密表示，否则转换到稀疏表示。
; 因为通用函数屏蔽了具体表示的细节，两种表示之间也可交叉计算。

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (neg x)   (apply-generic 'neg x))
(define (=zero? x) (apply-generic '=zero? x))

(define (install-scheme-number-package)
  (define (tag-2-args op)
    (lambda (x y) (attach-tag 'scheme-number (op x y))))
  (define (tag x) (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number) (tag-2-args +))
  (put 'sub '(scheme-number scheme-number) (tag-2-args -))
  (put 'mul '(scheme-number scheme-number) (tag-2-args *))
  (put 'neg '(scheme-number) (lambda (x) (tag (- x))))
  (put '=zero? '(scheme-number) (lambda (x) (= x 0)))
  )

(define (install-polynomial-package)
  (define (number->poly variable type n)
    (make-poly variable 
               (adjoin-term (make-term 0 n) 
                            (the-empty-termlist type))))
  (define (tag x) (attach-tag 'polynomial x))
  (define (put-op name op)
    (put name '(polynomial polynomial)
         (lambda (x y) (tag (op x y))))
    (put name '(polynomial scheme-number)
         (lambda (x y) (tag (op x (number->poly (variable x) (type-tag (term-list x)) y)))))
    (put name '(scheme-number polynomial)
         (lambda (x y) (tag (op (number->poly (variable y) (type-tag (term-list y)) x) y)))))
  (put-op 'add add-poly)
  (put-op 'mul mul-poly)
  (put-op 'sub sub-poly)
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
  (define (better-termlist-type termlist)
    (if (> (nonzero-terms-ratio termlist) 0.5)
        'dense-termlist
        'sparse-termlist))
  (let ((better-termlist (trans-termlist term-list 
                                        (better-termlist-type term-list))))
      (cons 'polynomial (cons variable better-termlist))))

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
      (the-empty-termlist (type-tag L1))
      (add-terms (mul-term-by-all-terms (first-term L1) L2)
                 (mul-terms (rest-terms L1) L2))))

(define (mul-term-by-all-terms t1 L)
  (if (empty-termlist? L)
      (the-empty-termlist (type-tag L))
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
      (the-empty-termlist (type-tag L))
      (let ((t (first-term L)))
        (adjoin-term (make-term (order t) (neg (coeff t)))
                     (neg-terms (rest-terms L))))))

;; 稠密表示
(define (install-dense-termlist-package)
  (define (adjoin-term term term-list)
    (cond ((=zero? (coeff term)) term-list)
          ((= (order term) (length term-list)) (cons (coeff term) term-list))
          (else (adjoin-term term (cons 0 term-list)))))
  (define (first-term term-list)
    (make-term (- (length term-list) 1) (car term-list)))
  (define (the-empty-termlist) '())
  
  (define (nonzero-terms-ratio term-list)
    (define (nonzero-terms-count term-list)
      (cond ((null? term-list) 0)
            ((=zero? (car term-list)) (nonzero-terms-count (cdr term-list)))
            (else (+ 1 (nonzero-terms-count (cdr term-list))))))
    (if (null? term-list)
        0
        (let ((nonzero-count (nonzero-terms-count term-list))
              (total-count (length term-list)))
          (/ nonzero-count total-count))))
        
  (define (tag x) (attach-tag 'dense-termlist x))
  (put 'adjoin-term 'dense-termlist
       (lambda (term term-list) (tag (adjoin-term term term-list))))
  (put 'first-term 'dense-termlist first-term)
  (put 'nonzero-terms-ratio 'dense-termlist nonzero-terms-ratio)
  (put 'the-empty-termlist 'dense-termlist
       (lambda () (tag (the-empty-termlist))))
)

;; 稀疏表示
(define (install-sparse-termlist-package)
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))
  (define (first-term term-list) (car term-list))
  (define (the-empty-termlist) '())
  (define (nonzero-terms-ratio term-list)
     (if (null? term-list)
        0
        (let ((nonzero-count (length term-list))
              (total-count (+ 1 (order (first-term term-list)))))
          (/ nonzero-count total-count))))
  
  (define (tag x) (attach-tag 'sparse-termlist x))
  (put 'adjoin-term 'sparse-termlist
       (lambda (term term-list) (tag (adjoin-term term term-list))))
  (put 'first-term 'sparse-termlist first-term)
  (put 'nonzero-terms-ratio 'sparse-termlist nonzero-terms-ratio)
  (put 'the-empty-termlist 'sparse-termlist
       (lambda () (tag (the-empty-termlist))))
)

(define (adjoin-term term term-list)
  ((get 'adjoin-term (type-tag term-list)) term (contents term-list)))

(define (first-term term-list)
  ((get 'first-term (type-tag term-list)) (contents term-list)))

(define (nonzero-terms-ratio term-list)
  ((get 'nonzero-terms-ratio (type-tag term-list)) (contents term-list)))

(define (the-empty-sparse-termlist)
  ((get 'the-empty-termlist 'sparse-termlist)))

(define (the-empty-dense-termlist)
  ((get 'the-empty-termlist 'dense-termlist)))
  
(define (the-empty-termlist type) 
  ((get 'the-empty-termlist type)))

(define (trans-termlist term-list type)
  (define (make-term-list term-list type)
    (if (empty-termlist? term-list)
        (the-empty-termlist type)
        (let ((t (first-term term-list)))
          (adjoin-term t (make-term-list (rest-terms term-list) type)))))
  ;; type 相同，不必要转换
  (if (eq? (type-tag term-list) type)
      term-list
      (make-term-list term-list type)))
  
(define (rest-terms term-list) (attach-tag (type-tag term-list) (cdr (contents term-list))))
(define (empty-termlist? term-list) (null? (contents term-list)))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
      (the-empty-dense-termlist)
      (let ((pair (car pairs)))
        (adjoin-term (make-term (car pair) (cadr pair))
                     (make-term-list (cdr pairs))))))

(module* main #f
  (install-scheme-number-package)
  (install-polynomial-package)       
  (install-dense-termlist-package)  
  (install-sparse-termlist-package)
  
  (define termlist (make-term-list '((100 1) (2 2) (0 1))))
  (trans-termlist termlist 'dense-termlist)
  (trans-termlist termlist 'sparse-termlist)
  (nonzero-terms-ratio (trans-termlist termlist 'dense-termlist))
  (nonzero-terms-ratio (trans-termlist termlist 'sparse-termlist))
  
  (define a (make-poly 'x (make-term-list '((5 1) (4 2) (2 3) (1 -2) (0 -5)))))
  (define b (make-poly 'x (make-term-list '((100 1) (2 2) (0 1)))))
  
  (print-poly "a" a)
  (print-poly "b" b)
  (print-poly "a - b" (sub-poly a b))
  (print-poly "a * b" (mul-poly a b))
  
  (define y0 (make-poly 'y (make-term-list '((1 1) (0 1)))))
  (define y1 (make-poly 'y (make-term-list '((2 1) (0 1)))))
  (define y2 (make-poly 'y (make-term-list '((1 1) (0 -1)))))
  (define c (make-poly 'x (make-term-list (list (list 2 y0) (list 1 y1) (list 0 y2)))))
  (print-poly "c" c)
  
  (define y4 (make-poly 'y (make-term-list '((1 1) (0 -2)))))
  (define y5 (make-poly 'y (make-term-list '((3 1) (0 7)))))
  (define d (make-poly 'x (make-term-list (list (list 1 y4) (list 0 y5)))))
  (print-poly "d" d)
  
  (print-poly "c - d" (sub-poly c d))
  (print-poly "a - c" (sub-poly a c))
)

