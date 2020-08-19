library(DoAbsolute)

request_cancer = c("TGCT")
for (i in request_cancer){
  print(i)
  load(paste0("/public/home/liuxs/taozy/doabsolute/script/data/", i, "/TCGA_",
              i, "_CNV_maf.RData"))
  maf$Tumor_Sample_Barcode = substr(maf$Tumor_Sample_Barcode, 1, 15)
  load(paste0("/public/home/liuxs/taozy/doabsolute/script/data/", i, "/TCGA_",
              i, "_CNV_seg.RData"))
  segTab$Sample = substr(segTab$Sample, 1, 15)
  print(paste0("success ", i))
  save(maf, file = paste0("/public/home/liuxs/taozy/doabsolute/script/data/", i, "/TCGA_",
                   i, "_CNV_maf.RData"))
  save(segTab, file = paste0("/public/home/liuxs/taozy/doabsolute/script/data/", i, "/TCGA_",
                   i, "_CNV_seg.RData"))
  rm(maf)
  rm(segTab)
}
# 进行绝对拷贝数的计算
for (i in request_cancer){
  load(paste0("/public/home/liuxs/taozy/doabsolute/script/data/", i, "/TCGA_",
              i, "_CNV_maf.RData"))
  load(paste0("/public/home/liuxs/taozy/doabsolute/script/data/", i, "/TCGA_",
              i, "_CNV_seg.RData"))
  DoAbsolute(Seg = segTab, Maf = maf, platform = "SNP_6.0", copy.num.type = "total",
             primary.disease = i,
             results.dir = paste0("/public/home/liuxs/taozy/doabsolute/result/", i), 
             nThread = 15, keepAllResult = TRUE, verbose = TRUE, 
             temp.dir = paste0("/public/home/liuxs/taozy/doabsolute/temp/temp_", i))
  print(paste0("success ", i))
}

