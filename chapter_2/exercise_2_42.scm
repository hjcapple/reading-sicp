#lang racket

;; P84 - [练习 2.42, 八皇后问题]

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define empty-board null)

(define (safe? k positions)
  (define (same-row? v0 v1)
    (= (car v0) (car v1)))
  
  (define (same-diag? v0 v1)
    (= (abs (- (car v0) (car v1))) 
       (abs (- (cdr v0) (cdr v1)))))
  
  ;; pair_list 中还原出 (row, col) 对
  (let ((pair_list (map cons positions (enumerate-interval 1 k))))
    (let ((val (car pair_list)))
      (= (length 
          (filter (lambda (x) 
                    (or (same-row? x val) (same-diag? x val)))
                  (cdr pair_list)))
         0))))

;; 将 new-row 粘在前面，safe? 中用 car 取出。
;; 也可以用 append 粘在后面，只是取出时就会麻烦一些。粘在前面还时后面，结果是等价的，只是解的顺序有所不同
(define (adjoin-position new-row k rest-of-queens)
  (cons new-row rest-of-queens))
  
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter 
          (lambda (positions) (safe? k positions))
          (flatmap
            (lambda (rest-of-queens)
              (map (lambda (new-row)
                     (adjoin-position new-row k rest-of-queens))
                   (enumerate-interval 1 board-size)))
            (queen-cols (- k 1))))))
  (queen-cols board-size))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 程序结果，八皇后问题有 92 个解
;; 其中的解，比如 (4 2 7 3 6 8 5 1) 省略了列号
;; 表示第 1 列放在第 4 行，第 2 列放在第 2 行，以此类推
(queens 8)
              
  
