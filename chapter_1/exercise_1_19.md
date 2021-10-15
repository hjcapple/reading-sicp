## P31 - [练习 1.19]

这道题其实是，斐波那契的矩阵形式的变种。斐波那契的矩阵形式为：

<img src="http://latex.codecogs.com/svg.latex?{\left[ \begin{array}{cc}1 & 1 \\1 & 0 \\\end{array} \right ]^{n}} = {\left[ \begin{array}{cc}F_{n+1} & F_{n} \\F_{n} &  F_{n-1}\\\end{array} \right ]} = {\left[ \begin{array}{cc}F_{n-1} + F_{n} & F_{n} \\F_{n} &  F_{n-1}\\\end{array} \right ]}" />

------

变化 <img src="http://latex.codecogs.com/svg.latex?T_{pq}" /> 对于对偶 (a, b) 的作用规则为

```
a ← bq + aq + ap
b ← bp + aq
```

其实可以写成

<img src="http://latex.codecogs.com/svg.latex?\left[ \begin{array}{cc}a' \\b' \end{array} \right ] = \left[ \begin{array}{cc}p + q & q \\q & p \\\end{array} \right ]\left[ \begin{array}{cc}a \\b \end{array} \right ]=\left[ \begin{array}{cc}bq + aq + ap \\bp + aq \end{array} \right ]" />

这里的 <img src="http://latex.codecogs.com/svg.latex?T_{pq}" />，矩阵形式就为

<img src="http://latex.codecogs.com/svg.latex?T_{pq}=\left[ \begin{array}{cc}p + q & q \\q & p \\\end{array} \right ]" />

于是

<img src="http://latex.codecogs.com/svg.latex?T_{pq}^{2}=\left[ \begin{array}{cc}p + q & q \\q & p \\\end{array} \right ]^{2} = \left[ \begin{array}{cc}(p+q)^{2}+q^{2} & 2pq + q^{2} \\2pq + q^{2} & p^{2} + q^{2} \\\end{array} \right ]=\left[ \begin{array}{cc}(p^{2} + q^{2})+(2pq + q^{2}) & 2pq + q^{2} \\2pq + q^{2} & p^{2} + q^{2} \\\end{array} \right ]" />

将上述最右边看成是新的 <img src="http://latex.codecogs.com/svg.latex?T_{p'q'}"/> 变换。有

<img src="http://latex.codecogs.com/svg.latex?T_{p'q'}=\left[ \begin{array}{cc}p' + q' & q' \\q' & p' \\\end{array} \right ]=T_{pq}^{2}=\left[ \begin{array}{cc}(p^{2} + q^{2})+(2pq + q^{2}) & 2pq + q^{2} \\2pq + q^{2} & p^{2} + q^{2} \\\end{array} \right ]"/>

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
