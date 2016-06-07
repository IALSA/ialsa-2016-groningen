How to reproduce Groningen Exercise Report (v.3)

- Open `./ialsa-2016-groningen.Rproj` in RStudio after cloning the corresponding repository from http://www.github.com/IALSA/ 

- execute `./utility/install-packages.R` to load all dependencies

- open `./reports/report-governor.R` and apply the script as necessary to reproduce reports using script annotations and other documentation.

- once `report-governor` produces the harmonized dataset, execute `./models/exercise-report-3/compile-models.R` to estimate the models of the selects types. (A, B, AA, BB)

- after model objects are generated (estimation may take a while, so save object once estimated and later call from memory) execute `./models/exercise-report-3/compile-tables.R` to generate tables that compare across model types and studies.

