---
layout: post
title: Install ROOT-V6 on IHEP Server
description: 很多root代码在高版本下才能运行，比如简单的vector<float>,低版本make时可成功，但运行时有bug
category: blog 
---

###编译到源代码目录root-v6-00/里

1.Get the sources of the latest ROOT (see above)

    % git clone http://root.cern.ch/git/root.git root-v6-00
    % cd root-v6-00
    % git checkout -b v6-00-01 v6-00-01

2.Type the build commands:

    % vi configure 

    //配置fftw编译
    --with-fftw3-incdir="/usr/include/"
    --with-fftw3-libdir="/usr/lib64/"
    //配置roofit编译
    enable_roofit=yes

    % ./configure [<arch>]      [set arch appropriately if no proper default]
    % (g)make                   [or, make -j n for n core machines]

3.Add bin/ to PATH and lib/ to LD_LIBRARY_PATH. For the csh shell family do:

    % source bin/thisroot.csh (原来的有错误——不能用ln -s——不能用cd显示文件，做了修改，见附件)

4.Try running ROOT:

    % root (.rootrc有个错误，造成TBrowser b时  segmentation violation，已删除该行)

=====

####Tips:

1】需要gcc for c11，需要python>2.5

[gcc安装参考](http://ldengjie.github.io/compile-gcc/)

2】编译时出错：

```
g++: error: misc/minicern/src/hbook.o: No such file or directory
g++: error: misc/minicern/src/kernlib.o: No such file or directory
g++: error: misc/minicern/src/zebra.o: No such file or directory
make: *** [lib/libminicern.so] Error 1
make: *** Waiting for unfinished jobs....
```

原因： gfortran版本太低了，重新编译gcc加入fortran支持
