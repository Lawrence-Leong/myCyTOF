

# Code previosly used to downasmple the Input to RUVIII before running the algorithm on full datasets
# was possible - saved just incase this is neccsaercy again (it is a bit intricate)
NULL

#data_list[[1]] <- data_list[[1]] %>%
# filter(sample %in% samples) %>%
#  mutate(ind = 1:nrow(.)) %>%
#  group_by(sample) %>%
#  sample_n(10000) %>%
#  ungroup() %>%
#  as.data.frame()

#index <- as.vector(as.matrix(select(data_list[[1]], ind)))
#data_list[[1]] <- select(data_list[[1]], -ind)

#if(n_raw_files != n_data){
#  # Downsample other files
#  for(i in (n_raw_files+1):n_data){
#   data_list[[i]] <- data_list[[i]] %>%
#      filter(sample %in% samples) %>%
#      slice(index) %>%
#     as.data.frame()
#  }
#}
