# Clear the workspace
rm(list = ls())
gc()

# Load libraries
library(tidyverse)
library(corrplot)

# Load data
df_sludge <- read_csv("Data/Sludge.csv")

# Filter data (Rowname < 48)
df_sludge <- df_sludge %>%
  filter(Rowname < 48)

# Rename variables
df_sludge <- df_sludge %>%
  rename(
    "Crude Protein" = "Crude_protein",
    "Crude Lipid" = "Crude_lipid",
    "Feed Spill" = "Feed_spill",
    "Sum PCB6" = "SumPCB6",
    "Sum DioxinsPCB" = "SumDioxinsPCB",
    "Sum PBDE" = "SumPBDE",
    "Essential Minerals (Group 1)" = "Essential",
    "Essential Minerals (Group 2)" = "Essential2",
    "Non-Essential Elements" = "Nonessential"
  )

# Select variables for correlation analysis
vars_for_corr <- c(
  "Crude Protein",
  "Crude Lipid",
  "Feed Spill",
  "Sum PCB6",
  "Sum DioxinsPCB",
  "Sum PBDE",
  "Essential Minerals (Group 1)",
  "Essential Minerals (Group 2)",
  "Non-Essential Elements"
)

# Calculate correlation matrix
cor_matrix <- df_sludge %>%
  select(all_of(vars_for_corr)) %>%
  cor(use = "pairwise.complete.obs")

# Print correlation matrix
print(cor_matrix)

# Create heatmap
heatmap <- corrplot(cor_matrix, method = "color", type = "upper", order = "hclust",
         tl.col = "black", tl.srt = 45) # Customize labels
