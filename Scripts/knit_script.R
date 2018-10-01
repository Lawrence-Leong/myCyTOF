library(rmarkdown)
library(here) # To help control file storage

# To keep the server happy
Sys.setenv(RSTUDIO_PANDOC="/usr/local/bioinfsoftware/pandoc/pandoc-v1.13.1/bin")

rmarkdown::render(input = here("Scripts", "RUVIII_simulation_report.Rmd"),
                  output_file = here("Reports", "RUVIII_simulation_report.html"))
