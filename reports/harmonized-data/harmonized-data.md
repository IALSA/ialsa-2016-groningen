# Harmonized Data

<!-- These two chunks should be added in the beginning of every .Rmd that you want to source an .R script -->
<!--  The 1st mandatory chunck  -->
<!--  Set the working directory to the repository's base directory -->


<!--  The 2nd mandatory chunck  -->
<!-- Set the report-wide options, and point to the external code file. -->


This report combines harmonized variables from all studies into a single data set with `study_name` as a factor. 

<!-- Load 'sourced' R files.  Suppress the output when loading packages. --> 



<!-- Load the sources.  Suppress the output when loading sources. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 

# (I) Exposition

> This report is a record of interaction with a data transfer object (dto) produced by `./manipulation/0-ellis-island.R`. 

The next section recaps this script, exposes the architecture of the DTO, and demonstrates the language of interacting with it.   

## (I.A) Ellis Island

> All data land on Ellis Island.

The script `0-ellis-island.R` is the first script in the analytic workflow. It accomplished the following: 

- (1) Reads in raw data files from the candidate studies   
- (2) Extract, combines, and exports their metadata (specifically, variable names and labels, if provided) into `./data/shared/derived/meta-data-live.csv`, which is updated every time Ellis Island script is executed.   
- (3) Augments raw metadata with instructions for renaming and classifying variables. The instructions are provided as manually entered values in `./data/shared/meta-data-map.csv`. They are used by automatic scripts in later harmonization and analysis.  
- (4) Combines unit and metadata into a single DTO to serve as a starting point to all subsequent analyses.   

<!-- Load the datasets.   -->

```r
# load the product of 0-ellis-island.R,  a list object containing data and metadata
dto <- readRDS("./data/unshared/derived/dto.rds")
```

<!-- Inspect the datasets.   -->

```r
# the list is composed of the following elements
names(dto)
```

```
[1] "studyName" "filePath"  "unitData"  "metaData" 
```

```r
# 1st element - names of the studies as character vector
dto[["studyName"]]
```

```
[1] "alsa"  "lbsl"  "satsa" "share" "tilda"
```

```r
# 2nd element - file paths of the data files for each study as character vector
dto[["filePath"]]
```

```
[1] "./data/unshared/raw/ALSA-Wave1.Final.sav"         "./data/unshared/raw/LBSL-Panel2-Wave1.Final.sav" 
[3] "./data/unshared/raw/SATSA-Q3.Final.sav"           "./data/unshared/raw/SHARE-Israel-Wave1.Final.sav"
[5] "./data/unshared/raw/TILDA-Wave1.Final.sav"       
```

```r
# 3rd element - is a list object containing the following elements
names(dto[["unitData"]])
```

```
[1] "alsa"  "lbsl"  "satsa" "share" "tilda"
```

```r
# each of these elements is a raw data set of a corresponding study, for example
dplyr::tbl_df(dto[["unitData"]][["lbsl"]]) 
```

```
Source: local data frame [656 x 39]

        id AGE94 SEX94  MSTAT94 EDUC94     NOWRK94  SMK94                                         SMOKE
     (int) (int) (int)   (fctr)  (int)      (fctr) (fctr)                                        (fctr)
1  4001026    68     1 divorced     16 no, retired     no                                  never smoked
2  4012015    94     2  widowed     12 no, retired     no                                  never smoked
3  4012032    94     2  widowed     20 no, retired     no don't smoke at present but smoked in the past
4  4022004    93     2       NA     NA          NA     NA                                  never smoked
5  4022026    93     2  widowed     12 no, retired     no                                  never smoked
6  4031031    92     1  married      8 no, retired     no don't smoke at present but smoked in the past
7  4031035    92     1  widowed     13 no, retired     no don't smoke at present but smoked in the past
8  4032201    92     2       NA     NA          NA     NA don't smoke at present but smoked in the past
9  4041062    91     1  widowed      7          NA     no don't smoke at present but smoked in the past
10 4042057    91     2       NA     NA          NA     NA                                            NA
..     ...   ...   ...      ...    ...         ...    ...                                           ...
Variables not shown: ALCOHOL (fctr), WINE (int), BEER (int), HARDLIQ (int), SPORT94 (int), FIT94 (int), WALK94 (int),
  SPEC94 (int), DANCE94 (int), CHORE94 (int), EXCERTOT (int), EXCERWK (int), HEIGHT94 (int), WEIGHT94 (int), HWEIGHT
  (int), HHEIGHT (int), SRHEALTH (fctr), smoke_now (lgl), smoked_ever (lgl), year_of_wave (dbl), age_in_years (dbl),
  year_born (dbl), female (lgl), marital (chr), single (lgl), educ3 (chr), current_work_2 (lgl), current_drink (lgl),
  sedentary (lgl), poor_health (lgl), bmi (dbl)
```


