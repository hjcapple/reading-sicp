## P295 - [练习 4.46]

我们的分析程序，将输入存储在 `*unparsed*` 中，对句子从左往右分析。分析过程中，会修改 `*unparsed*` 的值。

于是分析程序是有状态的，之前的分析结果，会影响之后的分析结果。因为有状态依赖，分析程序就严重依赖从左往右的求值顺序。比如

``` Scheme
(define (parse-sentence)
  (list 'sentence
        (parse-noun-phrase)
        (parse-verb-phrase)))
```

假如从右往左的求值顺序，就会存储在 `*unparsed*` 的句子依次执行

``` Scheme
(parse-verb-phrase)
(parse-noun-phrase)
```

这导致分析出错。

