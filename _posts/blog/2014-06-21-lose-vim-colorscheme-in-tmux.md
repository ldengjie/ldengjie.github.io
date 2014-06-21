---
layout: post
title: Vim 在 tcsh 中的显示与 tmux 中的显示不同 
description: lose vim colorscheme in tmux mode,and Powerline looks like crap 
category: blog 
---

###问题

tcsh下，在tmux里面，vim的配色不能正常显示,shell显示正常。

###解决办法

1. 使用`tmux -2` 而不是`tmux`.

    可在`~/.tcshrc`中添加`alias tmux 'tmux -2'`

2. need to tell tmux that it has 256-color capabilities.

    在`~/.tmux.conf`中添加`set -g default-terminal "xterm"`

---

###Tips

在第二步里:

* `set -g default-terminal "screen-256color"` 对vim没作用，shell显示正常。

* `set -g default-terminal "xterm-256color"` 对vim起作用，但shell里丢失了颜色。。。

可能跟我Xshell设置有关？

###参考资料

[Vim 在 bash 中的显示与 tmux 中的显示不同](https://ruby-china.org/topics/13385)

[http://stackoverflow.com/questions/10158508/lose-vim-colorscheme-in-tmux-mode](http://stackoverflow.com/questions/10158508/lose-vim-colorscheme-in-tmux-mode)

vim-powerline/README.rst
