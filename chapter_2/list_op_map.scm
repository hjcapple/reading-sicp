#lang racket

;; P67 - [表操作和表映射]

(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(define (length-2 items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (+ 1 count))))
  (length-iter items 0))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (scale-list items factor)
  (if (null? items)
      null
      (cons (* (car items) factor)
            (scale-list (cdr items) factor))))

(define (scale-list-2 items factor)
  (map (lambda (x) (* x factor))
       items))

(define (map proc items)
  (if (null? items)
      null
      (cons (proc (car items))
            (map proc (cdr items)))))
          
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define squares (list 1 4 9 16 25))
(list-ref squares 3)

(define odds (list 1 3 5 7))
(length odds)
(length-2 odds)

(append squares odds)
(append odds squares)

(map abs (list -10 2.5 -11.6 17))
(map (lambda (x) (* x x))
     (list 1 2 3 4))
(scale-list (list 1 2 3 4) 2)
(scale-list-2 (list 1 2 3 4) 2)

