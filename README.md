书籍使用《计算机程序的构造和解释》[中文第二版](https://book.douban.com/subject/1148282/)。在线英文版[点这里](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book.html)，排版更好的英文版[点这里](http://sarabander.github.io/sicp/html/index.xhtml)。

使用 [DrRacket](https://racket-lang.org) 开发环境，来测试编写 Scheme 代码。


* [序和前言](./foreword/README.md)
* [第1章 构造过程抽象](./chapter_1/README.md)
* [第2章 构造数据现象](./chapter_2/README.md)
* [第3章 模块化、对象和状态](./chapter_3/README.md)
* [第4章 元语言抽象](./chapter_4/README.md)
* [第5章 寄存器机器里的计算](./chapter_5/README.md)

-------

我最初设想使用 Lua 完成书中代码和习题。Lua 和 Scheme 有点相似，而我也更熟悉 Lua 语言。

第 1 章的代码和习题最开始使用 Lua 来完成。到了第 2 章，发现 Lua 语言还不够灵活，缺少操作符号(Symbol)的能力，于是转回使用 Scheme。第 1 章的代码也改写到 Scheme，但保留 Lua 版本。

* [第1章 构造过程抽象](./chapter_1_lua/README.md)（Lua 版本）

### 环境配置

正常安装 [DrRacket](https://racket-lang.org)后，某些代码用到了 `#lang sicp`，需要额外安装 sicp package。

打开 DrRacket, 选择 File -> Package Manager 菜单项。在 `Do What I Mean` 一栏输入 `sicp`, 点击 Install。

