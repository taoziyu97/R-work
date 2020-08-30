【非原创】

资料来源:

https://shixiangwang.gitee.io/geek-r-tutorial/prepare.html#%E9%85%8D%E7%BD%AE%E5%8F%AF%E9%80%89



在windows下使用R的时候，经常会遇到难以解决的包的安装上的问题，解决起来很麻烦，但是根据这篇R的配置（这里的配置的目的似乎描述的是，建立一个本地的R包存储文件夹，这样在更新R的时候，不必要再去重新安装包），可以解决我很多没有解决的问题。

#### 安装R三要素

- 安装R 
- 安装Rtools
- 安装R studio



#### 具体安装

- 安装R

  对于 MacOS 系统用户，下载后直接双击一路向下进行傻瓜式操作即可安装成功。

  对于 Windows 系统用户，根据笔者几年的安装和使用经验，安装时有一些额外的注意事项：

  1. Windows 一般包含多个盘符，请读者尽量不要将 R 安装在 `Program files` 这样有空格的目录或中文目录下。读者可以自行创建一个专门的工具用于安装 R 以及放置 R 的三方包，如 `C:/Tools`
  2. 读者的电脑如果有 SSD 固态硬盘，最好将 R 安装到固态硬盘目录里，因为读写数据快。
  3. 一般现在电脑是 64 位的，如果你确定是这样，在安装时有关于 32 位的选项都可以不勾选
  4. 如果涉及到添加环境变量/路径之类的步骤，勾选添加即可。
  5. 以上没提到的，一路点下一步。

- 在 Windows 或 MacOS 下读者如果想要安装含有像 C++ 这样的源码的包，需要安装编译工具如 g++，这些编译工具都被 R 语言团队打包成了 Rtools。

- 安装Rtools一路选择默认即可，不然会产生不必要的麻烦。



#### 配置

Windows 下的 R 默认使用用户文档目录作为家目录（等同于 Linux 中的`~`），使用系统指定的临时目录作为临时目录，使用安装路径下的 `R版本/library` 目录作为 R 包存储目录。

如果读者什么都选择默认的，

- 当你一时安装包过多，或者装了电脑管家之类的管理软件时，系统的临时目录经常会把 RStudio 锁死，导致不能进行读写。
- 当你想要更新 R 版本时，有时你不得不面临重装所有包的举动（如果你使用几个月，装了几百个包…），或者想其他办法解决。

下面介绍如何创建自定义的临时目录与包目录，这样上面情况都不会发生了。

读者在安装好 R 和 RStudio 后，打开 RStudio，在 R 控制台键入：

```R
file.edit("~/.Rprofile")
```

在启动RStudio时，RStudio会首先执行里面的 R 代码，所以我们可以在这里用 R 代码进行配置。

首先在该文档内添加内容：

```R
#--------------------------------------------
# Set custom library and temp directory for R
# NOTE: please only change following 2 paths
#   Any Question, please email to 
#       Shixiang Wang <w_shixiang@163.com>
#--------------------------------------------
.CUSTOM_LIB = "C:/Tools/R/R_Library" # set your custom library location
.TMP = "C:/Tools/R/Rtmp"             # set a temp dir for R running
                                     # please do not add '/' at the end !!!

if(!dir.exists(.CUSTOM_LIB)){
    dir.create(.CUSTOM_LIB, recursive = TRUE)
}

.libPaths(c(.CUSTOM_LIB, .libPaths()))
message("Using library: ", .libPaths()[1])


if(dirname(tempdir()) != .TMP){
    if(!dir.exists(.TMP)) dir.create(.TMP, recursive = TRUE)
    cat(paste0("TMPDIR = ", .TMP), file="~/.Renviron", sep = "\n")
}
message("Using temp directory: ", .TMP)

#---------------------------------------------------
# pacman is optional, you can delete following code
# If you wanna use pacman, please read:
#   <https://www.jianshu.com/p/cb16ded75672>
# Basically, 
# #1, you can use 'p_load' to load multiple package into R
#       like p_load(data.table, dplyr)
# #2, you can use 'p_get' just to install package
# #3, you can use 'p_update' to update all packages
#---------------------------------------------------
if(!require(pacman)){
    install.packages("pacman", dependencies = TRUE)
}
library(pacman)
#----------------------------------------------------
```

然后根据情况对上述内容中的目录设定进行修改即可。

**pacman** 那段代码是可选的，该包是 `library()` 函数的替代品，使用它安装和管理 R 包更简单。具体的使用方法可以[点击阅读](https://www.jianshu.com/p/cb16ded75672)我之前的简书文章。

这里为了方便大家使用，我添加了一些必要注释，如果上述配置存在问题，读者可以发邮件给我。

保存后重启 RStudio 或者点击菜单栏 **Session** 下的 **Restart R**。

以后 RStudio 每次启动后都会输出读者计算机中 R 包的存储路径和它使用的临时路径。读者如果以后升级 R，只要重装下 R 安装文件就可以了，R 包的目录并不会改动，键入下面的命令可以更新所有的 R 包：

```R
p_update()
```





