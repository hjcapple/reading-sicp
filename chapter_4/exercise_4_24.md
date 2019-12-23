## P276 - [练习 4.24]

修改 [mceval.scm](./mceval.scm), 在 `driver-loop` 中添加计时。

``` Scheme
(#%require (only racket current-inexact-milliseconds))

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let* ((input (read))
         (star-time (current-inexact-milliseconds)))
    (let ((output (eval input the-global-environment)))
      (announce-output (- (current-inexact-milliseconds) star-time))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
```  

写一段测试代码，累计求和，并循环多次。这样两个函数 sum、loop，里面都有递归。

``` Scheme
(begin 
  (define (sum a b)
    (if (= a b)
        a
        (+ (sum a (- b 1)) b)))
  
  (define (loop n f)
    (cond ((> n 0) 
           (f)
           (loop (- n 1) f))))
  
  (loop 1000 (lambda () (sum 1 1000)))  
)
```

在我的同一机器上跑上面的测试代码。

* 原来的求值器(没有预先分析），耗时 12.372 秒。
* 本节修改后的求值器(预先分析，再求值)，耗时 5.738 秒。

测试代码循环多次。分析再求值中，无论循环执行多少次，分析也只是一次。

于是忽略误差（分析只有一次，可忽略其时间），5.738 秒是纯粹的执行时间。而原来的求值器中，每次循环都需要分析和执行，于是分析加执行的时间为 12.372 秒。

因此，上面测试代码中。对于单独的函数（假如不循环）

* 执行时间占比为 `5.738/12.372 = 0.46 = 46%`。
* 分析时间占比为 `54%`。

注意，测试代码中其实有两个 sum、loop 两个函数。两者的分析、执行时间占比可能有所不同，其实应该分别讨论。上面的计算是将两者平均了。但也大概可看出，此例中，分析和执行的时间大概是一半一半。
