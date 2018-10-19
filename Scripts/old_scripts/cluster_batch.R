#Script to compare batch effects in the same biological cluster in different samples

library(here)
library(tidyverse)

raw_data <- readRDS(here("Data"  , "raw_data.rds"))
raw_data <- as.tibble(raw_data)


data_3B <- raw_data %>% filter(sample %in% c("3B1", "3B2"))
data_3B1 <- raw_data %>% filter(sample %in% c("3B1"))
data_3B2 <- raw_data %>% filter(sample %in% c("3B2"))

devtools::load_all()

data <- data_3B
samp <- sample(1:nrow(data), 4000)
input <- data[samp, 3:ncol(data)]
tsne <- cytofkit::cytof_dimReduction(input, method = "tsne", tsneSeed = 42)
data <- data.frame(data[samp,], tsne)

ggplot(data, aes(x = tsne_1, y = tsne_2, col = CD19)) +
  geom_point() +
  facet_wrap(~sample) +
  theme_bw()


ggplot(data,aes(x = tsne_1, y = tsne_2, col = factor(cluster))) +
  geom_point() +
  theme_bw()

table(data_3B2$cluster)

ggplot(data,aes(x = tsne_1, y = tsne_2, col = factor(cluster))) +
  geom_point() +
  theme_bw() +
  facet_wrap(~cluster)

# Okay so it looks like cluster 4 is the one we want
# 3 and 5 are also close


data_3B_4 <- data_3B %>%
  filter(cluster == 4)

data_3B_4

table(data_3B_4$sample)

data_3B_4 %>% plot_marker_boxplots_samp()

data_3B %>%
  filter(cluster == 3) %>%
  select(sample) %>%
  table()

data_3B %>%
  filter(cluster == 5) %>%
  select(sample) %>%
  table()

data_3B %>%
  filter(cluster == 11) %>%
  select(sample) %>%
  table()

data_3B %>%
  filter(cluster == 12) %>%
  select(sample) %>%
  table()

data_3B %>%
  filter(cluster == 11) %>%
  select(sample) %>%
  table()

data_3B %>%
  filter(cluster == 11) %>%
  plot_marker_boxplots_samp()

data_3B %>%
  filter(cluster == 12) %>%
  plot_marker_boxplots_samp()

data_3B %>%
  filter(cluster == 13) %>%
  plot_marker_boxplots_samp()

data_3B %>%
  filter(cluster == 10) %>%
  plot_marker_boxplots_samp()

data_3B %>% filter()


table(raw_data$sample)


