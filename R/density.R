# Get density of points in 2 dimensions.
# @param x A numeric vector.
# @param y A numeric vector.
# @param n Create a square n by n grid to compute density.
# @return The density within each square.
# Taken from: https://slowkow.com/notes/ggplot2-color-by-density/
get_density <- function(x, y, n = 100) {
  dens <- MASS::kde2d(x = x, y = y, n = n)
  ix <- findInterval(x, dens$x)
  iy <- findInterval(y, dens$y)
  ii <- cbind(ix, iy)
  return(dens$z[ii])
}

data <- as.tibble(readRDS(here::here("Data", "raw_data.rds")))
tsne <- compute_tsne(data, N = 5000)

# No density
plot_raw <- tsne %>%
  ggplot(aes(x = tSNE1, y = tSNE2)) +
  geom_point() +
  theme_bw()

# With density
plot_dens <- tsne %>%
  mutate(density = get_density(tSNE1, tSNE2, n = 100)) %>%
  ggplot(aes(x = tSNE1, y = tSNE2, col = density)) +
  geom_point() +
  viridis::scale_color_viridis() +
  theme_bw() +
  guides(col = FALSE)

ggpubr::ggarrange(plot_raw, plot_dens)

# Another option: always plot a associated number of cells barplot
clus_tsne <- tsne %>%
  ggplot(aes(x = tSNE1, y = tSNE2, col = factor(cluster))) +
  geom_point() +
  labs(col = "cluster") +
  theme_bw()

clus_barplot <- data %>%
  select(cluster) %>%
  table() %>%
  as_tibble() %>%
  setNames(c("cluster", "freq")) %>%
  ggplot(aes(x = cluster, y = freq)) +
    geom_bar(stat = "identity",
             fill = "steelblue",
             col = "black") +
    theme_bw() +
    labs(x = "Number of cells",
         y = "Cluster ID") +
    theme(axis.text.x = element_text(angle=90, vjust=0.5))

ggpubr::ggarrange(clus_tsne, clus_barplot)

# Another option would be do calculate the mid-point of each cluster and
# then plot as circles, with the number fo cells determined by the cluster