###  Meta

```r
# 4th element - a dataset names and labels of raw variables + added metadata for all studies
# dto[["metaData"]] %>% dplyr::select(study_name, name, item, construct, type, categories, label_short, label) %>% 
#   DT::datatable(
#     class   = 'cell-border stripe',
#     caption = "This is the primary metadata file. Edit at `./data/shared/meta-data-map.csv",
#     filter  = "top",
#     options = list(pageLength = 6, autoWidth = TRUE)
#   )
```

<!-- Tweak the datasets.   -->


<!-- Basic table view.   -->



### Combined data


```r
dmls <- list() # dummy list
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]] # get study data from dto
  (varnames <- names(ds)) # see what variables there are
  (get_these_variables <- c("id",
                            "year_of_wave","age_in_years","year_born",
                            "female",
                            "marital", "single",
                            "educ3",
                            "smoke_now","smoked_ever",
                            "current_work_2",
                            "current_drink",
                            "sedentary",
                            "poor_health",
                            "bmi")) 
  (variables_present <- varnames %in% get_these_variables) # variables on the list
  dmls[[s]] <- ds[,variables_present] # keep only them
}
lapply(dmls, names) # view the contents of the list object
```

```
$alsa
 [1] "id"             "smoke_now"      "smoked_ever"    "year_of_wave"   "age_in_years"   "year_born"     
 [7] "female"         "marital"        "single"         "educ3"          "current_work_2" "current_drink" 
[13] "sedentary"      "poor_health"    "bmi"           

$lbsl
 [1] "id"             "smoke_now"      "smoked_ever"    "year_of_wave"   "age_in_years"   "year_born"     
 [7] "female"         "marital"        "single"         "educ3"          "current_work_2" "current_drink" 
[13] "sedentary"      "poor_health"    "bmi"           

$satsa
 [1] "id"             "smoke_now"      "smoked_ever"    "year_of_wave"   "age_in_years"   "year_born"     
 [7] "female"         "marital"        "single"         "educ3"          "current_work_2" "current_drink" 
[13] "sedentary"      "poor_health"    "bmi"           

$share
 [1] "id"             "smoke_now"      "smoked_ever"    "year_of_wave"   "year_born"      "age_in_years"  
 [7] "female"         "marital"        "single"         "educ3"          "current_work_2" "current_drink" 
[13] "sedentary"      "poor_health"    "bmi"           

$tilda
 [1] "id"             "smoke_now"      "smoked_ever"    "year_of_wave"   "age_in_years"   "year_born"     
 [7] "female"         "marital"        "single"         "educ3"          "current_work_2" "current_drink" 
[13] "sedentary"      "poor_health"    "bmi"           
```

```r
ds <- plyr::ldply(dmls,data.frame,.id = "study_name")
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
head(ds)
```

```
  study_name id smoke_now smoked_ever year_of_wave age_in_years year_born female   marital single                 educ3
1       alsa  1     FALSE       FALSE         1992           86      1906  FALSE mar_cohab  FALSE more than high school
2       alsa  2     FALSE       FALSE         1992           78      1914   TRUE mar_cohab  FALSE           high school
3       alsa  3     FALSE       FALSE         1992           89      1903   TRUE   widowed   TRUE           high school
4       alsa  4     FALSE       FALSE         1992           78      1914  FALSE   widowed   TRUE           high school
5       alsa  5     FALSE       FALSE         1992           85      1907  FALSE   widowed   TRUE more than high school
6       alsa  6     FALSE       FALSE         1992           92      1900   TRUE   widowed   TRUE           high school
  current_work_2 current_drink sedentary poor_health bmi
