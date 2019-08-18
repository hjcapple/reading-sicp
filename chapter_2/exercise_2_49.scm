#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

;; P93 - [练习 2.49]

;; a) 画出给定框架边界的画家
;; 这里将 0.99 写成 1, 会显示不完整
(define frame-painter
  (segments->painter (list (make-segment (make-vect 0 0) (make-vect 0 0.99))
                           (make-segment (make-vect 0 0.99) (make-vect 0.99 0.99))
                           (make-segment (make-vect 0.99 0.99) (make-vect 0.99 0))
                           (make-segment (make-vect 0.99 0) (make-vect 0 0)))))

;; a) 连接框架两对角画出一个大交叉的画家
(define cross-painter
  (segments->painter (list (make-segment (make-vect 0 0) (make-vect 1 1))
                           (make-segment (make-vect 0 1) (make-vect 1 0)))))

;; c) 连接各边的中点，画出一个菱形的画家
(define diamond-painter
  (segments->painter (list (make-segment (make-vect 0.0 0.5) (make-vect 0.5 1.0))
                           (make-segment (make-vect 0.5 1.0) (make-vect 1.0 0.5))
                           (make-segment (make-vect 1.0 0.5) (make-vect 0.5 0.0))
                           (make-segment (make-vect 0.5 0.0) (make-vect 0.0 0.5)))))

;; d) 画家 wave
 (define wave 
   (segments->painter (list 
                       (make-segment (make-vect .25 0) (make-vect .35 .5)) 
                       (make-segment (make-vect .35 .5) (make-vect .3 .6)) 
                       (make-segment (make-vect .3 .6) (make-vect .15 .4)) 
                       (make-segment (make-vect .15 .4) (make-vect 0 .65)) 
                       (make-segment (make-vect 0 .65) (make-vect 0 .85)) 
                       (make-segment (make-vect 0 .85) (make-vect .15 .6)) 
                       (make-segment (make-vect .15 .6) (make-vect .3 .65)) 
                       (make-segment (make-vect .3 .65) (make-vect .4 .65)) 
                       (make-segment (make-vect .4 .65) (make-vect .35 .85)) 
                       (make-segment (make-vect .35 .85) (make-vect .4 1)) 
                       (make-segment (make-vect .4 1) (make-vect .6 1)) 
                       (make-segment (make-vect .6 1) (make-vect .65 .85)) 
                       (make-segment (make-vect .65 .85) (make-vect .6 .65)) 
                       (make-segment (make-vect .6 .65) (make-vect .75 .65)) 
                       (make-segment (make-vect .75 .65) (make-vect 1 .35)) 
                       (make-segment (make-vect 1 .35) (make-vect 1 .15)) 
                       (make-segment (make-vect 1 .15) (make-vect .6 .45)) 
                       (make-segment (make-vect .6 .45) (make-vect .75 0)) 
                       (make-segment (make-vect .75 0) (make-vect .6 0)) 
                       (make-segment (make-vect .6 0) (make-vect .5 .3)) 
                       (make-segment (make-vect .5 .3) (make-vect .4 0)) 
                       (make-segment (make-vect .4 0) (make-vect .25 0)) 
                       )))

;;;;;;;;;;;;;;;;;;;;
(paint frame-painter)
(paint cross-painter)
(paint diamond-painter)
(paint wave)


