## P366 - [练习 5.8]

### a)

控制器到达 there 时，寄存器 a 的内容是 3。

汇编程序在处理指令时，调用 `extract-labels`，会将 labels 按顺序存放。之后调用 lookup-label 按顺序查找。也就是说，假如两个标号的名字相同，会引用标号第一次出现的位置。

于是 `(goto (label here))` 会跳转到下面指令当中，寄存器 a 的内容修改为 3。

``` Scheme
here
  (assign a (const 3))
  (goto (label there))
```

### b)

在 [ch5-regsim.scm](./ch5-regsim.scm) 的基础上，将 `extract-labels` 修改为:

``` Scheme
(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels 
        (cdr text)
        (lambda (insts labels)
          (let ((next-inst (car text)))
            (if (symbol? next-inst)
                ;; 这里添加判断，识别重复的标号
                (if (assoc next-inst labels)
                    (error "The label has existed EXTRACT-LABELS" next-inst)
                    (receive insts
                             (cons (make-label-entry next-inst insts)
                                   labels)))
                (receive (cons (make-instruction next-inst) insts)
                         labels)))))))
```



