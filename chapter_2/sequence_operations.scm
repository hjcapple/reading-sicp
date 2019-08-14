#lang racket

;; P77 - [序列操作]

(define (square x)
  (* x x))

(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))

;;;;;;;;;;;;;;;;;;;;;;

(define (filter predicate sequence)
  (if (null? sequence)
      null
      (if (predicate (car sequence))
          (cons (car sequence) (filter predicate (cdr sequence)))
          (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

(define (enumerate-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (sum-odd-squares tree)
  (accumulate + 
              0
              (map square 
                   (filter odd? 
                           (enumerate-tree tree)))))

(define (even-fibs n)
  (accumulate cons 
              null
              (filter even?
                      (map fib (enumerate-interval 0 n)))))

(define (list-fib-squares n)
  (accumulate cons 
              null
              (map square
                   (map fib (enumerate-interval 0 n)))))

(define (product-of-squares-of-odd-elements sequence)
  (accumulate *
              1
              (map square
                   (filter odd? sequence))))


;;;;;;;;;;;;;;;
(filter odd? (list 1 2 3 4 5))
(accumulate + 0 (list 1 2 3 4 5))
(accumulate * 1 (list 1 2 3 4 5))
(accumulate cons null (list 1 2 3 4 5))
(enumerate-interval 2 7)
(enumerate-tree (list 1 (list 2 (list 3 4)) 5))
(sum-odd-squares (list 1 (list 2 (list 3 4)) 5))
(even-fibs 10)
(list-fib-squares 10)
(product-of-squares-of-odd-elements (list 1 2 3 4 5))

