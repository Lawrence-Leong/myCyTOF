# myCyTOF
Functions and scripts of analysing and normalising CyTOF data. 

## Functionality 

The core functionality provided by this quasi-package is the ability to run RUVIII on CyTOF data generating reports to indicate the effect the normalisation procedure is having. 

This is implemented though in which produces the actual rmarkdown document *RUVIII_data_report.Rmd* and script 
*generate_data_reports.R* which allows the report to be run on many different parameter combinations. To customise these options you will need to modify the *generate_data_reports.R* file. See the documentation about how to do this is provided in the file itself. Once suitably configured the file can be run from the command line:

```bash
Rscript generate_data_reports.R
```
This will generate reports **in the** `\Reports` **directory**. 

The quasi-package also supports the running of RUVIII on simulated data. This is implemented in the file *RUVIII_sim_report.Rmd*. The file itlsef contains documentation about all the different parameters options in the simulation - which are highlighted with a `#PARAMETER` tag. This file does **not** have an asscoiated generate reports style file as there are two many parameters and not all may be interest. If such a script is required please open an issue on the GitHub page. The file does however have the associated script *generate_sim_report.R* which is simply a convinceve wrapper around the knit command to enusre the reports is generated in the `\Reports` directory. If this script is used it shoud be run from the command line:

```bash
Rscript generate_sim_report.R
```
## Technical note

The R directory contains all the helper function used in *RUVIII_data_report.Rmd*. These functions are loaded using the `devtools::load_all()` which I admit is a bit of a hack. This is why I label this repo a pseduo-package - it was created with `devtools` which is why it includes all of the package paraphenelia. 

## Access 

To use this package simply download the GitHub repo as the most siginificant part of this Repo is the scripts directory installing it as package for example with devtools will not work

