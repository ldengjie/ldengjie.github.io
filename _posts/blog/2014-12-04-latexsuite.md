---
layout: post
title: win8+texlive2014+XeLatex+gvim+latexsuite+SumatraPDF
description: ����win8ϵͳ����vim�༭����latex,֧�����ģ�˫������
category: blog 
---

###���ֽ���
tex:�Ű����ԣ�����C����
texlive:tex�ı���ϵͳ�������������õĹ��ߡ��������(Ghostscript��GSview)�ͱ༭����(texworks)������gcc4.9��ƽ�е���MiKTeX�����ߵײ㲻ͬ;��MiKTeXΪ������CTex,��װ�˱��빤�ߡ��������(Ghostscript��GSview),�༭����Ϊ(WinEdt).
XeLatex:texlive��CTex�е��ڶ���빤��֮һ��ֱ��֧��Unicode���룬�����������壬��������

```
tex�ķ�װ  ���빤��  �ص� 
--------- ---------  -------------------------------------------------------------------------------
XeTex     XeLatex    ֧��Unicode�����ֱ�ӷ��ʲ���ϵͳ����,֧��eps������pdf
LaTex     PDFLatex   ��TeX ����д�Ĵ���ֱ�ӱ���� PDF�ļ�,������dvi,ps�м����,֧��jpg,png����֧��eps
LaTex     Latex      dvi->ps->pdf,��֧��jpg,png��֧��eps
```

gvim:vim��windows��,latex�ı༭����
latex-suite:vim��֧��latex�༭����͵��ñ��빤�ߵĹ��ܵĲ�������۵����Զ���ȫ��˫������
SumatraPDF:windows�����pdf�Ĺ���,֧��˫������

###�������

