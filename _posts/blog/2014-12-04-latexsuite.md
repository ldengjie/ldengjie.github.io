---  
layout: post  
title: win8 下 texlive2014+XeLatex+gvim+latexsuite+SumatraPDF  
description: 在新win8系统上用vim编辑编译latex,支持中文，双向搜索  
category: blog   
---  
  
###名字解释  
**tex**  排版语言，就像C语言  
**texlive**  tex的编译系统，包含编译所用的工具、浏览工具(Ghostscript、GSview)和编辑工具(texworks)，就像gcc4.9。平行的有MiKTeX，两者底层不同;以MiKTeX为基础的CTex,封装了编译工具、浏览工具(Ghostscript、GSview),编辑工具为(WinEdt).  
**XeLatex**  texlive、CTex中的众多编译工具之一，直接支持Unicode编码，不用配置字体，中文清晰  
  
>|tex的高级版语言    |    编译工具    |     特点   |  
>|------------------ | -------------- |  -------------------------------------------------------------------------------  |  
>|XeTex              | XeLatex        |  支持Unicode编码和直接访问操作系统字体,支持eps，生存pdf  |  
>|LaTex              | PDFLatex       |  把TeX 语言写的代码直接编译成 PDF文件,不经过dvi,ps中间过程,支持jpg,png，不支持eps  |  
>|LaTex              | Latex          |  dvi->ps->pdf,不支持jpg,png，支持eps  |  
  
**gvim**  vim的windows版,可用作latex的编辑工具  
**latex-suite**  vim的支持`latex编辑浏览和调用编译工具`的功能的插件，可折叠、自动补全、双向搜索  
**SumatraPDF**  windows下浏览pdf的工具,支持双向搜索,可打开时编辑生成pdf  
  
###软件下载  
  
