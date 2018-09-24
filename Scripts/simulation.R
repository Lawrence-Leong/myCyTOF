






bio_ids <- rep(c("T", "B", "T", "B"), each = 1000)

pca <- prcomp(sim_data)$x[,1:2]
pca <- data.frame(pca, sample = factor(sample_ids), cluster = clusters)
pca

ggplot(pca, aes(x = PC1, y = PC2, col = sample)) + 
  geom_point() + 
  theme_bw()

ggplot(pca, aes(x = PC1, y = PC2, col = factor(cluster))) + 
  geom_point() + 
  theme_bw()


norm_data <- RUVIII(Y = sim_data, M = M, ctl = 1:n_markers, k = 1)
norm_data

pca <- prcomp(norm_data)$x[,1:2]
pca <- data.frame(pca, sample = factor(sample_ids), bio = bio_ids)
pca

ggplot(pca, aes(x = PC1, y = PC2, col = sample, shape = bio)) + 
  geom_point() + 
  theme_bw()

