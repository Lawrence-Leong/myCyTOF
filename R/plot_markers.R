
# Plots boxplots of all markers
plot_marker_boxplots <- function(data){
  marker_names <- colnames(data)[3:ncol(data)]
  plot_data <- gather(data, key = "marker", value = "intensity", marker_names)
  plot <- ggplot(plot_data, aes(x = marker, y = intensity)) +
    geom_boxplot(fill = "steelblue") +
    labs(x = "Marker", y = "Intensity") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  plot
}

plot_marker_boxplots_samp <- function(data){
  marker_names <- colnames(data)[3:ncol(data)]
  plot_data <- gather(data, key = "marker", value = "intensity", marker_names)
  plot <- ggplot(plot_data, aes(x = marker, y = intensity, fill = sample)) +
    geom_boxplot(outlier.shape = NA) +
    labs(x = "Marker", y = "Intensity") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  plot
}

