## install packages
install.packages(c("tidyverse", "openxlsx", "readxl", "grid", "eulerr"))

# libraries
library(tidyverse)
library(openxlsx)
library(readxl)
library(grid)
library(eulerr)

## read files
gum <- read_csv("GUM.csv")
larynx <- read_csv("LARYNX.csv")
mouth <- read_csv("MOUTH.csv")
tongue <- read_csv("TONGUE.csv")

## remove Others data point
gum <- gum[-11,]
larynx <- larynx[-11,]
mouth <- mouth[-11,]
tongue <- tongue[-11,]

## list of Species name
xx <- list(gum = gum$Column_Names, larynx = larynx$Column_Names, mouth = mouth$Column_Names, tongue = tongue$Column_Names)

# create Euler diagram
euler <- euler(xx, labels = TRUE)
plot(euler, quantities = TRUE)
ggsave("ube_euler_labels.png", plot = euler)
ggsave("ube_euler_labels1.jpg", plot = euler)