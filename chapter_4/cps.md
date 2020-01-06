## Continuation-passing style

本节在描述 amb 求值器的实现中，会经常出现“继续”这个词。有成功继续、和失败继续。这个词在英文中是 continuation，是个专门的术语。

本节 [amb 求值器的实现](./ambeval.scm)，其代码风格叫 Continuation-passing style(CPS)。假如完全不知道 CPS，代码会比较难懂，会觉得有点神奇。

我对 CPS 也不是很懂，不做太多描述，避免误导。但有一些延伸阅读

* [怎样理解 Continuation-passing style?](https://www.zhihu.com/question/20259086)
* [什么是continuation?](https://www.zhihu.com/question/61222322)
* [call/cc 总结](https://www.sczyh30.com/posts/Functional-Programming/call-with-current-continuation/)

引用其他人的说法

> 简单来说，Continuation 就是程序执行到这里，完成了这里的求值以后，接下来还需要做的事。

具体到本节 amb 求值器的实现中，每个过程都带有 succeed、fail 两个 Continuation。这个 succeed 在求值成功后的调用，fail 会在失败后调用。这有像某些网络库中，请求成功或者失败的回调。

执行过程是个递归过程，本层的 succeed、fail 参数，是上一层执行过程中传进来的。在这里，succeed、fail 都被实现为 lambda。其中 fail 实际存储的是前面执行语句的返回点，在分析过程中，一层层往下传。于是调用 fail, 可以一下子跨越很多层。回到前一个返回点。

在这里，succeed 是往前。fail 是后退，回到前面，选择额外的选择分支再继续。

在过程式的结构编程中，会使用 return 作为返回，但只能够返回上一层。但这个 fail 放着的返回点，可以一下子跨越很多层。这有点像 goto、longjump、或者异常。一下子跨越很多层。

在过程式的语言中，每层的返回信息，通常会放到栈(Stack)中。但在这里，直接使用 lambda 保存了返回点的状态。执行过程中，每层都被传入 succeed、fail 可以作为退出返回。另外每一层也可以用 lambda 保存当前状态，作为下面层的返回点。

这种 CPS 风格有点难读。假如要去跟踪这个 succeed、fail 到底代表什么操作，一定会觉得很绕。但假如只管好自己这一层语句，将 succeed、fail 理解成某个返回点，就会容易理解了。

