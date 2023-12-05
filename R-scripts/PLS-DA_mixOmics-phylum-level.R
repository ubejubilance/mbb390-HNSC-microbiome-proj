data <- read.csv("plsda-bacteria_sums.csv")
category_mapping <- c("Base_of_tongue" = 1, "Floor_of_mouth" = 2, "Gum" = 3, "Larynx" = 4)
data$Y_numeric <- category_mapping[data$Primary_Site]
numeric_cols <- 2:77

library(mixOmics)
plsda_result <- plsda(X = data[, numeric_cols], Y = data$Y_numeric, ncomp = 2)
plotIndiv(
  plsda_result, 
  ind.names = FALSE, 
  legend = TRUE, 
  comp = c(1, 2), 
  ellipse = TRUE, 
  title = 'Phylum Level',
  col.ind = df$Primary_site  # Use 'Primary_site' for coloring and legend
)
