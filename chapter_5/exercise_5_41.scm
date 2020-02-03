#lang sicp

;; P424 - [练习 5.41]

(#%provide find-variable)

(define (find-variable var env)
  (define (position-in-frame var frame position)
    (if (null? frame)
        'not-found
        (if (eq? var (car frame))
            position
            (position-in-frame var (cdr frame) (+ position 1)))))
  
  (define (loop var env offset)
    (if (null? env)
        'not-found
        (let ((position (position-in-frame var (car env) 0)))
          (if (not (eq? position 'not-found))
              (list offset position)
              (loop var (cdr env) (+ offset 1))))))
  
  (loop var env 0))

;;;;;;;;;;;;;;;;;;;;;;;;
(#%require (only racket module*))
(module* main #f
  (find-variable 'c '((y z) (a b c d e) (x y))) ; (1 2)
  (find-variable 'x '((y z) (a b c d e) (x y))) ; (2 0)
  (find-variable 'w '((y z) (a b c d e) (x y))) ; not-found
)  
