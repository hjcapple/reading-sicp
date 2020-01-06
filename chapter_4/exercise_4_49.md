## P296 - [练习 4.49]

* [完整代码点这里](./exercise_4_49.scm)

将 `parse-word` 和 `parse` 修改为

``` Scheme
(define (amb-list lst) 
  (if (null? lst) 
      (amb) 
      (amb (car lst) (amb-list (cdr lst))))) 

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (set! *unparsed* (cdr *unparsed*))
  (let ((word (amb-list (cdr word-list))))
    (set! *sentence* (append *sentence* (list word)))
    (list (car word-list) word)))

(define *unparsed* '())
(define *sentence* '())

(define (parse input)
  (set! *sentence* '())
  (set! *unparsed* input)
  (let ((sent (parse-sentence)))
    (require (null? *unparsed*))
    *sentence*))
```

添加 `*sentence*`，用于存放生成的句子。

调用 `(parse '(1 2 3))`，表示生成的句子含有 3 个单词，生成的前 15 个句子为：

``` Scheme
;; (parse '(1 2 3))
(the student studies)
(the student lectures)
(the student eats)
(the student sleeps)
(the professor studies)
(the professor lectures)
(the professor eats)
(the professor sleeps)
(the cat studies)
(the cat lectures)
(the cat eats)
(the cat sleeps)
(the class studies)
(the class lectures)
(the class eats)
...
```

调用 `(parse '(1 2 3 4 5 6 7 8 9))`, 表示生成的句子含有 9 个单词，生成的前 15 个句子为：

``` Scheme
;; (parse '(1 2 3 4 5 6 7 8 9))
(the student studies for the student for the student)
(the student studies for the student for the professor)
(the student studies for the student for the cat)
(the student studies for the student for the class)
(the student studies for the student for a student)
(the student studies for the student for a professor)
(the student studies for the student for a cat)
(the student studies for the student for a class)
(the student studies for the student to the student)
(the student studies for the student to the professor)
(the student studies for the student to the cat)
(the student studies for the student to the class)
(the student studies for the student to a student)
(the student studies for the student to a professor)
(the student studies for the student to a cat)
...
```

