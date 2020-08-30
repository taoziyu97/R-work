- indel文献调研
- tide结果整理和解读
- 做汇报ppt
- 简书数据库技术性笔记



##### indel 背景

- 突变特征：

  - 移码突变

    读码框发生改变

  - 非移码突变

- 遗传角度分类;

  - 种系突变

    从父母那里遗传到的

  - 体细胞突变

    在日后生活中接受外在影响的条件下，发生的DNA序列的改变

- 人类中约有1-2百万个频率高低不等的indel，大部分发生在短串联重复区域



##### indel文献调研

- immunogenic phenotype[1]

  The frameshift of indel mutation maybe create novel open reading frames and mutagenic peptides distinct from self. 

- 乳腺癌肿瘤的免疫原性比较弱，考虑到indel会产生移码现象，可能会提供抗原，但是indel mutation在乳腺癌中的模式仍然不清楚，这篇文章分析了乳腺癌的indel突变模式[3]

- 45个和免疫相关的基因中，22个基因indel变异的肿瘤中显著提高表达，且基因组不稳定性很高[3]

  indel is significantly correlated with higher TMB and neoantigen level in TCGA cohort.Among 45 immune related genes, the mRNA expression of 22 genes were significantly higher in tumors with indels mutations, such as LAG3, IL18, IL6, CTLA4 and PDCD1. Indels group also showed a high levels of genome instability in terms of HRD-LOH (P = 0.004), NtAI (P = 0.000), wGII (P = 0.001) and LST (P =0.014)

- scanNeo：一个computational pipeline去预测肿瘤新抗原

  使用RNA-seq数据来预测indel引起的新抗原（不光是小的indel还有大的indel），再通过检查点抑制反应进行证明[5]。

- Turajlic et al. reported that neoantigens derived from indel mutations were nine times enriched for mutant specific binding, as compared with non-synonymous SNV derived neoantigens[6]

- 在 renal clear cell carcinoma cohortr cell carcinoma cohort这个癌症中,indel突变和上调抗原表达基因以及CD8+表达T细胞激活相关[6]

- homopolymer indel来检测MSI以及和突变负载之间的关系[7]

- MSI-H肿瘤有一些特征,比如:很高的淋巴浸润和很高的突变负载.而且这些肿瘤的indel数量很多.很多indel可以预测抗pd1治疗的反应[7]

- published a maximum likelihood approach to estimate the mutation rate and the distribution of fitness effects for indel. Fixed coding INDELs, 71% of insertions and 86% of deletions are fixed by positive selection. In noncoding regions, we estimate ∼80% of insertions and ∼52% of deletions are effectively neutral, the remainder show signatures of purifying selection.[8]

- indel的基因和进化机制还不是很清楚. 删除的频率比插入高得多[9]我随便找了一个癌症比如看了一下确实是这样,del有4k,ins有1k. indel的基因在进化上很保守,比非indel的基因进化要慢.还研究了indel基因在性转过程中的高表达,性腺的表达水平和indel在基因组上的密度表现出显著的正相关[9]

- indel calling 用新的方法检验或者重新得到准确度更高的indel

- 在人类基因组中重复序列大量存在，DNA序列重复有很多种类型：简单重复、串联重复、低拷贝重复、 散在重复序列和其他的元件，覆盖基因组上超过50%的部分。会导致各种不同的序列分析错误。——关于检测INDEL的文章[10]

- indel的位置

- 2017年7月柳叶刀上发表了一篇文章表示：癌症中的indel会导致异常蛋白的失活，也会致免疫系统的激活，indel越多的肿瘤组织可能对PD-1抑制剂等免疫治疗更敏感。

- indel所在位置和表征（文章重点不是indel）

  - 区域：incRNA FAS5,和热惊厥相关

  - 在KDM6A基因中的indel，和生长特征的强烈相关[13]

    

- indel在癌症中和拓扑异构酶相关

  indel signature和DNA活动的相关性





- 影响indel的

  - uridine depletion impact indel activity, 5-methoxyuridine uridine depletion induced indel frequencies 88% and elicited minimal immune responsess[2]

  - 移码indel很容易通过 无义介导的mRNA降解途径（NMD）发生降解，但是会有逃脱这个机制的indel存在，逃过降解的移码indel和免疫点治疗显著相关，甚至比nsSNV count和fs-indel count还高[4]

    





[1]Turajlic, Samra, et al. "Insertion-and-deletion-derived tumour-specific neoantigens and the immunogenic phenotype: a pan-cancer analysis." *The lancet oncology* 18.8 (2017): 1009-1021.

[2]Vaidyanathan, Sriram, et al. "Uridine depletion and chemical modification increase Cas9 mRNA activity and reduce immunogenicity without HPLC purification." *Molecular Therapy-Nucleic Acids* 12 (2018): 530-542.

[3]Breast cancer with insertion or deletion exhibits the immunogenic phenotype

[4]Litchfield, Kevin, et al. "Escape from nonsense mediated decay associates with anti-tumor immunogenicity." *bioRxiv* (2019): 823716.

[5]Wang, Ting-You, et al. "ScanNeo: identifying indel-derived neoantigens using RNA-Seq data." *Bioinformatics* 35.20 (2019): 4159-4161.

[6]Pan, Deng, et al. "Immunogenicity of Del19 EGFR mutations in Chinese patients affected by lung adenocarcinoma." *BMC immunology* 20.1 (2019): 43.

[7]Zhao, Hui, et al. "Association of a novel set of 7 homopolymer indels for detection of MSI with tumor mutation burden and total indel load in endometrial and colorectal cancers." (2018): e15654-e15654.

[8]Barton, Henry J., and Kai Zeng. "The impacst of natural selection on short insertion and deletion variation in the great tit genome." *Genome biology and evolution* 11.6 (2019): 1514-1524.

[9]Chen, Feng, et al. "The genome-wide landscape of small insertion and deletion mutations in Monopterus albus." *Journal of Genetics and Genomics* 46.2 (2019): 75-86.

[10]Narzisi, Giuseppe, and Michael C. Schatz. "The challenge of small-scale repeats for indel discovery." *Frontiers in bioengineering and biotechnology* 3 (2015): 8.

[11]Xiang, Wenna, et al. "Association between indel polymorphism (rs145204276) in the promoter region of lncRNA GAS5 and the risk of febrile convulsion." *Journal of cellular physiology* 234.9 (2019): 14526-14534.

[12]Boot, Arnoud, and Steven G. Rozen. "Distinctive indel mutational signature in tumors carrying TOP2A p. K743N." *bioRxiv* (2020).

[13]Wang, Ke, et al. "One 16 bp insertion/deletion (indel) within the KDM6A gene revealing strong associations with growth traits in goat." *Gene* 686 (2019): 16-20.