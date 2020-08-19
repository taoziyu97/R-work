library("TCGAbiolinks")
# 需要两组数据，一组是seg，一组是maf
request_cancer = c("LAML", "ACC", "BLCA", "LGG", "BRCA",
                   "CESC", "CHOL", "COAD", 
                   "ESCA", "GBM", "HNSC", "KICH",
                   "KIRC", "KIRP", "LIHC", "LUAD", "LUSC",
                   "DLBC", "MESO", "OV", "PAAD",
                   "PCPG", "PRAD", "READ", "SARC", "SKCM",
                   "STAD", "TGCT", "THYM", "THCA", "UCS",
                   "UCEC", "UVM")

for (i in request_cancer){
  maf <- GDCquery_Maf(i, pipeline = "mutect2")
  print(paste0("success download ", i))
  save(maf, file = paste0("/Users/taoziyu/a_shanghaitech/2020/liulab/pan_cancer_CNV_signature/",
                          i, "/", "TCGA_", i, "_CNV_maf.RData"
                          ))
  print(paste0("success saved", i))
}

for (i in request_cancer){
  query <- GDCquery(project = paste0("TCGA-", i),
                    data.category = "Copy Number Variation",
                    data.type = "Copy Number Segment",
                    )
  GDCdownload(query)
  segTab <- GDCprepare(query)
  print(paste0("success download ", i))
  save(segTab, file = paste0("/Users/taoziyu/a_shanghaitech/2020/liulab/pan_cancer_CNV_signature/data/",
                          i, "/", "TCGA_", i, "_CNV_seg.RData"
  ))
  print(paste0("success saved", i))
}






