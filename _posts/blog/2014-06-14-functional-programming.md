---
layout: post
title: 函数式编程 
description: 我对它的认识
category: blog 
---

###个人感觉

原理来自于lamda运算，特点是代码就是一个公式，一个个事件转变成一个公式链条，haskell中用where指明公式用变量的取值，大多用集合的概念表示，集合的赋值确实是代码量上最方便的，很容易实现插入、拼接、删除、子集,也就是说在数值处理上很方便，其他方面未知，但这点也体现不出它的优越性，其他高级语言若是想，也可以实现。

一大特点是静态数据。一般命令式编程是函数不变，变量的数值改变，函数式编程确是“变量”值不变，函数在变，跟量子物理里薛定谔表象和海森堡表象的区别相似。这里数据不变带来的好处就是可以轻易实现数据共享，不用考虑平常命令式编程所有的冲突问题，这样就有了它在并行计算方面的天生优势，目前也主要是用在这个方面。如果以后要做并行研发，函数式编程是个不错的选择。

纯粹的函数式编程主要有Lisp,Scheme,Haskell,Erlang。Scheme是Lisp的一种变体或者成为方言。Scheme和Haskell比起来，Haskell更偏向于学术，Scheme更贴近实际工业应用，更亲近使用者，Haskell更像是一个学术上精致的玩物，重在思想上的完善完美，忽略了应用实现上的方便性。

现行世界的主要流行语言还会是c++,java等等，函数式语言是大势所趋，但会火的是这种思想，而不是上面Lisp,Scheme,Haskell这几种语言，最大的可能就是c和java接收融合这种思想。所以学习Lisp or Scheme or Haskell?重在其中的思想：比如类型系统和基本的lamda运算。

###java和函数式编程

然后，java和函数式编程的结合物就有了：Scala，一种多范式的编程语言，一种类似java的编程 ，设计初衷是要集成面向对象编程和函数式编程的各种特性，在JVM上运行。在`作为我个人而言：`有限时间或有限的生产环境里，若想接触和利用这种新的思想，与其撇开c++,java从初学者角度学习Lisp,Scheme,Haskell, 不如学习Scala。

1. 什么语言都是工具，重在思想上的转变，重在是否能运用它。
2. Lisp,Scheme,Haskell,Erlang哪个能成为主流？只会其中一种或者都成为不了。
3. Scala与java有很好的互通性。

>Scala是静态类型的，这就允许它提供泛型类、内部类、甚至多态方法（Polymorphic Method）。另外值得一提的是，Scala被特意设计成能够与Java和.NET互操作。Scala当前版本还不能在.NET上运行（虽然上一版可以-_-b），但按照计划将来可以在.NET上运行。
Scala可以与Java互操作。它用scalac这个编译器把源文件编译成Java的class文件（即在JVM上运行的字节码）。你可以从Scala中调用所有的Java类库，也同样可以从Java应用程序中调用Scala的代码。用David Rupp的话来说，
它也可以访问现存的数之不尽的Java类库，这让（潜在地）迁移到Scala更加容易。


###c++和函数式编程
这是我关注的地方！慢慢调研

====
lamda运算、Pi运算是需要深入了解的方面，原来在并行的时空还有这么独特新颖的角度去看待理解计算这个世界。




###参考资料
1. [不再推荐Haskell-王垠](http://blog.sina.com.cn/s/blog_43f8547e01016oxg.html)
2. [函数式编程一年体会](http://top.jobbole.com/901/)
3. [Haskell函数式编程](http://www.cnblogs.com/speeding/category/417639.html)
4. [Real World Haskell网页版](http://book.realworldhaskell.org/) [中文版部分章节](http://rwh.readthedocs.org/en/latest/)

