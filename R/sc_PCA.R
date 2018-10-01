# Function to create single cell level PCA plots based on sub-sample of
# the data

# Assumes data in the format of an annotated series of cells
# Downsamples to display N cells

plot_scpca_samp <- function(data, N) {
  samp <- sample(1:nrow(data), N, replace = FALSE)

  # Peform the PCA on the subsampled data
  pca <- prcomp(data[samp, 3:ncol(data)])$x

  # Re-annotate the data
  pca_plot <- cbind(data[samp,1:2], pca)

  # Create plots of different PC combinations
  p_12 <- ggplot(pca_plot, aes(x = PC1, y = PC2, col = sample)) +
  geom_point(alpha = 0.3) +
  labs(col = "Sample") +
  theme_bw()

  p_23 <- ggplot(pca_plot, aes(x = PC2, y = PC3, col = sample)) +
  geom_point(alpha = 0.3) +
  labs(col = "Sample") +
  theme_bw()

  p_13 <- ggplot(pca_plot, aes(x = PC1, y = PC3, col = sample)) +
  geom_point(alpha = 0.3) +
  labs(col = "Sample") +
  theme_bw()

  plots <- list(p_12, p_23, p_13)
  plots
}

plot_scpca_clus <- function(data, N) {
  samp <- sample(1:nrow(data), N, replace = FALSE)

  # Peform the PCA on the subsampled data
  pca <- prcomp(data[samp, 3:ncol(data)], scale. = TRUE)$x

  # Re-annotate the data
  pca_plot <- cbind(data[samp,1:2], pca)

  # Create plots of different PC combinations
  p_12 <- ggplot(pca_plot, aes(x = PC1, y = PC2, col = factor(cluster))) +
    geom_point(alpha = 0.3) +
    labs(col = "Sample") +
    theme_bw()

  p_23 <- ggplot(pca_plot, aes(x = PC2, y = PC3, col = factor(cluster))) +
    geom_point(alpha = 0.3) +
    labs(col = "Sample") +
    theme_bw()

  p_13 <- ggplot(pca_plot, aes(x = PC1, y = PC3, col = factor(cluster))) +
    geom_point(alpha = 0.3) +
    labs(col = "Sample") +
    theme_bw()

  plots <- list(p_12, p_23, p_13)
  plots
}

# Plots a series of single cell pca plots coloured by annotation
plot_scpca_ann <- function(data, N, annotation, ann_label = "Annotation"){
    samp <- sample(1:nrow(data), N, replace = FALSE)

    # Peform the PCA on the subsampled data
    pca <- prcomp(data[samp, 3:ncol(data)])$x

    # Re-annotate the data
    pca_plot <- data.frame(ann = factor(annotation[samp,]), pca)

    # Create plots of different PC combinations
    p_12 <- ggplot(pca_plot, aes(x = PC1, y = PC2, col = ann)) +
      geom_point(alpha = 0.3) +
      labs(col = ann_label) +
      theme_bw()

    p_23 <- ggplot(pca_plot, aes(x = PC2, y = PC3, col = ann)) +
      geom_point(alpha = 0.3) +
      labs(col = ann_label) +
      theme_bw()

    p_13 <- ggplot(pca_plot, aes(x = PC1, y = PC3, col = ann)) +
      geom_point(alpha = 0.3) +
      labs(col = ann_label) +
      theme_bw()

    plots <- list(p_12, p_23, p_13)
    plots
}

