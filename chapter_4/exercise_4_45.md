## P295 - [练习 4.45]

使用[正文的程序](./parsing_natural_language.scm)执行

``` Scheme
(parse '(the professor lectures to the student in the class with the cat))
```

得到 5 种可能结果。其中没有歧义的是

* 教授在给学生讲课。

但是 `(in the class)` 和 `(with the cat)` 根据不同的断句，意思会有不同。

* `(in the class)`，可以修饰 student 或者是 lectures。(有 2 种可能)
* `(with the cat)`, 可以是 professor、student 或者是 class。(有 3 种可能)

其中原句的顺序是，

* lectures、student
* in the class、with the cat

语法分析中禁止交叉修饰，也就是不会出现 lectures in the class 和 student with the cat 这种情况，因为这种情况下介词交叉了。于是总的可能性是 2 * 3 - 1 = 5。

### 1

``` Scheme
'(sentence
   (simple-noun-phrase (article the) (noun professor))
   (verb-phrase
     (verb-phrase
       (verb-phrase
         (verb lectures)
         (prep-phrase
           (prep to)
           (simple-noun-phrase (article the) (noun student))))
       (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class))))
     (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))))
```

意思是：

* 教授在给学生讲课。
* 在课堂上讲课。lectures in the class
* 教授带着猫。professor with the cat

### 2

``` Scheme
'(sentence
   (simple-noun-phrase (article the) (noun professor))
   (verb-phrase
     (verb-phrase
       (verb lectures)
       (prep-phrase (prep to) (simple-noun-phrase (article the) (noun student))))
     (prep-phrase
       (prep in)
       (noun-phrase
         (simple-noun-phrase (article the) (noun class))
         (prep-phrase
           (prep with)
           (simple-noun-phrase (article the) (noun cat)))))))
```

意思是：

* 教授在给学生讲课。
* 在课堂上讲课。lectures in the class
* 课堂有只猫。class with the cat

### 3

``` Scheme
'(sentence
   (simple-noun-phrase (article the) (noun professor))
   (verb-phrase
     (verb-phrase
       (verb lectures)
       (prep-phrase
         (prep to)
         (noun-phrase
           (simple-noun-phrase (article the) (noun student))
           (prep-phrase
             (prep in)
             (simple-noun-phrase (article the) (noun class))))))
     (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))))
```

意思是：

* 教授在给学生讲课。
* 学生在课堂上。student in the class
* 教授带着猫。professor with the cat
 
### 4

``` Scheme
'(sentence
   (simple-noun-phrase (article the) (noun professor))
   (verb-phrase
     (verb lectures)
     (prep-phrase
       (prep to)
       (noun-phrase
         (noun-phrase
           (simple-noun-phrase (article the) (noun student))
           (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class))))
         (prep-phrase
           (prep with)
           (simple-noun-phrase (article the) (noun cat)))))))
```

意思是：

* 教授在给学生讲课。
* 学生在课堂上。student in the class
* 学生带着猫。student with the cat

### 5

``` Scheme
'(sentence
   (simple-noun-phrase (article the) (noun professor))
   (verb-phrase
     (verb lectures)
     (prep-phrase
       (prep to)
       (noun-phrase
         (simple-noun-phrase (article the) (noun student))
         (prep-phrase
           (prep in)
           (noun-phrase
             (simple-noun-phrase (article the) (noun class))
             (prep-phrase
               (prep with)
               (simple-noun-phrase (article the) (noun cat)))))))))
```

意思是：

* 教授在给学生讲课。
* 学生在课堂上。student in the class
* 课堂有只猫。class with the cat

