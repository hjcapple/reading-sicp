## P31 - [练习 1.19]

这道题其实是，斐波那契的矩阵形式的变种。斐波那契的矩阵形式为：

$$\begin{bmatrix} 1 & 1 \\
1 & 0 \end{bmatrix}^{n}= \begin{bmatrix}F_{n+1} & F_{n} \\
F_{n} &  F_{n-1}\end{bmatrix}= \begin{bmatrix}F_{n-1} + F_{n} & F_{n} \\
F_{n} &  F_{n-1}\end{bmatrix}$$

------

变化 $T_{pq}$ 对于对偶 (a, b) 的作用规则为

```
a ← bq + aq + ap
b ← bp + aq
```

其实可以写成

$$\begin{bmatrix}a' \\
b' \end{bmatrix} = \begin{bmatrix}p + q & q \\
q & p \end{bmatrix}\begin{bmatrix}a \\
b \end{bmatrix}=\begin{bmatrix}bq + aq + ap \\
bp + aq \end{bmatrix}$$

这里的 $T_{pq}$，矩阵形式就为

$$T_{pq}=\begin{bmatrix}p + q & q \\
q & p \end{bmatrix}$$

于是

$$T_{pq}^{2}=\begin{bmatrix}p + q & q \\
q & p \end{bmatrix}^{2} = \begin{bmatrix}(p+q)^{2}+q^{2} & 2pq + q^{2} \\
2pq + q^{2} & p^{2} + q^{2} \end{bmatrix}=\begin{bmatrix}(p^{2} + q^{2})+(2pq + q^{2}) & 2pq + q^{2} \\
2pq + q^{2} & p^{2} + q^{2} \end{bmatrix}$$

将上述最右边看成是新的 $T_{p'q'}$ 变换。有

$$T_{p'q'}=\begin{bmatrix}p' + q' & q' \\
q' & p' \end{bmatrix}=T_{pq}^{2}=\begin{bmatrix}(p^{2} + q^{2})+(2pq + q^{2}) & 2pq + q^{2} \\
2pq + q^{2} & p^{2} + q^{2} \end{bmatrix}$$

对比之后，得到结果

```
p ← pp + qq
q ← 2pq + qq
```

------

最后代码为：

``` Scheme
#lang racket

(define (fast-fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))    ;compute p'
                   (+ (* 2 p q) (* q q))  ;compute q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

;;;;;;;;;;;;;;;;;;;
(module* test #f
  (require rackunit)
  (define (for-loop n last op)
    (cond ((<= n last)
           (op n)
           (for-loop (+ n 1) last op))))
  
  (define (fib n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          (else (+ (fib (- n 1)) 
                   (fib (- n 2))))))
  
  (define (check i)
    (check-equal? (fib i) (fast-fib i)))
  
  (for-loop 0 20 check)
)
```
