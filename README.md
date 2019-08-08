我最初设想是使用 Lua 完成书中代码和习题。主要原因是

* 我更熟悉 Lua 语言，Lua 也用到实际工程中。
* Lua 和 Scheme 有点相似。
* 使用另一种语言，避免照抄书中代码。

第一章的代码和习题就使用 Lua 来完成。第一章所用到的 Scheme 特性，Lua 都有直接的对应。

但到了第二章，发现 Lua 语言还不够灵活，缺少操作符号(Symbol)的能力。假如还坚持使用 Lua，反而弄复杂了。因此第二章开始，转回使用 Scheme，所用的解释器是 Racket。

-----

使用《计算机程序的构造和解释》[中文第二版](https://book.douban.com/subject/1148282/)。在线英文版[点这里](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book.html)，排版更好的英文版[点这里](http://sarabander.github.io/sicp/html/index.xhtml)。

* [序和前言](./foreword/README.md)
* [第1章 构造过程抽象](./chapter_1/README.md)（使用 Lua)
* [第2章 构造数据现象](./chapter_2/README.md)
* 第3章 模块化、对象和状态
* 第4章 元语言抽象
* 第5章 寄存器机器里的计算

