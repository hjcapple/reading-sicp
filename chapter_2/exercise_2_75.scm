#lang racket

;; P128 - [练习 2.75]

(define (square x) (* x x))

(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
                       (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
                       (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))

(define (apply-generic op arg) (arg op))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z)     (apply-generic 'angle z))

(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude) (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else 
            (error "Unkown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)

(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          (else 
            (error "Unkown op -- MAKE-FROM-MAG-ANG" op))))
  dispatch)

;;;;;;;;;;;;;;;;;;;
(define a (make-from-real-imag 10 20))
(define b (make-from-real-imag 1 2))
(define c (make-from-mag-ang (magnitude a) (angle a)))
(define d (make-from-mag-ang (magnitude b) (angle b)))

(define (print-complex z)
  (define (print-pair v0 v1)
    (display "(")
    (display v0)
    (display ", ")
    (display v1)
    (display ")"))
  
  (display "(r, a) = ")
  (print-pair (magnitude z) (angle z))
  (display "     (x, y) = ")
  (print-pair (real-part z) (imag-part z))
  (newline)
  )

(print-complex (add-complex a b))
(print-complex (sub-complex a b))
(print-complex (mul-complex a b))
(print-complex (div-complex a b))

(print-complex (add-complex c d))
(print-complex (sub-complex c d))
(print-complex (mul-complex c d))
(print-complex (div-complex c d))

