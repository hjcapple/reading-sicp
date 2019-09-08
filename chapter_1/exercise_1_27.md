## P36 - [练习 1.27]

下面程序搜索前 10 个 carmichael 数字。即通过了所有费马检查，但又不是素数。

``` Scheme
#lang racket

(define (square x) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))  

(define (carmichael-test n)
  (define (fermat-test n a)
    (= (expmod a n n) a))
  
  (define (iter-test n a)
    (cond ((= a 0) #t)
          ((fermat-test n a) (iter-test n (- a 1)))
          (else #f)))
  
  (iter-test n (- n 1)))

(define (search-for-carmichae n count)
  (cond ((not (= count 0))
         (cond ((and (not (prime? n)) (carmichael-test n))
                (displayln n)
                (search-for-carmichae (+ n 1) (- count 1)))
               (else (search-for-carmichae (+ n 1) count))))))

;;;;;;;;;;;;;;;;;
(search-for-carmichae 1 10)

```

输出如下。

```
561
1105
1729
2465
2821
6601
8911
10585
15841
29341
```

其因式分解为

```
561 = 3 × 11 × 17
1105 = 5 × 13 × 17
1729 = 7 × 13 × 19
2465 = 5 × 17 × 29
2821 = 7 × 13 × 31
6601 = 7 × 23 × 41
8911 = 7 × 19 × 67
10585 = 5 × 29 × 73
15841 = 7 × 31 × 73
29341 = 13 × 37 × 61
```

上面程序中，假如将 `search-for-carmichae` 的判断翻转过来写成 `(and (carmichael-test n) (not (prime? n)))` 就会慢很多。这是因为判断 `prime?` 要比`carmichael-test` 快。而当是素数时，`carmichael-test` 一定为真，就包含了多余的运算。

DrRacket 的判断是短路求值，当写成 `(and (not (prime? n)) (carmichael-test n))` 时。假如是素数，`carmichael-test` 就会被跳过。

