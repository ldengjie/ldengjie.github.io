---
layout: post
title: Each Word is a Topic
description: 每个词可看作为一个话题
category: blog 
---

每个词都有可能成为一个话题，“鸡蛋”，“钱包”，“同桌”。每个词，比如“鸡蛋”，对应都有一个词汇列表，列表中的词汇都与“鸡蛋”这个主题相关。“鸡蛋”这个词暂成为“主题词t”，对应的列表中的词汇暂成为“相关词w”。

可能的出现次序： ![](http://latex.codecogs.com/gif.latex?w_1  w_2 w_3 w_1 w_1  w_2)

$w_1$为主题词时，w_1出现3次，需要记录其他词在这三次出现时的关系：

距离：分别取最近的距离（3次）

w_2 -1,2,-1
w_3 -2,1,-2



[code is here](https://github.com/ldengjie/TopicDetecter)



