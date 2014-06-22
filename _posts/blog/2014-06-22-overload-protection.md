---
layout: post
title: 过载保护算法思考
description: 漏桶算法(Leaky Bucket)存在开始一瞬间就装满了的可能性 
category: blog 
---

[过载保护算法浅析 原文连接](http://mp.weixin.qq.com/s?__biz=MzA5MTY2NTcwNw==&mid=200313819&idx=1&sn=5ff078a41d09d3c0900039bfd4dcd31b#rd)

1. 漏桶算法存在高请求下，瞬间就装满的情况（(now - timeStamp)*rate>capacity||water==0，距离上一个请求足够久，已经漏完了，此时来了一波高爆发请求），即在第一个时间片内还是会超出负载能力。整个时间片内流量最大为2n,同时桶内最大为n

2. 令牌桶算法同样存在瞬间令牌发放完毕((now - timeStamp)*rate>capacity),且代码有错误：`tokens = **max**(capacity, tokens+ (now - timeStamp)*rate);`应该为`tokens = **min**(capacity, tokens+ (now - timeStamp)*rate);`.整个时间片内最大为2n,同时桶内最大为n


传输和存储问题,比如高爆发请求引起内存不足而死机，可用，因为桶内最大为n

处理散热问题，处理速度过快造成硬件损坏，不可用，但可调最大容量为0.5n，损失请求换安全。
