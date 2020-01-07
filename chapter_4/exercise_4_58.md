## P312 - [练习 4.58]

运行 [queryeval.scm](./queryeval.scm) 测试。新增的规则为

``` Scheme
(rule (big-shot ?person ?division)
      (and (job ?person (?division . ?job-type))
           (or (not (supervisor ?person ?boss))
               (and (supervisor ?person ?boss)
                    (not (job ?boss (?division . ?boss-job-type)))))))
```

查询测试

``` Scheme
;;; Query input:
(big-shot ?x ?y)

;;; Query results:
(big-shot (Warbucks Oliver) administration)
(big-shot (Scrooge Eben) accounting)
(big-shot (Bitdiddle Ben) computer)
```
