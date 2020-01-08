## P312 - [练习 4.60]

### a)

`lives-near` 的规则为

``` Scheme
(rule (lives-near ?person-1 ?person-2)
      (and (address ?person-1 (?town . ?rest-1))
           (address ?person-2 (?town . ?rest-2))
           (not (same ?person-1 ?person-2))))
```

规则本身不涉及员工的顺序，person-1、person-2 是对称的。假如 (A、B) 满足规则，(B、A) 一定也会满足规则。于是每对员工都会出现两次，只是顺序不同。

### b)

要每对员工都只出现一次，查询语句中可以对员工的名字进行排序。

``` Scheme
(and (lives-near (?last-name-1 . ?n1) (?last-name-2 . ?n2))
     (lisp-value
       (lambda (s1 s2) (string<=? (symbol->string s1) (symbol->string s2))) 
       ?last-name-1 ?last-name-2))
```

查询结果

``` Scheme
(and (lives-near (Aull DeWitt) (Reasoner Louis)) 
     (lisp-value 
       (lambda (s1 s2) (string<=? (symbol->string s1) (symbol->string s2))) 
       Aull 
       Reasoner))
(and (lives-near (Aull DeWitt) (Bitdiddle Ben)) (lisp-value ...))
(and (lives-near (Fect Cy D) (Hacker Alyssa P)) (lisp-value ...))
(and (lives-near (Bitdiddle Ben) (Reasoner Louis)) (lisp-value ...))                 
```
