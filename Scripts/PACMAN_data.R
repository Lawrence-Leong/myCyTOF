library(xlsx)
library(tidyverse)
library(here)
devtools::load_all()

file <- here("Data", "S7_Dataset.xlsx")

# SLOW #
data <- read.xlsx(file, 1, header=TRUE, colClasses=NA)
labels <- read.xlsx(file, 2, header=TRUE, colClasses=NA)

colnames(data) <- paste0("Marker", 1:5)

#samp <- sample(1:nrow(data), 2000)
#tsne <- cytofkit::cytof_dimReduction(data[samp, ], method = "tsne")
#colnames(tsne) <- c("tSNE1", "tSNE2")
#ann_tsne <- data.frame(label = labels[samp, ], tsne)
#ggplot(ann_tsne, aes(x = tSNE1, y = tSNE2, col = factor(label))) +
#  geom_point() +
#  theme_bw()

ggplot(data, aes(x = Marker1, y = Marker2)) +
  geom_point()

ann_data <- data.frame(data, label = labels)
colnames(ann_data)[ncol(ann_data)] <- "label"

ann_data <- mutate(ann_data, batch = ifelse(label <= 2, 1, 2))

ggplot(ann_data, aes(x = Marker1, y = Marker2, col = factor(label))) +
  geom_point() +
  facet_wrap(~batch) +
  labs(col = "(True) Sample") +
  theme_bw()

ggplot(ann_data, aes(x = Marker1, y = Marker2, col = factor(label))) +
  geom_point() +
  labs(col = "(True) Sample") +
  theme_bw()

cluster <- kmeans(ann_data[, 1:2], 3, nstart = 40)
ann_data <- cbind(ann_data, clust = cluster$cluster)

ggplot(ann_data, aes(x = Marker1, y = Marker2, col = factor(clust))) +
  geom_point() +
  labs(col = "k means clustering") +
  theme_bw()

#M <- ruv::replicate.matrix(interaction(ann_data$clust, ann_data$batch))
M <- ruv::replicate.matrix(as.factor(ann_data$batch))
#any(rowSums(M) != 1)
#colSums(M)

raw_Y <- as.matrix(ann_data[,1:5])

col_means <- colMeans(raw_Y)
col_sds <- apply(raw_Y, 2, function(x) sd(x))

for(i in 1:ncol(raw_Y)){
  raw_Y[,i] <- (raw_Y[,i] - col_means[i])/col_sds[i]
}

ggplot(as.data.frame(raw_Y), aes(x = Marker1, y = Marker2)) +
  geom_point() +
  labs(col = "(True) Sample") +
  theme_bw()

ctl <- 3:5
norm_Y <- fastRUVIII(Y = raw_Y, M, ctl = 1:2, k = 1)$newY

for(i in 1:ncol(norm_Y)){
  norm_Y[,i] <- norm_Y[,i]*col_sds[i] + col_means[i]
}

ann_data[,1:5] <- norm_Y

ggplot(ann_data, aes(x = Marker1, y = Marker2, col = factor(label))) +
  geom_point() +
  labs(col = "(True) Sample") +
  theme_bw()

ggplot(ann_data, aes(x = Marker1, y = Marker2, col = factor(label))) +
  geom_point() +
  facet_wrap(~batch) +
  labs(col = "(True) Sample") +
  theme_bw()


