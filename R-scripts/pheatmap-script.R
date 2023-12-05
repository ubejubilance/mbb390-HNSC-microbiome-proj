data <- read.csv("heatmap.csv", row.names = 1)
sample_data <- read.csv("SampleNo_PrimarySite.csv")
legend_colors <- c("lightseagreen", "orange3", "tomato3", "black")
sample_data$Primary_Site <- factor(sample_data$Primary_Site, levels = c("Larynx", "Gum", "Floor_of_mouth", "Base_of_tongue"))

library(pheatmap)
pheatmap(
  data,
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  color = colorRampPalette(c("blue", "white", "red"))(50),
  main = "Heatmap of Normalized Abundances",
  fontsize = 8,
  fontsize_row = 7,
  fontsize_col = 7,
  annotation_col = sample_data["Primary_Site"],
  annotation_colors = list(Primary_Site = legend_colors),
  annotation_legend = TRUE,
  cellnote = data,  
  cellnote_fontsize = 8,  
  cellnote_col = legend_colors[sample_data$Primary_Site]  
)