[texlive2014](http://bt.neu6.edu.cn/thread-1359559-1-1.html)
[gvim7.4](http://www.vim.org/download.php)
[latex-suite](https://github.com/vim-latex/vim-latex) ,����ֱ�Ӹ��Ƶ�C:\Program Files (x86)\Vim\vimfiles��
[SumatraPDF3.0](http://www.sumatrapdfreader.org/download-free-pdf-viewer.html)
[grep](http://gnuwin32.sourceforge.net/packages/grep.htm) F9 do a completion (ref, cite, lename)��Ҫ,����
[python2.7.8](https://www.python.org/downloads/release/python-278/) ˫������������Ҫ,����

###�����װ
1. ����next
2. ����·��PATH

```
�ҵĵ���->����->�߼�ϵͳ����->��������->�û�������ϵͳ����->�༭���½�PATH����
����Ϊtexlive2014;grep;SumatraPDF;gsview;vim74
d:\texlive\2014\bin\win32;C:/Program Files (x86)/GnuWin32/bin;C:\Program Files (x86)\SumatraPDF;C:\Program Files\Ghostgum\gsview;C:\Program Files (x86)\Vim\vim74
```

###���ã�
1. _vimrc �����

```
""""""""""""""""gvim���"""""""""""""""
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll ba
""""""""""""""""latex-suite���"""""""""""""""
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
""""""""""""""""�����������"""""""""""""""
let g:Tex_DefaultTargetFormat=`pdf`
let g:Tex_CompileRule_pdf = `pdflatex --synctex=-1 -src-specials -interaction=nonstopmode $*`
let g:Tex_ViewRule_pdf = `sumatrapdf -reuse-instance -inverse-search "gvim -c \":RemoteOpen +\%l \%f\"" `
```

2. �޸�ftplugin/latex-suite/compiler.vim

""""""""""""""""�����������"""""""""""""""
ԭ���ǣ�
```
" inverse search tips taken from Dimitri Antoniou`s tip and Benji Fisher`s
" tips on vim.sf.net (vim.sf.net tip #225)
if (has(`win32`) && (viewer =~? `^ *yap\( \|$\)`))

    let execString = `silent! !start `. viewer.` -s `.line(`.`).expand(`%`).` `.mainfnameRoot
```

�޸�Ϊ��

```
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
```

3. XeLatex����
3.1 xelatexԭ��̬��֧��utf8�����ʽ��������Ҫת���ļ�����->ASCIIתutf8
3.2 �����Լ���latex theme .sty�ļ������������ü�������,Ҳ�ɵ��������.sty�ļ�

```
\usepackage[cm-default]{fontspec} %[cm-default]ѡ����Ҫ�������ʹ����ѧ����ʱ��ѧ���Ų���������ʾ������
\usepackage{xunicode,xltxtra}
\defaultfontfeatures{Mapping=tex-text} %���û����������һЩ tex �����ַ��޷�����ʹ�ã��������ַ���
% ���Ķ���
\XeTeXlinebreaklocale "zh"
\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt
%��ϵͳ������ӳ��Ϊ�߼��������ƣ���Ҫ��Ϊ��ά���ķ���
\newcommand\fontnamehei{΢���ź�}
\newcommand\fontnamesong{����}
\newcommand\fontnamekai{����}
\newcommand\fontnamemono{DejaVu Sans Mono}
\newcommand\fontnameroman{Times New Roman}
%%���ó��������ֺţ��������
\newcommand{\erhao}{\fontsize{22pt}{\baselineskip}\selectfont}
\newcommand{\xiaoerhao}{\fontsize{18pt}{\baselineskip}\selectfont}
\newcommand{\sanhao}{\fontsize{16pt}{\baselineskip}\selectfont}
\newcommand{\xiaosanhao}{\fontsize{15pt}{\baselineskip}\selectfont}
\newcommand{\sihao}{\fontsize{14pt}{\baselineskip}\selectfont}
\newcommand{\xiaosihao}{\fontsize{12pt}{\baselineskip}\selectfont}
\newcommand{\wuhao}{\fontsize{10.5pt}{\baselineskip}\selectfont}
\newcommand{\xiaowuhao}{\fontsize{9pt}{\baselineskip}\selectfont}
\newcommand{\liuhao}{\fontsize{7.5pt}{\baselineskip}\selectfont}
%�����ĵ���������Ϊ����
\setmainfont[BoldFont=\fontnamehei]{\fontnamesong}
\setsansfont[BoldFont=\fontnamehei]{\fontnamekai}
\setmonofont{\fontnamemono}
%����
\newfontinstance\KAI{\fontnamekai}
\newcommand{\kai}[1]{{\KAI#1}}
%����
\newfontinstance\HEI{\fontnamehei}
\newcommand{\hei}[1]{{\HEI#1}}
%Ӣ��
\newfontinstance\ENF{\fontnameroman}
\newcommand{\en}[1]{\,{\ENF#1}\,}
```

3.3 ��.tex�е���.sty,�����Ĳ���ʲô����

```
\usepackage{ldjtheme}
```

###ʹ�ã�vim�༭������

\ll��compile
\lv��view pdf
\ls: ��������
SumatraPDF ��˫��: ��������
Ctrl-J�� ������һ��++λ�ã�place holder��
F5��insert/wrap in environment
F9��do a completion (ref, cite, lename)
za��fold/unfold
\rf��refresh folding

###�ο�����
1. [utf8+xelatex ](http://blog.163.com/xie_qiuliang/blog/static/1810885002011387313105/)
2. [LaTeX����9��VIM+LaTexSuite���� ](http://blog.sina.com.cn/s/blog_5e16f1770100fqyt.html)
3. [ʹ��vim-latex��latex-suite�����](http://fightfxj.blog.163.com/blog/static/676839242013424103223400/)
4. [LaTeXʹ��--XeLaTeX���Ż���������](http://blog.csdn.net/geekcome/article/details/7618527)
5. [GVim + LaTeX-Suite + SumatraPDF ����������������� ](http://bbs.ctex.org/forum.php?mod=viewthread&tid=74881)
6. [latex-suite User Manual](http://vim-latex.sourceforge.net/index.php?subject=manual&title=Manual#user-manual)
7. [CTex�ٷ���ҳ](http://www.ctex.org/CTeX)
