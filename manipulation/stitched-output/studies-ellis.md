



This report was automatically generated with the R package **knitr**
(version 1.11).


```r
# knitr::stitch_rmd(script="./manipulation/studies-ellis.R", output="./manipulation/stitched-output/studies-ellis.md")
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
# requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit") #For asserting conditions meet expected patterns.
# requireNamespace("car") #For it's `recode()` function.
```

```r
# inspect what files there are
(listFiles <- list.files("./data/unshared/", full.names = T,  pattern = ".sav", recursive = F))
```

```
## [1] "./data/unshared/ALSA-Wave1 SPSS.Final.sav"       
## [2] "./data/unshared/LBSL-Panel2-Wave1 SPSS.Final.sav"
## [3] "./data/unshared/SATSA-Q3 SPSS.Final.sav"         
## [4] "./data/unshared/SHARE-Israel Wave 1.Final.sav"   
## [5] "./data/unshared/TILDA-Wave1 SPSS.Final.sav"
```

```r
# list the specific files to be used 
studyNames <- c("alsa", "lbsl", "satsa", "share", "tilda")
# manually declare the file paths 
alsa_path_input  <- "./data/unshared/ALSA-Wave1 SPSS.Final.sav"
lbsl_path_input  <- "./data/unshared/LBSL-Panel2-Wave1 SPSS.Final.sav"
satsa_path_input <- "./data/unshared/SATSA-Q3 SPSS.Final.sav" 
share_path_input <- "./data/unshared/SHARE-Israel Wave 1.Final.sav"   
tilda_path_input <- "./data/unshared/TILDA-Wave1 SPSS.Final.sav"      
# combine file paths into a single object
filePaths <- c(alsa_path_input, lbsl_path_input, satsa_path_input, share_path_input, tilda_path_input)
# declare where the derived data object should be placed
path_output_folder <- "./data/unshared/derived/"
figure_path <- 'manipulation/stitched-output/'
```

```r
# create a list object containing the names of the studies and the paths to their data files
main_list <- list("studyName"=studyNames, "filePath" = filePaths)
# import each data file and include it into the main list object 
data_list <- list() # first create a separate list object containing the data files
for(i in seq_along(studyNames)){
  data_list[[i]] <- Hmisc::spss.get(main_list[["filePath"]][i], use.value.labels = TRUE) 
}
```

```
## Warning in read.spss(file, use.value.labels = use.value.labels,
## to.data.frame = to.data.frame, : ./data/unshared/ALSA-Wave1 SPSS.Final.sav:
## Unrecognized record type 7, subtype 18 encountered in system file
```

```
## Warning in read.spss(file, use.value.labels = use.value.labels,
## to.data.frame = to.data.frame, : ./data/unshared/LBSL-Panel2-Wave1
## SPSS.Final.sav: Unrecognized record type 7, subtype 18 encountered in
## system file
```

```
## Warning in read.spss(file, use.value.labels = use.value.labels,
## to.data.frame = to.data.frame, : ./data/unshared/SATSA-Q3 SPSS.Final.sav:
## Unrecognized record type 7, subtype 18 encountered in system file
```

```
## Warning in read.spss(file, use.value.labels = use.value.labels,
## to.data.frame = to.data.frame, : ./data/unshared/SHARE-Israel Wave
## 1.Final.sav: Unrecognized record type 7, subtype 18 encountered in system
## file
```

```
## Warning in read.spss(file, use.value.labels = use.value.labels,
## to.data.frame = to.data.frame, : ./data/unshared/TILDA-Wave1
## SPSS.Final.sav: Unrecognized record type 7, subtype 18 encountered in
## system file
```

```r
names(data_list) <- studyNames # name the elements of the data list
main_list[["dataFiles"]] <- data_list # include data list into the main list
names(main_list) 
```

```
## [1] "studyName" "filePath"  "dataFiles"
```

```r
names(main_list[["dataFiles"]])
```

```
## [1] "alsa"  "lbsl"  "satsa" "share" "tilda"
```

