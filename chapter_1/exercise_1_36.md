## P47 - [练习 1.36]

程序为 

``` Scheme
#lang racket

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (let ((tolerance 0.00001))
      (< (abs (- v1 v2)) tolerance)))
  (define (try guess step)
    (display "step ")
    (display step)
    (display ": guess = ")
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next (+ step 1)))))
  (try first-guess 1))

(define (average x y) 
  (/ (+ x y) 2))

(define (find-root)
  (define (f x)
    (/ (log 1000) (log x)))
  (fixed-point f 2))

(define (find-root-damp)
  (define (f x)
    (average x (/ (log 1000) (log x))))
  (fixed-point f 2))

;;;;;;;;;;;;;;;;;
(find-root)
(find-root-damp)

```
------

`find-root` 没有采用平均阻尼，需要 34 步，最终结果 4.555532270803653。

```
step 1: guess = 2
step 2: guess = 9.965784284662087
step 3: guess = 3.004472209841214
step 4: guess = 6.279195757507157
....
step 30: guess = 4.555563237292884
step 31: guess = 4.555517548417651
step 32: guess = 4.555547679306398
step 33: guess = 4.555527808516254
step 34: guess = 4.555540912917957
4.555532270803653
```
------

`find-root-damp` 采用平均阻尼，只需要 9 步，最终结果 4.555537551999825。

```
step 1: guess = 2
step 2: guess = 5.9828921423310435
step 3: guess = 4.922168721308343
step 4: guess = 4.628224318195455
step 5: guess = 4.568346513136242
step 6: guess = 4.5577305909237005
step 7: guess = 4.555909809045131
step 8: guess = 4.555599411610624
step 9: guess = 4.5555465521473675
4.555537551999825
```

可见，采用平均阻尼，大大加快了计算收敛速度。

