



This report was automatically generated with the R package **knitr**
(version 1.12.3).


```r
# The purpose of this script is to create a data object (dto) 
# (dto) which will hold all data and metadata from each candidate study of the exercise
# Run the line below to stitch a basic html output. For elaborated report, run the corresponding .Rmd file
# knitr::stitch_rmd(script="./manipulation/0-ellis-island.R", output="./manipulation/stitched-output/0-ellis-island.md")
# These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console 
```



```r
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
source("./scripts/common-functions.R")
```

```r
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr) #Pipes
# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("ggplot2")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit") #For asserting conditions meet expected patterns.
```

```r
#
# There will be a total of (4) elements in (dto)
dto <- list() # creates empty list object to populate with script to follow 
#
### dto (1) : names of candidate studies
#
# inspect what files there are
(listFiles <- list.files("./data/unshared/raw", full.names = T,  pattern = ".sav", recursive = F))
```

```
## [1] "./data/unshared/raw/ALSA-Wave1.Final.sav"        
## [2] "./data/unshared/raw/LBSL-Panel2-Wave1.Final.sav" 
## [3] "./data/unshared/raw/SATSA-Q3.Final.sav"          
## [4] "./data/unshared/raw/SHARE-Israel-Wave1.Final.sav"
## [5] "./data/unshared/raw/TILDA-Wave1.Final.sav"
```

```r
# list the names of the studies to be used in subsequent code
studyNames <- c("alsa", "lbsl", "satsa", "share", "tilda")
dto[["studyName"]] <- studyNames
```

```r
#
### dto (2) : file paths to corresponding data files
#
# manually declare the file paths to enforce the order and prevent mismatching
alsa_path_input  <- "./data/unshared/raw/ALSA-Wave1.Final.sav"
lbsl_path_input  <- "./data/unshared/raw/LBSL-Panel2-Wave1.Final.sav"
satsa_path_input <- "./data/unshared/raw/SATSA-Q3.Final.sav" 
share_path_input <- "./data/unshared/raw/SHARE-Israel-Wave1.Final.sav"   
tilda_path_input <- "./data/unshared/raw/TILDA-Wave1.Final.sav"     
# combine file paths into a single object
filePaths <- c(alsa_path_input, lbsl_path_input, satsa_path_input, share_path_input, tilda_path_input )
dto[["filePath"]] <- filePaths
```

```r
# declare where the derived data object should be placed
path_output_folder <- "./data/unshared/derived/"
figure_path <- 'manipulation/stitched-output/'
```

```r
#
### dto (3) : datasets with raw source data from each study
#
# at this point the object `dto` contains components:
names(dto)
```

```
## [1] "studyName" "filePath"
```

