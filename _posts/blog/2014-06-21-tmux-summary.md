---
layout: post
title: tmux 安装及配置 
description: 没有root权限，自动安装tmux脚本；基本的配置；自动化启动打开tmux脚本（tcsh)
category: blog 
---

### 安装步骤（tcsh）：

[我的安装及配置代码](https://gist.github.com/ldengjie/059db63d0d21c6520274)

1.修改`tmux_local_install.sh`,设置`INSTALLDIR`为安装位置

    source tmux_local_install.sh

2.简单配置见`.tmux.conf`,要放到`~`下。

>更多细节参加 [tmux manual](http://www.openbsd.org/cgi-bin/man.cgi?query=tmux&sektion=1)

3.`tchs`版的自动化脚本`.tmux.init.csh`，放到`~`下,然后添加`source ~/.tmux.init.csh`到`~/.tcshrc`,每次启动就可以自动打开相应窗口了。

4.解决vim-powerlin和tmux主题冲突问题 [参见](http://ldengjie.github.io/lose-vim-colorscheme-in-tmux/)

### 参考资料：

[tmux入门](http://www.ituring.com.cn/minibook/10707)

[Manual Pages](http://www.openbsd.org/cgi-bin/man.cgi?query=tmux&sektion=1)

[bash自动化脚本](https://github.com/xuxiaodong/tmuxen/blob/master/tmuxen)

[Tmux使用初体验](http://blog.chinaunix.net/uid-26285146-id-3252286.html)

---

###在IHEP server上，怎样才能保持tmux不中断？

####实验

1.`C+d` ,退出session，关掉Xshell窗口，中断

2.`[前缀] C+z`,挂起session

2.1不关掉 Xshell窗口，**保持**

2.2关掉 Xshell窗口，中断。且之前保持的其他的session，也会丢失。`failed to connect to server: Connection refused`

3.在session里，关掉Xshell窗口，**保持**

4.`[前缀] d`，分离session,关掉Xshell窗口，**保持**

#### 结论

**在session里，关掉Xshell窗口,保持**

**`[前缀] d`，分离session,关掉Xshell窗口,保持**

**不要** `[前缀] C+z`,挂起session，关掉Xshell窗口，这样会丢失session

---

###IHEP server上（空闲ssh链接会被killed），空闲tmux session 能保持超过一个小时？
####实验
三个session。s4共包含两个window:一个空闲,一个运行top；s5,一个运行top的window；s6 一个空闲window

* s4: 2 windows (created Thu Jun 19 17:59:29 2014) [159x34]
* s5: 1 windows (created Thu Jun 19 17:59:01 2014) [159x34]
* s6: 1 windows (created Thu Jun 19 17:45:12 2014) [159x34]

####结果
（10:31pm时）
* s4: 1 windows (created Thu Jun 19 17:59:29 2014) [159x34]
* s5: 1 windows (created Thu Jun 19 17:59:01 2014) [159x34]

####结论
空闲window会被关闭，若这个window为最后一个window，则这个session关闭

###IHEP 服务器限制，前端程序只能运行75分钟

tmux窗口内也是75分钟。**tmux只能让程序在断线后保留下来，仿佛没掉线，但还是要遵循IHEP服务器设置。**

---
###Tips
1. 旧的ssh，tmux ls 可以看到s4,s5,s6。新开的ssh，看不到。。几个小时后，在旧的ssh里可以连接，新的仍旧看不到连接不到。

>原因：登录了不同的服务器节点。。。登录到同一节点后就看到了