1          FALSE          TRUE     FALSE       FALSE  NA
2          FALSE          TRUE     FALSE       FALSE  NA
3          FALSE          TRUE      TRUE       FALSE  NA
4           TRUE          TRUE     FALSE        TRUE  NA
5          FALSE          TRUE     FALSE       FALSE  NA
6          FALSE          TRUE      TRUE       FALSE  NA
```

```r
saveRDS(ds, "./data/unshared/derived/ds_harmonized.rds")
```

### Basic model

We test the harmonized data with a simple logistic regression

```r
# 
# 
# m1 <- glm(
#   formula = smoke_now ~ 1 + study_name + age_in_years + female + marital + educ3, 
#   data = ds, family = "binomial"
#   )
# m1
# 
# m2 <- glm(
#   formula = smoke_now ~ -1  + age_in_years + female + marital + educ3, 
#   data = ds_sub_share, family = "binomial"
# )
# m2

# # useful functions working with GLM model objects
# summary(m1) # model summary
# summary(m2)
# coefficients(mdl) # point estimates of model parameters (aka "model solution")
# knitr::kable(vcov(mdl)) # covariance matrix of model parameters (inspect for colliniarity)
# knitr::kable(cov2cor(vcov(mdl))) # view the correlation matrix of model parameters
# confint(mdl, level=0.95) # confidence intervals for the estimated parameters
# 
# # predict(mdl); fitted(mld) # generate prediction of the full model (all effects)
# # residuals(mdl) # difference b/w observed and modeled values
# anova(mdl) # put results into a familiary ANOVA table
# # influence(mdl) # regression diagnostics
# 
# 
# # create a model summary object to query 
# (summod <- summary(mdl))
# str(summod)
# 
```


Export data to be used by Mplus


```r
convert_to_numeric <- c("smoke_now","smoked_ever")
for(v in convert_to_numeric){
  ds[,v] <- as.integer(ds[,v])
}

# ds$marital_n <- car::recode(ds$marital,"
#                          'single'      = 0;
#                          'mar_cohab'   = 1;
#                          'sep_divorced'= 2; 
#                          'widowed'     = 3
#                          ", as.numeric.result=TRUE )
# ds$educ3_n <- car::recode(ds$educ3,"
#                          'less than high school'= 0;
#                          'high school'          = 1;
#                          'more than high school'= 2
#                          
#                          ", as.numeric.result=TRUE )

str(ds)
```

```
'data.frame':	15342 obs. of  16 variables:
 $ study_name    : Factor w/ 5 levels "alsa","lbsl",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ id            : int  1 2 3 4 5 6 7 8 9 10 ...
 $ smoke_now     : int  0 0 0 0 0 0 0 0 0 0 ...
 $ smoked_ever   : int  0 0 0 0 0 0 0 0 0 0 ...
 $ year_of_wave  : num  1992 1992 1992 1992 1992 ...
 $ age_in_years  : num  86 78 89 78 85 92 74 80 99 85 ...
 $ year_born     : num  1906 1914 1903 1914 1907 ...
 $ female        : logi  FALSE TRUE TRUE FALSE FALSE TRUE ...
 $ marital       : chr  "mar_cohab" "mar_cohab" "widowed" "widowed" ...
 $ single        : logi  FALSE FALSE TRUE TRUE TRUE TRUE ...
 $ educ3         : chr  "more than high school" "high school" "high school" "high school" ...
 $ current_work_2: logi  FALSE FALSE FALSE TRUE FALSE FALSE ...
 $ current_drink : logi  TRUE TRUE TRUE TRUE TRUE TRUE ...
 $ sedentary     : logi  FALSE FALSE TRUE FALSE FALSE TRUE ...
 $ poor_health   : logi  FALSE FALSE FALSE TRUE FALSE FALSE ...
 $ bmi           :Classes 'labelled', 'numeric'  atomic [1:15342] NA NA NA NA NA NA NA NA NA NA ...
  .. ..- attr(*, "label")= Named chr "Weight in kilograms"
  .. .. ..- attr(*, "names")= chr "WEIGHT"
```

```r
# write.table(ds,"./data/unshared/derived/combined-harmonized-data-set.dat", row.names=F, col.names=F)
# write(names(ds), "./data/unshared/derived/variable-names.txt", sep=" ")
```





