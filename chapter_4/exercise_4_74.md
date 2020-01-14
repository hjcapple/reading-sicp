## P339 - [练习 4.74]

### a)

``` Scheme
(define (simple-stream-flatmap proc s)
  (simple-flatten (stream-map proc s)))

(define (simple-flatten stream)
  (stream-map stream-car
              (stream-filter (lambda (s) (not (stream-null? s))) 
                             stream)))
``` 

### b)

查询系统的行为不会改变。

`stream-flatmap` 调用 `flatten-stream`，最重要的是其中的交错合并。[练习 4.72](./exercise_4_72.md) 描述了不交错合并时会出现的问题。

假如传入的是空流，或者是单元素的流，是不需要交错合并的。

`simple-flatten` 的实现中，假如是空流，会先被 `stream-filter` 过滤掉，也就会返回空流。假如是单元素流，会通过过滤，再被 `stream-car` 取出。

在空流或者单元素流的情况下，`flatten-stream` 和 `simple-flatten` 是等价的。

