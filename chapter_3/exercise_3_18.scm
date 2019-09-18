#lang sicp

;; P179 - [练习 3.18]

; 练习 2.60 中的集合，将 equal? 改为 eq?
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((eq? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

; 将访问过的 x 放入集合中
(define (contains-cycle? x)
  (let ((visited '()))
    (define (contains-cycle-set? x)
      (cond ((not (pair? x)) false)
            ((element-of-set? x visited) true)
            (else 
              (set! visited (adjoin-set x visited))
              (contains-cycle-set? (cdr x)))))
    (contains-cycle-set? x)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (last-pair x)
  (if (null? (cdr x))
      x 
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z1 (list 'a 'b 'c))
(contains-cycle? z1)  ; #f

(define z2 (make-cycle (list 'a 'b 'c)))
(contains-cycle? z2)  ; #t
