# myCyTOF
Functions and scripts of analysing and normalising CyTOF data. 

The core functionality provided by this quasi-package is the ability to run RUVIII on CyTOF data generating reports to indicate the effect the normalisation procedure is having. 

This is implemented though in which produces the actual rmarkdown document *RUVIII_data_report.Rmd* and script 
*generate_data_reports.R* which allows the report to be run on many different parameter combinations. To customise these options you will need to modify the *generate_data_reports.R* documentation about how to do this is provided in the file itself. Once suitably configured the file can be run from the command line:

```bash
Rscript generate_data_reports.R
```

The quasi-package also supports the running of RUVIII on simulated data. This is implemented in the file *1*. The file itlsef contains documentation about all the different parameters options in the simulation - which are highlighted with a `#PARAMTER` tag. This file does **not** have an asscoiated generate reports style file as there are two many parameters and not all may be interest. If such a script is required please open an issue on the GitHub page. The file does however have the associated script *1* which is simply a convinceve wrapper around the knit command to enusre the reports is generated in the `\Reports` directory. If this script is used it shoud be run from the command line:

```bash
Rscript 1
```
