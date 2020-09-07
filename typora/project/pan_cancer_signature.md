基本：用COSMIC v3的作为统计结果



目录：

- 泛癌基于WES/WGS的生存关联分析
- 基因水平
- 免疫浸润
- 其他分析
- 数据库构建



整体框架：

- 不同数据库来源的数据
- 不同癌症类型的数据
- 泛癌的数据
- 生存数据：单因素，多因素（做各个cancer type的时候，用每个类型含有的signature，不含有的signature就不放进去考虑），分组cutoff（10%，20%，25%，50%）做KM分析



代码框架：

- 数据预处理文件
- 数据分析文件



分析方法：

- t检验 spearman
- cox分析



整理：

生成一个表格，整理一下各个cancer type含有的signature



数据：

不再使用sig_fit去做，sig_fit对于WES得到的不准确性达到10-30%，针对突变数目比较少的样本可能结果不准确率更高。

![image-20200819163212787](pan_cancer_signature.assets/image-20200819163212787.png)