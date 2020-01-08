#lang sicp

;; P313 - [将逻辑看做程序]

(#%require "queryeval.scm")

(initialize-data-base 
  '(
    (rule (append-to-form () ?y ?y))
    (rule (append-to-form (?u . ?v) ?y (?u . ?z))
          (append-to-form ?v ?y ?z))
    ))

(easy-qeval '(append-to-form (a b) (c d) ?z))
(easy-qeval '(append-to-form (a b) ?y (a b c d)))
(easy-qeval '(append-to-form ?x ?y (a b c d)))