```r
# next, we will add another element to this list `dto`  and call it "unitData"
# it will be a list object in itself, storing datasets from studies as seperate elements
# no we will reach to the file paths in `dto[["filePath"]][[i]] and input raw data sets
# where `i` is iteratively each study in `dto[["studyName"]][[i]]
data_list <- list() # declare a list to populate
for(i in seq_along(dto[["studyName"]])){
  # i <- 1
  # input the 5 SPSS files in .SAV extension provided with the exercise
  data_list[[i]] <- Hmisc::spss.get(dto[["filePath"]][i], use.value.labels = TRUE) 
}
```

```
## Warning in read.spss(file, use.value.labels = use.value.labels,
## to.data.frame = to.data.frame, : ./data/unshared/raw/ALSA-Wave1.Final.sav:
## Unrecognized record type 7, subtype 18 encountered in system file
```

```
## Warning in read.spss(file, use.value.labels = use.value.labels,
## to.data.frame = to.data.frame, : ./data/unshared/raw/LBSL-Panel2-
## Wave1.Final.sav: Unrecognized record type 7, subtype 18 encountered in
## system file
```

```
## Warning in read.spss(file, use.value.labels = use.value.labels,
## to.data.frame = to.data.frame, : ./data/unshared/raw/SATSA-Q3.Final.sav:
## Unrecognized record type 7, subtype 18 encountered in system file
```

```
## Warning in read.spss(file, use.value.labels = use.value.labels,
## to.data.frame = to.data.frame, : ./data/unshared/raw/SHARE-Israel-
## Wave1.Final.sav: Unrecognized record type 7, subtype 18 encountered in
## system file
```

```
## Warning in read.spss(file, use.value.labels = use.value.labels,
## to.data.frame = to.data.frame, : ./data/unshared/raw/TILDA-Wave1.Final.sav:
## Unrecognized record type 7, subtype 18 encountered in system file
```

```r
names(data_list) <- studyNames # name the elements of the data list
dto[["unitData"]] <- data_list # include data list into the main list as another element
names(dto) # elements in the main list object
```

```
## [1] "studyName" "filePath"  "unitData"
```

```r
names(dto[["unitData"]]) # elements in the subelement 
```

```
## [1] "alsa"  "lbsl"  "satsa" "share" "tilda"
```

```r
# at this point the object `dto` contains components:
names(dto)
```

```
## [1] "studyName" "filePath"  "unitData"
```

```r
# dto contains:  "studyName" ,  "filePath",  "unitData"
# we have just added the (3rd) element, a list of datasets:
names(dto[["unitData"]])
```

```
## [1] "alsa"  "lbsl"  "satsa" "share" "tilda"
```

```r
#
### dto (4) : collect metadata
#
```

```r
# inspect the variable names and their labels in the raw data files
# names_labels(dto[["unitData"]][["alsa"]])
# names_labels(dto[["unitData"]][["lbsl"]])
# names_labels(dto[["unitData"]][["satsa"]])
# names_labels(dto[["unitData"]][["share"]])
# names_labels(dto[["unitData"]][["tilda"]])
```

```r
# rename "MAR4" because it can be confused by machines for  March-4
dto[["unitData"]][["tilda"]] <- plyr::rename(dto[["unitData"]][["tilda"]], replace = c("MAR4"= "MAR_4"))
 
# rename personal identifiers for consistency
dto[["unitData"]][["alsa"]] <- plyr::rename(dto[["unitData"]][["alsa"]], replace = c("SEQNUM"= "id"))
dto[["unitData"]][["lbsl"]] <- plyr::rename(dto[["unitData"]][["lbsl"]], replace = c("ID"= "id"))
dto[["unitData"]][["satsa"]] <- plyr::rename(dto[["unitData"]][["satsa"]], replace = c("ID"= "id"))
dto[["unitData"]][["share"]] <- plyr::rename(dto[["unitData"]][["share"]], replace = c("SAMPID.rec"= "id"))
dto[["unitData"]][["tilda"]] <- plyr::rename(dto[["unitData"]][["tilda"]], replace = c("ID"= "id"))
```

```r
# to prepare for the final step in which we add metadata to the dto
# we begin by extracting the names and (hopefuly their) labels of variables from each dataset
# and combine them in a single rectanguar object, long/stacked with respect to study names
for(i in studyNames){  
  save_csv <- names_labels(dto[["unitData"]][[i]])
  write.csv(save_csv, paste0("./data/meta/names-labels-live/nl-",i,".csv"), 
            row.names = T)  
}  
# these 5 individual .cvs contain the original variable names and labels
# now we combine these files to create the starter for our metadata object
dum <- list()
for(i in studyNames){  
  dum[[i]] <- read.csv(paste0("./data/meta/names-labels-live/nl-",i,".csv"),
                       header = T, stringsAsFactors = F )  
}
mdsraw <- plyr::ldply(dum, data.frame,.id = "study_name") # convert list of ds into a single ds
mdsraw["X"] <- NULL # remove native counter variable, not needed
write.csv(mdsraw, "./data/meta/names-labels-live/names-labels-live.csv", row.names = T)  
```

```r
# after the final version of the data files used in the excerside have been obtained
# we made a dead copy of `./data/shared/derived/meta-raw-live.csv` and named it `./data/shared/meta-data-map.csv`
# decisions on variables' renaming and classification is encoded in this map
# reproduce ellis-island script every time you make changes to `meta-data-map.csv`
dsm <- read.csv("./data/meta/meta-data-map.csv")
dsm["X"] <- NULL # remove native counter variable, not needed
dsm["X.1"] <- NULL # remove native counter variable, not needed
# dsm$url <- if(is.na(dsm$url){paste0("[link](", dsm$url,")")
dsm$url <- as.character(dsm$url)
for(i in seq_along(dsm$url)){ # i <- 20
  if(!dsm[i,"url"]==""){
    dsm[i,"url"] <- paste0("[link](",dsm[i,"url"],")")
  } 
}   
  
