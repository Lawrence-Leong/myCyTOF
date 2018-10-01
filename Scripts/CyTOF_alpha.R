library(here)
library(pheatmap)
devtools::load_all()

data <- readRDS(here("Data", "raw_data.rds"))
head(data)

Y <- as.matrix(data[,3:ncol(data)])
M <- make_M(data$cluster, 4)
samp <- sample(1:nrow(Y), 10000)
Y <- Y[samp, ]
M <- M[samp, ]
ruv_out <- fastRUVIII(Y = Y, M = M, ctl = c(1:ncol(Y)), k = 1)
pheatmap::pheatmap(ruv_out$fullalpha, cluster_cols = FALSE, cluster_rows = FALSE,
                   main = "All data")

table(data$cluster)

for(i in 1:10){
  cat("Considering cluster:", i, "\n")
  cluster_data <- data[data$cluster == i,]
  Y <- as.matrix(cluster_data[3:ncol(data)])
  M <- matrix(1, nrow = nrow(Y), ncol = 1)
  if (nrow(Y) > 5000){
    samp <- sample(1:nrow(Y), 5000)
    Y <- Y[samp, ]
    M <- M[samp, ]
  }
  ruv_out <- fastRUVIII(Y = Y, M = M, ctl = c(1:ncol(Y)), k = 1)
  pheatmap(ruv_out$fullalpha, cluster_cols = FALSE, cluster_rows = FALSE,
           main = paste("Plot:", i))
}

# Test of running RUV on each cluster individually.
library(tidyverse)

samp_data <- data %>%
  group_by(cluster) %>%
  sample_frac(0.025) %>%
  ungroup()

tsne_data <- compute_tsne(samp_data, 2000)
plot_tsne_sample(tsne_data)
plot_tsne_cluster(tsne_data)

table(samp_data$cluster)

norm_clusts <- list()
for(i in 1:40){
  cat("Normalising cluster", i, '\n')
  clust_data <- filter(samp_data, cluster == i)
  Y <- as.matrix(select(clust_data, -cluster, -sample))
  M <- matrix(1, nrow = nrow(Y), ncol = 1)
  norm_clusts[[i]] <- fastRUVIII(Y = Y, M = M, ctl = c(1:ncol(Y)), k = 1)$newY
}

norm_clusts

norm_cells <- do.call(rbind, norm_clusts)

norm_data <- data.frame(sample = samp_data$sample,
                        cluster = samp_data$cluster,
                        norm_cells)

tsne_data <- compute_tsne(norm_data, 2000)
plot_tsne_sample(tsne_data)
plot_tsne_cluster(tsne_data)

cells <- select(samp_data, -sample, -cluster)
cells <- sample_n(cells, 10000)
pca <- prcomp(select(cells, CD19, CD20, CD3, CD4))$x
qplot(pca[,1], pca[,2])
qplot(cells$CD19)

Bcells <- filter(cells, CD19 > 2.5)
pca <- prcomp(Bcells)
qplot(pca$x[,2], pca$x[,3])
qplot(Bcells$CD3, Bcells$CD27)

