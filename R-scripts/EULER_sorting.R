gum <- c("Streptococcus", "Mycobacterium", "Staphylococcus", "Pseudomonas", "Bacillus", "Waddlia", "Pseudoalteromonas", "Escherichia", "Streptomyces", "Vibrio")
larynx <- c("Streptococcus", "Mycobacterium", "Neisseria", "Staphylococcus", "Bacillus", "Mesorhizobium", "Pseudomonas", "Streptomyces", "Bordetella", "Escherichia")
mouth <- c("Streptococcus", "Mycobacterium", "Staphylococcus", "Pseudomonas", "Bacillus", "Streptomyces", "Waddlia", "Bordetella", "Escherichia", "Mesorhizobium")
tongue <- c("Streptococcus", "Mycobacterium", "Staphylococcus", "Lactobacillus", "Waddlia", "Bacillus", "Pseudoalteromonas", "Pseudomonas", "Escherichia", "Vibrio")

sets <- list(
  gum = gum,
  larynx = larynx,
  mouth = mouth,
  tongue = tongue
)

set_combinations <- lapply(2:length(sets), function(i) combn(names(sets), i, simplify = FALSE))

combinations_df <- data.frame(
  Set_Combination = character(),
  Genera = character(),
  stringsAsFactors = FALSE
)

for (comb_length in set_combinations) {
  for (i in 1:length(comb_length)) {
    combo <- comb_length[[i]]
    set_names <- combo
    key <- paste(sort(set_names), collapse = " & ")
    genus_intersection <- Reduce(intersect, sets[set_names])
    if (length(genus_intersection) > 0) {
      combinations_df <- rbind(
        combinations_df,
       
#WRITE CSV

# Convert the list of combinations into a data frame
combinations_df <- data.frame(
  Set_Combination = character(),
  Genera = character(),
  stringsAsFactors = FALSE
)

for (comb_length in set_combinations) {
  for (i in 1:length(comb_length)) {
    combo <- comb_length[[i]]
    set_names <- combo
    key <- paste(sort(set_names), collapse = " & ")
    genus_intersection <- Reduce(intersect, sets[set_names])
    if (length(genus_intersection) > 0) {
      combinations_df <- rbind(
        combinations_df,
        data.frame(Set_Combination = key, Genera = paste(genus_intersection, collapse = ", "), stringsAsFactors = FALSE)
      )
    }
  }
}

# Write the data frame to a CSV file
write.csv(combinations_df, file = "combination_genera_data.csv", row.names = FALSE)
