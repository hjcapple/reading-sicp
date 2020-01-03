## P291 - [练习 4.39]

### a) 

约束条件的顺序并不会影响结果。同时满足多个条件，相当于 and 运算。and 运算满足交换律和结合率。任意改变条件的顺序，结果也是相同的。

### b)

约束条件的顺序，会影响程序的速度。

我们应该将比较快的判断，放到前面。比较慢的判断，放到后面。

比如 A 判断较快，B 判断较慢。A 放在前面。这样当 A 不成立时，就会立即退出，并不会真正执行 B 的判断。就可以过滤掉尽量多的耗时判断。

对于 `multiple-dwelling` 的实现。最慢是那个 `distinct?` 的判断，我们将其放到最后，可以加快程序速度。

``` Scheme
(define (multiple-dwelling)
  (let ((baker (amb 1 2 3 4 5))
        (cooper (amb 1 2 3 4 5))
        (fletcher (amb 1 2 3 4 5))
        (miller (amb 1 2 3 4 5))
        (smith (amb 1 2 3 4 5)))
    (require (not (= baker 5)))
    (require (not (= cooper 1)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (> miller cooper))
    (require (not (= (abs (- smith fletcher)) 1)))
    (require (not (= (abs (- fletcher cooper)) 1)))
    (require (distinct? (list baker cooper fletcher miller smith))) ;; 放到最后
    (list (list 'baker baker)
          (list 'cooper cooper)
          (list 'fletcher fletcher)
          (list 'miller miller)
          (list 'smith smith))))
```
