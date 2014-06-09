---
layout: post
title: git push save username and password
description: 除了ssh key，还需检查协议类型，确保为git协议 
category: blog 
---

配置上传了ssh key 到 github,还是每次git push都需要输入帐号密码。


输入`git remote -v` 看了下，是https协议。。。

git协议才用到ssh key。

解决方法：

>1. 删除本地repository
>
>2. git clone git@github.com:ldengjie/ldengjie.github.io.git

>今天小编要介绍的是如何用 markdown 语言记漂亮整齐的笔记,演示的软件是为知笔 记,因为这是目前唯一一款可以完全支持 markdown 语言的笔记产品。废话少说,下面小今天小编要介绍的是如何用 markdown 语言记漂亮整齐的笔记,演示的软件是为知笔 记,因为这是目前唯一一款可以完全支持 markdown 语言的笔记产品。废话少说,下面小今天小编要介绍的是如何用 markdown 语言记漂亮整齐的笔记,演示的软件是为知笔 记,因为这是目前唯一一款可以完全支持 markdown 语言的笔记产品。废话少说,下面小

这样就行了。

    $ git remote -v
    origin  git@github.com:ldengjie/ldengjie.github.io.git (fetch)
    origin  git@github.com:ldengjie/ldengjie.github.io.git (push)


===

Tips:

>fatal: https://github.com/ldengjie/ldengjie.github.io/info/refs not found: did you run git update-server-info on the server?

这个错误也随之解决了。
