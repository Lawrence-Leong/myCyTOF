ncells <- 20000
nmarkers <- 20
ngroups <- 10

# Biology design matrix
X <- matrix(c(rep(0,ncells/2), rep(1,ncells/2)), ncells, 1)

# Global mean (similair to overall shift to CyTOF data)
mu <- matrix(10, ncells, nmarkers)

# Coefficients of interest
beta <- matrix(0, 1, nmarkers)
beta[c(2,6,8)] <- rnorm(3, c(4,2,1), 0.5)

# Unwanted variation design matrix
W <- matrix(rbinom(ncells, 1, 0.5), ncells, 1)

# Coeffcients of unwanted variation
alpha <- matrix(rnorm(1*nmarkers, 1), 1, nmarkers)

Z <- ruv::design.matrix(rep(letters[1:ngroups], each = ncells/ngroups))

gamma <- matrix(rnorm(nmarkers * ngroups), nrow = ngroups, ncol = nmarkers)

# Random error
epsilon <- matrix(rnorm(ncells*nmarkers), ncells, nmarkers)

# RUVIII model
Y <-  mu + X%*%beta + Z%*%gamma + W%*%alpha + epsilon
Y

sample_id <- rep(LETTERS[1:2], each = ncells/2)
cluster_id <- rep(NA, ncells) # Add nonsense to make correct format

data <- data.frame(sample = sample_id, cluster = cluster_id, Y)

data$cluster <- cluster_FlowSOM(data, 10)

pca <- prcomp(data[3:ncol(data)])$x

#A1 <- which(X & W)
#A2 <- which(X & !W)
#B1 <- which(!X & W)
#B2 <- which(!X & !W)

M <- matrix(0, nrow = ncells, ncol = 2)

# Incorrect pseudo replicates
#M[sample(c(A1, B1), 1000),1] <- 1
#M[sample(c(A2, B2), 1000),2] <- 1

# Correct psuedo replicates
#M[sample(c(A1, A2), 5000),1] <- 1
#M[sample(c(B1, B2), 5000),2] <- 1

# Random replicates
M[sample(1:ncells, 5000), 1] <- 1
M[sample(1:ncells, 5000), 2] <- 1


