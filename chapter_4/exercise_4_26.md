## P278 - [练习 4.26]

### a)

unless 可以实现成 if 的派生表达式。比如

``` Scheme
(unless (= b 0)
        (/ a b)
        (begin (display "exception: returning 0")
          0))

(define (factorial n)
  (unless (= n 1)
          (* n (factorial (- n 1)))
          1))         
```

可以转换为
 
``` Scheme
(if (= b 0)
    (begin (display "exception: returning 0")
      0)
    (/ a b))

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
```          

### b)

``` Scheme
(define select-y '(#t #f #t #t)) 
(define xs '(1 3 5 7)) 
(define ys '(2 4 6 8)) 
(define selected (map unless select-y xs ys))
```

在上面代码中，unless 作为了 map 的参数。

假如 unless 实现为过程，上面代码可以正常运行。但假如将 unless 实现成派生表达式，代码就运行不了。

