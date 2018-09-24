library(tidyverse)

setwd("/home/users/allstaff/pullin.j/CyTOF-RUVIII/Data")
# NB: the first file must be the raw one
files <- c("raw_data.rds")
data_list <- map(files, ~readRDS(.))

# Look at cluster size
plot(table(data_list[[1]]$cluster))

raw_data <- data_list[[1]]

cluster_spread <- function(data){
  prod(apply(data, 2, IQR))/nrow(data)
}

test <- data.frame(test = 1:10000)
set.seed(43)
test %>% sample_n(10)
set.seed(43)
test %>% sample_n(10) 

