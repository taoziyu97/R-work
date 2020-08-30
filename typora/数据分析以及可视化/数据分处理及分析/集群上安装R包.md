集群上安装R包方法之一：

- 克隆仓库下来

  `git clone http:/name_of_packages.git`

- 进入集群R

  `conda activate R_36`

  `R`

- build and install

  `devtools::build("name_of_package")`

  `install.packages("DoAbsolute_2.1.0.tar.gz", type = "source")`

  

  

  

  

  

  
