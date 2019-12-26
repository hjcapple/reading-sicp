## P282 - [练习 4.27]

代码在惰性求值器的响应如下

``` Scheme
(define count 0)
(define (id x)
  (set! count (+ count 1))
  x)

(define w (id (id 10)))

;;; L-Eval input:
count
;;; L-Eval value:
1
;;; L-Eval input:
w
;;; L-Eval value:
10
;;; L-Eval input:
count
;;; L-Eval value:
2
```

### a)

定义 w 后，count 的求值结果为 1, 并非为 0。

追踪 `(define w (id (id 10)))` 的求值过程，依次为

``` Scheme
(eval-definition exp env)
(define-variable! 'w (eval '(id (id 10)) env) env)
(eval '(id (id 10)) env)
(apply (actual-value 'id env) '((id 10)) env)
(apply id '((id 10)) env)
```

`(id 10)` 作为 id 过程的参数，但会延迟求值，`(id 10)` 本身还不会执行。

``` Scheme
(eval-sequence
  (procedure-body id)  ; 这里有副作用，调用了 id 过程体中的 set!
  (extend-environment 
    (procedure-parameters id)
    (list-of-delayed-args '((id 10)) env)
    (procedure-environment id)
    )
  )
```

其中，求值 `eval-sequence` 时，调用了 id 过程体中的语句

``` Scheme
(set! count (+ count 1))  ; 副作用，让 count 改变了
x                         ; x 被延迟求值，这里 x 是 (id 10)
```

于是定义 w 时，只调用了 id 过程一次。count 被修改为 1。

实际上，在惰性求值下，定义 w 时，无论 id 过程出现多少次，count 这时都为 1。

``` Scheme
(define w (id (id (id (id 10)))))
count ; 1
```

### b)

求值 w 时，结果为 10，这很平常。

### c)

求值 w 时，触发了 force-it，让之前的 `(id 10)` 表达式强制求值了。于是 id 过程又再被调用了一次。也就再执行了

``` Scheme
(set! count (+ count 1))
```

于是，这时候 count 的值为 2。

