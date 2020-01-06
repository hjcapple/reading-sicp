## P272 - [练习 4.21]

此题涉及自指概念，跟 Y combinator 也有点关系。可进一步阅读刘未鹏的文章

* [康托尔、哥德尔、图灵——永恒的金色对角线](http://mindhacks.cn/2006/10/15/cantor-godel-turing-an-eternal-golden-diagonal/)

### a)

原来代码中 `lambda` 嵌套看起来很复杂。我们先用 define 取个名字，简化一下。
 
``` Scheme
(define (func n)
  (define (f-gen fact)
    (fact fact n))
  (define (fact ft k)
    (if (= k 1)
        1
        (* k (ft ft (- k 1)))))
  (f-gen fact))
(func 10)
```

注意，上面的代码中，虽然为每个 lambda 取了名字，但完全是非递归的。上面代码可以更进一步简化，相当于

``` Scheme
(define (fact self k)
  (if (= k 1)
      1
      (* k (self self (- k 1)))))
(fact fact 10)
```

这是一种小诡计。递归函数需要调用自身，既然不可以使用递归，我们就可添加多一个参数(就是那个 self 的参数）, 调用时将自身也传递过去。

-----

现在我们来写类似代码，计算第 10 个斐波纳契数。首先是递归函数，为

``` Scheme
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1)) 
                 (fib (- n 2))))))
(fib 10)
```

添加 self 参数，将 fib 变成非递归。为

``` Scheme
(define (fib self n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (self self (- n 1)) 
                 (self self (- n 2))))))
(fib fib 10)
```

最后去掉函数名字，用 lambda 组装起来

``` Scheme
((lambda (n)
   ((lambda (fib)
      (fib fib n))
    (lambda (self n)
      (cond ((= n 0) 0)
            ((= n 1) 1)
            (else (+ (self self (- n 1)) 
                     (self self (- n 2))))))))
 10)
``` 

### b)

按照 a 的思路，原来的递归函数，添加一个 self 的参数。这里的 event? 和 odd? 是相互递归，于是原始函数添加多了 ev? 和 od? 的参数。补充完整的代码为

``` Scheme
(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))))
```

