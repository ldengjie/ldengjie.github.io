---
layout: post
title: 源码编译gcc4.9.0
description: gcc4.9.0支持c11，而c11是ROOT6.0必需的
category: blog 
---

安装gcc4.9.0（4.7.5以上都支持c11）

0.安装 GMP、MPFR、MPC这三个库

1.下载 

参看最新版本：ftp://gcc.gnu.org/pub/gcc/releases/

    wget ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.9.0/gcc-4.9.0.tar.gz

只是压缩格式不相同，内容完全一致，下载其中一种即可。 

2.解压缩 

根据压缩格式，选择下面相应的一种方式解包（以下的"%"表示命令行提示符）： 

    % tar -zxvf gcc-4.9.0.tar.gz 或
    % tar -xjvf gcc-4.9.0.tar.bz2

新生成的gcc-4.9.0这个目录被称为源目录，用${srcdir}表示他。以后在出现${srcdir}的地方，应该用真实的路径来替换他。 

3.建立目标目录 

目标目录（用${objdir}表示）是用来存放编译结果的地方。GCC建议编译后的文件不要放在源目录${srcdir]中（虽然这样做也能），最佳独立存放在另外一个目录中，而且不能是${srcdir}的子目录。例如，能这样建立一个叫 gcc-build的目标目录（和源目录${srcdir}是同级目录）： 

    % mkdir gcc-build
    % cd gcc-build 

以下的操作主要是在目标目录 ${objdir} 下进行。 

4.设置 

设置的目的是决定将GCC编译器安装到什么地方（${destdir}），支持什么语言及指定其他一些选项等。其中，${destdir}不能和${objdir}或${srcdir}目录相同。 设置是通过执行${srcdir}下的configure来完成的。其命令格式为（记得用你的真实路径替换${destdir}）： 

    % ${srcdir}/configure --prefix=${destdir} [其他选项] 

例如，如果想将GCC4.9.0安装到/usr/local/gcc-4.9.0目录下，则${destdir}就表示这个路径。 
在我的机器上，我是这样设置的： (可以参考之间的设置gcc -v 做相应修改就可以了，比如4.9.0我去掉了java（编译时需要X11***失败）;4.8.3不去掉也可以编译成功。一定要加上fortran，否则ROOT编译出错。IHEP上用--build，否则失败)

    ../gcc-4.9.0/configure --prefix=/afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0  --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-libgcj-multifile --enable-languages=c,c++,fortran --disable-dssi --disable-plugin  --with-cpu=generic --build=x86_64-redhat-linux --with-gmp=/afs/ihep.ac.cn/users/l/lidj/user/software/gmp-4.3.2 --with-mpfr=/afs/ihep.ac.cn/users/l/lidj/user/software/mpfr-2.4.2 --with-mpc=/afs/ihep.ac.cn/users/l/lidj/user/software/mpc-0.8.1

