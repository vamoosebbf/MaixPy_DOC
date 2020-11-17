参与经验分享
=======

本目录下主要用于大家分享自己的经验，或者教程


## 要参与分享，你需要提前掌握的知识

* git 和 github 的使用
* github PR（pull request）的使用

在入门教程里面有简要的介绍， 详细的使用方法请自行学习

如果你没有信心掌握这些技能， 你可以到提交[issue](https://github.com/sipeed/MaixPy_DOC/issues) 来说明问题或者贡献经验等，我们帮助你进行添加


## 如何添加


### 克隆文档到本地

```
git clone https://github.com/sipeed/MaixPy_DOC
cd MaixPy_DOC
```


### 新建目录

需要新建一个目录专门用于写分享的文章，
在`MaixPy_DOC/zh/share/my_share/`目录下建立一个文件夹， 文件夹名只能用小写英文和下划线，可以用你的英文名字命名，比如`tom`或者`lihua`,
以下用`MaixPy_DOC/zh/share/my_share/tom`举例

在这个文件夹内建立一个文件，命名为`readme.md`, 然后在里面使用`markdown`语法编写分享，
建立`MaixPy_DOC/zh/share/my_share/tom/assets`目录，用来存放图片，
文档里面引用图片使用相对路径，比如放了一张图片路径是`MaixPy_DOC/zh/share/my_share/tom/assets/cover.jpg`，则在`MaixPy_DOC/zh/share/my_share/tom/readme.md`中引用图片使用如下语法
```
![封面](./assets/cover.jpg)
```

注意， 不要往文件夹内放大文件， 图片也不要用太大的，否则会导致文档仓库巨大无比


### 编写文档

为了文档看起来格式正确，更易于阅读，
编写文档需要遵循语法和格式要求： 看 [文档规范](../../contribute/doc_convention.md)

文档模板

```
TODO:
```


### 添加这篇分享到文档左边的目录栏


打开`MaixPy_DOC/zh/SUMMARY.md`, 在末尾添加自己的分享，比如



```
## 社区 & 分享

- [精选教程](./share/recommend_articles.md)
- [开源项目](./share/open_projects.md)
- 大家的经验分享
  * [参与经验分享/分享模板](./share/my_share/README.md)
  * [jerry 的模型训练教程](./share/my_share/jerry/README.md)

```

添加自己的卡后效果是：

```
## 社区 & 分享

- [精选教程](./share/recommend_articles.md)
- [开源项目](./share/open_projects.md)
- 大家的经验分享
  * [参与经验分享/分享模板](./share/my_share/README.md)
  * [模型训练教程-jerry](./share/my_share/jerry/README.md)
  * [如何设计一个自己的模型-tom](./share/my_share/tom/README.md)
```

注意是**\***号前面是两个空格，不是`tab`


### 提交

编写完后提交修改，然后在 github 上提交 PR， PR 通过后官方文档页面就会有这篇文章了








