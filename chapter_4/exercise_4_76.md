## P340 - [练习 4.76]

在 [queryeval.scm](./queryeval.scm) 的基础上修改测试。

### 代码

``` Scheme
(define (new-conjoin conjuncts frame-stream) 
  (if (empty-conjunction? conjuncts) 
      frame-stream 
      (merge-frame-streams 
        (qeval (first-conjunct conjuncts) frame-stream) 
        (new-conjoin (rest-conjuncts conjuncts) frame-stream)))) 

(define (merge-frame-streams stream1 stream2) 
  (stream-flatmap (lambda (f1) 
                    (stream-filter 
                      (lambda (f) (not (eq? f 'failed))) 
                      (stream-map 
                        (lambda (f2) (merge-frames f1 f2)) 
                        stream2))) 
                  stream1)) 

(define (merge-frames frame1 frame2) 
  (cond ((null? frame1) frame2) 
        ((eq? 'failed frame2) 'failed) 
        (else  
          (let ((var (binding-variable (car frame1))) 
                (val (binding-value (car frame1)))) 
            (let ((extension (extend-if-possible var val frame2)))
              (merge-frames (cdr frame1) extension))))))  
``` 

### 备注

这个 `new-conjoin` 实现，跟原始的 `conjoin` 还是有区别的。处理不了 `lisp-value` 和 `not` 语句。

比如 [练习 4.56](./exercise_4_56.md) 的查询，在 `new-conjoin` 实现下，结果会出错。

``` Scheme
(and (salary (Bitdiddle Ben) ?ben-salary)
     (salary ?person ?person-salary)
     (lisp-value < ?person-salary ?ben-salary))
     
(and (supervisor ?person ?boss)
     (not (job ?boss (computer . ?type)))
     (job ?boss ?boss-job))     
```

原因见正文 P322 页，与 not 有关的问题。可以参考 [练习 4.77](./exercise_4_77.md) 的代码，对 `lisp-value` 和 `not` 特殊处理，修正这个问题。

