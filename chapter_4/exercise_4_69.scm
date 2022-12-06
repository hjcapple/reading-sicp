#lang sicp

;; P324 - [练习 4.69]

(#%require "queryeval.scm")

(initialize-data-base 
  '(
    (son Adam Cain) ; 表示 Adam 的儿子是 Cain
    (son Cain Enoch)
    (son Enoch Irad)
    (son Irad Mehujael)
    (son Mehujael Methushael)
    (son Methushael Lamech)
    (wife Lamech Ada)
    (son Ada Jabal)
    (son Ada Jubal)
    
    (rule (grandson ?G ?S)
          (and (son ?G ?F)
               (son ?F ?S)))
    
    (rule (son ?man ?son)
          (and (wife ?man ?woman)
               (son ?woman ?son)))
    
    (rule (end-in-grandson (grandson)))
    (rule (end-in-grandson (?x . ?rest))
          (end-in-grandson ?rest))
    
    (rule ((great grandson) ?x ?y)
        (and (son ?x ?z)
            (grandson ?z ?y)))
    (rule ((great . ?rel) ?x ?y)
        (and (son ?x ?z)
            (?rel ?z ?y)
            (end-in-grandson ?rel)))
    ))

(easy-qeval '((great grandson) ?g ?ggs))
;; ((great grandson) Mehujael Jubal)
;; ((great grandson) Irad Lamech)
;; ((great grandson) Mehujael Jabal)
;; ((great grandson) Enoch Methushael)
;; ((great grandson) Cain Mehujael)
;; ((great grandson) Adam Irad)

(easy-qeval '((great great grandson) ?g ?ggs))
;; ((great great grandson) irad jubal)
;; ((great great grandson) enoch lamech)
;; ((great great grandson) irad jabal)
;; ((great great grandson) cain methushael)
;; ((great great grandson) adam mehujael)

(easy-qeval '(?relationship Adam Irad))
;; ((great grandson) adam irad)

(easy-qeval '(?relationship Adam Jabal))
;; ((great great great great great grandson) adam jabal)
