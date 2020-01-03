#lang sicp

;; P292 - [练习 4.43]

;; 问题 a) 
;; 输出唯一答案 ((mary moore) (gabrielle hall) (lorna downing) (rosalind parker) (melissa barnacle))
;; 表示 Lorna 的父亲是 Colonel Downing

;; 问题 b)
;; 假如去约束条件 (require (eq? mary 'moore)), 得到两个答案
;; ((mary moore) (gabrielle hall) (lorna downing) (rosalind parker) (melissa barnacle)) 
;; ((mary hall) (gabrielle moore) (lorna parker) (rosalind downing) (melissa barnacle))
;; 表示 Lorna 的父亲可能是 Colonel Downing，也可能是 Dr.Parker

(#%require "ambeval.scm")

(easy-ambeval 10 '(begin
                    
(define (require p)
  (if (not p) (amb)))

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

(define (a-father-name)
  (amb 'moore 'downing 'hall 'barnacle 'parker))

;; 这个实现方法较快，但比较难读
(define (yacht-puzzle)
  (let ((mary (a-father-name)))
    (require (eq? mary 'moore))
    (let ((melissa (a-father-name)))
      (require (eq? melissa 'barnacle))
      (let ((gabrielle (a-father-name)))
        (require (not (memq gabrielle (list mary melissa 'barnacle))))
        (let ((lorna (a-father-name)))
          (require (not (memq lorna (list mary melissa gabrielle 'moore))))
          (let ((rosalind (a-father-name)))
            (require (not (memq rosalind (list mary melissa gabrielle lorna 'hall))))
            (require
              (cond
                ;((eq? gabrielle 'moore) (eq? lorna 'parker)) ;; 分支不会成立，已有 (require (eq? mary 'moore))
                ;((eq? gabrielle 'downing) (eq? melissa 'parker)) ;; 分支不会成立，已有 (eq? melissa 'barnacle)
                ((eq? gabrielle 'hall) (eq? rosalind 'parker))
                ((eq? gabrielle 'barnacle) (eq? gabrielle 'parker))
                (else false))
              )
            (list (list 'mary mary)
                  (list 'gabrielle gabrielle)
                  (list 'lorna lorna)
                  (list 'rosalind rosalind)
                  (list 'melissa melissa))))))))

;; 这个实现暴力搜索，较慢但比较清晰
(define (yacht-puzzle-brush)
  (let ((mary (a-father-name))
        (melissa (a-father-name))
        (gabrielle (a-father-name))
        (lorna (a-father-name))
        (rosalind (a-father-name)))
    
    (require (eq? mary 'moore))
    (require (eq? melissa 'barnacle))
    (require (not (eq? lorna 'moore)))
    (require (not (eq? rosalind 'hall)))
    (require (distinct? (list mary gabrielle lorna rosalind melissa)))
    
    (require
      (cond
        ((eq? gabrielle 'moore) (eq? lorna 'parker))
        ((eq? gabrielle 'downing) (eq? melissa 'parker))
        ((eq? gabrielle 'hall) (eq? rosalind 'parker))
        ((eq? gabrielle 'barnacle) (eq? gabrielle 'parker))
        (else false))
      )
    
    (list (list 'mary mary)
          (list 'gabrielle gabrielle)
          (list 'lorna lorna)
          (list 'rosalind rosalind)
          (list 'melissa melissa))))


(yacht-puzzle)

))

