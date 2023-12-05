#by primary site
archaea <- read.csv("full_data_abundace_Archaea_allsites.csv")
target_primary_site <- "Larynx"
sample_number <- primary_site[primary_site$Primary_Site == target_primary_site, "Sample_Number"]
subset_file2 <- archaea[archaea$Sample_Number %in% sample_number, ]
write.csv(subset_file2, file = "full_data_abundance_Archaea_larynx.csv", row.names = FALSE)

#Editing Column Name
raw_bacteria_larynx <- read.csv("raw_abundance_bacteria_larynx.csv")
new_colnames <- colnames(raw_bacteria_larynx)
for(i in seq_along(new_colnames)) {
  if(i > 1) {
    new_colnames[i] <- sub("^k__Bacteria.p__", "", new_colnames[i])
  }
}

colnames(raw_bacteria_larynx) <- new_colnames
col_names <- names(raw_bacteria_larynx)
new_col_names <- c(col_names[1], sub("\\..*", "", col_names[-1]))
names(raw_bacteria_larynx) <- new_col_names
write.csv(raw_bacteria_larynx, "phyla.csv", row.names = FALSE)

#For Viruses Family
raw_viruses_larynx <- read.csv("raw_abundance_viruses_larynx.csv")
new_colnames <- colnames(raw_viruses_larynx)
for(i in seq_along(new_colnames)) {
  if(i > 1) {
    new_colnames[i] <- sub(".*f__", "", new_colnames[i])
  }
}
colnames(raw_viruses_larynx) <- new_colnames
col_names <- names(raw_viruses_larynx)
new_col_names <- c(col_names[1], sub("\\..*", "", col_names[-1]))
names(raw_viruses_larynx) <- new_col_names
write.csv(raw_viruses_larynx, "raw_viruses_larynx_family.csv", row.names = FALSE)


#Sum each Column
data <- read.csv("phyla.csv", check.names = FALSE)
sums <- colSums(data[, -1])
col_names <- names(data)[-1]
result <- data.frame(Column_Names = col_names, Sums = sums)
write_csv(result, "output_file.csv")

#Combine the same phylum
data <- read.csv("output_file.csv", check.names = FALSE)
duplicates <- duplicated(data$Column_Names) | rev(duplicated(rev(data$Column_Names)))
summed_data <- aggregate(Sums ~ Column_Names, data = data, sum)
write_csv(summed_data, "raw_abundance_bacteria_larynx_total_perphyla.csv")

#Get percentage of each phylum
library(dplyr)
data <- read.csv("raw_abundance_bacteria_larynx_total_perphyla.csv")
data <- mutate(data, Percentage = (Sums / sum(Sums)) * 100)
data <- arrange(data, desc(Percentage))
write.csv(data, "raw_abundance_bacteria_larynx_total_perphyla_percentage1.csv", row.names = FALSE)

#Top5 Phyla
top_5 <- head(data, 5)
others <- data.frame(Column_Names = "Others",
              Sums = sum(tail(data$Sums, -5)),
              Percentage = sum(tail(data$Percentage, -5)))
final_data <- bind_rows(top_5, others)
write.csv(final_data, "raw_abundance_bacteria_larynx_total_perphyla_top5_others.csv", row.names = FALSE)

#Group by phylum
data <- read.csv("norm_bacteria.csv", check.names = FALSE)
chlamydiae_columns <- which(colnames(data) == "Chlamydiae")
chlamydiae_data <- data[, c(1, chlamydiae_columns)]
write.csv(chlamydiae_data, "chlamydiae_data.csv", row.names = FALSE)
#others
data <- read.csv("norm_bacteria.csv", check.names = FALSE)
exclude_columns <- c("Actinobacteria", "Proteobacteria", "Bacteroidetes", "Firmicutes", "Chlamydiae")
exclude_indices <- which(colnames(data) %in% exclude_columns)
filtered_data <- data[, -exclude_indices]
write.csv(filtered_data, "filtered_data.csv", row.names = FALSE)

#Group by phylum them Sum
data <- read.csv("plsda-bacteria.csv", check.names = FALSE)
firmicutes_columns <- data[, grepl("Firmicutes", names(data))]
row_sums <- rowSums(firmicutes_columns[, -1])
write.csv(row_sums, "firmicutes_columns-sum.csv")

#Cross reference Primary Site with Sample Number
main_data <- read.csv("plsda-bacteria_sums.csv")
reference_data <- read.csv("SampleNo_PrimarySite.csv")
result_data <- merge(main_data, reference_data, by.x = "Sample_Number", by.y = "Sample_Number", all.x = TRUE)
colnames(result_data)[ncol(result_data)] <- "Primary_Site"
write.csv(result_data, "updated_main_data.csv", row.names = FALSE)


#Remove Family/Phylum with Low Variability
variance <- apply(data[, numeric_cols], 2, sd)
low_variability_columns <- names(variance[variance < 1e-6])
data <- data[, !(colnames(data) %in% low_variability_columns)]
