tumor_data <- read.csv("tumor_data.csv", header = TRUE)
paired_normal_data <- read.csv("paired_normal_data.csv", header = TRUE)

library(dplyr)
tumor_median <- tumor_data %>%
  group_by(Phylum) %>%
  summarise(
    count = n(),
    median = median(Abundance, na.rm = TRUE),
    IQR = IQR(Abundance, na.rm = TRUE)
  )
normal_median <- paired_normal_data %>%
  group_by(Phylum) %>%
  summarise(
    count = n(),
    median = median(Abundance, na.rm = TRUE),
    IQR = IQR(Abundance, na.rm = TRUE)
  )

tumor_data$Type <- "Tumor"
paired_normal_data$Type <- "Paired Normal"

combined_data <- rbind(tumor_data, paired_normal_data)

library("ggplot2")
ggplot(combined_data, aes(x = Phylum, y = Abundance, color = Type)) +
  geom_boxplot(position = position_dodge(width = 0.8)) +
  geom_jitter(position = position_dodge(width = 0.8), size = 1) + 
  labs(x = "Phylum", y = "Abundance") +
  theme_minimal() +
  scale_color_manual(values = c("blue", "red")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 

wilcox_results_df <- data.frame(Phylum = character(),
                                  W = numeric(),
                                  p.value = numeric(),
                                  stringsAsFactors = FALSE)

unique_phyla <- unique(combined_data$Phylum)

for (phylum in unique_phyla) {
    subset_data <- subset(combined_data, Phylum == phylum)
      if ("Tumor" %in% subset_data$Type && "Paired Normal" %in% subset_data$Type) {
        wilcox_results <- wilcox.test(Abundance ~ Type, data = subset_data, paired = TRUE, exact = FALSE)
        wilcox_results_df <- rbind(wilcox_results_df, data.frame(Phylum = phylum,
                                              W = wilcox_results$statistic,
                                              p.value = wilcox_results$p.value))
        }
}

write.csv(wilcox_results_df, "wilcox_results_df.csv")