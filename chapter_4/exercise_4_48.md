## P296 - [练习 4.48]

* [完整代码点这里](./exercise_4_48.scm)

我们添加一些形容词。增加形容词的表

``` Scheme
(define adjectives '(adj lazy nice shitty))
```

并将 `parse-simple-noun-phrase` 修改为

``` Scheme
(define (parse-simple-noun-phrase)
  (amb (list 'simple-noun-phrase
             (parse-word articles)
             (parse-word nouns))
       (list 'simple-noun-phrase
             (parse-word articles)
             (parse-word adjectives)
             (parse-word nouns))))
```

测试句子

``` Scheme
(parse '(the lazy student with the nice cat sleeps in the class))
```

输出为

```
'(sentence
   (noun-phrase
     (simple-noun-phrase (article the) (adj lazy) (noun student))
     (prep-phrase
       (prep with)
       (simple-noun-phrase (article the) (adj nice) (noun cat))))
   (verb-phrase
     (verb sleeps)
     (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class)))))
```             