# attach metadata object as the 4th element of the dto
dto[["metaData"]] <- dsm
```

```r
# testit::assert("`model_name` should be a unique value", sum(duplicated(ds$model_name))==0L)
# testit::assert("`miles_per_gallon` should be a positive value.", all(ds$miles_per_gallon>0))
# testit::assert("`weight_gear_z` should be a positive or missing value.", all(is.na(ds$miles_per_gallon) | (ds$miles_per_gallon>0)))
```

```r
# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
saveRDS(dto, file="./data/unshared/derived/dto.rds", compress="xz")
```

```r
# the production of the dto object is now complete
# we verify its structure and content:
dto <- readRDS("./data/unshared/derived/dto.rds")
# each element this list is another list:
names(dto)
```

```
## [1] "studyName" "filePath"  "unitData"  "metaData"
```

```r
# 1st element - names of the studies as character vector
dto[["studyName"]]
```

```
## [1] "alsa"  "lbsl"  "satsa" "share" "tilda"
```

```r
# 2nd element - file paths of the data files for each study
dto[["filePath"]]
```

```
## [1] "./data/unshared/raw/ALSA-Wave1.Final.sav"        
## [2] "./data/unshared/raw/LBSL-Panel2-Wave1.Final.sav" 
## [3] "./data/unshared/raw/SATSA-Q3.Final.sav"          
## [4] "./data/unshared/raw/SHARE-Israel-Wave1.Final.sav"
## [5] "./data/unshared/raw/TILDA-Wave1.Final.sav"
```

```r
# 3rd element - list objects with 
names(dto[["unitData"]])
```

```
## [1] "alsa"  "lbsl"  "satsa" "share" "tilda"
```

```r
dplyr::tbl_df(dto[["unitData"]][["alsa"]]) 
```

```
## Source: local data frame [2,087 x 26]
## 
##       id EXRTHOUS HWMNWK2W LSVEXC2W LSVIGEXC TMHVYEXR TMVEXC2W VIGEXC2W
##    (int)   (fctr)    (int)    (int)   (fctr)    (int)    (int)    (int)
## 1     41       No       14       NA       No       NA       NA       NA
## 2     42       No       14        4      Yes       NA       NA       NA
## 3     61       No       NA       NA       No       NA       NA       NA
## 4     71       No       14       NA       No       NA       NA       NA
## 5     91       No       28       NA       No       NA       NA       NA
## 6    121       No       NA       NA       No       NA       NA       NA
## 7    181       No       NA       NA       No       NA       NA       NA
## 8    201       No       NA       NA       No       NA       NA       NA
## 9    221       No       NA       NA       No       NA       NA       NA
## 10   261       No       NA       NA       No       NA       NA       NA
## ..   ...      ...      ...      ...      ...      ...      ...      ...
## Variables not shown: VIGEXCS (fctr), WALK2WKS (fctr), BTSM12MN (fctr),
##   HLTHBTSM (fctr), HLTHLIFE (fctr), AGE (int), SEX (fctr), MARITST (fctr),
##   SCHOOL (fctr), TYPQUAL (fctr), RETIRED (fctr), SMOKER (fctr), FR6ORMOR
##   (fctr), NOSTDRNK (fctr), FREQALCH (fctr), WEIGHT (dbl), PIPCIGAR (fctr),
##   CURRWORK (fctr)
```

```r
# 4th element - dataset with augmented names and labels for variables from all involved studies
dplyr::tbl_df(dto[["metaData"]])
```

```
## Source: local data frame [150 x 10]
## 
##    study_name     name                      label_short   item construct
##        (fctr)   (fctr)                           (fctr) (fctr)    (fctr)
## 1        alsa   SEQNUM                  Sequence Number     id        id
## 2        alsa EXRTHOUS            Exertion around house          physact
## 3        alsa HWMNWK2W   Times walked in past two weeks          physact
## 4        alsa LSVEXC2W Less vigor sessions last 2 weeks          physact
## 5        alsa LSVIGEXC          Less vigor past 2 weeks          physact
## 6        alsa TMHVYEXR     Time heavy physical exertion          physact
## 7        alsa TMVEXC2W          Vigor Time past 2 weeks          physact
## 8        alsa VIGEXC2W   Vigor Sessions in past 2 weeks          physact
## 9        alsa  VIGEXCS                Vigorous exercise          physact
## 10       alsa WALK2WKS             Walking past 2 weeks          physact
## ..        ...      ...                              ...    ...       ...
## Variables not shown: type (fctr), categories (int), label (fctr), url
##   (chr), notes (fctr)
```

The R session information (including the OS info, R version and all
packages used):


```r
sessionInfo()
```

```
## R version 3.2.4 Revised (2016-03-16 r70336)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows >= 8 x64 (build 9200)
## 
## locale:
## [1] LC_COLLATE=English_United States.1252 
## [2] LC_CTYPE=English_United States.1252   
## [3] LC_MONETARY=English_United States.1252
## [4] LC_NUMERIC=C                          
## [5] LC_TIME=English_United States.1252    
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] knitr_1.12.3  ggplot2_2.1.0 magrittr_1.5 
## 
## loaded via a namespace (and not attached):
##  [1] reshape2_1.4.1      splines_3.2.4       lattice_0.20-33    
##  [4] colorspace_1.2-6    htmltools_0.3.5     yaml_2.1.13        
##  [7] mgcv_1.8-12         survival_2.38-3     nloptr_1.0.4       
## [10] foreign_0.8-66      DBI_0.3.1           RColorBrewer_1.1-2 
## [13] plyr_1.8.3          stringr_1.0.0       MatrixModels_0.4-1 
## [16] munsell_0.4.3       gtable_0.2.0        htmlwidgets_0.6    
## [19] evaluate_0.8.3      labeling_0.3        latticeExtra_0.6-28
## [22] SparseM_1.7         extrafont_0.17      quantreg_5.21      
## [25] pbkrtest_0.4-6      parallel_3.2.4      markdown_0.7.7     
## [28] Rttf2pt1_1.3.3      highr_0.5.1         Rcpp_0.12.4        
## [31] acepack_1.3-3.3     scales_0.4.0        DT_0.1.40          
## [34] formatR_1.3         Hmisc_3.17-3        jsonlite_0.9.19    
## [37] lme4_1.1-11         gridExtra_2.2.1     testit_0.5         
## [40] digest_0.6.9        stringi_1.0-1       dplyr_0.4.3        
## [43] grid_3.2.4          tools_3.2.4         lazyeval_0.1.10    
## [46] dichromat_2.0-0     Formula_1.2-1       cluster_2.0.3      
## [49] car_2.1-2           extrafontdb_1.0     tidyr_0.4.1        
## [52] MASS_7.3-45         Matrix_1.2-4        rsconnect_0.4.2.1  
## [55] assertthat_0.1      minqa_1.2.4         rmarkdown_0.9.5    
## [58] rpart_4.1-10        R6_2.1.2            nnet_7.3-12        
## [61] nlme_3.1-126
```

```r
Sys.time()
```

```
## [1] "2016-04-09 11:37:57 PDT"
```

