library(rmarkdown)
library(here) # To help control file storage

# To keep the server happy
Sys.setenv(RSTUDIO_PANDOC="/usr/local/bioinfsoftware/pandoc/pandoc-v1.13.1/bin")

rmarkdown::render(input = here("Scripts", "RUIII_simulation_report_2.Rmd"),
                  output_file = here("Reports", "RUVIII_simulation_report_2.html"))
