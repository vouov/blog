title=怎样建立自己的Github博客
date=2015-03-01
type=post
tags=技术,github,blog
status=published
~~~~~~

去年发生太多的事情，一直无时间打理博客，之前wordpress也荒废了。今年下决定好好的维护一个博客，记录一下自己的生活和学习。

在学习如何搭建一个github博客之前，首先我们需要了解github的博客本质是什么，我们都知道github的页面都是通过markdown语法编写的。其实github也支持普通的静态html页面显示，就类似于给你一个免费的HTML空间，你自己上传HTML页面和资源文件，这样就是一个网站，这个和我们普通理解的CMS或者Blog系统不太一样。现在Github推荐的jekyll本质就是提供一套主题给你，然后你自己运行本地的生成静态的脚本把.md结尾的文件按照模板生成静态HTML然后再发布到github的仓库中，github然后就可以对外展示你最新的东西了。所以我们的目的只有一个就是如何搭建一个静态HTML站点.

如何搭建一个github博客就变成如何搭建一个静态的HTML站点，那我们就不一定需要jekyll去做这件事，同样我们也可以使用纯静态HTML的空间或者PHP空间来作为我们的服务器空间。我们比较熟悉java变成，希望用自己熟悉和擅长东西来做这件事情，经过查找研究选择了[jbake](http://jbake.org/)来做这件事。

  * 在操作之前我们首先要有github的账号，具体如何申请一个博客空间请参照：[Creating Pages with the automatic generator](https://help.github.com/articles/creating-pages-with-the-automatic-generator/)，
  * 有了空间如何绑定域名请参照：[Setting up a custom domain with GitHub Pages](https://help.github.com/articles/setting-up-a-custom-domain-with-github-pages/)
  
这样我们就有个一个github博客空间，并且可以通过域名访问了，下面就开始如何开始使用jbake搭建我们的博客系统，jbake使用freemarker模板引擎实现。具体的jbake如何运行和使用请参照：[jbake使用手册](http://jbake.org/docs/2.3.2/)。因为jbake不支持首页分页，我对官方源码修改了下支持首页分页，如果需要请参见我的github：https://github.com/vouov/jbake，打好的支持分页的jar包可以直接下载替换，请下载：[jbake-core.jar](/uploads/software/jbake-core.jar),具体使用分页请参照我的blog源码：[github blog](https://github.com/vouov/blog)

使用jbake作为github的具体步骤如下（前提是我认为你已经申请号github博客空间，并且可以域名访问了）:

  * 在你电脑创建一个blog目录，运行命令 jbake -i, 这样就会生成一个example博客模板，有JS、CSS、Images、freemarker模板等资源文件。
  * 运行命令 jbake . <目的路径>, 把当前的blog内容生成静态HTML到'目的路径'，便于发布展示。
  * 运行命令 jbake -s <目的路径>， 打开浏览器，输入URL地址：http://localhost:8820/,就可以看到示例博客的内容了。这个是一个bootstrap主题博客样式.
  * 如果不喜欢官方的主题，自己可以开发。我修改后的主题可以参照我的blog源码：[github blog](https://github.com/vouov/blog)
  * 接下来就是在blog目录中content\blog目录下写自己的.md文件，具体请参照markdown语法
  * 写好文章就是编译成HTML，运行命令 jbake . <目的路径>,刷新一下浏览器的地址就可以看到你的文章了
  * 提交同步自己的github仓库中，就可以通过域名访问最新的内容了
  
用到的软件列表如下：
[Jbake](http://jbake.org)
[highlightjs](https://highlightjs.org/)
[新浪微博留言箱](http://open.weibo.com/widget/comments.php)
[百度分享](http://share.baidu.com/)

如果使用中有什么问题可以留言给我，或者通过最底部的多种联系方式联系我！
具体可以参照我的github blog源码：
[blog jbake源码](https://github.com/vouov/blog)
[编译后的blog HTML](https://github.com/vouov/vouov.github.io)
