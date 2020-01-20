## P371 - 练习 5.12

[完整的代码在这里](./exercise_5_12.scm)

我们在 `make-machine` 中创建出新的机器，在其中保存统计信息。添加了一些获取统计的消息，其他消息转发到原来的机器当中。

``` Scheme
(define (make-new-machine-dataset)
  (let ((machine (make-new-machine))
        (inst-dataset-table '())
        (register-dataset-table '())
        (assign-dataset-table '()))
    
    xxxxx
    
    (define (dispatch message)
      (cond ((eq? message 'get-inst-dataset) get-inst-dataset)
            ((eq? message 'get-register-dataset) get-register-dataset)
            ((eq? message 'get-assign-dataset) get-assign-dataset)
            ((eq? message 'print-all-dataset-table) print-all-dataset-table)
            (else (machine message))))                      
    dispatch))
```

其中

* `inst-dataset-table` 用于保存指令表。对应问题 1。
* `register-dataset-table` 用于保存 goto、save、restore 所用到的寄存器。对应问题 2、3。
* `assign-dataset-table` 保存赋值的来源。对应问题 4。

之后再改写 `make-execution-procedure`，在其中根据每条指令，添加统计信息。


### 输出结果

使用分析器执行[斐波那契机器](./fib-machine.scm), 输出下面分析信息。

```
Instructions: 
==============
restore: 
(restore val)
(restore continue)
(restore n)

goto: 
(goto (reg continue))
(goto (label fib-loop))

save: 
(save val)
(save n)
(save continue)

branch: 
(branch (label immediate-answer))

test: 
(test (op <) (reg n) (const 2))

assign: 
(assign val (reg n))
(assign val (op +) (reg val) (reg n))
(assign n (reg val))
(assign continue (label afterfib-n-2))
(assign n (op -) (reg n) (const 2))
(assign n (op -) (reg n) (const 1))
(assign continue (label afterfib-n-1))
(assign continue (label fib-done))

Register: 
==============
goto: 
continue

restore: 
val
continue
n

save: 
val
n
continue

Assign: 
==============
val: 
((reg n))
((op +) (reg val) (reg n))

n: 
((reg val))
((op -) (reg n) (const 2))
((op -) (reg n) (const 1))

continue: 
((label afterfib-n-2))
((label afterfib-n-1))
((label fib-done))
```

