library(ggplot2)
library(dplyr)

data <- read.csv("data.csv")
data$Percentage <- as.numeric(data$Percentage)

ggplot(data, aes(x = Site, y = Percentage, fill = Phylum)) +
  geom_bar(position = "fill", stat = "identity") +
  labs(title = "100% Stacked Bar Chart",
       x = "Site",
       y = "Percentage") +
  scale_fill_brewer(palette = "Set3") + 
  theme_minimal()