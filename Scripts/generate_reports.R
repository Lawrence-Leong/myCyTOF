# Script to automatically generate reports using the rmarkdown file
# "RUVIII_leipoldetal_report.Rmd". These reports will be generated for:
# different values of k, different samples and different clusters
# used for the normalisation stage.
library(tidyverse)
library(rmarkdown)

# To keep the server happy
Sys.setenv(RSTUDIO_PANDOC="/usr/local/bioinfsoftware/pandoc/pandoc-v1.13.1/bin")

# To help control file storage
library(here)

# NOTE: all inputs must be of the same length!
# Spcify all combinations

# Vector of k values to use
k_values <- rep(1, 40)

# List of vectors each containing 3 letters sample ids (i.e. "1A2") as strings
sample_list <- list()
for(i in 1:40){
  sample_list[[i]] <- c("1B1", "2B1", "3B1", "4B1", "5B1", "6B1")
}

# List of numeric vectors representing the clusters to use during the normalisation
cluster_list <- map(1:40, function(x) x)

# Check 'input' for user stupidity
if (!(length(k_values) == length(sample_list) & (length(k_values) == length(cluster_list))))
  stop("Input lengths of all parameters must be the same!")

n <- length(k_values) # Length of all inputs

for (i in 1:n){
  k_value <- k_values[i]
  sample <- sample_list[[i]]
  clusters <- cluster_list[[i]]

  file_name <- paste0("report","_", "k=", k_value, "_samps=", paste(sample, collapse = "_"),
                      "_clus=", paste(clusters, collapse = "_"), ".html")

  cat("Knitting with: \n")
  cat(paste0("k value: ", k_value), "\n")
  cat(paste0("samples: ", paste(sample, collapse = " ")), "\n")
  cat(paste0("clusters: ", paste(clusters, collapse = "-")), "\n")

  rmarkdown::render(input = here::here("Scripts", "RUVIII_leipoldetal_report.Rmd"),
    params = list(
      k = k_value,
      norm_clusters = clusters,
      samples = sample),
    output_file = paste0(here::here("Reports"), "/", file_name))
}