[texlive2014](http://bt.neu6.edu.cn/thread-1359559-1-1.html)  
[gvim7.4](http://www.vim.org/download.php)  
[latex-suite](https://github.com/vim-latex/vim-latex) ,内容直接复制到C:\Program Files (x86)\Vim\vimfiles下  
[SumatraPDF3.0](http://www.sumatrapdfreader.org/download-free-pdf-viewer.html)  
[grep](http://gnuwin32.sourceforge.net/packages/grep.htm) F9 do a completion (ref, cite, lename)需要,必需  
[python2.7.8](https://www.python.org/downloads/release/python-278/) 双向搜索功能需要,必需  
  
###软件安装  
1. 各种next  
2. 配置路径PATH  
  
>我的电脑->属性->高级系统设置->环境变量->用户变量或系统变量->编辑或新建PATH变量  
>依次为texlive2014;grep;sumatrapdf;gsview;vim74  

>```
>d:\texlive\2014\bin\win32;C:/Program Files (x86)/GnuWin32/bin;C:\Program Files (x86)\SumatraPDF;C:\Program Files\Ghostgum\gsview;C:\Program Files (x86)\Vim\vim74  
>```
  
###配置；  
1._vimrc 中添加  
  
```
""""""""""""""""gvim相关,个人习惯简洁"""""""""""""""  
set guioptions-=m  "remove menu bar  
set guioptions-=T  "remove toolbar  
set guioptions-=r  "remove right-hand scroll bar  
set guioptions-=L  "remove left-hand scroll ba  
""""""""""""""""latex-suite相关"""""""""""""""  
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.  
filetype plugin on  
  
" IMPORTANT: win32 users will need to have `shellslash` set so that latex  
" can be called correctly.  
set shellslash  
  
" IMPORTANT: grep will sometimes skip displaying the file name if you  
" search in a singe file. This will confuse Latex-Suite. Set your grep  
" program to always generate a file-name.  
set grepprg=grep\ -nH\ $*  
  
" OPTIONAL: This enables automatic indentation as you type.  
filetype indent on  
  
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to  
" `plaintex` instead of `tex`, which results in vim-latex not being loaded.  
" The following changes the default filetype back to `tex`:  
let g:tex_flavor=`latex`  
""""""""""""""""反向搜索相关"""""""""""""""  
let g:Tex_DefaultTargetFormat=`pdf`  
let g:Tex_CompileRule_pdf = `pdflatex --synctex=-1 -src-specials -interaction=nonstopmode $*`  
let g:Tex_ViewRule_pdf = `sumatrapdf -reuse-instance -inverse-search "gvim -c \":RemoteOpen +\%l \%f\"" `  
```
  
2.修改ftplugin/latex-suite/compiler.vim,正向搜索相关
  
原来是:  
  
    " inverse search tips taken from Dimitri Antoniou`s tip and Benji Fisher`s  
    " tips on vim.sf.net (vim.sf.net tip #225)  
    if (has(`win32`) && (viewer =~? `^ *yap\( \|$\)`))  
      
        let execString = `silent! !start `. viewer.` -s `.line(`.`).expand(`%`).` `.mainfnameRoot  
  
修改为：  
  
    " inverse search tips taken from Dimitri Antoniou`s tip and Benji Fisher`s  
    " tips on vim.sf.net (vim.sf.net tip #225)  
    if (has(`win32`) && (viewer =~? `^ *yap\( \|$\)` || viewer =~? "^sumatrapdf"))  
      
        if (viewer =~? `^ *yap\( \|$\)`)  
      
            let execString = `silent! !start `. viewer.` -s `.line(`.`).expand(`%`).` `.mainfnameRoot  
      
        elseif (viewer =~? "^sumatrapdf")  
      
            let execString = `silent! !start `.viewer.` "`.  
                            \ Tex_GetMainFileName(`:p:r:gs?/?\\?`).`.`.s:target.`" -forward-search "`.  
                            \ Tex_GetMainFileName(`:p:gs?/?\\?`).`" `. line(`.`)  
        endif  
  
3.XeLatex配置  
3.1xelatex原生态仅支持utf8编码格式，所以需要转换文件编码->ASCII转utf8  
3.2我有自己的latex theme .sty文件，把下列设置加入其中,也可单独保存成.sty文件,也可直接加到.tex文件中,"[DejaVu Sans Mono字体](http://dejavu-fonts.org/wiki/Download)"需要自己下载安装，这里也可替换其他已有字体  
  
```
\usepackage[cm-default]{fontspec} %[cm-default]选项主要用来解决使用数学环境时数学符号不能正常显示的问题  
\usepackage{xunicode,xltxtra}  
\defaultfontfeatures{Mapping=tex-text} %如果没有它，会有一些 tex 特殊字符无法正常使用，比如连字符。  
% 中文断行  
\XeTeXlinebreaklocale "zh"  
\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt  
%将系统字体名映射为逻辑字体名称，主要是为了维护的方便  
\newcommand\fontnamehei{微软雅黑}  
\newcommand\fontnamesong{仿宋}  
\newcommand\fontnamekai{楷体}  
\newcommand\fontnamemono{DejaVu Sans Mono}  
\newcommand\fontnameroman{Times New Roman}  
%%设置常用中文字号，方便调用  
\newcommand{\erhao}{\fontsize{22pt}{\baselineskip}\selectfont}  
\newcommand{\xiaoerhao}{\fontsize{18pt}{\baselineskip}\selectfont}  
\newcommand{\sanhao}{\fontsize{16pt}{\baselineskip}\selectfont}  
\newcommand{\xiaosanhao}{\fontsize{15pt}{\baselineskip}\selectfont}  
\newcommand{\sihao}{\fontsize{14pt}{\baselineskip}\selectfont}  
\newcommand{\xiaosihao}{\fontsize{12pt}{\baselineskip}\selectfont}  
\newcommand{\wuhao}{\fontsize{10.5pt}{\baselineskip}\selectfont}  
\newcommand{\xiaowuhao}{\fontsize{9pt}{\baselineskip}\selectfont}  
\newcommand{\liuhao}{\fontsize{7.5pt}{\baselineskip}\selectfont}  
%设置文档正文字体为宋体  
\setmainfont[BoldFont=\fontnamehei]{\fontnamesong}  
\setsansfont[BoldFont=\fontnamehei]{\fontnamekai}  
\setmonofont{\fontnamemono}  
%楷体  
\newfontinstance\KAI{\fontnamekai}  
\newcommand{\kai}[1]{{\KAI#1}}  
%黑体  
\newfontinstance\HEI{\fontnamehei}  
\newcommand{\hei}[1]{{\HEI#1}}  
%英文  
\newfontinstance\ENF{\fontnameroman}  
\newcommand{\en}[1]{\,{\ENF#1}\,}  
```
  
3.3在.tex中调用.sty,其他的不用什么设置  
  
    \usepackage{ldjtheme}  
  
###使用：vim编辑、编译  
  
\ll：compile  
\lv：view pdf  
\ls: 正向搜索  
SumatraPDF中 双击: 反向搜索  
Ctrl-J： 跳到下一个++位置（place holder）  
F5：insert/wrap in environment  
F9：do a completion (ref, cite, lename)  
za：fold/unfold  
\rf：refresh folding  
  
###参考资料  
1. [utf8+xelatex ](http://blog.163.com/xie_qiuliang/blog/static/1810885002011387313105/)  
2. [LaTeX技巧9：VIM+LaTexSuite配置 ](http://blog.sina.com.cn/s/blog_5e16f1770100fqyt.html)  
3. [使用vim-latex（latex-suite）插件](http://fightfxj.blog.163.com/blog/static/676839242013424103223400/)  
4. [LaTeX使用--XeLaTeX入门基础（二）](http://blog.csdn.net/geekcome/article/details/7618527)  
5. [GVim + LaTeX-Suite + SumatraPDF 正反向搜索解决方案 ](http://bbs.ctex.org/forum.php?mod=viewthread&tid=74881)  
6. [latex-suite User Manual](http://vim-latex.sourceforge.net/index.php?subject=manual&title=Manual#user-manual)  
7. [CTex官方主页](http://www.ctex.org/CTeX)  
