#lang sicp

;; P378 - [练习 5.21]

(#%require "ch5-regsim.scm")

;; a)
(define (count-leaves-a tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
        (else (+ (count-leaves-a (car tree))
                 (count-leaves-a (cdr tree))))))

(define count-leaves-machine-a
  (make-machine
    '(tree result continue temp)
    (list (list 'null? null?)
          (list 'pair? pair?) 
          (list 'car car) 
          (list 'cdr cdr) 
          (list '+ +))
    '(
      (assign continue (label count-done))
      
    count-loop
      (test (op null?) (reg tree))
      (branch (label null-tree))
      
      (test (op pair?) (reg tree))
      (branch (label count-car))
      
      ;; (not (pair? tree))
      (assign result (const 1))
      (goto (reg continue))
      
    null-tree
      (assign result (const 0))
      (goto (reg continue))
        
    count-car
      (save continue)
      (save tree)
      
      (assign tree (op car) (reg tree))
      (assign continue (label count-cdr))
      (goto (label count-loop))
      
    count-cdr
      (restore tree)
      (save result)
      
      (assign tree (op cdr) (reg tree))
      (assign continue (label after-count))
      (goto (label count-loop))
      
    after-count
      (assign temp (reg result))  ; cdr-result
      (restore result)            ; car-result
      (restore continue)
      (assign result (op +) (reg temp) (reg result))
      (goto (reg continue))
      
    count-done
      )))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; b)
(define (count-leaves-b tree)
  (define (count-iter tree n)
    (cond ((null? tree) n)
          ((not (pair? tree)) (+ n 1))
          (else (count-iter (cdr tree)
                            (count-iter (car tree) n)))))
  (count-iter tree 0))

(define count-leaves-machine-b
  (make-machine
    '(tree result continue)
    (list (list 'null? null?)
          (list 'pair? pair?) 
          (list 'car car) 
          (list 'cdr cdr) 
          (list '+ +))
    '(
      (assign result (const 0))
      (assign continue (label count-done))
      
    count-loop
      (test (op null?) (reg tree))
      (branch (label null-tree))
      
      (test (op pair?) (reg tree))
      (branch (label count-car))
      
      ;; (not (pair? tree))
      (assign result (op +) (reg result) (const 1))
      (goto (reg continue))
      
    null-tree
      (goto (reg continue))
      
    count-car
      (save continue)
      (save tree)
      
      (assign tree (op car) (reg tree))
      (assign continue (label count-cdr))
      (goto (label count-loop))
      
    count-cdr
      (restore tree)
      
      (assign tree (op cdr) (reg tree))
      (assign continue (label after-count))
      (goto (label count-loop))
      
    after-count
      (restore continue)
      (goto (reg continue))
      
    count-done
      )))

;;;;;;;;;;;;;;;;;;;;;;;;;;
(define tree '(1 2 (3 4) (5 6 7)))
(count-leaves-a tree)                                       ; 7
(set-register-contents! count-leaves-machine-a 'tree tree)  ; done
(start count-leaves-machine-a)                              ; done
(get-register-contents count-leaves-machine-a 'result)      ; 7

(count-leaves-b tree)
(set-register-contents! count-leaves-machine-b 'tree tree)  ; done
(start count-leaves-machine-b)                              ; done
(get-register-contents count-leaves-machine-b 'result)      ; 7

