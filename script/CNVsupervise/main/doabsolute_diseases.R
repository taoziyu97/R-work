library(DoAbsolute)
# 数据要取barcode的前15位，并且去除正常病人
request_cancer = c("LAML", "ACC", "BLCA", "LGG", "BRCA",
                   "CESC", "CHOL", "COAD", 
                   "ESCA", "GBM", "HNSC", "KICH",
                   "KIRC", "KIRP", "LIHC", "LUAD", "LUSC",
                   "DLBC", "MESO", "OV", "PAAD",
                   "PCPG", "PRAD", "READ", "SARC", "SKCM",
                   "STAD", "TGCT", "THYM", "THCA", "UCS",
                   "UCEC", "UVM")

# 进行绝对拷贝数的计算
for (i in request_cancer){
  load(paste0("~/pan_cancer_CNV_signature/data/", i, "/TCGA_",
              i, "_CNV_maf.RData"))
  load(paste0("~/pan_cancer_CNV_signature/data/", i, "/TCGA_",
              i, "_CNV_seg.RData"))
  DoAbsolute(Seg = segTab, Maf = maf, platform = "SNP_6.0", copy.num.type = "total",
             results.dir = paste0("~/pan_cancer_CNV_signature/doabsolute/new_test", i), 
             max.as.seg.count = 100000,
             nThread = 15, keepAllResult = TRUE, verbose = TRUE, 
             temp.dir = paste0("~/pan_cancer_CNV_signature/doabsolute/temp/temp_new_", i))
  print(paste0("success ", i))
}
