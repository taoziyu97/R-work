library(pheatmap)
library(ComplexHeatmap)
# Create test matrix
test = matrix(rnorm(200), 20, 10)
test[1:10, seq(1, 10, 2)] = test[1:10, seq(1, 10, 2)] + 3
test[11:20, seq(2, 10, 2)] = test[11:20, seq(2, 10, 2)] + 2
test[15:20, seq(2, 10, 2)] = test[15:20, seq(2, 10, 2)] + 4
colnames(test) = paste("Test", 1:10, sep = "")
rownames(test) = paste("Gene", 1:20, sep = "")
head(test, 5)
pheatmap(test, display_numbers = TRUE, number_format = "%.1e")

# Draw heatmaps
pheatmap(log10(test))




pheatmap(test,clustering_method = "median")
pheatmap(test, cluster_row = FALSE)
pheatmap(test, kmeans_k = 2)
pheatmap(test, legend = FALSE)

pheatmap(test, scale = "row", clustering_distance_rows = "correlation")

pheatmap(test, color = colorRampPalette(c("navy", "white", "firebrick3"))(50))

# Show text within cells
pheatmap(test, display_numbers = TRUE)
pheatmap(test, display_numbers = TRUE, number_format = "%.1e")
pheatmap(test, display_numbers = matrix(ifelse(test > 5, "*", ""), nrow(test)))

pheatmap(test, cluster_row = FALSE, legend_breaks = -1:4, legend_labels = c("0",
                                                                            "1e-4", "1e-3", "1e-2", "1e-1", "1"))
library(Hmisc)
cortest <- rcorr(as.matrix(test), type = "pearson")
r_value <- cortest$r
range(r_value)

p_value <- ifelse(is.na(cortest$P), "", cortest$P)
pheatmap(cortest$r, display_numbers = matrix(ifelse(p_value < 0.05, "*", ""), nrow(p_value)))

# Fix cell sizes and save to file with correct size
pheatmap(test, cellwidth = 15, cellheight = 12, fontsize = 8,main = "Example heatmap")
pheatmap(test, cellwidth = 15, cellheight = 12, fontsize = 8, filename = "test.pdf")

# Generate annotations for rows and columns
annotation_col = data.frame(
  CellType = factor(rep(c("CT1", "CT2"), 5)), 
  Time = 1:5
)
rownames(annotation_col) = paste("Test", 1:10, sep = "")

annotation_row = data.frame(
  GeneClass = factor(rep(c("Path1", "Path2", "Path3"), c(10, 4, 6)))
)
rownames(annotation_row) = paste("Gene", 1:20, sep = "")

# Display row and color annotations
pheatmap(test, annotation_row = annotation_col)
pheatmap(test, annotation_col = annotation_col, annotation_legend = FALSE)
pheatmap(test, annotation_col = annotation_col, annotation_row = annotation_row)

# Change angle of text in the columns
pheatmap(test, annotation_col = annotation_col, annotation_row = annotation_row, angle_col = "45")
pheatmap(test, annotation_col = annotation_col, angle_col = "0")

# Specify colors
ann_colors = list(
  Time = c("white", "firebrick"),
  CellType = c(CT1 = "#1B9E77", CT2 = "#D95F02"),
  GeneClass = c(Path1 = "#7570B3", Path2 = "#E7298A", Path3 = "#66A61E")
)

pheatmap(test, annotation_col = annotation_col, annotation_colors = ann_colors, main = "Title")
pheatmap(test, annotation_col = annotation_col, annotation_row = annotation_row, 
         annotation_colors = ann_colors)
pheatmap(test, annotation_col = annotation_col, annotation_colors = ann_colors[2]) 

# Gaps in heatmaps
pheatmap(test, annotation_col = annotation_col, cluster_rows = FALSE, gaps_row = c(10, 14))
pheatmap(test, annotation_col = annotation_col, cluster_rows = FALSE, gaps_row = c(10, 14), 
         cutree_col = 2)

# Show custom strings as row/col names
labels_row = c("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", 
               "", "", "Il10", "Il15", "Il1b")

pheatmap(test, annotation_col = annotation_col, labels_row = labels_row)

# Specifying clustering from distance matrix
drows = dist(test, method = "minkowski")
dcols = dist(t(test), method = "minkowski")
pheatmap(test, clustering_distance_rows = drows, clustering_distance_cols = dcols)

# # Modify ordering of the clusters using clustering callback option
# callback = function(hc, mat){
#   sv = svd(t(mat))$v[,1]
#   dend = reorder(as.dendrogram(hc), wts = sv)
#   as.hclust(dend)
# }
# 
# pheatmap(test, clustering_callback = callback)

## Not run: 
# Same using dendsort package
library(dendsort)

callback = function(hc, ...){dendsort(hc)}
pheatmap(test, clustering_callback = callback)

## End(Not run)

library(Hmisc)
library(reshape2)
cortest <- rcorr(as.matrix(test), type = "spearman")
r_value <- cortest$r
range(r_value)

r_value[upper.tri(r_value)] <- NA

pheatmap(r_value,c(colorRampPalette(c("blue","white"))(10),
                colorRampPalette(c("white","red"))(10)),
         legend_breaks=seq(-1,1,0.2))

r_value[upper.tri(r_value)] <- 0  
pheatmap(r_value, 
         c(colorRampPalette(c("blue","white"))(5),
          colorRampPalette(c("white","red"))(5)),
         legend_breaks=seq(-1,1,0.2),
         cluster_rows=F, cluster_cols=F, border_color=NA)

library(devtools)
install_github("https://github.com/jokergoo/ComplexHeatmap.git")
