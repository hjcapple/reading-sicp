## P324 - [练习 4.67]

在 [queryeval.scm](./queryeval.scm) 的基础上修改测试。

### 代码

先添加一些代码，用于记录查询历史。这里的 `THE-QUERY-HISTORY` 相当于全局变量。实际工程中，随便定义全局变量是不好的。这里定义全局变量，是为了改动较少。

``` Scheme
(define THE-QUERY-HISTORY '())

;; 清空历史记录
(define (history-reset!)
  (set! THE-ASSERTIONS '()))

;; 插入
(define (history-insert! query frame)
  (set! THE-ASSERTIONS 
        (cons (cons query frame) THE-ASSERTIONS)))

;; 判断
(define (history-has? query frame)
  (define (simple-instantiate query frame)
    (instantiate query
                 frame
                 (lambda (v f)
                   (string->symbol
                     (string-append "?" 
                                    (if (number? (cadr v))
                                        (string-append (symbol->string (caddr v)))
                                        (symbol->string (cadr v))))))
                 
                 ))
  (define (same? item query frame)
    (let ((i0 (simple-instantiate (car item) (cdr item)))
          (i1 (simple-instantiate query frame)))
      (equal? i0 i1)))
  (define (iter history query frame)
    (if (null? history)
        #f
        (if (same? (car history) query frame)
            #t
            (iter (cdr history) query frame))))
  (iter THE-ASSERTIONS query frame))
```

有了上述的历史记录代码。稍微修改 `query-driver-loop`, `simple-query`。

``` Scheme
(define (query-driver-loop)
  (prompt-for-input input-prompt)
  (let ((q (query-syntax-process (read))))
    (history-reset!)    ;; 清空历史记录
    xxx))

(define (simple-query query-pattern frame-stream)
  (stream-flatmap
    (lambda (frame)
      (if (history-has? query-pattern frame)      ;; 判断是否已被查询
          the-empty-stream
          (begin 
            (history-insert! query-pattern frame) ;; 将查询插入到历史记录中
            (stream-append-delayed
              (find-assertions query-pattern frame)
              (delay (apply-rules query-pattern frame))))))
    frame-stream))
```    

### 一点注释

我们在历史记录中，插入 `(cons query frame)` 对。`history-has?` 中遍历记录，判断是否相同。

same? 的实现中，将 `(cons query frame)` 还原成原始的形式，方便做判断。

特别注意，我们在 `instantiate` 中写自己的 lambda, 并没有直接调用 `contract-question-mark` 函数。因为代码 `apply-a-rule` 会将规则的变量重命名。比如每次使用规则，变量 `(? boss)` 依次重命名为

```
(? 1 boss)
(? 2 boss)
(? 3 boss)
```

假如使用 `contract-question-mark` 函数，这些变量的名字会还原成 `?boss-1`、`?boss-2`、`?boss-3`。这样会导致重复应用相同的规则，名字都不相同，还是会引起无穷循环。在 `simple-instantiate` 中，上述名字都会被还原成 `?boss`。

### 测试

修改后，正文原来会引起无穷循环的查询

``` Scheme
(assert! (married Minnie Mickey))
(assert! (rule (married ?x ?y)
               (married ?y ?x)))
(married Mickey ?who)
```

可以正确返回查询结果

``` Scheme
(married Mickey Minnie)
```
