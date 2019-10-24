#lang racket 

;; [3.5.5 函数式程序的模块化和对象的模块化]

(require "stream.scm")
(require "infinite_stream.scm")
(require "ch3support.scm")  ; for rand-update, gcd
(provide monte-carlo)

(define random-init 7)
(define random-numbers
  (cons-stream random-init
               (stream-map rand-update random-numbers)))

(define (map-successive-pairs f s)
  (cons-stream
    (f (stream-car s) (stream-car (stream-cdr s)))
    (map-successive-pairs f (stream-cdr (stream-cdr s)))))

(define cesaro-stream
  (map-successive-pairs (lambda (r1 r2) (= (gcd r1 r2) 1))
                        random-numbers))

(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
      (/ passed (+ passed failed))
      (monte-carlo
        (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define pi
  (stream-map (lambda (p) 
                (if (= p 0)
                    0
                    (sqrt (/ 6 p))))
              (monte-carlo cesaro-stream 0 0)))

;;;;;;;;;;;;;;;;;;;;;
(module* main #f
  (stream-ref pi 2000)  ; 3.125526806694407
)
