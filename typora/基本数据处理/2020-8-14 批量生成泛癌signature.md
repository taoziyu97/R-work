生成泛癌signature首先要准备maf文件，我这里得到的maf文件都是从这个网站上整理好的

https://gdc.cancer.gov/about-data/publications/pancanatlas

由于所有的癌症都归在一个文件当中，而且只有barcode，没有对应的癌症类型，需要把名称比对上，再根据癌症类型生成各自的maf，再批量生成siganture



批量生成各个癌症类型的maf：

```R
$ for (i in cancer_type){
  locate <- paste0("TCGA-",i)
  type <- by_cancer[[locate]]
  save(type, file = paste0(i, ".RData"))
}
```