须指定GMP,MPFR,MPC的位置，编译安装的语言，一定要加上fortran，否则ROOT编译出错，gfrotran版本太低。(单机编译一般是Host，在集群服务器上估计是要用--build,这个不是很明白，没有它编译会找不到ar之类的。--build的值，可以从/usr/lib/x86_64-redhat-linux4E看出来） 将GCC安装在/afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0目录下，支持C/C++和JAVA语言，其他选项参见GCC提供的帮助说明。 

5.编译 

    % make 

这是个漫长的过程。在服务器上，这个过程用了150多分钟。 下次应该尝试make -j4 (% cat /proc/cpuinfo | grep "cores" | uniq 查看cpu个数，-jN N<=cpu个数)，用了-j4大概90分钟.

6.安装 

执行下面的命令将编译好的库文件等拷贝到${destdir}目录中（根据你设定的路径，可能需要管理员的权限）： 

    % make install 

至此，GCC 4.9.0安装过程就完成了。 

7.配置路径~/.tchsrc

    setenv PATH /afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0/bin:$PATH
    setenv LD_LIBRARY_PATH /afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0/lib64:/afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0/lib:/afs/ihep.ac.cn/users/l/lidj/user/software/mpc-0.8.1/lib:/afs/ihep.ac.cn/users/l/lidj/user/software/gmp-4.3.2/lib:/afs/ihep.ac.cn/users/l/lidj/user/software/mpfr-2.4.2/lib:$LD_LIBRARY_PATH

查看版本：

    % gcc -v 

    Using built-in specs.
    COLLECT_GCC=gcc
    COLLECT_LTO_WRAPPER=/publicfs/dyb/user/lidj/software/gcc-4.9.0/bin/../libexec/gcc/x86_64-redhat-linux/4.9.0/lto-wrapper
    Target: x86_64-redhat-linux
    Configured with: ../gcc-4.9.0/configure --prefix=/afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0 --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-libgcj-multifile --enable-languages=c,c++ --disable-dssi --disable-plugin --with-cpu=generic --build=x86_64-redhat-linux --with-gmp=/afs/ihep.ac.cn/users/l/lidj/user/software/gmp-4.3.2 --with-mpfr=/afs/ihep.ac.cn/users/l/lidj/user/software/mpfr-2.4.2 --with-mpc=/afs/ihep.ac.cn/users/l/lidj/user/software/mpc-0.8.1
    Thread model: posix
    gcc version 4.9.0 (GCC)

=====

make时出现的错误：

1】（4.设置 %../gcc-4.9.0/configure ****时）

配置gcc的过程中出现错误：**gcc configure: error: Building GCC requires GMP 4.2+, MPFR 2.3.1+ and MPC 0.8.0+**

*解决方法：*说明要安装gcc需要GMP、MPFR、MPC这三个库，可从ftp://gcc.gnu.org/pub/gcc/infrastructure/下载相应的压缩包。由于MPFR依赖GMP，而MPC依赖GMP和MPFR，所以要先安装GMP，其次MPFR，最后才是MPC。这里三个库我用的版本分别是gMP4.3.2，mpfr2.4.2和mpc0.8.1。

先开始安装GMP。解压GMP的压缩包后，得到源代码目录gmp-4.3.2。在该目录的同级目录下建立一个临时的编译目录，这里命名为gmp-build。然后开始配置安装选项，进入gmp-build目录，输入以下命令进行配置：

    ../gmp-4.3.2/configure --prefix=/afs/ihep.ac.cn/users/l/lidj/user/software/gmp-4.3.2

这里--prefix选项代表要将该库安装在哪里，我是装在/afs/ihep.ac.cn/users/l/lidj/user/software/gmp-4.3.2目录下，后面的安装都会用到这个选项。这时在gmp的编译目录下就会生成一个makefile文件，现在开始编译安装。

    make
    make check
    make install

这样就安装好了gmp。mpfr和mpc的安装方法与此类似。不过要注意配置的时候要把依赖关系选项加进去，具体后面两个库配置命令如下：

    ../mpfr-2.4.2/configure  --prefix=/afs/ihep.ac.cn/users/l/lidj/user/software/mpfr-2.4.2 --with-gmp=/afs/ihep.ac.cn/users/l/lidj/user/software/gmp-4.3.2
    ../mpc-0.8.1/configure --prefix=/afs/ihep.ac.cn/users/l/lidj/user/software/mpc-0.8.1 --with-gmp=/afs/ihep.ac.cn/users/l/lidj/user/software/gmp-4.3.2 --with-mpfr=/afs/ihep.ac.cn/users/l/lidj/user/software/mpfr-2.4.2

安装好这三个库之后，需要添加环境变量LD_LIBRARY_PATH以指出前面三个库的位置，键入以下命令：(可加入到~/.tcshrc，因为以后gcc运行也需要)

    setenv LD_LIBRARY_PATH /afs/ihep.ac.cn/users/l/lidj/user/software/mpc-0.8.1/lib:/afs/ihep.ac.cn/users/l/lidj/user/software/gmp-4.3.2/lib:/afs/ihep.ac.cn/users/l/lidj/user/software/mpfr-2.4.2/lib:$LD_LIBRARY_PATH

2】(5.编译 %make时)

**error while loading shared libraries: libmpc.so.2: cannot open shared object file: No such file or directory**

*解决方法：*需要添加环境变量LD_LIBRARY_PATH以指出前面三个库的位置，键入以下命令：

    setenv LD_LIBRARY_PATH /afs/ihep.ac.cn/users/l/lidj/user/software/mpc-0.8.1/lib:/afs/ihep.ac.cn/users/l/lidj/user/software/gmp-4.3.2/lib:/afs/ihep.ac.cn/users/l/lidj/user/software/mpfr-2.4.2/lib:$LD_LIBRARY_PATH　

3】(5.编译 %make时)

**make[2]: x86_64-redhat-linux-ar: Command not found**

*解决方法：*改用--build=x86_64-redhat-linux
build版本在下面看到/usr/lib/x86_64-redhat-linux4E 


=================

1】其他错误情形,configure不同而带来的失败
../gcc-4.9.0/configure --prefix=/afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0 --enable-threads=posix --enable-checking=release --disable-multilib --enable-languages=c,c++,java  --build=x86_64-redhat-linux --with-gmp=/afs/ihep.ac.cn/users/l/lidj/user/software/gmp-4.3.2 --with-mpfr=/afs/ihep.ac.cn/users/l/lidj/user/software/mpfr-2.4.2 --with-mpc=/afs/ihep.ac.cn/users/l/lidj/user/software/mpc-0.8.1

```
**Bootstrap comparison failure!**
```

../gcc-4.9.0/configure --prefix=/afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0  --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-libgcj-multifile --enable-languages=c,c++,java --enable-java-awt=gtk --disable-dssi --disable-plugin --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre --with-cpu=generic --build=x86_64-redhat-linux --with-gmp=/afs/ihep.ac.cn/users/l/lidj/user/software/gmp-4.3.2 --with-mpfr=/afs/ihep.ac.cn/users/l/lidj/user/software/mpfr-2.4.2 --with-mpc=/afs/ihep.ac.cn/users/l/lidj/user/software/mpc-0.8.1

```
checking for X... (cached) no
configure: error: GTK+ peers requested but no X library available
configure: error: ../../../../../gcc-4.9.0/libjava/classpath/configure failed for classpath
make[1]: *** [configure-target-libjava] Error 1
make[1]: Leaving directory `/scratchfs/dyw/lidj/gcc-build'
make: *** [all] Error 2
```

2】2.5小时出现一下错误！！！

```
Comparing stages 2 and 3
warning: gcc/cc1-checksum.o differs
warning: gcc/cc1plus-checksum.o differs
Bootstrap comparison failure!
gcc/tree-vect-stmts.o differs
gcc/builtins.o differs
gcc/tree-vect-loop.o differs
make[2]: *** [compare] Error 1
make[2]: Leaving directory `/scratchfs/dyw/lidj/gcc-build'
make[1]: *** [stage3-bubble] Error 2
make[1]: Leaving directory `/scratchfs/dyw/lidj/gcc-build'
make: *** [all] Error 2
```

>You likely didn't clean up properly in-between tries. Do a make distclean and try again. Sorry.

>already solved it by make distclean and configure again.


3】15：44-17：43失败

```
libtool: link: /afs/ihep.ac.cn/users/l/lidj/scratchOld/gcc-build/./gcc/gcj -B/afs/ihep.ac.cn/users/l/lidj/scratchOld/gcc-build/x86_64-redhat-linux/libjava/ -B/afs/ihep.ac.cn/users/l/lidj/scratchOld/gcc-build/./gcc/ -B/afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0/x86_64-redhat-linux/bin/ -B/afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0/x86_64-redhat-linux/lib/ -isystem /afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0/x86_64-redhat-linux/include -isystem /afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0/x86_64-redhat-linux/sys-include -fomit-frame-pointer -Usun -g -O2 -o .libs/gc-analyze --main=gnu.gcj.tools.gc_analyze.MemoryAnalyze -shared-libgcc  -L/afs/ihep.ac.cn/users/l/lidj/scratchOld/gcc-build/x86_64-redhat-linux/libjava/.libs -L/afs/ihep.ac.cn/users/l/lidj/scratchOld/gcc-build/x86_64-redhat-linux/libjava ./.libs/libgcj-tools.so -lm /afs/ihep.ac.cn/users/l/lidj/scratchOld/gcc-build/x86_64-redhat-linux/libjava/.libs/libgcj.so ./.libs/libgcj.so -lpthread -ldl -lrt -Wl,-rpath -Wl,/afs/ihep.ac.cn/users/l/lidj/user/software/gcc-4.9.0/lib/../lib64
make[3]: Leaving directory `/scratchfs/dyw/lidj/gcc-build/x86_64-redhat-linux/libjava'
make[2]: Leaving directory `/scratchfs/dyw/lidj/gcc-build/x86_64-redhat-linux/libjava'
make[1]: Leaving directory `/scratchfs/dyw/lidj/gcc-build'
```

（该去掉java,反正用不着）
