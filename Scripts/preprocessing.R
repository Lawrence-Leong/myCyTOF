
setwd("/home/users/allstaff/pullin.j/GP_Transfer/Marie_Trussart/Leipold_batch_effects_study/Raw_data")
load("Raw_analysis_without_beads.Rdata")

# See what we've got
head(sample_ids)
head(cell_clustering1)
head(expr)

data <- data.frame(sample = sample_ids, cluster = cell_clustering1, expr)

setwd("/home/users/allstaff/pullin.j/CyTOF-RUVIII/Data")
saveRDS(data, "raw_data.rds")
data <- readRDS("raw_data.rds")
head(data)
rm(list = ls()) 

# Same deal, normalised data

setwd("/home/users/allstaff/pullin.j/GP_Transfer/Marie_Trussart/Leipold_batch_effects_study/Norm_data")
load("Norm_analysis.Rdata")

head(sample_ids)
head(cell_clustering1)
head(expr)

data <- data.frame(sample = sample_ids, cluster = cell_clustering1, expr)
setwd("/home/users/allstaff/pullin.j/CyTOF-RUVIII/Data")
saveRDS(data, "norm_data.rds")
data <- readRDS("norm_data.rds")
head(data)

rm(list = ls()) 

library(tidyverse)
# Exploratory
setwd("/home/users/allstaff/pullin.j/GP_Transfer/Marie_Trussart/Leipold_batch_effects_study/Raw_data")
load("new_expr_data.Rdata") 
load("list_file.Rdata")

library(reshape2)
list_file <- list_file[1:length(new_expr_data), ]
smooth_data <- tibble(cluster = list_file[,1], sample = list_file[,2], marker = list_file[,3], intensity = new_expr_data)
smooth_data <- unnest(smooth_data)
smooth_data <- dcast(smooth_data, cluster + sample ~ marker, value.var = "intensity")
smooth_data


length(new_expr_data)

length(new_expr_data)
nrow(list_file)


length(new_expr_data)

str(new_expr_data)
rm(list = ls()) 

str(new_expr_data)
length(new_expr_data)
lapply(new_expr_data, length)



new_expr_data[[1]]


str(list_file)

load("list_file.Rdata") # Don't know that this is
list_file
rm(list = ls())
