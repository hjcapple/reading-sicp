## P295 - [练习 4.47]

### a)

Louis 的建议行不通，有可能会引起死循环。比如解析语句

``` Scheme
(parse '(the cat eats))
```

第一次 parse 时，可以成功。`try-again` 就会死循环。Louis 建议的代码如下

``` Scheme
(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 'verb-phrase
             (parse-verb-phrase)
             (parse-prepositional-phrase))))
```

其中 `(parse-verb-phrase)` 的第二个选择项，会递归调用 `(parse-verb-phrase)`，并且没有停止条件。一旦第一个选择项 `(parse-word verbs)` 失败，进入第二个选择项，就会死循环。


### b)

就算交换了 amb 的顺序，变成

``` Scheme
(define (parse-verb-phrase)
  (amb (list 'verb-phrase
             (parse-verb-phrase)
             (parse-prepositional-phrase))
       (parse-word verbs)))
```       

问题仍然存在。此时解析语句 

``` Scheme
(parse '(the cat eats))
```

第一次 parse 时，就会死循环了。


