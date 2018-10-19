library(cydar)
nda <- 20000
nmarkers <- 31
down.pos <- 1.8
up.pos <- 1.2
conditions <- c("A", "B")

combined <- rbind(matrix(rnorm(nda*nmarkers, down.pos, 0.3), ncol=nmarkers),
                  matrix(rnorm(nda*nmarkers, up.pos, 0.3), ncol=nmarkers))
                  
combined[,31] <- rnorm(nrow(combined), 1, 0.5) # last marker is a QC marker. 

combined <- 10^combined # raw intensity values 

sample.id <- rep(c("A", "B"), each = nda)

colnames(combined) <- paste0("Marker", seq_len(nmarkers))

library(ncdfFlow)
collected.exprs <- list()
for (i in seq_along(conditions)) {
  stuff <- list(combined[sample.id==i,,drop=FALSE])
  names(stuff) <- paste0("Sample", i)
  collected.exprs[[i]] <- poolCells(stuff)
}

names(collected.exprs) <- paste0("Sample", seq_along(conditions))
collected.exprs <- ncdfFlowSet(as(collected.exprs, "flowSet"))

pool.ff <- poolCells(collected.exprs)

library(flowCore)
trans <- estimateLogicle(pool.ff, colnames(pool.ff))
proc.ff <- transform(pool.ff, trans)

gate.31 <- outlierGate(proc.ff, "Marker31", type="upper")
gate.31

filter.31 <- flowCore::filter(proc.ff, gate.31)
summary(filter.31@subSet)

processed.exprs <- transform(collected.exprs, trans)

processed.exprs <- Subset(processed.exprs, gate.31)

processed.exprs <- processed.exprs[,1:30]

library(purrr)
library(dplyr)
library(FlowSOM)
library(devtools)
load_all()

# Number of samples
n_samples <- 6

# What are the lenght of the samples
lens <- map_dbl(1:n_samples, ~nrow(processed.exprs[[.]]@exprs))

# Put into list
exprs_list <- map(1:n_samples, ~processed.exprs[[.]]@exprs)

# Remove column names
exprs_list <- map(exprs_list, function(x){colnames(x) <- NULL; x})

# Bind into data.frame
exprs_data <- do.call(rbind, exprs_list)
colnames(exprs_data) <- paste0("Marker", seq_len(nmarkers-1))

# Create sample ids and clusters
sample_ids <- rep(as.character(1:n_samples), lens)
clusters <- cluster_FlowSOM(exprs_data, 3, seed = 42)

# Collate into 1 data.frame
all_data <- data.frame(sample = sample_ids, 
                   cluster = clusters, 
                   exprs_data)

setwd("/wehisan/home/allstaff/p/pullin.j/CyTOF-RUVIII/Data")
saveRDS(all_data, "sim_data.rds")










