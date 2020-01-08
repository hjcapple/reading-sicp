#lang sicp

;; P314 - [练习 4.62]

(#%require "queryeval.scm")

(initialize-data-base 
  '(
    (rule (last-pair (?x) (?x)))
    
    (rule (last-pair (?u . ?v) ?x)
          (last-pair ?v ?x))
    ))

(easy-qeval '(last-pair (3) ?x))
; (last-pair (3) (3))

(easy-qeval '(last-pair (1 2 3) ?x))
; (last-pair (1 2 3) (3))

(easy-qeval '(last-pair (2 ?x) (3)))
; (last-pair (2 3) (3))

; (easy-qeval '(last-pair ?x (3)))
; 不会停止
