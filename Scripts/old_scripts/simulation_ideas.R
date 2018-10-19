
# Code based that found in the cydar blurb found at:
# http://bioconductor.org/packages/release/bioc/html/cydar.html

ncells <- 20000 # Number of cells
nda <- 200 # Number of cells in differentially expressed population
nmarkers <- 31 # Number of markers 
down_pos <- 1.8 # Mean of one of the differentially expressed population
up_pos <- 1.2 # Mean of other differentially expressed population

conditions <- rep(c("A", "B"), each=3)

combined <- rbind(matrix(rnorm(ncells*nmarkers, 1.5, 0.6), ncol=nmarkers),
                  matrix(rnorm(nda*nmarkers, down_pos, 0.3), ncol=nmarkers),
                  matrix(rnorm(nda*nmarkers, up_pos, 0.3), ncol=nmarkers))

combined[,31] <- rnorm(nrow(combined), 1, 0.5) # last marker is a QC marker.

combined <- 2^combined # raw intensity values

sample_id <- c(sample(length(conditions), ncells, replace=TRUE), 
               sample(which(conditions=="A"), nda, replace=TRUE), # Make the different population 'biological'
               sample(which(conditions=="B"), nda, replace=TRUE)) 

colnames(combined) <- paste0("Marker", seq_len(nmarkers))

head(combined)

pca <- prcomp(combined)

plot(pca$x[,1], pca$x[,2])

# Code taken from:
#https://stats.stackexchange.com/questions/70855/generating-random-variables-from-a-mixture-of-normal-distributions


N <- 100000
num_comp <- 3 # Number of components
probs <- c(0.3,0.5,0.2) # Proabability of each component

components <- sample(1:num_comp, prob=probs, size=N, replace=TRUE)

mus <- c(0,10,3) # Means
sds <- sqrt(c(1,1,0.1)) # Standard deviations

samples <- rnorm(N)*sds[components]+mus[components]

hist(samples)

