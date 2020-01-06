## P303 - [练习 4.50]

### a)

在 [ambeval.scm](./ambeval.scm) 的基础上修改测试。`analyze` 添加判断

``` Scheme
((ramb? exp) (analyze-ramb exp))
```

`analyze-ramb` 的实现如下

``` Scheme
(define (insert-list lst item n)
  (if (= n 0)
      (cons item lst)
      (cons (car lst) (insert-list (cdr lst) item (- n 1)))))

(define (shuffle lst)
  (if (null? lst)
      lst
      (let ((n (random (length lst))))
        (insert-list (shuffle (cdr lst)) (car lst) n))))

(define (ramb? exp) (tagged-list? exp 'ramb))
(define (ramb-choices exp) (shuffle (cdr exp)))

(define (analyze-ramb exp)
  (let ((cprocs (map analyze (ramb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((car choices) env
                           succeed
                           (lambda ()
                             (try-next (cdr choices))))))
      (try-next cprocs))))
```

### b)

[练习 4.49](./exercise_4_49.scm) 的代码，将 amb 修改成 ramb 后，每次执行程序，生成的句子都可能会不同。但是每次连续生成十几个句子，还是会很单调。就算修改为 ramb, 对练习 4.49 中 Alyssa 遇到的问题也没有什么帮助。

比如某一次运行，其结果为

``` Scheme
;; ;; (parse '(1 2 3))
(a class sleeps)
(a class eats)
(a class lectures)
(a class studies)
(a cat sleeps)
(a cat eats)
(a cat lectures)
(a cat studies)
(a professor sleeps)
(a professor eats)
(a professor lectures)
(a professor studies)
(a student sleeps)
(a student eats)
(a student lectures)
...

;; (parse '(1 2 3 4 5 6 7 8 9))
(a class with a class with a class sleeps)
(a class with a class with a class eats)
(a class with a class with a class lectures)
(a class with a class with a class studies)
(a class with a class with a cat sleeps)
(a class with a class with a cat eats)
(a class with a class with a cat lectures)
(a class with a class with a cat studies)
(a class with a class with a professor sleeps)
(a class with a class with a professor eats)
(a class with a class with a professor lectures)
(a class with a class with a professor studies)
(a class with a class with a student sleeps)
(a class with a class with a student eats)
(a class with a class with a student lectures)
...
```

