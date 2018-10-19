# Script to automatically generate reports using the rmarkdown file
# "RUVIII_data_report.Rmd". These reports will be generated for:
# different values of k, different samples and different clusters
# used for the normalisation stage.

# Note this code is optomised to allow for the running of RUVIII on different subsets of the
# Leipold data, however it could be easily converted to run on other datasets.
# This could be done by removing the sample_list argument from both this script and the report
library(tidyverse)
library(rmarkdown)

# To keep the server happy
Sys.setenv(RSTUDIO_PANDOC="/usr/local/bioinfsoftware/pandoc/pandoc-v1.13.1/bin")

# To help control file storage
library(here)

# Character vector of formatted CyTOF data RDS files for the report to be run on
# The data in these files will be nomalised using the RUVIII algorithm.
# Note: the raw version of the data in these files will form part of the reports output
raw_files <- c("raw_data.rds")

# Character vector of formatted CyTOF data RDS files for the report to be run on
# The data in these files will be not be normalised by the CyTOF algorithm.
# This is intended to allow comaparison of other normaliastaion techniques
other_files <- c("norm_data.rds")

# All of these files must be located in the /Data directory in the /myCyTOF folder.

# Character vector of data labels or titles
# Should be of the form:
#c(labels for raw data, labels for normalised data, labels for raw data after normalisation)
titles <- c("Raw", "Finck", "RUVIII")

# NOTE: all inputs must be of the same length!
# Spcify all combinations
# Vector of k values to use
k_values <- c(1)

# List of vectors each containing 3 letters sample ids (i.e. "1A2") as strings
sample_list <- list(c("1B1", "2B1", "3B1", "4B1", "5B1", "6B1"))

# List of numeric vectors representing the clusters to use during the normalisation
cluster_list <- list(c(1))

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

  rmarkdown::render(input = here::here("Scripts", "RUVIII_data_report.Rmd"),
    params = list(
      k = k_value,
      norm_clusters = clusters,
      samples = sample,
      raw_files = raw_files,
      other_files = other_files,
      titles = titles),
    output_file = paste0(here::here("Reports"), "/", file_name))
}
