---
layout: post
title: where is my new blog? 
description: 中文编码确保为utf-8;冒号之后带空格
category: blog 
---


    title: where is my new blog?
    description: a bug?

1. 冒号之后一定要有空格，否则编译不通过。
2. 全英文，文件编码可以为：cp936,utf-8
3. 含有中文时,文件编码一定是：utf-8.

`
vim下改变编码：
    :set fileencoding=utf-8
`
