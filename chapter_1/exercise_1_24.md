## P36 - [练习 1.24]

将[练习 1.22](./exercise_1_22.md) 和 [费马检测](./fermat_test.md) 的程序合起来，修改为

``` Scheme
#lang racket

(define (square x) (* x x))
(define (runtime) (current-inexact-milliseconds)) 

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))  

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 100)
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

输出

```
1009 is prime: 0.1279296875
1013 is prime: 0.135986328125
1019 is prime: 0.13916015625
10007 is prime: 0.1708984375
10009 is prime: 0.166015625
10037 is prime: 0.1689453125
100003 is prime: 0.192138671875
100019 is prime: 0.197021484375
100043 is prime: 0.197998046875
1000003 is prime: 0.217041015625
1000033 is prime: 0.218994140625
1000037 is prime: 0.22412109375
10000019 is prime: 0.2509765625
10000079 is prime: 0.26318359375
10000103 is prime: 0.26318359375
100000007 is prime: 0.2919921875
100000037 is prime: 0.2958984375
100000039 is prime: 0.302978515625
```

将 3 个素数时间值取平均数，做成表格

| n 附近       | 1000  | 10000  | 100000  | 1000000  | 10000000 | 100000000 |
|-------------|-------|--------|---------|----------|----------|-----------|
| 时间(ms)     | 0.134359 | 0.168620  | 0.195719  | 0.220052   |0.259115     | 0.296956     |
| 跟前面时间差值 | -  |  0.034261 | 0.027100 | 0.024333 | 0.039062 | 0.037842 |

因为算法复杂度为 O(logN)，会预期每次增加 10 倍，时间只会递增一个常数值。注意上表是在算差值，而不是比值。

但可以看到，这里并非严格的常数值，会有所偏差。

在此例中，虽然算法复杂度为 O(logN)，但程序当中会计算随机值作为指数的阶，这个随机值会影响 `expmod` 的执行速度。

计算机实际的运行时间受到多方面的影响，比如计算机的当前 CPU 和内存占用，解释器运行状况，时间会有所波动。现代的计算机执行速度很快，而计算机运行越快，程序本身运行时间越短，波动影响就会越大。

算法复杂度分析，可以描述了增长速度的快慢，会对速度的长期增长有个估算。但并非真正的绝对时间。






