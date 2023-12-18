##install packages
install.packages(c("tidyverse", "openxlsx", "readxl", "grid", "ggvenn"))

##libraries
library(tidyverse)
library(openxlsx)
library(readxl)
library(grid)
library(ggvenn)


#read files
gum <- read_csv("GUM.csv")
larynx <- read_csv("LARYNX.csv")
mouth <- read_csv("MOUTH.csv")
tongue <- read_csv("TONGUE.csv")


##remove Others data point
gum <- gum[-11,]
larynx <- larynx[-11,]
mouth <- mouth[-11,]
tongue <- tongue[-11,]


##list of Species name
xx <- list(gum = gum$Column_Names, larynx = larynx$Column_Names, mouth = mouth$Column_Names, tongue = tongue$Column_Names)


###create venn diagram
venn <- ggvenn(xx, show_elements = TRUE, set_name_size = 4, text_size = 2.5, 
               fill_alpha = 0.4, stroke_size = 0.3, label_sep = "\n", 
               show_outside = "always", 
               fill_color = c("skyblue", "lightblue", "darkblue", "blue"))
venn
ggsave("ube_venn.png", plot=venn)
ggsave("ube_venn1.jpg", plot=venn)