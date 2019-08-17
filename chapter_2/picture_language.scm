#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;; P86 - [图形语言]

(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter))))
    (below painter2 painter2)))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (flipped-pairs-2 painter)
  (let ((combine4 (square-of-four identity flip-vert 
                                  identity flip-vert)))
    (combine4 painter)))

(define (square-limit painter n)
    (let ((combine4 (square-of-four flip-horiz identity
                                    rotate180 flip-vert)))
    (combine4 (corner-split painter n))))
            
;;;;;;;;;;;;;
(define wave einstein)
(paint (flipped-pairs wave))
(paint (right-split wave 3))
(paint (up-split wave 3))
(paint (corner-split wave 3))
(paint (flipped-pairs-2 wave))
(paint (square-limit wave 3))

