#lang racket

;; P114 - [练习 2.69]

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x)
  (cadr x))

(define (weight-leaf x)
  (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbol left) (symbol right))
        (+ (weight left) (weight right))))

(define (left-branch tree)
  (car tree))

(define (right-branch tree)
  (cadr tree))

(define (symbol tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        null 
        (let ((next-branch (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))

(define (encode message tree)
  (if (null? message)
      null 
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (if (leaf? tree)
      (if (eq? symbol (symbol-leaf tree))
          '()
          #f)
      (let ((left-result (encode-symbol symbol (left-branch tree))))
        (if left-result
            (cons 0 left-result)
            (let ((right-result (encode-symbol symbol (right-branch tree))))
              (if right-result
                  (cons 1 right-result)
                  #f))))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      null 
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair) (cadr pair))
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge set)
  (if (= (length set) 1)
      (car set)
      (let ((left (car set))
            (right (cadr set))
            (remained (cddr set)))
        (successive-merge (adjoin-set (make-code-tree left right)
                                      remained)))))

(provide generate-huffman-tree encode decode)
             
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define huffman-tree (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1))))
(define symbols '(A D A B B C A))
(define message (encode symbols huffman-tree))

huffman-tree                  ; '((leaf A 4) ((leaf B 2) ((leaf D 1) (leaf C 1) (D C) 2) (B D C) 4) (A B D C) 8)
symbols                       ; '(A D A B B C A)
message                       ; '(0 1 1 0 0 1 0 1 0 1 1 1 0)
(decode message huffman-tree) ; '(A D A B B C A)

