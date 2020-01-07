## P311 - [练习 4.56]

运行 [queryeval.scm](./queryeval.scm) 测试。

### a)

``` Scheme
(and (supervisor ?person (Bitdiddle Ben))
     (address ?person ?where))
```

查询结果

``` Scheme
(and (supervisor (Tweakit Lem E) (Bitdiddle Ben)) 
     (address (Tweakit Lem E) (Boston (Bay State Road) 22)))
(and (supervisor (Fect Cy D) (Bitdiddle Ben)) 
     (address (Fect Cy D) (Cambridge (Ames Street) 3)))
(and (supervisor (Hacker Alyssa P) (Bitdiddle Ben)) 
     (address (Hacker Alyssa P) (Cambridge (Mass Ave) 78)))
```

### b)

``` Scheme
(and (salary (Bitdiddle Ben) ?ben-salary)
     (salary ?person ?person-salary)
     (lisp-value < ?person-salary ?ben-salary))
```

查询结果

``` Scheme
(and (salary (Bitdiddle Ben) 60000) (salary (Aull DeWitt) 25000) (lisp-value < 25000 60000))
(and (salary (Bitdiddle Ben) 60000) (salary (Cratchet Robert) 18000) (lisp-value < 18000 60000))
(and (salary (Bitdiddle Ben) 60000) (salary (Reasoner Louis) 30000) (lisp-value < 30000 60000))
(and (salary (Bitdiddle Ben) 60000) (salary (Tweakit Lem E) 25000) (lisp-value < 25000 60000))
(and (salary (Bitdiddle Ben) 60000) (salary (Fect Cy D) 35000) (lisp-value < 35000 60000))
(and (salary (Bitdiddle Ben) 60000) (salary (Hacker Alyssa P) 40000) (lisp-value < 40000 60000))
```

### c)

``` Scheme
(and (supervisor ?person ?boss)
     (not (job ?boss (computer . ?type)))
     (job ?boss ?boss-job))
```

查询结果

``` Scheme
(and (supervisor (Aull DeWitt) (Warbucks Oliver)) 
     (not (job (Warbucks Oliver) (computer . ?type))) 
     (job (Warbucks Oliver) (administration big wheel)))
(and (supervisor (Cratchet Robert) (Scrooge Eben)) 
     (not (job (Scrooge Eben) (computer . ?type))) 
     (job (Scrooge Eben) (accounting chief accountant)))
(and (supervisor (Scrooge Eben) (Warbucks Oliver)) 
     (not (job (Warbucks Oliver) (computer . ?type))) 
     (job (Warbucks Oliver) (administration big wheel)))
(and (supervisor (Bitdiddle Ben) (Warbucks Oliver)) 
     (not (job (Warbucks Oliver) (computer . ?type))) 
     (job (Warbucks Oliver) (administration big wheel)))
```

