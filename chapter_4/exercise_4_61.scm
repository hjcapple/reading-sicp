#lang sicp

;; P314 - [练习 4.61]

(#%require "queryeval.scm")

(initialize-data-base 
  '(
    (rule (?x next-to ?y in (?x ?y . ?u)))
    
    (rule (?x next-to ?y in (?v . ?z))
          (?x next-to ?y in ?z))
    ))

(easy-qeval '(?x next-to ?y in (1 (2 3) 4)))
; Query output: 
; ((2 3) next-to 4 in (1 (2 3) 4)) 
; (1 next-to (2 3) in (1 (2 3) 4)) 

(easy-qeval '(?x next-to 1 in (2 1 3 1)))
; Query results:
; (3 next-to 1 in (2 1 3 1))
; (2 next-to 1 in (2 1 3 1))

