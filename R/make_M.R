# Note: has caused confusion - should rewrite to take a list of vectors.
# Each vector corresponds to one pseudo replicate group.

# Note this DOES NOT follow the documentation of ruv::RUVIII i.e. it DOES NOT ensure that the
# row sums of the M matrix are 1 - FIXED
make_M <- function(clusters, norm_clus){
  M <- matrix(0, nrow = length(clusters), ncol = (length(norm_clus) + 1))
  # rewrite the for loop
  for(i in 1:length(norm_clus)){
    M[clusters == norm_clus[i], i] <- 1
  }
  M[!(rowSums(M) == 1), i + 1] <- 1
  as.matrix(M)
}


