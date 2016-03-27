# Harmonization exposition : smoking

<!-- These two chunks should be added in the beginning of every .Rmd that you want to source an .R script -->
<!--  The 1st mandatory chunck  -->
<!--  Set the working directory to the repository's base directory -->


<!--  The 2nd mandatory chunck  -->
<!-- Set the report-wide options, and point to the external code file. -->


This report lists the candidate variable for DataScheme variables of the construct **smoking**.

<!-- Load 'sourced' R files.  Suppress the output when loading packages. --> 

```
Warning: package 'ggplot2' was built under R version 3.2.4
```


<!-- Load the sources.  Suppress the output when loading sources. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 

# Exposition

> This report is meant to be compiled after having executed the script `./manipulation/0-ellis-island.R`, which prepares the necessary data transfer object (DTO). We begin with a brief recap of this script and the DTO it produces.  

## Ellis Island

> All data arrive to Ellis Island. 

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
(studyNames <- dto[["studyName"]])
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
# 3rd element - list objects with the following elements
names(dto[["unitData"]])
```

```
[1] "alsa"  "lbsl"  "satsa" "share" "tilda"
```

```r
# each of these elements is a raw data set of a corresponding study, for example
dplyr::tbl_df(dto[["unitData"]][["alsa"]]) 
```

```
Source: local data frame [2,087 x 26]

   SEQNUM EXRTHOUS HWMNWK2W LSVEXC2W LSVIGEXC TMHVYEXR TMVEXC2W VIGEXC2W VIGEXCS WALK2WKS        BTSM12MN HLTHBTSM
    (int)   (fctr)    (int)    (int)   (fctr)    (int)    (int)    (int)  (fctr)   (fctr)          (fctr)   (fctr)
1      41       No       14       NA       No       NA       NA       NA      No      Yes  About the same     Same
2      42       No       14        4      Yes       NA       NA       NA      No      Yes Not as good now   Better
3      61       No       NA       NA       No       NA       NA       NA      No       No  About the same   Better
4      71       No       14       NA       No       NA       NA       NA      No      Yes  About the same     Same
5      91       No       28       NA       No       NA       NA       NA      No      Yes  About the same   Better
6     121       No       NA       NA       No       NA       NA       NA      No       No      Better now     Same
7     181       No       NA       NA       No       NA       NA       NA      No       No  About the same     Same
8     201       No       NA       NA       No       NA       NA       NA      No       No Not as good now   Better
9     221       No       NA       NA       No       NA       NA       NA      No       No Not as good now   Better
10    261       No       NA       NA       No       NA       NA       NA      No       No  About the same   Better
..    ...      ...      ...      ...      ...      ...      ...      ...     ...      ...             ...      ...
Variables not shown: HLTHLIFE (fctr), AGE (int), SEX (fctr), MARITST (fctr), SCHOOL (fctr), TYPQUAL (fctr), RETIRED
  (fctr), SMOKER (fctr), FR6ORMOR (fctr), NOSTDRNK (fctr), FREQALCH (fctr), WEIGHT (dbl), PIPCIGAR (fctr), CURRWORK
  (fctr)
```

```r
# 4th element - a dataset names and labels of raw variables + added metadata for all studies
mds <- dto[["metaData"]]; dplyr::tbl_df(mds)
```

```
Source: local data frame [150 x 11]

       X study_name     name label_short     item construct     type categories                            label    url
   (int)     (fctr)   (fctr)      (fctr)   (fctr)    (fctr)   (fctr)      (int)                           (fctr) (fctr)
1      1       alsa   SEQNUM                   id        id     demo       2087                  Sequence Number       
2      2       alsa EXRTHOUS             exertion           activity         NA            Exertion around house       
3      3       alsa HWMNWK2W              walking           activity         NA   Times walked in past two weeks       
4      4       alsa LSVEXC2W                                activity         NA Less vigor sessions last 2 weeks       
5      5       alsa LSVIGEXC                                activity         NA          Less vigor past 2 weeks       
6      6       alsa TMHVYEXR                                activity         NA     Time heavy physical exertion       
7      7       alsa TMVEXC2W                                activity         NA          Vigor Time past 2 weeks       
8      8       alsa VIGEXC2W                                activity         NA   Vigor Sessions in past 2 weeks       
9      9       alsa  VIGEXCS                                activity         NA                Vigorous exercise       
10    10       alsa WALK2WKS                                activity         NA             Walking past 2 weeks       
..   ...        ...      ...         ...      ...       ...      ...        ...                              ...    ...
Variables not shown: notes (fctr)
```

<!-- Tweak the datasets.   -->


<!-- Basic table view.   -->



## Harmonization targets 

We query metadata set to see what variables are present that tap into the construct `smoking`. These variables constitute the candidates for the DataSchema variables of the harmonized variable.  


```r
# function to pull out the name meta data before graph


