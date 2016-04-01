



This report was automatically generated with the R package **knitr**
(version 1.12.3).


```r
# the purpose of this script is to create a data object (dto) which will hold all data and metadata from each candidate study of the exercise
# run the line below to stitch a basic html output. For elaborated report, run the corresponding .Rmd file
# knitr::stitch_rmd(script="./manipulation/0-ellis-island.R", output="./manipulation/stitched-output/0-ellis-island.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
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
names_labels(dto[["unitData"]][["alsa"]])
```

```
##        name                               label
## 1    SEQNUM                     Sequence Number
## 2  EXRTHOUS               Exertion around house
## 3  HWMNWK2W      Times walked in past two weeks
## 4  LSVEXC2W    Less vigor sessions last 2 weeks
## 5  LSVIGEXC             Less vigor past 2 weeks
## 6  TMHVYEXR        Time heavy physical exertion
## 7  TMVEXC2W             Vigor Time past 2 weeks
## 8  VIGEXC2W      Vigor Sessions in past 2 weeks
## 9   VIGEXCS                   Vigorous exercise
## 10 WALK2WKS                Walking past 2 weeks
## 11 BTSM12MN         Health comp with 12mths ago
## 12 HLTHBTSM           Health compared to others
## 13 HLTHLIFE                   Self-rated health
## 14      AGE                                 Age
## 15      SEX                                 Sex
## 16  MARITST                      Marital status
## 17   SCHOOL                     Age left school
## 18  TYPQUAL               Highest qualification
## 19  RETIRED Are you retired from your last job?
## 20   SMOKER                              Smoker
## 21 FR6ORMOR        Frequency six or more drinks
## 22 NOSTDRNK           Number of standard drinks
## 23 FREQALCH                   Frequency alcohol
## 24   WEIGHT                 Weight in kilograms
## 25 PIPCIGAR               Smokes pipe or cigars
## 26 CURRWORK                   Currently working
```

```r
names_labels(dto[["unitData"]][["lbsl"]])
```

```
##        name
## 1        ID
## 2     AGE94
## 3     SEX94
## 4   MSTAT94
## 5    EDUC94
## 6   NOWRK94
## 7     SMK94
## 8     SMOKE
## 9   ALCOHOL
## 10     WINE
## 11     BEER
## 12  HARDLIQ
## 13  SPORT94
## 14    FIT94
## 15   WALK94
## 16   SPEC94
## 17  DANCE94
## 18  CHORE94
## 19 EXCERTOT
## 20  EXCERWK
## 21 HEIGHT94
## 22 WEIGHT94
## 23  HWEIGHT
## 24  HHEIGHT
## 25 SRHEALTH
##                                                                                label
## 1                                                                               <NA>
## 2                                                                        Age in 1994
## 3                                                                                Sex
## 4                                                             Marital Status in 1994
## 5                                         Number of Years of school completed (1-20)
## 6                                                           Working at present time?
## 7                                                                   Currently smoke?
## 8                                                                 Smoke, tobacco use
## 9                                                                        Alcohol use
## 10                                               Number of glasses of wine last week
## 11                                          Number of cans/bottles of beer last week
## 12                                 Number of drinks containing hard liquor last week
## 13                                               Participant sports, number of hours
## 14                                       Physical fitness, number of hours each week
## 15                                                 Walking, number of hours per week
## 16                                  Spectator sports, number of hours spent per week
## 17                                                                           Dancing
## 18                            Doing household chores, number of hours spent per week
## 19 Number of total hours in an average week exercising for shape/fun (not housework)
## 20                           Number of times in past week exercised or played sports
## 21                                                                  Height in Inches
## 22                                                                  Weight in Pounds
## 23                                                    Self-reported weight in pounds
## 24                                                    Self-reported height in inches
## 25                                        Self-reported health compared to age peers
```

```r
names_labels(dto[["unitData"]][["satsa"]])
```

