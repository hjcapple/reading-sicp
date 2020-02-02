## P421 - [练习 5.36]

### a)

我们的编译器，对运算对象的求值顺序是从右到左。比如编译代码 `(f 1 2)`, 结果为

```
((assign proc (op lookup-variable-value) (const f) (reg env))
 (assign val (const 2))
 (assign argl (op list) (reg val))
 (assign val (const 1))
 (assign argl (op cons) (reg val) (reg argl))
 (test (op primitive-procedure?) (reg proc))
 ...)
```

很明显看出，是先求值 2，再求值 1。

### b)

[编译器代码中](./ch5-compiler.scm), 是过程 `construct-arglist` 决定了参数的求值顺序。假如将求值顺序修改为从左到右，修改为

``` Scheme
(define (construct-arglist operand-codes)
  ;; (let ((operand-codes (reverse operand-codes))) 删掉这一行，不再逆序
  (if (null? operand-codes)
      (make-instruction-sequence '() '(argl)
       '((assign argl (const ()))))
      (let ((code-to-get-last-arg
             (append-instruction-sequences
              (car operand-codes)
              (make-instruction-sequence '(val) '(argl)
               '((assign argl (op list) (reg val)))))))
        (if (null? (cdr operand-codes))
            code-to-get-last-arg
            (preserving '(env)
             code-to-get-last-arg
             (code-to-get-rest-args
              (cdr operand-codes)))))))

(define (code-to-get-rest-args operand-codes)
  (let ((code-for-next-arg
         (preserving '(argl)
          (car operand-codes)
          (make-instruction-sequence '(val argl) '(argl)
           '((assign argl
              (op adjoin-arg) (reg val) (reg argl))))))) ;; 这里用 (op adjoin-arg) 替代 (op cons)
    (if (null? (cdr operand-codes))
        code-for-next-arg
        (preserving '(env)
         code-for-next-arg
         (code-to-get-rest-args (cdr operand-codes))))))
```

### c)

`adjoin-arg` 的实现为

``` Scheme
(define (adjoin-arg arg arglist)
  (append arglist (list arg)))
``` 

`adjoin-arg` 使用了 `append`，效率会比原来的 `cons` 慢。而原始从右到左顺序的实现中，需要调用 `reverse` 来反转参数表。一来二去，似乎两者效率差别不大。

但是要注意，`adjoin-arg` 替代 `cons` 是在运行期执行的。而调用 `reverse` 反转参数表只是在编译时执行的，运行时并不需要反转参数表。因此在运行时，参数求值顺序从右到左的效率更高。

另外求值顺序从左到右的另一种实现方式是：先按顺序调用 `cons` 组合参数（这样组合出来的参数表是逆序的），最终再调用 `reverse` 反转一下。这种实现会将 `cons` 和 `reverse` 都放到了执行期。还是会比原来从右到左的求值顺序要慢。

