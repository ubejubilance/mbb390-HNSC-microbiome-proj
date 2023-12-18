#To make heatmap (heatmaply)
data <- read.csv("heatmap.csv", row.names = 1)
sample_data <- read.csv("SampleNo_PrimarySite.csv")
sample_data$Primary_Site <- factor(sample_data$Primary_Site, levels = c("Larynx", "Gum", "Floor_of_mouth", "Base_of_tongue"))
legend_labels <- c(

    "Larynx" = "Larynx Label",
    "Gum" = "Gum Label",
    "Floor_of_mouth" = "Floor of Mouth Label",
    "Base_of_tongue" = "Base of Tongue Label"
)
colors <- colorRampPalette(c("blue", "white", "red"))(50)
legend_colors <- c("navy", "green4", "darkorange", "purple")
heatmaply(

    data,
    ColSideColors = legend_colors[sample_data$Primary_Site],
    k_col = length(unique(sample_data$Primary_Site)),
    col = colors,
    dendrogram = "both",
    main = "Heatmap of Normalized Abundances",
    xlab = "Samples",
    ylab = "Top 10 Genera",
    fontsize = 5,
    legend_labels = legend_labels,
)