```
##        name
## 1        ID
## 2  GMARITAL
## 3  GAMTWORK
## 4   GEVRSMK
## 5   GEVRSNS
## 6  GSMOKNOW
## 7   GBOTVIN
## 8  GALCOHOL
## 9   GEVRALK
## 10 GSTOPALK
## 11   GBEERX
## 12    GLIQX
## 13    GVINX
## 14  GDRLOTS
## 15 GFREQBER
## 16 GFREQLIQ
## 17 GFREQVIN
## 18 GEXERCIS
## 19    GHTCM
## 20    GWTKG
## 21 GHLTHOTH
## 22 GGENHLTH
## 23      GPI
## 24      SEX
## 25   YRBORN
## 26    QAGE3
## 27     EDUC
##                                                                                                                                                               label
## 1                                                                                                                                                       Twin number
## 2                                                                                                                                      What is your marital status?
## 3                                                                        Which of the following alternatives best describes your current work/retirement situation?
## 4                                                                                                                  Do you smoke cigarettes, cigars or a pipe? - Yes
## 5                                                                                                                                          Do you take snuff? - Yes
## 6                                                             Have you smoked more than 6 cigarettes, 4 cigars or used pipe tobacco or snuff during the last month?
## 7                                                                                          ..more than 1 bottle, i.e.____bottles (state number of bottles): GBOTVIN
## 8                                                                                                                            Do you ever drink alcoholic beverages?
## 9                                                                                                                         Do you ever drink alcoholic drinks? - Yes
## 10                                                                                                       Do you ever drink alcoholic drinks? -No I quit. When? 19__
## 11                                                                                                                    How much beer do you usually drink at a time?
## 12                                                                                                               How much hard liquot do you usually drink at time?
## 13                                                                                                                    How much wine do you usually drink at a time?
## 14                          How often do you consume more than five bottles of beer or more than one bottle of wine or more than 1/2 bottle liquot at one occasion?
## 15                                                                                                                    How often do you drink beer (not light beer)?
## 16                               How often do you usually drink hard liquor? (e.g. aquavit, whiskey, gin, brandy, punsch. Also liquot in cocktails and long drinks)
## 17                                                                                                              How often do you usually drink wine (red or white)?
## 18 Here are seven different options concerning exercise during your leisure time. Which one of these options best fits how you yourself exercise on a yearly basis?
## 19                                                                                                                                           How tall are you? (cm)
## 20                                                                                                                                      How much do you weigh? (kg)
## 21                                                                                 How do you judge your general state of health compared to other people your age?
## 22                                                                                                                   How do you judge your general state of health?
## 23                                                                                                                                               BMI ((htcm/100)^2)
## 24                                                                                                                                                             <NA>
## 25                                                                                                                                                             <NA>
## 26                                                                                                                                                        age at Q3
## 27                                                                                                                                                        Education
```

```r
names_labels(dto[["unitData"]][["share"]])
```

```
##          name                                           label
## 1  SAMPID.rec                                            <NA>
## 2      DN0030                                   year of birth
## 3      GENDER                                  male or female
## 4      DN0140                                  marital status
## 5      DN0100             highest educational degree obtained
## 6      EP0050                           current job situation
## 7      BR0010                               ever smoked daily
## 8      BR0020                       smoke at the present time
## 9      BR0030                           how many years smoked
## 10     BR0100                beverages consumed last 6 months
## 11     BR0110          freq more than 2 glasses beer in a day
## 12     BR0120          freq more than 2 glasses wine in a day
## 13     BR0130           freq more than 2 hard liquor in a day
## 14     BR0150          sports or activities that are vigorous
## 15     BR0160 activities requiring a moderate level of energy
## 16     PH0130                               how tall are you?
## 17     PH0120                            weight of respondent
## 18     PH0020                  health in general question v 1
## 19     PH0030                  health in general question v 2
## 20     PH0520                  health in general question v 2
## 21     PH0530                  health in general question v 1
## 22   INT.YEAR                                  interview year
## 23   DN012D01             yeshiva, religious high institution
## 24   DN012D02                                  nursing school
## 25   DN012D03                                     polytechnic
## 26   DN012D04                    university, Bachelors degree
## 27   DN012D05                     university, graduate degree
## 28   DN012D09          still in further education or training
## 29   DN012DNO                            no further education
## 30   DN012DOT                         other further education
## 31   DN012DRF                                         refused
## 32   DN012DDK                                       dont know
```

```r
names_labels(dto[["unitData"]][["tilda"]])
```