```r
# remove everything, but the main object
# rm(list=setdiff(ls(),c("main_list")))
# at this point the main list object contains three components:
# main_list contains:  "studyName" ,  "filePath",  "dataFiles"
# data_list <- main_list[["dataFiles"]]
# names(data_list)
```

```r
names_labels(data_list[["alsa"]])
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
```

```r
names_labels(data_list[["lbsl"]])
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
names_labels(data_list[["satsa"]])
```

```
##        name
## 1    TWINNR
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
names_labels(data_list[["share"]])
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
```

```r
names_labels(data_list[["tilda"]])
```

```
##                     name
## 1                     ID
## 2                    AGE
## 3                  CM003
## 4                    SEX
## 5                  GD002
## 6             SOCMARRIED
## 7                  CS006
## 8                   MAR4
## 9                  DM001
## 10                 WE001
## 11                 WE003
## 12                 WE106
## 13                 WE601
## 14                 WE610
## 15                  EMP3
## 16                 BH001
## 17                 BH002
## 18                 BH003
## 19             BEHSMOKER
## 20            SCQALCOHOL
## 21           SCQALCOFREQ
## 22            SCQALCONO1
## 23            SCQALCONO2
## 24      BEHALC.FREQ.WEEK
## 25   BEHALC.DRINKSPERDAY
## 26  BEHALC.DRINKSPERWEEK
## 27                 BH101
## 28                 BH102
## 29                BH102A
## 30                 BH103
## 31                 BH104
## 32                BH104A
## 33                 BH105
## 34                 BH106
## 35                BH106A
## 36                 BH107
## 37                BH107A
## 38        IPAQMETMINUTES
## 39         IPAQEXERCISE3
## 40 SR.HEIGHT.CENTIMETRES
## 41                HEIGHT
## 42                 PH008
## 43 SR.WEIGHT.KILOGRAMMES
## 44                WEIGHT
## 45                 FRBMI
## 46               FRWAIST
## 47                 FRHIP
## 48                 FRWHR
## 49                 PH001
## 50                 PH009
##                                                                                      label
## 1                                                                            Anonymised ID
## 2                                  Age at interview assuming DOB is 1st of specified month
## 3                 FIRST INTERVIEW - Age group of first person interviewed in the househ...
## 4                                                                                   Gender
## 5                                               gd002 - Is this respondent male or female?
## 6                                                            SOCmarried  Currently married
## 7                                                                       cs006  Are you...?
## 8                                                                     mar4  Marital Status
## 9                         dm001  What is the highest level of education you have completed
## 10          we001  Which one of these would you say best describes your current situation?
## 11   we003  Did you, nevertheless, do any paid work during the last week, either as an em?
## 12                                               we106  Could you please tell me, is this?
## 13                                                     we601  In what year did you retire?
## 14                                 we610  When did you stop working at your last job? YEAR
## 15        emp3  Current employment status in three groups - 'other' response not yet coded
## 16   bh001  Have you ever smoked cigarettes, cigars, cigarillos or a pipe daily for a per?
## 17                                                bh002  Do you smoke at the present time?
## 18                                       bh003  How old were you when you stopped smoking?
## 19                                                                       BEHsmoker  Smoker
## 20                                                               SCQalcohol  drink alcohol
## 21                                              SCQalcofreq  frequency of drinking alcohol
## 22                                        SCQalcono1  more than two drinks in a single day
## 23                                SCQalcono2  How many drinks consumed on days drink taken
## 24                                       BEHalc_freq_week  Average times drinking per week
## 25                                            BEHalc_drinksperday  Standard drinks per day
## 26                                            BEHalc_drinksperweek  Standard drinks a week
## 27   bh101  During the last 7 days, on how many days did you do vigorous physical activit?
## 28   bh102  How much time did you usually spend doing vigorous physical activities on one?
## 29  bh102a  How much time did you usually spend doing vigorous physical activities on one?
## 30   bh103  During the last 7 days, on how many days did you do moderate physical activit?
## 31   bh104  How much time did you usually spend doing moderate physical activities on one?
## 32  bh104a  How much time did you usually spend doing moderate physical activities on one?
## 33   bh105  During the last 7 days, on how many days did you walk for at least 10 minutes?
## 34          bh106  How much time did you usually spend walking on one of those days? HOURS
## 35          bh106a  How much time did you usually spend walking on one of those days? MINS
## 36   bh107  During the last 7 days, how much time did you spend sitting on a week day? HO?
## 37 bh107a  During the last 7 days, how much time did you spend sitting on a week day? MINS
## 38                                           IPAQmetminutes  Phsyical activity met-minutes
## 39                                           IPAQmetminutes  Phsyical activity met-minutes
## 40                                                                   SR_Height_Centimetres
## 41                                                                       Respondent height
## 42   ph008  In the past year have you lost 10 pounds (4.5 kg) or more in weight when you ?
## 43                                                                   SR_Weight_Kilogrammes
## 44                                                                       Respondent weight
## 45                                                                                   FRbmi
## 46                                                       FRwaist  Waist circumference (cm)
## 47                                                           FRhip  Hip circumference (cm)
## 48                                                                  FRwhr  Waist/hip ratio
## 49   ph001  Now I would like to ask you some questions about your health.  Would you say ?
## 50      ph009  In general, compared to other people your age, would you say your health is
```

