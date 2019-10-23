## P243 - [练习 3.80]

[完整代码](./exercise_3_80.scm)

### a)

<!-- $i_{C}=C\frac{dv_{C}}{dt}\Rightarrow\frac{dv_{C}}{dt}=\frac{i_{C}}{C}$ -->

<img src="exercise_3_80_a.svg"/>

<!-- $i_{L}=-i_{C}\Rightarrow\frac{i_{C}}{C}=-\frac{i_{L}}{C}$ -->

<img src="exercise_3_80_b.svg"/>

结合上面两式，有

<!-- $\frac{dv_{C}}{dt}=-\frac{i_{L}}{C}$ -->

<img src="exercise_3_80_c.svg"/>

### b)

<!-- $v_{L}=L\frac{di_{L}}{dt}\Rightarrow\frac{di_{L}}{dt}=\frac{v_{L}}{L}$ -->

<img src="exercise_3_80_d.svg"/>

<!-- $v_{C}=v_{L}+v_{R}\Rightarrow v_{L}=v_{C}-v_{R}$ -->

<img src="exercise_3_80_e.svg"/>

结合上面两式，有

<!-- $\frac{di_{L}}{dt}=\frac{v_{C}-v_{R}}{L}=\frac{v_{C}}{L}-\frac{v_{R}}{L}$ -->

<img src="exercise_3_80_f.svg"/>

另外有

<!-- $v_{R}=i_{R}R, i_{R}=i_{L}\Rightarrow v_{R}=i_{L}R$ -->

<img src="exercise_3_80_g.svg"/>

结合上面两式，得到结果

<!-- $\frac{di_{L}}{dt}=\frac{v_{C}}{L}-\frac{i_{L}R}{L}=\frac{1}{L}v_{C}-\frac{R}{L}i_{L}$ -->

<img src="exercise_3_80_h.svg"/>

### 代码

根据 a)、b) 两式，RLC 代码为

``` Scheme
(define (RLC R L C dt)
  (lambda (vc0 iL0)
    (define vc (integral (delay (scale-stream iL (- (/ 1.0 C)))) vc0 dt))
    (define iL (integral (delay diL) iL0 dt))
    (define diL (add-streams (scale-stream vc (/ 1.0 L))
                             (scale-stream iL (- (/ R L)))))
    (stream-map cons vc iL)))
```



