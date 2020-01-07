## P312 - [练习 4.57]

运行 [queryeval.scm](./queryeval.scm) 测试。新增的规则为

``` Scheme
(rule (can-replace ?person-1 ?person-2)
      (and (job ?person-1 ?job-1)
           (job ?person-2 ?job-2)
           (not (same ?person-1 ?person-2))
           (or (same ?job-1 ?job-2)
               (can-do-job ?job-1 ?job-2))))
```

### a)

``` Scheme
(can-replace ?x (Fect Cy D))
```

查询结果:

``` Scheme
(can-replace (Hacker Alyssa P) (Fect Cy D))
(can-replace (Bitdiddle Ben) (Fect Cy D))
```

### b)

``` Scheme
(and (can-replace ?person-1 ?person-2)
     (salary ?person-1 ?salary-1)
     (salary ?person-2 ?salary-2)
     (lisp-value < ?salary-1 ?salary-2))
```

查询结果:

``` Scheme
(and (can-replace (Fect Cy D) (Hacker Alyssa P)) 
     (salary (Fect Cy D) 35000) 
     (salary (Hacker Alyssa P) 40000) 
     (lisp-value < 35000 40000))
(and (can-replace (Aull DeWitt) (Warbucks Oliver)) 
     (salary (Aull DeWitt) 25000) 
     (salary (Warbucks Oliver) 150000) 
     (lisp-value < 25000 150000))
```

这里作者幽默了一下。

Warbucks Oliver 是公司大老板，工资 150000。Aull DeWitt 是老板秘书，工资只有 25000。但秘书 Aull DeWitt 可以替代老板 Warbucks Oliver 的工作。

