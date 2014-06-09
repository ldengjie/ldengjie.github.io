---
layout: post
title: github JekyII 代码高亮 
description: 使用prettify实现代码高亮，jQuery加入行号、修正html对`pre`标签识别问题
category: blog 
---

### 使用步骤

1.[下载](https://code.google.com/p/google-code-prettify/) prettify.js和prettify.css,放到网站特定文件加下`/js/prettify/`

2.在.html中加入, 考虑到加载速度，最好js写到文档末尾，body闭合标签之前，css写到头部

    <link href="/js/prettify/prettify.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/js/prettify/prettify.js"></script>

3.调用，可以写在body的onload事件中，但是不建议，这里用jquery，在DOM节点加载完之后就调用

    <script type="text/javascript">
    $(window).load(function () {
            prettyPrint();
            })
    </script>

4.书写代码。这时就可以用markdown写文章了，代码语法为`四个空格`，,JekyII编译时会自动生成`pre`标签。显示是带行号的，复制下来就没有行号了。

示例：c++

	#include  <iostream>
	using namespace std;
	int main(int argc, char *argv[])
	{
	    cout<<"hello word! "<<endl;
	}
	
java

    public class HelloWord
    {
        public static void main(String[] args)
        {   
            System.out.println("Ni hao!");
        }      
    }

=====
### Tips:

1.步骤3的调用也可以如下,但资料说会拖延加载速度，不如先加载主要内容，再处理代码部分

    <body onload="prettyPrint()">

2.步骤4,若网页是直接通过html代码编写，应该这样标记

    <pre class="prettyprint">
    // code here
    </pre>

3.默认显示行号，不需要添加如下代码，跟jQuery([2.1.1](http://code.jquery.com/jquery-2.1.1.min.js)),prettify([7.x-1.0-beta1](http://ftp.drupal.org/files/projects/prettify-7.x-1.0-beta1.zip))更新版本有关？下载不了的话，可能是被墙了。

    <script type="text/javascript">
    $(window).load(function () {
            $("pre").addClass("prettyprint linenums");
            })
    </script>

4.linux 解压tar.bz2

    tar -xjf *.tar.bz2

5.html代码不能放在markdown的1.2.3...列表里，且要和上下文用空行隔开，否则JekyII编译时会添加`li`标签，而不是`pre`标签，这样的话html code不会显示，而是会被执行

6.行号距离边框太近了，修改`/js/prettify/prettify.css`

    ol.linenums{margin-top:0;margin-bottom:0} 修改前
    ol.linenums{padding:5px;margin-top:0;margin-bottom:0} 修改后

7.prettify.js **一定**要放在jquery-2.1.1.min.js之后，且jquery-2.1.1.min.js**一定**要在/head之前!!!

参考资料：

[Jekyll中使用google-code-prettify高亮代码](http://blog.evercoding.net/2013/02/27/highlight-code-with-google-code-prettify/)

[使用google-code-prettify高亮显示网页代码](http://www.cnblogs.com/changweihua/archive/2012/06/02/2531590.html)

[github page code highlight](http://dj-chen.com/blog%20construction/2012/11/24/github-page-code-highlight/)

[jQuery 教程](http://www.w3school.com.cn/jquery/index.asp)
