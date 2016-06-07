How to reproduce Groningen Exercise Report (v.3)

- Open `./ialsa-2016-groningen.Rproj` in RStudio after cloning the corresponding repository from http://www.github.com/IALSA/ 

- execute `./utility/install-packages.R` to load all dependencies

- open `./reports/report-governor.R` and apply the script as necessary to reproduce reports using script annotations and other documentation.

- once `report-governor` produces the harmonized dataset, execute `./models/exercise-report-3/compile-models.R` to estimate the models of the selects types. (A, B, AA, BB)

- after model objects are generated (estimation may take a while, so save object once estimated and later call from memory) execute `./models/exercise-report-3/compile-tables.R` to generate tables that compare across model types and studies.

##### `compile-models.R`


Table 1: Names of the model objects to be compiled

analysis|model type   | glm object name  |glmulti object name   |
|---|---|---|---|
| pooled| A  |pooled_A   | pooled_A_bs  |
| pooled| B  |pooled_B   | pooled_B_bs  |
| pooled| AA  |pooled_AA   |pooled_AA_bs   |
| pooled| BB  |pooled_BB   |pooled_BB_bs   |
| local| A  |local_A   | local_A_bs  |
| local| B  |local_B   | local_B_bs  |
| local| AA  |local_AA   |local_AA_bs   |
| local| BB  |local_BB   |local_BB_bs   |

- local analyis means using only data from a single study, pooled - from all of them, using study as a factor
-glmulti objects are lists of models selected by best subset search. 

It is possible to keep the entire model information during subset search : use `includeobjects=T` option in ` glmulti::glmulti()` calls. However, the files that store them may become prohibitively large. Instead, it is recommended to use `includeobjects=F` and then manually estimate the desired model:
```r
models_pooled <- list(
  "A"  = pooled_A  ,
  "AA" = pooled_AA ,
  "B"  = pooled_B  ,
  "BB" = pooled_BB 
)
eq <-pooled_BB_bs@formulas[[1]] # 1 for the top model
eq_formula <- as.formula(paste("dv ~ ", as.character(eq)[3])))
models_pooled[["best"]] <- glm(eq_formula,ds2, family = binomial(link="logit")) # object of class glm
```
Similar procedure was carried out to asseble another key object, `models_local`. Therefore at this point you should have two objects:
- `models_pooled` - containing solutions of models A, AA, B, BB and best subset suggestion estimated using study as a factor
- `models_local` - containing solution of models A, AA, B, BB and best subseet suggestion estimated in each study's dataset separately (using study as a cluster).  