```r
colnames(ds)
```

```
##  [1] "SEQNUM"   "EXRTHOUS" "HWMNWK2W" "LSVEXC2W" "LSVIGEXC" "TMHVYEXR"
##  [7] "TMVEXC2W" "VIGEXC2W" "VIGEXCS"  "WALK2WKS" "BTSM12MN" "HLTHBTSM"
## [13] "HLTHLIFE" "AGE"      "SEX"      "MARITST"  "SCHOOL"   "TYPQUAL" 
## [19] "RETIRED"  "SMOKER"   "FR6ORMOR" "NOSTDRNK" "FREQALCH" "WEIGHT"
```

```r
# testit::assert("`model_name` should be a unique value", sum(duplicated(ds$model_name))==0L)
# testit::assert("`miles_per_gallon` should be a positive value.", all(ds$miles_per_gallon>0))
# testit::assert("`weight_gear_z` should be a positive or missing value.", all(is.na(ds$miles_per_gallon) | (ds$miles_per_gallon>0)))
```

```r
# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
saveRDS(ds, file=path_output, compress="xz")
```

```
## Error in saveRDS(ds, file = path_output, compress = "xz"): object 'path_output' not found
```

The R session information (including the OS info, R version and all
packages used):


```r
sessionInfo()
```

```
## R version 3.2.3 (2015-12-10)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows 7 x64 (build 7601) Service Pack 1
## 
## locale:
## [1] LC_COLLATE=English_Canada.1252  LC_CTYPE=English_Canada.1252   
## [3] LC_MONETARY=English_Canada.1252 LC_NUMERIC=C                   
## [5] LC_TIME=English_Canada.1252    
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] magrittr_1.5
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.11.6         Formula_1.2-1       knitr_1.11         
##  [4] cluster_2.0.3       splines_3.2.3       munsell_0.4.2      
##  [7] testit_0.4          colorspace_1.2-6    lattice_0.20-33    
## [10] R6_2.0.1            stringr_1.0.0       plyr_1.8.2         
## [13] dplyr_0.4.3         tools_3.2.3         nnet_7.3-11        
## [16] parallel_3.2.3      grid_3.2.3          gtable_0.1.2       
## [19] latticeExtra_0.6-28 DBI_0.3.1           survival_2.38-3    
## [22] assertthat_0.1      gridExtra_2.0.0     formatR_1.2        
## [25] RColorBrewer_1.1-2  ggplot2_2.0.0       tidyr_0.4.1        
## [28] acepack_1.3-3.3     rpart_4.1-10        evaluate_0.8       
## [31] stringi_0.4-1       scales_0.3.0        Hmisc_3.17-2       
## [34] markdown_0.7.7      foreign_0.8-66
```

```r
Sys.time()
```

```
## [1] "2016-03-14 16:59:13 PDT"
```