# view metadata for the construct of smoking
mds_sub <- mds %>%
  dplyr::filter(construct %in% c('smoking')) %>% 
  dplyr::select(-url, -label, -notes, - X) %>%
  dplyr::arrange(study_name, item)
base::print(mds_sub,nrow(mds_sub))  
```

```
   study_name      name                           label_short            item construct      type categories
1        alsa    SMOKER    Do you currently smoke cigarettes?       smoke_now   smoking substance          2
2        alsa  PIPCIGAR Do you regularly smoke pipe or cigar? smoke_pipecigar   smoking substance          2
3        lbsl     SMOKE                    Smoke, tobacco use   smoke_history   smoking substance          3
4        lbsl     SMK94                      Currently smoke?       smoke_now   smoking substance          2
5       satsa   GEVRSMK                 Do you smoke tobacco?   smoke_history   smoking substance          3
6       satsa  GSMOKNOW               Smoked some last month?       smoke_now   smoking substance          2
7       satsa   GEVRSNS                    Do you take snuff?   snuff_history   smoking substance          3
8       share    BR0010 Ever smoked tobacco daily for a year?   smoke_history   smoking substance          2
9       share    BR0020                     Smoke at present?       smoke_now   smoking substance          2
10      share    BR0030                How many years smoked?     smoke_years   smoking substance         NA
11      tilda     BH003              Age when stopped smoking       smoke_age   smoking substance         NA
12      tilda     BH001 Ever smoked tobacco daily for a year?   smoke_history   smoking substance          2
13      tilda BEHSMOKER                Respondent is a smoker  smoke_history2   smoking substance          3
14      tilda     BH002                     Smoke at present?       smoke_now   smoking substance          2
```

```r
# now, let's focus on the variables we suspect will be included into data schema for smoking
mds_sub <- mds %>%
  dplyr::filter(construct %in% c('smoking')) %>% 
  # dplyr::filter(     item %in% c("smoke_now")) %>%
  dplyr::select(study_name, name, item, label_short, -categories) %>%
  dplyr::arrange(item, study_name)
base::print(mds_sub,nrow(mds_sub))
```

```
   study_name      name            item                           label_short
1       tilda     BH003       smoke_age              Age when stopped smoking
2        lbsl     SMOKE   smoke_history                    Smoke, tobacco use
3       satsa   GEVRSMK   smoke_history                 Do you smoke tobacco?
4       share    BR0010   smoke_history Ever smoked tobacco daily for a year?
5       tilda     BH001   smoke_history Ever smoked tobacco daily for a year?
6       tilda BEHSMOKER  smoke_history2                Respondent is a smoker
7        alsa    SMOKER       smoke_now    Do you currently smoke cigarettes?
8        lbsl     SMK94       smoke_now                      Currently smoke?
9       satsa  GSMOKNOW       smoke_now               Smoked some last month?
10      share    BR0020       smoke_now                     Smoke at present?
11      tilda     BH002       smoke_now                     Smoke at present?
12       alsa  PIPCIGAR smoke_pipecigar Do you regularly smoke pipe or cigar?
13      share    BR0030     smoke_years                How many years smoked?
14      satsa   GEVRSNS   snuff_history                    Do you take snuff?
```
After examining the metadata and reviewing  relevant codebooks, the following operationalization of the harmonized variables for `smoking` have been adopted:

##### (1). H-Target Item : **Smoke now** 

* Item `smoke_now` :  *Is respondent a current smoker?*
Values:       
  - `0` - no (healthy choice)
  - `1` - yes (unhealthy choice)

##### (2). H-Target Item : **Smoked ever**

* Item `smoked_ever` : *Has respondent every smoked?*
Values:      
 - `0` - no, (healthy choice)
 - `1` - yes, (unhealthy choice)
 


```r
# pull out the variables from the subsetted metadata
# source("./scripts/common-functions.r")
ds <- load_data_schema(dto=dto,
                       varname_new="item",
                       construct_name = "smoking")
names(ds)               
```

```
 [1] "study_name"      "smoke_now"       "smoke_pipecigar" "SMOKER"          "PIPCIGAR"        "smoke_history"  
 [7] "SMK94"           "SMOKE"           "snuff_history"   "GEVRSMK"         "GEVRSNS"         "GSMOKNOW"       
[13] "smoke_years"     "BR0010"          "BR0020"          "BR0030"          "smoke_age"       "smoke_history2" 
[19] "BH001"           "BH002"           "BH003"           "BEHSMOKER"      
```

```r
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0030") %>% dplyr::select(name,label)
```

```
    name                 label
1 BR0030 how many years smoked
```

```r
dto[["unitData"]][["share"]] %>% dplyr::filter(!BR0030==9999) %>% histogram_continuous("BR0030", bin_width=5)
```

<img src="basic-graphs/get-schema-variables-1.png" title="" alt="" width="550px" />





### `smoke_now`







