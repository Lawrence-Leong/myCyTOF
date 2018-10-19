ncells <- 20000 # Total number of cells
nmarkers <- 20 # Number of markers
beta_size <- 8 # Sample differnce
sigma_alpha <- 3 # Size of batch effects
sigma_epsilon <- 4 # Size of random noise
sigma_biology <- 8 # Size of inherent biology
nbioclust <- 4

# Sample (treatment/control) design matrix
X <- matrix(c(rep(0,ncells/2), rep(1,ncells/2)), ncells, 1)

# Inherent biology
# Note: the construction ensures that Z and X are uncorrelated.
Z <- matrix(0, ncol = nbioclust, nrow = ncells)
for(i in 1:nbioclust){
  free <- which(rowSums(Z) != 1)
  Z[sample(free, ncells/nbioclust), i] <- 1
}

# Coefficeints of biology
# Select certain coefficeints and make them non-zero
# gamma_size <- 5
# gamma <- matrix(0, 1, nmarkers)
# gamma[c(1,3,5)] <- rep(gamma_size, 3)

# Randomly sample all coeffcients from N(0, sigma_biology)
gamma <- matrix(rnorm(nmarkers*nbioclust, sd = sigma_biology), nbioclust, nmarkers)

# Global mean (similair overall shift to CyTOF data)
mu <- matrix(10, ncells, nmarkers)

# Coefficients of interest
beta <- matrix(0, 1, nmarkers)
beta[c(1,3,5)] <- rep(beta_size, 3)

# Unwanted variation design matrix
# Note: This is UNCORRELATED with X
W <- matrix(rbinom(ncells, 1, 0.5), ncells, 1)

# Coeffcients of unwanted variation
alpha <- matrix(rnorm(nmarkers, sd = sigma_alpha), 1, nmarkers)

# Random error
epsilon <- matrix(rnorm(ncells*nmarkers, sd = sigma_epsilon), ncells, nmarkers)

# RUVIII model
Y <-  mu + X %*% beta + Z %*% gamma + W %*% alpha + epsilon
