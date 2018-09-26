
# Imports SOM and metaClustering_consensus
cluster_FlowSOM <- function(data, k, seed = 42){
  cells <- as.matrix(data[, 3:ncol(data)])
  map <- FlowSOM::SOM(cells, silent = TRUE)
  metaClusters <- FlowSOM::metaClustering_consensus(map$codes, k = k)
  cluster <- metaClusters[map$mapping[,1]]
  cluster
}
