#lang racket

;; P84 - [练习 2.41]

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (make-triples n)
  (flatmap
    (lambda (i)
      (flatmap 
        (lambda (j) 
          (map (lambda (k) 
                 (list i j k))
               (enumerate-interval 1 n)))
        (enumerate-interval 1 n)))
    (enumerate-interval 1 n)))

(define (different? items)
  (let ((i (car items))
        (j (cadr items))
        (k (cadr (cdr items))))
    (and (not (= i j)) (not (= i k)) (not (= j k)))))

(define (ordered-triples-sum n s)
  (filter (lambda (x) (and (= (accumulate + 0 x) s) (different? x)))
          (make-triples n)))

;;;;;;;;;;;;;;;;;;
(ordered-triples-sum 6 14)
  
