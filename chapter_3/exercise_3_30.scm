#lang sicp

;; P192 - [练习 3.29]

(#%require "digital_circuit.scm")

(define (ripple-carry-adder A B S c-out)
  (define (helper A B S c-in c-out)
    (if (null? (cdr A))
        (full-adder (car A) (car B) c-in (car S) c-out)
        (let ((wire (make-wire)))
          (helper (cdr A) (cdr B) (cdr S) c-in wire)
          (full-adder (car A) (car B) wire (car S) c-out))))
  
  (let ((c-in (make-wire)))
    (set-signal! c-in 0)
    (helper A B S c-in c-out)
    'ok))

;;;;;;;;;;;;;;;;;;;;;;;;;
(define (make-wires n)
  (if (= n 0)
      '()
      (cons (make-wire) (make-wires (- n 1)))))

(define (set-wire-signals! wires values)
  (cond ((not (null? wires))
         (set-signal! (car wires) (car values))
         (set-wire-signals! (cdr wires) (cdr values)))))

(define (get-wire-signals wires)
  (if (null? wires)
      '()
      (append (list (get-signal (car wires))) 
              (get-wire-signals (cdr wires)))))

(define A (make-wires 4))
(define B (make-wires 4))
(define S (make-wires 4))
(define c-out (make-wire))
(ripple-carry-adder A B S c-out)

(define (print-info tag b)
  (display tag)
  (display b)
  (newline))

(define (run-simulate AB-values)
  (cond ((not (null? AB-values))
         (set-wire-signals! A (car (car AB-values)))
         (set-wire-signals! B (cadr (car AB-values)))
         (propagate)
         (print-info "" "==========")
         (print-info "time: " (get-agenda-current-time))
         (print-info "a: " (get-wire-signals A))
         (print-info "b: " (get-wire-signals B))
         (print-info "s: " (get-wire-signals S))
         (print-info "c-out: " (get-signal c-out))
         (run-simulate (cdr AB-values)))))

(run-simulate '(
                ((0 0 0 0) (0 0 0 0))
                ((0 1 1 1) (0 1 1 1))
                ((1 1 1 1) (0 0 0 0))
                ((1 1 1 1) (0 0 0 1))
                ((1 1 1 1) (1 1 1 1))
                ))

;(run-simulate '(
;                ((1 1 1 1) (0 0 0 0))
;                ((1 1 1 1) (0 0 0 1))
;                ((1 1 1 1) (0 0 0 0))
;                ))