```
##                     name
## 1                     ID
## 2                    AGE
## 3                    SEX
## 4                  GD002
## 5             SOCMARRIED
## 6                  CS006
## 7                   MAR4
## 8                  DM001
## 9                  WE001
## 10                 WE003
## 11                 BH001
## 12                 BH002
## 13                 BH003
## 14             BEHSMOKER
## 15            SCQALCOHOL
## 16           SCQALCOFREQ
## 17            SCQALCONO1
## 18            SCQALCONO2
## 19      BEHALC.FREQ.WEEK
## 20   BEHALC.DRINKSPERDAY
## 21  BEHALC.DRINKSPERWEEK
## 22                 BH101
## 23                 BH102
## 24                BH102A
## 25                 BH103
## 26                 BH104
## 27                BH104A
## 28                 BH105
## 29                 BH106
## 30                BH106A
## 31                 BH107
## 32                BH107A
## 33        IPAQMETMINUTES
## 34         IPAQEXERCISE3
## 35 SR.HEIGHT.CENTIMETRES
## 36                HEIGHT
## 37 SR.WEIGHT.KILOGRAMMES
## 38                WEIGHT
## 39                 PH001
## 40                 PH009
##                                                                                      label
## 1                                                                            Anonymised ID
## 2                                  Age at interview assuming DOB is 1st of specified month
## 3                                                                                   Gender
## 4                                               gd002 - Is this respondent male or female?
## 5                                                            SOCmarried  Currently married
## 6                                                                       cs006  Are you...?
## 7                                                                     mar4  Marital Status
## 8                         dm001  What is the highest level of education you have completed
## 9           we001  Which one of these would you say best describes your current situation?
## 10   we003  Did you, nevertheless, do any paid work during the last week, either as an em?
## 11   bh001  Have you ever smoked cigarettes, cigars, cigarillos or a pipe daily for a per?
## 12                                                bh002  Do you smoke at the present time?
## 13                                       bh003  How old were you when you stopped smoking?
## 14                                                                       BEHsmoker  Smoker
## 15                                                               SCQalcohol  drink alcohol
## 16                                              SCQalcofreq  frequency of drinking alcohol
## 17                                        SCQalcono1  more than two drinks in a single day
## 18                                SCQalcono2  How many drinks consumed on days drink taken
## 19                                       BEHalc_freq_week  Average times drinking per week
## 20                                            BEHalc_drinksperday  Standard drinks per day
## 21                                            BEHalc_drinksperweek  Standard drinks a week
## 22   bh101  During the last 7 days, on how many days did you do vigorous physical activit?
## 23   bh102  How much time did you usually spend doing vigorous physical activities on one?
## 24  bh102a  How much time did you usually spend doing vigorous physical activities on one?
## 25   bh103  During the last 7 days, on how many days did you do moderate physical activit?
## 26   bh104  How much time did you usually spend doing moderate physical activities on one?
## 27  bh104a  How much time did you usually spend doing moderate physical activities on one?
## 28   bh105  During the last 7 days, on how many days did you walk for at least 10 minutes?
## 29          bh106  How much time did you usually spend walking on one of those days? HOURS
## 30          bh106a  How much time did you usually spend walking on one of those days? MINS
## 31   bh107  During the last 7 days, how much time did you spend sitting on a week day? HO?
## 32 bh107a  During the last 7 days, how much time did you spend sitting on a week day? MINS
## 33                                           IPAQmetminutes  Phsyical activity met-minutes
## 34                                           IPAQmetminutes  Phsyical activity met-minutes
## 35                                                                   SR_Height_Centimetres
## 36                                                                       Respondent height
## 37                                                                   SR_Weight_Kilogrammes
## 38                                                                       Respondent weight
## 39   ph001  Now I would like to ask you some questions about your health.  Would you say ?
## 40      ph009  In general, compared to other people your age, would you say your health is
```

```r
# rename "MAR4" because it can be confused by machines for  March-4
dto[["unitData"]][["tilda"]] <- plyr::rename(dto[["unitData"]][["tilda"]], replace = c("MAR4"= "marital4"))
```

```r
# to prepare for the final step in which we add metadata to the dto
# we begin by extracting the names and (hopefuly their) labels of variables from each dataset
# and combine them in a single rectanguar object, long/stacked with respect to study names
for(i in studyNames){  
  save_csv <- names_labels(dto[["unitData"]][[i]])
  write.csv(save_csv, paste0("./data/shared/derived/meta-raw-",i,".csv"), 
            row.names = T)  
}  
# these 5 individual .cvs contain the original variable names and labels
# now we combine these files to create the starter for our metadata object
dum <- list()
for(i in studyNames){  
  dum[[i]] <- read.csv(paste0("./data/shared/derived/meta-raw-",i,".csv"),
                       header = T, stringsAsFactors = F )  
}
mdsraw <- plyr::ldply(dum, data.frame,.id = "study_name") # convert list of ds into a single ds
mdsraw["X"] <- NULL # remove native counter variable, not needed
write.csv(mdsraw, "./data/shared/derived/meta-raw-live.csv", row.names = T)  
```

