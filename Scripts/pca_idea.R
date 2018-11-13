library(tidyverse)
devtools::load_all()

raw_data <- as.tibble(readRDS(here::here("Data", "raw_data.rds")))
raw_data


head(M)

Y <- raw_data %>%
  select(-cluster, -sample) %>%
  as.matrix()

M <- make_M(raw_data$cluster, c(1:20))
Y0 <- fast_residop(Y, M)

pca <- prcomp(Y, center = TRUE, scale. = TRUE)
pca0 <- prcomp(Y0, center = TRUE, scale. = TRUE)

samp <- sample(1:nrow(Y), 2000)

qplot(pca$x[samp,1], pca$x[samp,2])
qplot(pca0$x[samp,1], pca0$x[samp,2])




