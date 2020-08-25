```R
##add cancer type 
load("~/cnv/cancer_type_code.Rdata")
load("~/cnv/cancer_type_code_sub.Rdata")
getcancer_type <- function(tumor_barcode){
  tumor_barcode <- a$Tumor_Sample_Barcode
  code <- substr(tumor_barcode,6,7)
  cancer_type <- cancer_type_code$cancer_type[grep(code,cancer_type_code$cancer_code)]
  if(length(cancer_type)==0){cancer_type <- cancer_type_code_sub$cancer_type[grep(code,cancer_type_code_sub$cancer_code)]}
  return(cancer_type)
}

pancancer_maf[,c("Tumor_Sample_Barcode")] %>% data.table::as.data.table() -> barcode

tans2barcode <- dplyr::mutate(barcode, cancertype = apply(barcode, 1, function(tumor_barcode){
  code <- substr(tumor_barcode,6,7)
  cancer_type <- cancer_type_code$cancer_type[grep(code,cancer_type_code$cancer_code)]
  if(length(cancer_type)==0){cancer_type <- cancer_type_code_sub$cancer_type[grep(code,cancer_type_code_sub$cancer_code)]}
  return(cancer_type)
}))

merg_col <- tans2barcode[,2] %>% data.table::as.data.table()
names(merg_col) <- "cancertype"

pancancer_maf_type <- cbind(merg_col, pancancer_maf)

View(head(pancancer))

```