```r
# after the final version of the data files used in the excerside have been obtained
# we made a dead copy of `./data/shared/derived/meta-raw-live.csv` and named it `./data/shared/meta-data-map.csv`
# decisions on variables' renaming and classification is encoded in this map
# reproduce ellis-island script every time you make changes to `meta-data-map.csv`
dsm <- read.csv("./data/shared/meta-data-map.csv")
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
##    SEQNUM EXRTHOUS HWMNWK2W LSVEXC2W LSVIGEXC TMHVYEXR TMVEXC2W VIGEXC2W
##     (int)   (fctr)    (int)    (int)   (fctr)    (int)    (int)    (int)
## 1      41       No       14       NA       No       NA       NA       NA
## 2      42       No       14        4      Yes       NA       NA       NA
## 3      61       No       NA       NA       No       NA       NA       NA
## 4      71       No       14       NA       No       NA       NA       NA
## 5      91       No       28       NA       No       NA       NA       NA
## 6     121       No       NA       NA       No       NA       NA       NA
## 7     181       No       NA       NA       No       NA       NA       NA
## 8     201       No       NA       NA       No       NA       NA       NA
## 9     221       No       NA       NA       No       NA       NA       NA
## 10    261       No       NA       NA       No       NA       NA       NA
## ..    ...      ...      ...      ...      ...      ...      ...      ...
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
##    study_name     name                      label_short     item construct
##        (fctr)   (fctr)                           (fctr)   (fctr)    (fctr)
## 1        alsa   SEQNUM                  Sequence Number       id        id
## 2        alsa EXRTHOUS            Exertion around house exertion          
## 3        alsa HWMNWK2W   Times walked in past two weeks  walking          
## 4        alsa LSVEXC2W Less vigor sessions last 2 weeks                   
## 5        alsa LSVIGEXC          Less vigor past 2 weeks                   
## 6        alsa TMHVYEXR     Time heavy physical exertion                   
## 7        alsa TMVEXC2W          Vigor Time past 2 weeks                   
## 8        alsa VIGEXC2W   Vigor Sessions in past 2 weeks                   
## 9        alsa  VIGEXCS                Vigorous exercise                   
## 10       alsa WALK2WKS             Walking past 2 weeks                   
## ..        ...      ...                              ...      ...       ...
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
##  [1] splines_3.2.4       lattice_0.20-33     colorspace_1.2-6   
##  [4] htmltools_0.3       yaml_2.1.13         mgcv_1.8-12        
##  [7] survival_2.38-3     nloptr_1.0.4        foreign_0.8-66     
## [10] DBI_0.3.1           RColorBrewer_1.1-2  plyr_1.8.3         
## [13] stringr_1.0.0       MatrixModels_0.4-1  munsell_0.4.3      
## [16] gtable_0.2.0        htmlwidgets_0.6     evaluate_0.8.3     
## [19] labeling_0.3        latticeExtra_0.6-28 SparseM_1.7        
## [22] extrafont_0.17      quantreg_5.21       pbkrtest_0.4-6     
## [25] parallel_3.2.4      markdown_0.7.7      Rttf2pt1_1.3.3     
## [28] highr_0.5.1         Rcpp_0.12.3         acepack_1.3-3.3    
## [31] scales_0.4.0        DT_0.1.40           formatR_1.3        
## [34] Hmisc_3.17-2        jsonlite_0.9.19     lme4_1.1-11        
## [37] gridExtra_2.2.1     testit_0.5          digest_0.6.9       
## [40] stringi_1.0-1       dplyr_0.4.3         grid_3.2.4         
## [43] tools_3.2.4         lazyeval_0.1.10     dichromat_2.0-0    
## [46] Formula_1.2-1       cluster_2.0.3       car_2.1-1          
## [49] extrafontdb_1.0     tidyr_0.4.1         MASS_7.3-45        
## [52] Matrix_1.2-4        rsconnect_0.3.79    assertthat_0.1     
## [55] minqa_1.2.4         rmarkdown_0.9.5     R6_2.1.2           
## [58] rpart_4.1-10        nnet_7.3-12         nlme_3.1-126
```

```r
Sys.time()
```

```
## [1] "2016-04-01 09:15:12 PDT"
```

