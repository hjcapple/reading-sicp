## P340 - [练习 4.77]

在 [queryeval.scm](./queryeval.scm) 的基础上修改测试。

### 代码

``` Scheme
(define (conjoin conjuncts frame-stream) 
  (conjoin-mix conjuncts '() frame-stream)) 

(define (conjoin-mix conjs delayed-conjs frame-stream) 
  (if (empty-conjunction? conjs) 
      frame-stream
      (let ((first (first-conjunct conjs))
            (rest (rest-conjuncts conjs)))
        (cond ((and (filter-exp? first) (has-unbound-var? first frame-stream))
               (conjoin-mix rest (cons first delayed-conjs) frame-stream))
              ((and (filter-exp? first) (not (has-unbound-var? first frame-stream)))
               (conjoin-mix rest delayed-conjs (qeval first frame-stream)))
              (else
                (conjoin-delayed rest delayed-conjs (qeval first frame-stream)))))))

(define (conjoin-delayed conjs delayed-conjs frame-stream)
  (define (iter lst delayed-conjs frame-stream)
    (if (null? lst)
        (conjoin-mix conjs delayed-conjs frame-stream)
        (let ((first (car lst)))
          (if (has-unbound-var? first frame-stream)
              (iter (cdr lst) (cons first delayed-conjs) frame-stream)
              (iter (cdr lst) delayed-conjs (qeval first frame-stream))))))
  (iter delayed-conjs '() frame-stream))

(define (filter-exp? exp)
  (or (eq? (type exp) 'lisp-value)
      (eq? (type exp) 'not)))

(define (has-unbound-var-frame? exp frame) 
  (define (tree-walk exp)
    (cond ((var? exp) 
           (let ((binding (binding-in-frame exp frame))) 
             (if binding 
                 (tree-walk (binding-value binding)) 
                 true))) 
          ((pair? exp) 
           (or (tree-walk (car exp)) (tree-walk (cdr exp)))) 
          (else false))) 
  (tree-walk exp))

(define (has-unbound-var? exp frame-stream)
  (has-unbound-var-frame? exp (stream-car frame-stream)))
``` 

### 测试

修改后，`lisp-value` 和 `not` 语句就可以出现在 `and` 的最前面。如下面查询

``` Scheme
(and (not (job ?x (computer programmer)))
     (supervisor ?x ?y))
```

结果为

``` Scheme
(and (not (job (Aull DeWitt) (computer programmer))) (supervisor (Aull DeWitt) (Warbucks Oliver)))
(and (not (job (Cratchet Robert) (computer programmer))) (supervisor (Cratchet Robert) (Scrooge Eben)))
(and (not (job (Scrooge Eben) (computer programmer))) (supervisor (Scrooge Eben) (Warbucks Oliver)))
(and (not (job (Bitdiddle Ben) (computer programmer))) (supervisor (Bitdiddle Ben) (Warbucks Oliver)))
(and (not (job (Reasoner Louis) (computer programmer))) (supervisor (Reasoner Louis) (Hacker Alyssa P)))
(and (not (job (Tweakit Lem E) (computer programmer))) (supervisor (Tweakit Lem E) (Bitdiddle Ben)))
```     
