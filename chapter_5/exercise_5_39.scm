#lang sicp

;; P424 - [练习 5.39]

(#%require "ch5-eceval-support.scm")
(#%provide lexical-address-lookup lexical-address-set!)

(define (env-frame-values env offset)
  (if (= offset 0)
      (frame-values (first-frame env))
      (env-frame-values (enclosing-environment env) (- offset 1))))

(define (list-ref lst offset)
  (if (= offset 0)
      (car lst)
      (list-ref (cdr lst) (- offset 1))))

(define (list-set! lst offset val)
  (if (= offset 0)
      (set-car! lst val)
      (list-set! (cdr lst) (- offset 1) val)))

(define (lexical-address-lookup address env)
  (if (eq? address '*unassigned*)
      (error "the address is unassigned -- LEXICAL-ADDRESS-LOOKUP" address)
      (list-ref (env-frame-values env (car address)) (cadr address))))

(define (lexical-address-set! address val env)
  (if (eq? address '*unassigned*)
      (error "the address is unassigned -- LEXICAL-ADDRESS-SET!" address)
      (list-set! (env-frame-values env (car address)) (cadr address) val)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(#%require (only racket module*))
(module* test #f
  (#%require rackunit)
  (define lst (list 0 1 2 3 4 5))
  (check-equal? (list-ref lst 4) 4)
  (list-set! lst 0 1)
  (check-equal? (list 1 1 2 3 4 5) lst)
  (list-set! lst 5 7)
  (check-equal? (list 1 1 2 3 4 7) lst)
  
  (define env the-empty-environment)
  (set! env (extend-environment (list 'x 'y) (list 1 2) env))
  (set! env (extend-environment (list 'a 'b 'c 'd) (list 3 4 5 6) env))
  (set! env (extend-environment (list 'y 'z) (list 7 8) env))
  
  (define x-address '(2 0))
  (define y-address '(0 0))
  (define c-address '(1 2))
  
  (set-variable-value! 'x 'helloworld env)
  (lexical-address-set! y-address 'ok env)
  (lexical-address-set! c-address 99999 env)
  
  (check-equal? (lookup-variable-value 'x env) (lexical-address-lookup x-address env))
  (check-equal? (lookup-variable-value 'y env) (lexical-address-lookup y-address env))
  (check-equal? (lookup-variable-value 'c env) (lexical-address-lookup c-address env))
)  

