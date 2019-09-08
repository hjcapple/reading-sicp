## P35 - [练习 1.22]

``` Scheme
#lang racket

(define (square x) (* x x))
(define (runtime) (current-inexact-milliseconds)) 

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

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (begin
        (report-prime n (- (runtime) start-time))
        #t)
      #f))

(define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " is prime: ")
  (display elapsed-time))

(define (search-for-primes n count)
  (define (make-odd n)
    (if (even? n)
        (+ n 1)
        n))
  (define (iter-even n count)
    (cond ((not (= count 0))
           (if (timed-prime-test n)
               (iter-even (+ n 2) (- count 1))
               (iter-even (+ n 2) count)))))
  (iter-even (make-odd n) count))

;;;;;;;;;;;;;;;;;
(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)
(search-for-primes 10000000 3)
(search-for-primes 100000000 3)

```

现代的机器比以前快得多，我多寻找了几个素数。用 Racket 执行程序，在我的机器上结果如下，时间单位是毫秒。

```
1009 is prime: 0.001953125
1013 is prime: 0.0029296875
1019 is prime: 0.001953125
10007 is prime: 0.007080078125
10009 is prime: 0.008056640625
10037 is prime: 0.008056640625
100003 is prime: 0.02197265625
100019 is prime: 0.02197265625
100043 is prime: 0.023193359375
1000003 is prime: 0.071044921875
1000033 is prime: 0.070068359375
1000037 is prime: 0.06982421875
10000019 is prime: 0.21923828125
10000079 is prime: 0.219970703125
10000103 is prime: 0.220947265625
100000007 is prime: 0.672119140625
100000037 is prime: 0.696044921875
100000039 is prime: 0.68994140625
```

3 个素数时间值取平均数，耗时

| n 附近   | 1000  | 10000  | 100000  | 1000000  | 10000000 | 100000000 |
|---------|-------|--------|---------|----------|----------|-----------|
| 时间(ms) | 0.002279 | 0.007731  | 0.022380  | 0.0703125   |0.220052    | 0.686035     |
| 跟前面时间比值 | - | 3.392857  | 2.894737  | 3.141818   |3.129630     | 3.117604     |

每次 n 增加 10 倍，时间增加 3 倍左右。而 `sqrt(10) = 3.1622`。

实际测量时间跟 sqrt(10) 并非严格相等，但还是比较接近的。计算机本身速度快慢，资源占用，解释器运行状况，会影响测量时间，实际上也不可能跟 sqrt(10) 严格相等。但算法复杂度分析，可以脱离计算机的具体环境，较好地描述了增长速度的快慢。

