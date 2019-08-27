## P114 - [练习 2.70]

利用 [练习 2.69](./exercise_2_69.scm) 的程序，将其补充完整。

``` Scheme
#lang racket

(require "exercise_2_69.scm")

(define (encode-messages messages tree)
  (if (null? messages)
      '()
      (append (encode (car messages) tree) 
              (encode-messages (cdr messages) tree))))

(define tree (generate-huffman-tree '((A    2) 
                                      (NA   16) 
                                      (BOOM 1)
                                      (SHA  3) 
                                      (GET  2) 
                                      (YIP  9) 
                                      (JOB  2)
                                      (WAH  1))))

(define messages '((GET A JOB)
                   (SHA NA NA NA NA NA NA NA NA)
                   (GET A JOB)
                   (SHA NA NA NA NA NA NA NA NA)
                   (WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP)
                   (SHA BOOM)))

(encode-messages messages tree)
(decode (encode-messages messages tree) tree)
(length (encode-messages messages tree))      ;; 84
```

可以得到结果，编码后的二进制位长度为 84。

假如使用定长编码，字母表中符号有 8 个，因而每个符号至少需要 3 个二进制位。原文共有 36 个符号，于是采用定长编码，需要二进制位长度为 36 * 3 = 108。

可见，采用 huffman 编码比定长编码节省了 24 个二进制位。
