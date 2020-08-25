#### 内容

- 肿瘤信息学中名词

- 软件功能
- 软件原理
- 分析流程
- 计算方法



##### 肿瘤信息学中名词

- 肿瘤纯度：tumor purity

  肿瘤细胞占样本中所有细胞的比例。

- 肿瘤倍性：tumor ploidy

  由染色体结构和数目异常导致的这种癌细胞在肿瘤样本中的含量为倍性。？？？

- the ploidy of cancer cells refers to the amount of DNA they contain.

  - If there's a normal amount of DNA in the cells, they are said to be *diploid*. These cancers tend to grow and spread more slowly.
  - If the amount of DNA is abnormal, then the cells are called *aneuploid*. These cancers tend to be more aggressive. (They tend to grow and spread faster.)



##### 软件功能

Extracts absolute copy numbers **per cancer cell** from a mixed DNA population.

直接分析  **体细胞DNA变异**  得到肿瘤纯度和细胞倍性，推断得到绝对拷贝数。



##### 绝对拷贝数为什么难得到？

1. 取样时肿瘤纯度未知
2. 实际的癌细胞中的DNA含量为多少未知
3. 癌细胞群体可能是异质的（经历subclonal evolution）

原则上，得到每个癌细胞的DNA质量，或者通过单细胞测序技术可以得到绝对拷贝数。



##### 软件原理

1. 通过突变数据和拷贝比率得到样本的异质性（heterogeneity）

- 样本异质性：理解成大样本数据中有很多小样本，每个小样本有不同的数据特征，仅仅在大样本的层面去分析，用来估计和预测小样本的时候会出现偏差，因为每个小样本有自己的特征。

- 两个方面

  - tumor purity：总体细胞中肿瘤细胞占比，肿瘤样本中会混合进去部分的正常细胞。
  - tumor cell heterogeneity：经历过亚克隆进化，每个肿瘤群体通过ploity（正常单倍体基因组为单位对基因组的segment进行定义）进行分组。

- 如何验证肿瘤细胞纯度的估计？

  通过比较：组织学纯度的估计和血液中白细胞甲基化特征（常见的样本污染）

  

2. 核型模型（karyotype model）

   提供了3种推断方法



2. 使用突变数据得到等位基因分数

   VAF可以用于推断肿瘤异质性和肿瘤纯度

- ABSOLUTE使用拷贝数和突变数据推断样本的纯度

- 评估了细胞的重复性

  每个癌细胞的平均位点拷贝数，得到了克隆性的和亚克隆性突变的绝对拷贝数变化。



##### 计算特点（三个）

1. 通过相对拷贝数估计肿瘤的纯度和倍性。

2. 使用pre-computed统计模型和不同的参考样本收集来解决倍性和纯度模糊的情况。

3. 计算绝对拷贝数和肿瘤亚克隆中的点突变。

   copy ratio需要接近1，小于0.75大于1.25会失败。















   