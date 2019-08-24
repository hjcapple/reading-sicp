## P104 - [练习 2.60]

``` Scheme
#lang racket

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)
  (append set1 set2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define a '(1 2 2 3 4 4 5 6))
(define b '(4 4 5 6 7 8 9))

(element-of-set? 10 a)  ; #f
(element-of-set? 9 b)   ; #t

(adjoin-set 10 a)       ; '(10 1 2 2 3 4 4 5 6)
(intersection-set a b)  ; '(4 4 5 6)
(union-set a b)         ; '(1 2 2 3 4 4 5 6 4 4 5 6 7 8 9)
```


上面实现中，`element-of-set?` 和 `intersection-set` 跟无重复表示是一样的。`element-of-set?` 的复杂度为 O(n), `intersection-set` 复杂度是 O(n ^ 2)。

而 `adjoin-set` 是常数复杂度 O(1)，`union-set` 复杂度是 O(n), 被之前耗时短。

在有重复的表示下，假如数据重复率过高，就会耗费更多内存空间，查找也越慢。

有重复的表示，适合于那种数据本身重复的几率较小的场合。

比如一个浏览器的广告拦截名单，可以让用户自己添加某些网站，之后网站的广告就可被过滤。通常用户是看到自己不想看到的广告，才会去添加新的名单，而不会凭空添加新网站名单。而之前已添加的网站，不会看到广告，通常情况下就想不起要添加新名单了。于是这个广告拦截名单重复的几率就比较小。

再比如用户存储下雨的日子，之后再进行查询。有很大可能，用户只会每天添加一条记录。也有少数可能，用户忘记了，会重复添加记录。在这种应用场合下，数据本身的重复几率会比较少。

