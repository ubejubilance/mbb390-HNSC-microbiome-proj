1

raw_bacteria_larynx <- read.csv("raw_abundance_bacteria_larynx.csv")

# Modify column names by removing everything before the last underscore and changing "Phyla" to "genera"
new_colnames <- colnames(raw_bacteria_larynx)
new_colnames[2:length(new_colnames)] <- sub(".*_", "", new_colnames[2:length(new_colnames)])
new_colnames <- gsub("Phyla", "genera", new_colnames)

colnames(raw_bacteria_larynx) <- new_colnames

write.csv(raw_bacteria_larynx, "genera.csv", row.names = FALSE)

2

# Read the data from the CSV file "genera.csv"
data <- read.csv("genera.csv", check.names = FALSE)

# Calculate the sum of values in each column (excluding the first column)
sums <- colSums(data[, -1])

# Extract the column names (excluding the first column)
col_names <- names(data)[-1]

# Create a new data frame with column names and their respective sums
result <- data.frame(Column_Names = col_names, Sums = sums)

# Write the results to a new CSV file named "output_file.csv"
write.csv(result, "output_file.csv")

3

# Read the data from the CSV file "output_file.csv"
data <- read.csv("output_file.csv", check.names = FALSE)

# Combine the same "genera"
duplicates <- duplicated(data$Column_Names) | rev(duplicated(rev(data$Column_Names)))
summed_data <- aggregate(Sums ~ Column_Names, data = data, sum)

# Write the results to a new CSV file named "raw_abundance_bacteria_larynx_total_pergenera.csv"
write.csv(summed_data, "raw_abundance_bacteria_larynx_total_pergenera.csv", row.names = FALSE)

4

# Load the 'readr' package for the 'write_csv' function
library(readr)

# Read the data from the CSV file "output_file.csv"
data <- read.csv("output_file.csv", check.names = FALSE)

# Combine the same "genera"
duplicates <- duplicated(data$Column_Names) | rev(duplicated(rev(data$Column_Names)))
summed_data <- aggregate(Sums ~ Column_Names, data = data, sum)

# Write the results to a new CSV file named "raw_abundance_archaea_larynx_total_pergenera.csv"
write_csv(summed_data, "raw_abundance_archaea_larynx_total_pergenera.csv", col_names = TRUE)
5

# Load the 'dplyr' package for data manipulation
library(dplyr)

# Read the data from the CSV file "raw_abundance_archaea_larynx_total_pergenera.csv"
data <- read.csv("raw_abundance_archaea_larynx_total_pergenera.csv")

# Calculate the percentage of each "genera"
data <- mutate(data, Percentage = (Sums / sum(Sums)) * 100)

# Arrange the data in descending order of Percentage
data <- arrange(data, desc(Percentage))

# Write the results to a new CSV file named "raw_abundance_archaea_larynx_total_pergenera_percentage1.csv"
write.csv(data, "raw_abundance_archaea_larynx_total_pergenera_percentage1.csv", row.names = FALSE)

6

# Top 10 Genera
top_10 <- head(data, 10)

# Combine the remaining phyla into a single "Others" category
others <- data.frame(
  Column_Names = "Others",
  Sums = sum(tail(data$Sums, -10)),
  Percentage = sum(tail(data$Percentage, -10))
)

# Combine the top 10 and "Others" categories
final_data <- bind_rows(top_10, others)

# Save the updated data to a CSV file
write.csv(final_data, "raw_abundance_bacteria_larynx_total_pergenera_top10_others.csv", row.names = FALSE)