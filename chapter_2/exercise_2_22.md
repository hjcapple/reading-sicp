## P71 - [练习 2.22]

``` Scheme
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) 
              (cons (square (car things))
                    answer))))
  (iter items null))
```

使用上述代码求值 `(square-list (list 1 2 3 4))`, 展开计算过程。

``` Scheme
(square-list (list 1 2 3 4))
(iter '(1 2 3 4) '())
(iter '(2 3 4) (cons 1 '()))
(iter '(3 4) (cons 4 (cons 1 '())))
(iter '(4) (cons 9 (cons 4 (cons 1 '()))))
(iter '() (cons 16 (cons 9 (cons 4 (cons 1 '())))))
(cons 16 (cons 9 (cons 4 (cons 1 '()))))
'(16 9 4 1)
```
开始看到，每次迭代。会取出 things 的第一个数字，计算 square 后，粘在 answer 的前面。于是顺序就反过来了。

事实上，将这段代码的 square 去掉。就是 [练习 2.18](./exercise_2_18.scm) 的 reverse 实现。

--------

``` Scheme
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things) 
              (cons answer 
                    (square (car things))))))
  (iter items null))
```

使用修改后的代码求值，`(square-list (list 1 2 3 4))`, 展开计算过程。

``` Scheme
(square-list (list 1 2 3 4))
(iter '(1 2 3 4) '())
(iter '(2 3 4) (cons '() 1))
(iter '(3 4) (cons (cons '() 1) 4))
(iter '(4) (cons (cons (cons '() 1) 4) 9))
(iter '() (cons (cons (cons (cons '() 1) 4) 9) 16))
(cons (cons (cons (cons '() 1) 4) 9) 16)
'((((() . 1) . 4) . 9) . 16)
```

修改后，虽然数字的顺序对了，但是求值结果并非是列表。在 DrRacket 中。

``` Scheme
(cons (cons (cons (cons '() 1) 4) 9) 16)
```

的求值结果表示为

``` Scheme
'((((() . 1) . 4) . 9) . 16)
```

而

``` Scheme
(cons 1 (cons 4 (cons 9 (cons 16 '()))))
```

的求值结果，才是 list。

``` Scheme
'(1 4 9 16)
```
