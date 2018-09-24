# File to produce before and after heatmaps for Terry
library(tidyverse)

setwd("/home/users/allstaff/pullin.j/CyTOFScripts/Data")
# NB: the first file must be the raw one
files <- c("raw_data.rds", "norm_data.rds")
data_list <- map(files, ~readRDS(.))

n_raw_files <- 1
n_data <- length(data_list)

samples <- c("1B1", "2B1", "3B1", "4B1", "5B1", "6B1")
n_clust <- max(data_list[[1]]$cluster) # Get the number of clusters 

data_list[[1]] <- data_list[[1]] %>%
  filter(sample %in% samples) %>% 
  mutate(ind = 1:nrow(.)) %>% 
  group_by(sample) %>% 
  sample_n(10000) %>% 
  ungroup() %>% 
  as.data.frame()

index <- as.vector(as.matrix(select(data_list[[1]], ind)))
data_list[[1]] <- select(data_list[[1]], -ind)

if(n_raw_files != n_data){
  # Downsample other files
  for(i in (n_raw_files+1):n_data){
    data_list[[i]] <- data_list[[i]] %>%
      filter(sample %in% samples) %>% 
      slice(index) %>% 
      as.data.frame()
  }
}

library(ruv)
library(rsvd)
library(FlowSOM)
norm_data <- CyTOFFunctions::normalise_data(data_list[[1]], c(13), 1, num_clusters = n_clust)

data_list[[length(data_list) + 1]] <- norm_data

n_data <- length(data_list)

plot_median_exprs_pheatmap <- function(data){
  data <- select(data, -sample)
  
  plot_data <- data %>%
    group_by(cluster) %>%
    summarize_all(median)
  
  plot_data <- as.matrix(plot_data[,-1])
  
  pheatmap::pheatmap(plot_data,
                     cluster_cols = FALSE)
  
}

library(grid)
library(gridGraphics)

grab_grob <- function(){
  grid.echo()
  grid.grabExpr()
}

plots <- list()
for(i in 1:n_data){
  plots[[i]] <- plot_median_exprs_pheatmap(data_list[[i]])
  plots[[i]] <- grab_grob()
}

grid.arrange(grobs = plots, ncol = 2, clip = TRUE)
