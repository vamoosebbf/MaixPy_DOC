git 和 github 介绍
=====

因为在学习 MaixPy 的过程中， 有很多地方用到 git 和 github， 所以这里简单解释一下它们是什么，以及区别是什么。


## 什么是 git

git 是一款 代码托管 **软件**， 用来管理代码的版本。
比如：
我今天改了代码， 然后明天也改了代码， 以后我都能看到这两次改动历史， 以及改了什么内容，可以精确到哪一行，方便后面找问题;
或者我发现第二次提交的代码出现了问题， 我需要回到第一次提交后的版本， 都可以用这个工具实现;
另外方便多个人修改同一份代码，能管理大家提交的代码，不容易出现混乱。

再也不用拷贝无数个文件夹来备份修改了！

git 会在目录下创建一个`.git`隐藏文件夹， 所有更改记录保存在这里面，不能删除这个文件夹。

但是需要注意的是， 现在的 git 主要用来管理文本文件， 不适用拿来管理二进制文件，比如图片 PDF等等， 会让文件夹占用的空间变得很大。

具体的教程，可以看 [这里](https://git-scm.com/), 中文教程可以看 [这里](https://www.liaoxuefeng.com/wiki/896043488029600/896067008724000)


## 什么是 github

github 是一个 分享代码 的 **网站**。

可以在这个网站上注册， 然后建立仓库（repository），往这个仓库里面放代码公开分享，让更多地人来使用， 甚至一起修改，一起优化代码， 这就是**开源**。

每个仓库都是可以单独地使用 `git` 这个软件来管理的， 大家在自己的电脑上修改代码， 然后使用`git`提交， 然后使用`git`推送到`github`这个网站， 大家就可以看到新的内容了。

MaixPy 的源码的地址是： [https://github.com/sipeed/maixpy](https://github.com/sipeed/maixpy) , 也就是一个 `git 仓库`。


github 的[帮助](https://docs.github.com/en/free-pro-team@latest/github), 中文 [帮助](https://docs.github.com/cn/free-pro-team@latest/github)

## git 和 github 的区别

一个是一个软件， 一个是一个网站。
只不过这个网站用到了 git 这个技术来管理仓库。


## 什么是 issue

也就是问题的意思， 在github 上， 每个仓库有一个专门用来提问的地方， 比如 [MaixPy的issue](https://github.com/sipeed/MaixPy/issues)
大家在这里提问， 类似论坛一样， 都会被记录下来，方便后面的人查阅


## 什么是 PR

即 github 上的 pull request 功能， 就是参与一个仓库的代码更新， 具体方法可自行学习



