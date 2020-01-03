## P291 - [练习 4.40]

### a) 

依次添加条件，遍历所有的可能性。各个约束条件前后的可能性，分别为

``` Scheme
;; 3125
(require (distinct? (list baker cooper fletcher miller smith)))
;; 120
(require (not (= baker 5)))
;; 96
(require (not (= cooper 1)))
;; 78
(require (not (= fletcher 5)))
;; 60
(require (not (= fletcher 1)))
;; 42
(require (> miller cooper))
;; 15
(require (not (= (abs (- smith fletcher)) 1)))
;; 8
(require (not (= (abs (- fletcher cooper)) 1)))
;; 1
```

这表示，没有任何约束条件是，有 3125 种可能性，添加 `distinct?` 约束后，剩 120 种可能性。再添加 `(not (= baker 5))`, 剩 96 种可能性。依次类似。最后满足所有约束条件的，就只剩一种可能性。

### b)

更有效率的过程如下。

``` Scheme
(define (multiple-dwelling)
  (let ((cooper (amb 2 3 4 5))
        (miller (amb 1 2 3 4 5)))
    (require (> miller cooper))
    (let ((fletcher (amb 2 3 4)))
      (require (not (= (abs (- fletcher cooper)) 1)))
      (let ((smith (amb 1 2 3 4 5)))
        (require (not (= (abs (- smith fletcher)) 1)))
        (let ((baker (amb 1 2 3 4)))
          (require (distinct? (list baker cooper fletcher miller smith)))
          (list (list 'baker baker)
                (list 'cooper cooper)
                (list 'fletcher fletcher)
                (list 'miller miller)
                (list 'smith smith)))))))
```                
