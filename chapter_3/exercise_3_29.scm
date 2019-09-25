#lang sicp

;; P192 - [练习 3.29]

(#%require "digital_circuit.scm")

(define (or-gate a1 a2 output)
  (let ((b (make-wire)) 
        (c (make-wire))
        (d (make-wire))
        )
    (inverter a1 b)
    (inverter a2 c)
    (and-gate b c d)
    (inverter d output)
    'ok))

;;;;;;;;;;;;;;;;;;;;
(#%require (only racket module*))
(module* main #f
  (define a1 (make-wire))
  (define a2 (make-wire))
  (define output (make-wire))
  (probe 'output output)
  
  (or-gate a1 a2 output)

  (set-signal! a1 1)
  (set-signal! a2 1)
  (propagate) ; output 7  New-value = 1
  
  (set-signal! a1 0)
  (set-signal! a2 0)
  (propagate) ; output 14  New-value = 0
  
  (set-signal! a1 1)
  (set-signal! a2 0)
  (propagate) ; output 21  New-value = 1
)

; 从输出信号中可以判断，or-gate 连接正确。并且当 a1、a2 改变时
; ouput 改变的时间点为 7、14、21，判断出其延迟为 7。
; digital_circuit.scm 中的定义
; (define inverter-delay 2)
; (define and-gate-delay 3)
; 可以证实我们的分析，or-gate 的延迟为 2 * inverter-delay + and-gate-delay = 7


