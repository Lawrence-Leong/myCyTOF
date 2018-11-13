

library(tidyverse)
devtools::load_all()

marie <- readRDS("/home/users/allstaff/pullin.j/GP_Transfer/Marie_Trussart/Leipold_batch_effects_study/AllRaw.rds")
marie <- as_tibble(marie)
marie

marie_tsne <- compute_tsne(marie, N = 3000)

marie_tsne %>%
  ggplot(aes(x = tSNE1, y = tSNE2, col = factor(cluster))) +
  geom_point() +
  facet_wrap(~sample) +
  labs(col = "cluster") +
  theme_bw()

sort(table(marie$cluster))

M <- make_M(marie$cluster, c(7, 2, 1))
head(M)

Y <- marie %>%
  select(-cluster, -sample) %>%
  as.matrix()

ctl <- c(1:ncol(Y))
norm_Y <- fastRUVIII(Y = Y, ctl = ctl, M = M, k = 1)$newY
head(norm_Y)

norm_marie <- as_tibble(data.frame(sample = marie$sample,
                                   cluster = marie$cluster,
                                   norm_Y))

norm_m_tsne <- compute_tsne(norm_marie, N = 3000)

norm_m_tsne %>%
  ggplot(aes(x = tSNE1, y = tSNE2, col = factor(cluster))) +
  geom_point() +
  facet_wrap(~sample) +
  labs(col = "cluster") +
  theme_bw()

# Right so RUV is not very effective

# Cluster 7 is the big one
marie$cluster %>% table() %>% sort()

marie %>%
  filter(cluster == 17) %>%
  select(-cluster) %>%
  mutate_at(vars(-sample), ~ . - mean(.)) %>%
  gather(key = "marker", value = "intensity", X89Y_CD45:X176Lu_pCREB__S133__87G3) %>%
  #sample_n(10000) %>%
  ggplot(aes(x = marker, y = intensity)) +
    geom_boxplot() +
    facet_wrap(~sample) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1))

norm_marie %>%
  filter(cluster == 7) %>%
  select(-cluster) %>%
  mutate_at(vars(-sample), ~ . - mean(.)) %>%
  gather(key = "marker", value = "intensity", X89Y_CD45:X176Lu_pCREB__S133__87G3) %>%
  sample_n(10000) %>%
  ggplot(aes(x = marker, y = intensity)) +
    geom_boxplot() +
    facet_wrap(~sample) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1))


marie %>%
  filter(cluster == 3 | cluster == 7) %>%
  gather(key = "marker", value = "intensity", X89Y_CD45:X176Lu_pCREB__S133__87G3) %>%
  sample_n(10000) %>%
  ggplot(aes(x = marker, y = intensity)) +
    geom_boxplot() +
    facet_wrap(~cluster) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 1))

marie_norm_tsne

