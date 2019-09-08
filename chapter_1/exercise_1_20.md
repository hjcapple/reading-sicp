## P33 - [练习 1.20]

``` Scheme
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
```

-------

采用正则序 `(gcd 206 40)` 的整个计算过程分析起来有点啰嗦。

``` Scheme
(gcd 206 40)
(if (= 40 0)    ;; #f
    206
    (gcd 40 (remainder 206 40)))
(gcd 40 (remainder 206 40))
```
为了描述方便 

* 设 `B0 = (remainder 206 40) = 6`，包含 1 次 remainder 调用。

注意，B0 并非表示 6 这个数字，而是 `(remainder 206 40)` 这个式子。正则序最开始并不会进行计算，只会进行替换展开。

``` Scheme
(gcd 40 B0)
(if (= B0 0)    ;; #f, 调用 1 次 remainder
	40
	(gcd B0 (remainder 40 B0)))
```

* 累计调用 1 次 remainder。
* 设 `B1 = (remainder 40 B0) = 4`, 包含 2 次 remainder 调用。

``` Scheme
(gcd B0 B1)
(if (= B1 0)    ;; #f, 调用 2 次 remainder
    B0
    (gcd B1 (remainder B0 B1)))
```
    
* 累计调用 3 次 remainder。
* 设 `B2 = (remainder B0 B1) = 2`, 包含 4 次 remainder 调用。

``` Scheme
(gcd B1 B2)
(if (= B2 0)    ;; #f, 调用 4 次 remainder
    B1
    (gcd B2 (remainder B1 B2)))
```
    
* 累计调用 7 次 remainder。
* 设 `B3 = (remainder B1 B2) = 0`, 包含 7 次 remainder 调用。

``` Scheme
(gcd B2 B3)
(if (= B3 0)    ;; #t，调用 7 次 remainder
    B2
    (gcd B3 (remainder B2 B3)))
B2              ;; 调用 4 次 remainder
```

因此，最后累计调用了 `7 + 7 + 4 = 18` 次 remainder。可以看到正则序先完全替换，最后再计算。会重复计算多次 remainder。比如 B2 只是简写，完全展开如下，就计算了两次 `(remainder 206 40)`。

``` Scheme
B2
(remainder B0 B1)
(remainder B0 (remainder 40 B0))
(remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
``` 

-----

采用应用序展开 `(gcd 206 40)` 就简单多了，如下

``` Scheme
(gcd 206 40)
(gcd 40 (remainder 206 40)) ;; 累计 1 次
(gcd 40 6)
(gcd 6 (remainder 40 6))    ;; 累计 2 次
(gcd 6 4)
(gcd 4 (remainder 6 4))     ;; 累计 3 次
(gcd 4 2)
(gcd 2 (remainder 4 2))     ;; 累计 4 次
(gcd 2 0)
2
``` 

可以看到，对于应用序求值，累计调用了 4 次 remainder。比采用正则序少得多。

	