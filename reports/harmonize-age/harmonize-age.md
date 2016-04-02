# Harmonize: age

<!-- These two chunks should be added in the beginning of every .Rmd that you want to source an .R script -->
<!--  The 1st mandatory chunck  -->
<!--  Set the working directory to the repository's base directory -->


<!--  The 2nd mandatory chunck  -->
<!-- Set the report-wide options, and point to the external code file. -->


This report lists the candidate variable for DataScheme variables of the construct **age**.

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
Source: local data frame [656 x 26]

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
  (int), HHEIGHT (int), SRHEALTH (fctr), year_of_wave (dbl)
```


###  Meta

```r
# 4th element - a dataset names and labels of raw variables + added metadata for all studies
dto[["metaData"]] %>% dplyr::select(study_name, name, item, construct, type, categories, label_short, label) %>% 
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "This is the primary metadata file. Edit at `./data/shared/meta-data-map.csv",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )
```

<!--html_preserve--><div id="htmlwidget-479" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-479">{"x":{"filter":"top","filterHTML":"<tr>\n  <td>\u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"alsa\">alsa\u003c/option>\n        <option value=\"lbsl\">lbsl\u003c/option>\n        <option value=\"satsa\">satsa\u003c/option>\n        <option value=\"share\">share\u003c/option>\n        <option value=\"tilda\">tilda\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"AGE\">AGE\u003c/option>\n        <option value=\"AGE94\">AGE94\u003c/option>\n        <option value=\"ALCOHOL\">ALCOHOL\u003c/option>\n        <option value=\"BEER\">BEER\u003c/option>\n        <option value=\"BEHALC.DRINKSPERDAY\">BEHALC.DRINKSPERDAY\u003c/option>\n        <option value=\"BEHALC.DRINKSPERWEEK\">BEHALC.DRINKSPERWEEK\u003c/option>\n        <option value=\"BEHALC.FREQ.WEEK\">BEHALC.FREQ.WEEK\u003c/option>\n        <option value=\"BEHSMOKER\">BEHSMOKER\u003c/option>\n        <option value=\"BH001\">BH001\u003c/option>\n        <option value=\"BH002\">BH002\u003c/option>\n        <option value=\"BH003\">BH003\u003c/option>\n        <option value=\"BH101\">BH101\u003c/option>\n        <option value=\"BH102\">BH102\u003c/option>\n        <option value=\"BH102A\">BH102A\u003c/option>\n        <option value=\"BH103\">BH103\u003c/option>\n        <option value=\"BH104\">BH104\u003c/option>\n        <option value=\"BH104A\">BH104A\u003c/option>\n        <option value=\"BH105\">BH105\u003c/option>\n        <option value=\"BH106\">BH106\u003c/option>\n        <option value=\"BH106A\">BH106A\u003c/option>\n        <option value=\"BH107\">BH107\u003c/option>\n        <option value=\"BH107A\">BH107A\u003c/option>\n        <option value=\"BR0010\">BR0010\u003c/option>\n        <option value=\"BR0020\">BR0020\u003c/option>\n        <option value=\"BR0030\">BR0030\u003c/option>\n        <option value=\"BR0100\">BR0100\u003c/option>\n        <option value=\"BR0110\">BR0110\u003c/option>\n        <option value=\"BR0120\">BR0120\u003c/option>\n        <option value=\"BR0130\">BR0130\u003c/option>\n        <option value=\"BR0150\">BR0150\u003c/option>\n        <option value=\"BR0160\">BR0160\u003c/option>\n        <option value=\"BTSM12MN\">BTSM12MN\u003c/option>\n        <option value=\"CHORE94\">CHORE94\u003c/option>\n        <option value=\"CS006\">CS006\u003c/option>\n        <option value=\"CURRWORK\">CURRWORK\u003c/option>\n        <option value=\"DANCE94\">DANCE94\u003c/option>\n        <option value=\"DM001\">DM001\u003c/option>\n        <option value=\"DN0030\">DN0030\u003c/option>\n        <option value=\"DN0100\">DN0100\u003c/option>\n        <option value=\"DN012D01\">DN012D01\u003c/option>\n        <option value=\"DN012D02\">DN012D02\u003c/option>\n        <option value=\"DN012D03\">DN012D03\u003c/option>\n        <option value=\"DN012D04\">DN012D04\u003c/option>\n        <option value=\"DN012D05\">DN012D05\u003c/option>\n        <option value=\"DN012D09\">DN012D09\u003c/option>\n        <option value=\"DN012DDK\">DN012DDK\u003c/option>\n        <option value=\"DN012DNO\">DN012DNO\u003c/option>\n        <option value=\"DN012DOT\">DN012DOT\u003c/option>\n        <option value=\"DN012DRF\">DN012DRF\u003c/option>\n        <option value=\"DN0140\">DN0140\u003c/option>\n        <option value=\"EDUC\">EDUC\u003c/option>\n        <option value=\"EDUC94\">EDUC94\u003c/option>\n        <option value=\"EP0050\">EP0050\u003c/option>\n        <option value=\"EXCERTOT\">EXCERTOT\u003c/option>\n        <option value=\"EXCERWK\">EXCERWK\u003c/option>\n        <option value=\"EXRTHOUS\">EXRTHOUS\u003c/option>\n        <option value=\"FIT94\">FIT94\u003c/option>\n        <option value=\"FR6ORMOR\">FR6ORMOR\u003c/option>\n        <option value=\"FREQALCH\">FREQALCH\u003c/option>\n        <option value=\"GALCOHOL\">GALCOHOL\u003c/option>\n        <option value=\"GAMTWORK\">GAMTWORK\u003c/option>\n        <option value=\"GBEERX\">GBEERX\u003c/option>\n        <option value=\"GBOTVIN\">GBOTVIN\u003c/option>\n        <option value=\"GD002\">GD002\u003c/option>\n        <option value=\"GDRLOTS\">GDRLOTS\u003c/option>\n        <option value=\"GENDER\">GENDER\u003c/option>\n        <option value=\"GEVRALK\">GEVRALK\u003c/option>\n        <option value=\"GEVRSMK\">GEVRSMK\u003c/option>\n        <option value=\"GEVRSNS\">GEVRSNS\u003c/option>\n        <option value=\"GEXERCIS\">GEXERCIS\u003c/option>\n        <option value=\"GFREQBER\">GFREQBER\u003c/option>\n        <option value=\"GFREQLIQ\">GFREQLIQ\u003c/option>\n        <option value=\"GFREQVIN\">GFREQVIN\u003c/option>\n        <option value=\"GGENHLTH\">GGENHLTH\u003c/option>\n        <option value=\"GHLTHOTH\">GHLTHOTH\u003c/option>\n        <option value=\"GHTCM\">GHTCM\u003c/option>\n        <option value=\"GLIQX\">GLIQX\u003c/option>\n        <option value=\"GMARITAL\">GMARITAL\u003c/option>\n        <option value=\"GPI\">GPI\u003c/option>\n        <option value=\"GSMOKNOW\">GSMOKNOW\u003c/option>\n        <option value=\"GSTOPALK\">GSTOPALK\u003c/option>\n        <option value=\"GVINX\">GVINX\u003c/option>\n        <option value=\"GWTKG\">GWTKG\u003c/option>\n        <option value=\"HARDLIQ\">HARDLIQ\u003c/option>\n        <option value=\"HEIGHT\">HEIGHT\u003c/option>\n        <option value=\"HEIGHT94\">HEIGHT94\u003c/option>\n        <option value=\"HHEIGHT\">HHEIGHT\u003c/option>\n        <option value=\"HLTHBTSM\">HLTHBTSM\u003c/option>\n        <option value=\"HLTHLIFE\">HLTHLIFE\u003c/option>\n        <option value=\"HWEIGHT\">HWEIGHT\u003c/option>\n        <option value=\"HWMNWK2W\">HWMNWK2W\u003c/option>\n        <option value=\"ID\">ID\u003c/option>\n        <option value=\"INT.YEAR\">INT.YEAR\u003c/option>\n        <option value=\"IPAQEXERCISE3\">IPAQEXERCISE3\u003c/option>\n        <option value=\"IPAQMETMINUTES\">IPAQMETMINUTES\u003c/option>\n        <option value=\"LSVEXC2W\">LSVEXC2W\u003c/option>\n        <option value=\"LSVIGEXC\">LSVIGEXC\u003c/option>\n        <option value=\"marital4\">marital4\u003c/option>\n        <option value=\"MARITST\">MARITST\u003c/option>\n        <option value=\"MSTAT94\">MSTAT94\u003c/option>\n        <option value=\"NOSTDRNK\">NOSTDRNK\u003c/option>\n        <option value=\"NOWRK94\">NOWRK94\u003c/option>\n        <option value=\"PH001\">PH001\u003c/option>\n        <option value=\"PH0020\">PH0020\u003c/option>\n        <option value=\"PH0030\">PH0030\u003c/option>\n        <option value=\"PH009\">PH009\u003c/option>\n        <option value=\"PH0120\">PH0120\u003c/option>\n        <option value=\"PH0130\">PH0130\u003c/option>\n        <option value=\"PH0520\">PH0520\u003c/option>\n        <option value=\"PH0530\">PH0530\u003c/option>\n        <option value=\"PIPCIGAR\">PIPCIGAR\u003c/option>\n        <option value=\"QAGE3\">QAGE3\u003c/option>\n        <option value=\"RETIRED\">RETIRED\u003c/option>\n        <option value=\"SAMPID.rec\">SAMPID.rec\u003c/option>\n        <option value=\"SCHOOL\">SCHOOL\u003c/option>\n        <option value=\"SCQALCOFREQ\">SCQALCOFREQ\u003c/option>\n        <option value=\"SCQALCOHOL\">SCQALCOHOL\u003c/option>\n        <option value=\"SCQALCONO1\">SCQALCONO1\u003c/option>\n        <option value=\"SCQALCONO2\">SCQALCONO2\u003c/option>\n        <option value=\"SEQNUM\">SEQNUM\u003c/option>\n        <option value=\"SEX\">SEX\u003c/option>\n        <option value=\"SEX94\">SEX94\u003c/option>\n        <option value=\"SMK94\">SMK94\u003c/option>\n        <option value=\"SMOKE\">SMOKE\u003c/option>\n        <option value=\"SMOKER\">SMOKER\u003c/option>\n        <option value=\"SOCMARRIED\">SOCMARRIED\u003c/option>\n        <option value=\"SPEC94\">SPEC94\u003c/option>\n        <option value=\"SPORT94\">SPORT94\u003c/option>\n        <option value=\"SR.HEIGHT.CENTIMETRES\">SR.HEIGHT.CENTIMETRES\u003c/option>\n        <option value=\"SR.WEIGHT.KILOGRAMMES\">SR.WEIGHT.KILOGRAMMES\u003c/option>\n        <option value=\"SRHEALTH\">SRHEALTH\u003c/option>\n        <option value=\"TMHVYEXR\">TMHVYEXR\u003c/option>\n        <option value=\"TMVEXC2W\">TMVEXC2W\u003c/option>\n        <option value=\"TYPQUAL\">TYPQUAL\u003c/option>\n        <option value=\"VIGEXC2W\">VIGEXC2W\u003c/option>\n        <option value=\"VIGEXCS\">VIGEXCS\u003c/option>\n        <option value=\"WALK2WKS\">WALK2WKS\u003c/option>\n        <option value=\"WALK94\">WALK94\u003c/option>\n        <option value=\"WE001\">WE001\u003c/option>\n        <option value=\"WE003\">WE003\u003c/option>\n        <option value=\"WEIGHT\">WEIGHT\u003c/option>\n        <option value=\"WEIGHT94\">WEIGHT94\u003c/option>\n        <option value=\"WINE\">WINE\u003c/option>\n        <option value=\"YRBORN\">YRBORN\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"\">\u003c/option>\n        <option value=\"age\">age\u003c/option>\n        <option value=\"age_1994\">age_1994\u003c/option>\n        <option value=\"age_interview\">age_interview\u003c/option>\n        <option value=\"age_left_school\">age_left_school\u003c/option>\n        <option value=\"age_q3\">age_q3\u003c/option>\n        <option value=\"born_year\">born_year\u003c/option>\n        <option value=\"current_job\">current_job\u003c/option>\n        <option value=\"edu\">edu\u003c/option>\n        <option value=\"edu_highest\">edu_highest\u003c/option>\n        <option value=\"edu_hight\">edu_hight\u003c/option>\n        <option value=\"employed\">employed\u003c/option>\n        <option value=\"exertion\">exertion\u003c/option>\n        <option value=\"healt_self\">healt_self\u003c/option>\n        <option value=\"health_12ago\">health_12ago\u003c/option>\n        <option value=\"health_others\">health_others\u003c/option>\n        <option value=\"height_in\">height_in\u003c/option>\n        <option value=\"height_in_sr\">height_in_sr\u003c/option>\n        <option value=\"id\">id\u003c/option>\n        <option value=\"marital\">marital\u003c/option>\n        <option value=\"marital_2\">marital_2\u003c/option>\n        <option value=\"marital_4\">marital_4\u003c/option>\n        <option value=\"marital_6\">marital_6\u003c/option>\n        <option value=\"retired\">retired\u003c/option>\n        <option value=\"school_years\">school_years\u003c/option>\n        <option value=\"sex\">sex\u003c/option>\n        <option value=\"sex_gender\">sex_gender\u003c/option>\n        <option value=\"smoke_age\">smoke_age\u003c/option>\n        <option value=\"smoke_history\">smoke_history\u003c/option>\n        <option value=\"smoke_history2\">smoke_history2\u003c/option>\n        <option value=\"smoke_now\">smoke_now\u003c/option>\n        <option value=\"smoke_pipecigar\">smoke_pipecigar\u003c/option>\n        <option value=\"smoke_years\">smoke_years\u003c/option>\n        <option value=\"snuff_history\">snuff_history\u003c/option>\n        <option value=\"twin_id\">twin_id\u003c/option>\n        <option value=\"walking\">walking\u003c/option>\n        <option value=\"weight_kg\">weight_kg\u003c/option>\n        <option value=\"weight_lb\">weight_lb\u003c/option>\n        <option value=\"weight_lb_sr\">weight_lb_sr\u003c/option>\n        <option value=\"work_extra\">work_extra\u003c/option>\n        <option value=\"work_status\">work_status\u003c/option>\n        <option value=\"year_born\">year_born\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"\">\u003c/option>\n        <option value=\"age\">age\u003c/option>\n        <option value=\"alcohol\">alcohol\u003c/option>\n        <option value=\"education\">education\u003c/option>\n        <option value=\"employment\">employment\u003c/option>\n        <option value=\"health\">health\u003c/option>\n        <option value=\"height\">height\u003c/option>\n        <option value=\"id\">id\u003c/option>\n        <option value=\"marital\">marital\u003c/option>\n        <option value=\"sex\">sex\u003c/option>\n        <option value=\"smoking\">smoking\u003c/option>\n        <option value=\"weight\">weight\u003c/option>\n        <option value=\"work_status\">work_status\u003c/option>\n        <option value=\"year\">year\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"activity\">activity\u003c/option>\n        <option value=\"demo\">demo\u003c/option>\n        <option value=\"physical\">physical\u003c/option>\n        <option value=\"substance\">substance\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"integer\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"2\" data-max=\"8504\">\u003c/div>\n      <span style=\"float: left;\">\u003c/span>\n      <span style=\"float: right;\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"\">\u003c/option>\n        <option value=\"activities requiring a moderate level of energy\">activities requiring a moderate level of energy\u003c/option>\n        <option value=\"Age\">Age\u003c/option>\n        <option value=\"Age at current wave\">Age at current wave\u003c/option>\n        <option value=\"Age in 1994\">Age in 1994\u003c/option>\n        <option value=\"Age left school\">Age left school\u003c/option>\n        <option value=\"Age when stopped smoking\">Age when stopped smoking\u003c/option>\n        <option value=\"Alcohol use\">Alcohol use\u003c/option>\n        <option value=\"Anonymised ID\">Anonymised ID\u003c/option>\n        <option value=\"Are you retired from your last job?\">Are you retired from your last job?\u003c/option>\n        <option value=\"beverages consumed last 6 months\">beverages consumed last 6 months\u003c/option>\n        <option value=\"Current job situation\">Current job situation\u003c/option>\n        <option value=\"Currently smoke?\">Currently smoke?\u003c/option>\n        <option value=\"Currently working\">Currently working\u003c/option>\n        <option value=\"Dancing\">Dancing\u003c/option>\n        <option value=\"Do you currently smoke cigarettes?\">Do you currently smoke cigarettes?\u003c/option>\n        <option value=\"Do you regularly smoke pipe or cigar?\">Do you regularly smoke pipe or cigar?\u003c/option>\n        <option value=\"Do you smoke tobacco?\">Do you smoke tobacco?\u003c/option>\n        <option value=\"Do you take snuff?\">Do you take snuff?\u003c/option>\n        <option value=\"Doing household chores (hrs/wk)\">Doing household chores (hrs/wk)\u003c/option>\n        <option value=\"dont know\">dont know\u003c/option>\n        <option value=\"Edcuation\">Edcuation\u003c/option>\n        <option value=\"Education\">Education\u003c/option>\n        <option value=\"Ever smoked tobacco daily for a year?\">Ever smoked tobacco daily for a year?\u003c/option>\n        <option value=\"Exercised or played sports (oc/wk)\">Exercised or played sports (oc/wk)\u003c/option>\n        <option value=\"Exercising for shape/fun (hrs/wk)\">Exercising for shape/fun (hrs/wk)\u003c/option>\n        <option value=\"Exertion around house\">Exertion around house\u003c/option>\n        <option value=\"freq more than 2 glasses beer in a day\">freq more than 2 glasses beer in a day\u003c/option>\n        <option value=\"freq more than 2 glasses wine in a day\">freq more than 2 glasses wine in a day\u003c/option>\n        <option value=\"freq more than 2 hard liquor in a day\">freq more than 2 hard liquor in a day\u003c/option>\n        <option value=\"Frequency alcohol\">Frequency alcohol\u003c/option>\n        <option value=\"Frequency six or more drinks\">Frequency six or more drinks\u003c/option>\n        <option value=\"Health comp with 12mths ago\">Health comp with 12mths ago\u003c/option>\n        <option value=\"Health compared to others\">Health compared to others\u003c/option>\n        <option value=\"health in general question v 1\">health in general question v 1\u003c/option>\n        <option value=\"health in general question v 2\">health in general question v 2\u003c/option>\n        <option value=\"Height in Inches\">Height in Inches\u003c/option>\n        <option value=\"Highest qualification\">Highest qualification\u003c/option>\n        <option value=\"How many years smoked?\">How many years smoked?\u003c/option>\n        <option value=\"how tall are you?\">how tall are you?\u003c/option>\n        <option value=\"id\">id\u003c/option>\n        <option value=\"Id\">Id\u003c/option>\n        <option value=\"interview year\">interview year\u003c/option>\n        <option value=\"Less vigor past 2 weeks\">Less vigor past 2 weeks\u003c/option>\n        <option value=\"Less vigor sessions last 2 weeks\">Less vigor sessions last 2 weeks\u003c/option>\n        <option value=\"Marital status\">Marital status\u003c/option>\n        <option value=\"Marital Status\">Marital Status\u003c/option>\n        <option value=\"Marital Status in 1994\">Marital Status in 1994\u003c/option>\n        <option value=\"no further education\">no further education\u003c/option>\n        <option value=\"Number of cans/bottles of beer last week\">Number of cans/bottles of beer last week\u003c/option>\n        <option value=\"Number of drinks containing hard liquor last week\">Number of drinks containing hard liquor last week\u003c/option>\n        <option value=\"Number of glasses of wine last week\">Number of glasses of wine last week\u003c/option>\n        <option value=\"Number of standard drinks\">Number of standard drinks\u003c/option>\n        <option value=\"nursing school\">nursing school\u003c/option>\n        <option value=\"other further education\">other further education\u003c/option>\n        <option value=\"Participant sports, number of hours\">Participant sports, number of hours\u003c/option>\n        <option value=\"Physical fitness, number of hours each week\">Physical fitness, number of hours each week\u003c/option>\n        <option value=\"polytechnic\">polytechnic\u003c/option>\n        <option value=\"refused\">refused\u003c/option>\n        <option value=\"Respondent is a smoker\">Respondent is a smoker\u003c/option>\n        <option value=\"Self-rated health\">Self-rated health\u003c/option>\n        <option value=\"Self-reported health compared to age peers\">Self-reported health compared to age peers\u003c/option>\n        <option value=\"Self-reported height in inches\">Self-reported height in inches\u003c/option>\n        <option value=\"Self-reported weight in pounds\">Self-reported weight in pounds\u003c/option>\n        <option value=\"Sequence Number\">Sequence Number\u003c/option>\n        <option value=\"Sex\">Sex\u003c/option>\n        <option value=\"Smoke at present?\">Smoke at present?\u003c/option>\n        <option value=\"Smoke, tobacco use\">Smoke, tobacco use\u003c/option>\n        <option value=\"Smoked some last month?\">Smoked some last month?\u003c/option>\n        <option value=\"Spectator sports, number of hours spent per week\">Spectator sports, number of hours spent per week\u003c/option>\n        <option value=\"sports or activities that are vigorous\">sports or activities that are vigorous\u003c/option>\n        <option value=\"still in further education or training\">still in further education or training\u003c/option>\n        <option value=\"Time heavy physical exertion\">Time heavy physical exertion\u003c/option>\n        <option value=\"Times walked in past two weeks\">Times walked in past two weeks\u003c/option>\n        <option value=\"Twin number\">Twin number\u003c/option>\n        <option value=\"university, Bachelors degree\">university, Bachelors degree\u003c/option>\n        <option value=\"university, graduate degree\">university, graduate degree\u003c/option>\n        <option value=\"Vigor Sessions in past 2 weeks\">Vigor Sessions in past 2 weeks\u003c/option>\n        <option value=\"Vigor Time past 2 weeks\">Vigor Time past 2 weeks\u003c/option>\n        <option value=\"Vigorous exercise\">Vigorous exercise\u003c/option>\n        <option value=\"Walking past 2 weeks\">Walking past 2 weeks\u003c/option>\n        <option value=\"Walking, number of hours per week\">Walking, number of hours per week\u003c/option>\n        <option value=\"Weight in kilograms\">Weight in kilograms\u003c/option>\n        <option value=\"Weight in Pounds\">Weight in Pounds\u003c/option>\n        <option value=\"weight of respondent\">weight of respondent\u003c/option>\n        <option value=\"What is your marital status?\">What is your marital status?\u003c/option>\n        <option value=\"Which of the following alternatives best describes your current work/retirement situation?\">Which of the following alternatives best describes your current work/retirement situation?\u003c/option>\n        <option value=\"Working at present time?\">Working at present time?\u003c/option>\n        <option value=\"Year born\">Year born\u003c/option>\n        <option value=\"Years of school completed\">Years of school completed\u003c/option>\n        <option value=\"yeshiva, religious high institution\">yeshiva, religious high institution\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"..more than 1 bottle, i.e.____bottles (state number of bottles): GBOTVIN\">..more than 1 bottle, i.e.____bottles (state number of bottles): GBOTVIN\u003c/option>\n        <option value=\"activities requiring a moderate level of energy\">activities requiring a moderate level of energy\u003c/option>\n        <option value=\"Age\">Age\u003c/option>\n        <option value=\"Age at interview assuming DOB is 1st of specified month\">Age at interview assuming DOB is 1st of specified month\u003c/option>\n        <option value=\"age at Q3\">age at Q3\u003c/option>\n        <option value=\"Age in 1994\">Age in 1994\u003c/option>\n        <option value=\"Age left school\">Age left school\u003c/option>\n        <option value=\"Alcohol use\">Alcohol use\u003c/option>\n        <option value=\"Anonymised ID\">Anonymised ID\u003c/option>\n        <option value=\"Are you retired from your last job?\">Are you retired from your last job?\u003c/option>\n        <option value=\"BEHalc_drinksperday  Standard drinks per day\">BEHalc_drinksperday  Standard drinks per day\u003c/option>\n        <option value=\"BEHalc_drinksperweek  Standard drinks a week\">BEHalc_drinksperweek  Standard drinks a week\u003c/option>\n        <option value=\"BEHalc_freq_week  Average times drinking per week\">BEHalc_freq_week  Average times drinking per week\u003c/option>\n        <option value=\"BEHsmoker  Smoker\">BEHsmoker  Smoker\u003c/option>\n        <option value=\"beverages consumed last 6 months\">beverages consumed last 6 months\u003c/option>\n        <option value=\"bh001  Have you ever smoked cigarettes, cigars, cigarillos or a pipe daily for a per?\">bh001  Have you ever smoked cigarettes, cigars, cigarillos or a pipe daily for a per?\u003c/option>\n        <option value=\"bh002  Do you smoke at the present time?\">bh002  Do you smoke at the present time?\u003c/option>\n        <option value=\"bh003  How old were you when you stopped smoking?\">bh003  How old were you when you stopped smoking?\u003c/option>\n        <option value=\"bh101  During the last 7 days, on how many days did you do vigorous physical activit?\">bh101  During the last 7 days, on how many days did you do vigorous physical activit?\u003c/option>\n        <option value=\"bh102  How much time did you usually spend doing vigorous physical activities on one?\">bh102  How much time did you usually spend doing vigorous physical activities on one?\u003c/option>\n        <option value=\"bh102a  How much time did you usually spend doing vigorous physical activities on one?\">bh102a  How much time did you usually spend doing vigorous physical activities on one?\u003c/option>\n        <option value=\"bh103  During the last 7 days, on how many days did you do moderate physical activit?\">bh103  During the last 7 days, on how many days did you do moderate physical activit?\u003c/option>\n        <option value=\"bh104  How much time did you usually spend doing moderate physical activities on one?\">bh104  How much time did you usually spend doing moderate physical activities on one?\u003c/option>\n        <option value=\"bh104a  How much time did you usually spend doing moderate physical activities on one?\">bh104a  How much time did you usually spend doing moderate physical activities on one?\u003c/option>\n        <option value=\"bh105  During the last 7 days, on how many days did you walk for at least 10 minutes?\">bh105  During the last 7 days, on how many days did you walk for at least 10 minutes?\u003c/option>\n        <option value=\"bh106  How much time did you usually spend walking on one of those days? HOURS\">bh106  How much time did you usually spend walking on one of those days? HOURS\u003c/option>\n        <option value=\"bh106a  How much time did you usually spend walking on one of those days? MINS\">bh106a  How much time did you usually spend walking on one of those days? MINS\u003c/option>\n        <option value=\"bh107  During the last 7 days, how much time did you spend sitting on a week day? HO?\">bh107  During the last 7 days, how much time did you spend sitting on a week day? HO?\u003c/option>\n        <option value=\"bh107a  During the last 7 days, how much time did you spend sitting on a week day? MINS\">bh107a  During the last 7 days, how much time did you spend sitting on a week day? MINS\u003c/option>\n        <option value=\"BMI ((htcm/100)^2)\">BMI ((htcm/100)^2)\u003c/option>\n        <option value=\"cs006  Are you...?\">cs006  Are you...?\u003c/option>\n        <option value=\"current job situation\">current job situation\u003c/option>\n        <option value=\"Currently smoke?\">Currently smoke?\u003c/option>\n        <option value=\"Currently working\">Currently working\u003c/option>\n        <option value=\"Dancing\">Dancing\u003c/option>\n        <option value=\"dm001  What is the highest level of education you have completed\">dm001  What is the highest level of education you have completed\u003c/option>\n        <option value=\"Do you currently smoke cigarettes?\">Do you currently smoke cigarettes?\u003c/option>\n        <option value=\"Do you ever drink alcoholic beverages?\">Do you ever drink alcoholic beverages?\u003c/option>\n        <option value=\"Do you ever drink alcoholic drinks? - Yes\">Do you ever drink alcoholic drinks? - Yes\u003c/option>\n        <option value=\"Do you ever drink alcoholic drinks? -No I quit. When? 19__\">Do you ever drink alcoholic drinks? -No I quit. When? 19__\u003c/option>\n        <option value=\"Do you regularly smoke pipe or cigar?\">Do you regularly smoke pipe or cigar?\u003c/option>\n        <option value=\"Do you smoke cigarettes, cigars or a pipe? - Yes\">Do you smoke cigarettes, cigars or a pipe? - Yes\u003c/option>\n        <option value=\"Do you take snuff? - Yes\">Do you take snuff? - Yes\u003c/option>\n        <option value=\"Doing household chores, number of hours spent per week\">Doing household chores, number of hours spent per week\u003c/option>\n        <option value=\"dont know\">dont know\u003c/option>\n        <option value=\"Education\">Education\u003c/option>\n        <option value=\"ever smoked daily\">ever smoked daily\u003c/option>\n        <option value=\"Exertion around house\">Exertion around house\u003c/option>\n        <option value=\"freq more than 2 glasses beer in a day\">freq more than 2 glasses beer in a day\u003c/option>\n        <option value=\"freq more than 2 glasses wine in a day\">freq more than 2 glasses wine in a day\u003c/option>\n        <option value=\"freq more than 2 hard liquor in a day\">freq more than 2 hard liquor in a day\u003c/option>\n        <option value=\"Frequency alcohol\">Frequency alcohol\u003c/option>\n        <option value=\"Frequency six or more drinks\">Frequency six or more drinks\u003c/option>\n        <option value=\"gd002 - Is this respondent male or female?\">gd002 - Is this respondent male or female?\u003c/option>\n        <option value=\"Gender\">Gender\u003c/option>\n        <option value=\"Have you smoked more than 6 cigarettes, 4 cigars or used pipe tobacco or snuff during the last month?\">Have you smoked more than 6 cigarettes, 4 cigars or used pipe tobacco or snuff during the last month?\u003c/option>\n        <option value=\"Health comp with 12mths ago\">Health comp with 12mths ago\u003c/option>\n        <option value=\"Health compared to others\">Health compared to others\u003c/option>\n        <option value=\"health in general question v 1\">health in general question v 1\u003c/option>\n        <option value=\"health in general question v 2\">health in general question v 2\u003c/option>\n        <option value=\"Height in Inches\">Height in Inches\u003c/option>\n        <option value=\"Here are seven different options concerning exercise during your leisure time. Which one of these options best fits how you yourself exercise on a yearly basis?\">Here are seven different options concerning exercise during your leisure time. Which one of these options best fits how you yourself exercise on a yearly basis?\u003c/option>\n        <option value=\"highest educational degree obtained\">highest educational degree obtained\u003c/option>\n        <option value=\"Highest qualification\">Highest qualification\u003c/option>\n        <option value=\"How do you judge your general state of health compared to other people your age?\">How do you judge your general state of health compared to other people your age?\u003c/option>\n        <option value=\"How do you judge your general state of health?\">How do you judge your general state of health?\u003c/option>\n        <option value=\"how many years smoked\">how many years smoked\u003c/option>\n        <option value=\"How much beer do you usually drink at a time?\">How much beer do you usually drink at a time?\u003c/option>\n        <option value=\"How much do you weigh? (kg)\">How much do you weigh? (kg)\u003c/option>\n        <option value=\"How much hard liquot do you usually drink at time?\">How much hard liquot do you usually drink at time?\u003c/option>\n        <option value=\"How much wine do you usually drink at a time?\">How much wine do you usually drink at a time?\u003c/option>\n        <option value=\"How often do you consume more than five bottles of beer or more than one bottle of wine or more than 1/2 bottle liquot at one occasion?\">How often do you consume more than five bottles of beer or more than one bottle of wine or more than 1/2 bottle liquot at one occasion?\u003c/option>\n        <option value=\"How often do you drink beer (not light beer)?\">How often do you drink beer (not light beer)?\u003c/option>\n        <option value=\"How often do you usually drink hard liquor? (e.g. aquavit, whiskey, gin, brandy, punsch. Also liquot in cocktails and long drinks)\">How often do you usually drink hard liquor? (e.g. aquavit, whiskey, gin, brandy, punsch. Also liquot in cocktails and long drinks)\u003c/option>\n        <option value=\"How often do you usually drink wine (red or white)?\">How often do you usually drink wine (red or white)?\u003c/option>\n        <option value=\"how tall are you?\">how tall are you?\u003c/option>\n        <option value=\"How tall are you? (cm)\">How tall are you? (cm)\u003c/option>\n        <option value=\"interview year\">interview year\u003c/option>\n        <option value=\"IPAQmetminutes  Phsyical activity met-minutes\">IPAQmetminutes  Phsyical activity met-minutes\u003c/option>\n        <option value=\"Less vigor past 2 weeks\">Less vigor past 2 weeks\u003c/option>\n        <option value=\"Less vigor sessions last 2 weeks\">Less vigor sessions last 2 weeks\u003c/option>\n        <option value=\"male or female\">male or female\u003c/option>\n        <option value=\"mar4  Marital Status\">mar4  Marital Status\u003c/option>\n        <option value=\"marital status\">marital status\u003c/option>\n        <option value=\"Marital status\">Marital status\u003c/option>\n        <option value=\"Marital Status in 1994\">Marital Status in 1994\u003c/option>\n        <option value=\"no further education\">no further education\u003c/option>\n        <option value=\"Number of cans/bottles of beer last week\">Number of cans/bottles of beer last week\u003c/option>\n        <option value=\"Number of drinks containing hard liquor last week\">Number of drinks containing hard liquor last week\u003c/option>\n        <option value=\"Number of glasses of wine last week\">Number of glasses of wine last week\u003c/option>\n        <option value=\"Number of standard drinks\">Number of standard drinks\u003c/option>\n        <option value=\"Number of times in past week exercised or played sports\">Number of times in past week exercised or played sports\u003c/option>\n        <option value=\"Number of total hours in an average week exercising for shape/fun (not housework)\">Number of total hours in an average week exercising for shape/fun (not housework)\u003c/option>\n        <option value=\"Number of Years of school completed (1-20)\">Number of Years of school completed (1-20)\u003c/option>\n        <option value=\"nursing school\">nursing school\u003c/option>\n        <option value=\"other further education\">other further education\u003c/option>\n        <option value=\"Participant sports, number of hours\">Participant sports, number of hours\u003c/option>\n        <option value=\"ph001  Now I would like to ask you some questions about your health.  Would you say ?\">ph001  Now I would like to ask you some questions about your health.  Would you say ?\u003c/option>\n        <option value=\"ph009  In general, compared to other people your age, would you say your health is\">ph009  In general, compared to other people your age, would you say your health is\u003c/option>\n        <option value=\"Physical fitness, number of hours each week\">Physical fitness, number of hours each week\u003c/option>\n        <option value=\"polytechnic\">polytechnic\u003c/option>\n        <option value=\"refused\">refused\u003c/option>\n        <option value=\"Respondent height\">Respondent height\u003c/option>\n        <option value=\"Respondent weight\">Respondent weight\u003c/option>\n        <option value=\"SCQalcofreq  frequency of drinking alcohol\">SCQalcofreq  frequency of drinking alcohol\u003c/option>\n        <option value=\"SCQalcohol  drink alcohol\">SCQalcohol  drink alcohol\u003c/option>\n        <option value=\"SCQalcono1  more than two drinks in a single day\">SCQalcono1  more than two drinks in a single day\u003c/option>\n        <option value=\"SCQalcono2  How many drinks consumed on days drink taken\">SCQalcono2  How many drinks consumed on days drink taken\u003c/option>\n        <option value=\"Self-rated health\">Self-rated health\u003c/option>\n        <option value=\"Self-reported health compared to age peers\">Self-reported health compared to age peers\u003c/option>\n        <option value=\"Self-reported height in inches\">Self-reported height in inches\u003c/option>\n        <option value=\"Self-reported weight in pounds\">Self-reported weight in pounds\u003c/option>\n        <option value=\"Sequence Number\">Sequence Number\u003c/option>\n        <option value=\"Sex\">Sex\u003c/option>\n        <option value=\"smoke at the present time\">smoke at the present time\u003c/option>\n        <option value=\"Smoke, tobacco use\">Smoke, tobacco use\u003c/option>\n        <option value=\"SOCmarried  Currently married\">SOCmarried  Currently married\u003c/option>\n        <option value=\"Spectator sports, number of hours spent per week\">Spectator sports, number of hours spent per week\u003c/option>\n        <option value=\"sports or activities that are vigorous\">sports or activities that are vigorous\u003c/option>\n        <option value=\"SR_Height_Centimetres\">SR_Height_Centimetres\u003c/option>\n        <option value=\"SR_Weight_Kilogrammes\">SR_Weight_Kilogrammes\u003c/option>\n        <option value=\"still in further education or training\">still in further education or training\u003c/option>\n        <option value=\"Time heavy physical exertion\">Time heavy physical exertion\u003c/option>\n        <option value=\"Times walked in past two weeks\">Times walked in past two weeks\u003c/option>\n        <option value=\"Twin number\">Twin number\u003c/option>\n        <option value=\"university, Bachelors degree\">university, Bachelors degree\u003c/option>\n        <option value=\"university, graduate degree\">university, graduate degree\u003c/option>\n        <option value=\"Vigor Sessions in past 2 weeks\">Vigor Sessions in past 2 weeks\u003c/option>\n        <option value=\"Vigor Time past 2 weeks\">Vigor Time past 2 weeks\u003c/option>\n        <option value=\"Vigorous exercise\">Vigorous exercise\u003c/option>\n        <option value=\"Walking past 2 weeks\">Walking past 2 weeks\u003c/option>\n        <option value=\"Walking, number of hours per week\">Walking, number of hours per week\u003c/option>\n        <option value=\"we001  Which one of these would you say best describes your current situation?\">we001  Which one of these would you say best describes your current situation?\u003c/option>\n        <option value=\"we003  Did you, nevertheless, do any paid work during the last week, either as an em?\">we003  Did you, nevertheless, do any paid work during the last week, either as an em?\u003c/option>\n        <option value=\"Weight in kilograms\">Weight in kilograms\u003c/option>\n        <option value=\"Weight in Pounds\">Weight in Pounds\u003c/option>\n        <option value=\"weight of respondent\">weight of respondent\u003c/option>\n        <option value=\"What is your marital status?\">What is your marital status?\u003c/option>\n        <option value=\"Which of the following alternatives best describes your current work/retirement situation?\">Which of the following alternatives best describes your current work/retirement situation?\u003c/option>\n        <option value=\"Working at present time?\">Working at present time?\u003c/option>\n        <option value=\"year of birth\">year of birth\u003c/option>\n        <option value=\"yeshiva, religious high institution\">yeshiva, religious high institution\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n\u003c/tr>","caption":"<caption>This is the primary metadata file. Edit at `./data/shared/meta-data-map.csv\u003c/caption>","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"],["alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda"],["SEQNUM","EXRTHOUS","HWMNWK2W","LSVEXC2W","LSVIGEXC","TMHVYEXR","TMVEXC2W","VIGEXC2W","VIGEXCS","WALK2WKS","BTSM12MN","HLTHBTSM","HLTHLIFE","AGE","SEX","MARITST","SCHOOL","TYPQUAL","RETIRED","SMOKER","FR6ORMOR","NOSTDRNK","FREQALCH","WEIGHT","PIPCIGAR","CURRWORK","ID","AGE94","SEX94","MSTAT94","EDUC94","NOWRK94","SMK94","SMOKE","ALCOHOL","WINE","BEER","HARDLIQ","SPORT94","FIT94","WALK94","SPEC94","DANCE94","CHORE94","EXCERTOT","EXCERWK","HEIGHT94","WEIGHT94","HWEIGHT","HHEIGHT","SRHEALTH","ID","GMARITAL","GAMTWORK","GEVRSMK","GEVRSNS","GSMOKNOW","GBOTVIN","GALCOHOL","GEVRALK","GSTOPALK","GBEERX","GLIQX","GVINX","GDRLOTS","GFREQBER","GFREQLIQ","GFREQVIN","GEXERCIS","GHTCM","GWTKG","GHLTHOTH","GGENHLTH","GPI","SEX","YRBORN","QAGE3","EDUC","SAMPID.rec","DN0030","GENDER","DN0140","DN0100","EP0050","BR0010","BR0020","BR0030","BR0100","BR0110","BR0120","BR0130","BR0150","BR0160","PH0130","PH0120","PH0020","PH0030","PH0520","PH0530","INT.YEAR","DN012D01","DN012D02","DN012D03","DN012D04","DN012D05","DN012D09","DN012DNO","DN012DOT","DN012DRF","DN012DDK","ID","AGE","SEX","GD002","SOCMARRIED","CS006","marital4","DM001","WE001","WE003","BH001","BH002","BH003","BEHSMOKER","SCQALCOHOL","SCQALCOFREQ","SCQALCONO1","SCQALCONO2","BEHALC.FREQ.WEEK","BEHALC.DRINKSPERDAY","BEHALC.DRINKSPERWEEK","BH101","BH102","BH102A","BH103","BH104","BH104A","BH105","BH106","BH106A","BH107","BH107A","IPAQMETMINUTES","IPAQEXERCISE3","SR.HEIGHT.CENTIMETRES","HEIGHT","SR.WEIGHT.KILOGRAMMES","WEIGHT","PH001","PH009"],["id","exertion","walking","","","","","","","","health_12ago","health_others","healt_self","age","sex","marital","age_left_school","edu_hight","retired","smoke_now","","","","weight_kg","smoke_pipecigar","employed","id","age_1994","sex","marital","school_years","employed","smoke_now","smoke_history","","","","","","","","","","","","","height_in","weight_lb","weight_lb_sr","height_in_sr","","twin_id","marital","work_status","smoke_history","snuff_history","smoke_now","","","","","","","","","","","","","","","","","","sex","year_born","age_q3","edu","id","born_year","sex","marital","edu","current_job","smoke_history","smoke_now","smoke_years","","","","","","","","","","","","","","","","","","","","","","","","id","age_interview","sex","sex_gender","marital_2","marital_6","marital_4","edu_highest","work_status","work_extra","smoke_history","smoke_now","smoke_age","smoke_history2","","","","","","","","","","","","","","","","","","","","","","","","","",""],["id","","","","","","","","","","health","health","health","age","sex","marital","education","education","work_status","smoking","alcohol","alcohol","alcohol","weight","smoking","work_status","id","age","sex","marital","education","work_status","smoking","smoking","alcohol","alcohol","alcohol","alcohol","","","","","","","","","height","weight","weight","height","health","id","marital","work_status","smoking","smoking","smoking","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","","","","","","","sex","age","age","education","id","age","sex","marital","education","employment","smoking","smoking","smoking","alcohol","alcohol","alcohol","alcohol","","","height","weight","health","health","health","health","year","education","education","education","education","education","education","education","education","education","education","id","age","sex","sex","marital","marital","marital","education","employment","employment","smoking","smoking","smoking","smoking","","","","","","","","","","","","","","","","","","","","","","","","","",""],["demo","activity","activity","activity","activity","activity","activity","activity","activity","activity","physical","physical","physical","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","physical","substance","demo","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","substance","substance","activity","activity","activity","activity","activity","activity","activity","activity","physical","physical","physical","physical","physical","demo","demo","demo","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","activity","physical","physical","physical","physical","physical","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","substance","substance","substance","activity","activity","physical","physical","physical","physical","physical","physical","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","physical","physical","physical","physical","physical","physical"],[2087,null,null,null,null,null,null,null,null,null,null,null,null,38,2,7,8,10,2,2,null,null,null,null,2,null,656,65,2,6,18,9,2,3,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,1498,5,11,3,3,2,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,2,62,879,4,2598,57,2,9,13,10,2,2,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,8504,33,13,2,2,2,6,4,9,9,2,2,null,3,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],["Sequence Number","Exertion around house","Times walked in past two weeks","Less vigor sessions last 2 weeks","Less vigor past 2 weeks","Time heavy physical exertion","Vigor Time past 2 weeks","Vigor Sessions in past 2 weeks","Vigorous exercise","Walking past 2 weeks","Health comp with 12mths ago","Health compared to others","Self-rated health","Age","Sex","Marital status","Age left school","Highest qualification","Are you retired from your last job?","Do you currently smoke cigarettes?","Frequency six or more drinks","Number of standard drinks","Frequency alcohol","Weight in kilograms","Do you regularly smoke pipe or cigar?","Currently working","Id","Age in 1994","Sex","Marital Status in 1994","Years of school completed","Working at present time?","Currently smoke?","Smoke, tobacco use","Alcohol use","Number of glasses of wine last week","Number of cans/bottles of beer last week","Number of drinks containing hard liquor last week","Participant sports, number of hours","Physical fitness, number of hours each week","Walking, number of hours per week","Spectator sports, number of hours spent per week","Dancing","Doing household chores (hrs/wk)","Exercising for shape/fun (hrs/wk)","Exercised or played sports (oc/wk)","Height in Inches","Weight in Pounds","Self-reported weight in pounds","Self-reported height in inches","Self-reported health compared to age peers","Twin number","What is your marital status?","Which of the following alternatives best describes your current work/retirement situation?","Do you smoke tobacco?","Do you take snuff?","Smoked some last month?","","","","","","","","","","","","","","","","","","Sex","Year born","Age at current wave","Education","id","Year born","Sex","Marital Status","Edcuation","Current job situation","Ever smoked tobacco daily for a year?","Smoke at present?","How many years smoked?","beverages consumed last 6 months","freq more than 2 glasses beer in a day","freq more than 2 glasses wine in a day","freq more than 2 hard liquor in a day","sports or activities that are vigorous","activities requiring a moderate level of energy","how tall are you?","weight of respondent","health in general question v 1","health in general question v 2","health in general question v 2","health in general question v 1","interview year","yeshiva, religious high institution","nursing school","polytechnic","university, Bachelors degree","university, graduate degree","still in further education or training","no further education","other further education","refused","dont know","Anonymised ID","","","","","","","","","","Ever smoked tobacco daily for a year?","Smoke at present?","Age when stopped smoking","Respondent is a smoker","","","","","","","","","","","","","","","","","","","","","","","","","",""],["Sequence Number","Exertion around house","Times walked in past two weeks","Less vigor sessions last 2 weeks","Less vigor past 2 weeks","Time heavy physical exertion","Vigor Time past 2 weeks","Vigor Sessions in past 2 weeks","Vigorous exercise","Walking past 2 weeks","Health comp with 12mths ago","Health compared to others","Self-rated health","Age","Sex","Marital status","Age left school","Highest qualification","Are you retired from your last job?","Do you currently smoke cigarettes?","Frequency six or more drinks","Number of standard drinks","Frequency alcohol","Weight in kilograms","Do you regularly smoke pipe or cigar?","Currently working",null,"Age in 1994","Sex","Marital Status in 1994","Number of Years of school completed (1-20)","Working at present time?","Currently smoke?","Smoke, tobacco use","Alcohol use","Number of glasses of wine last week","Number of cans/bottles of beer last week","Number of drinks containing hard liquor last week","Participant sports, number of hours","Physical fitness, number of hours each week","Walking, number of hours per week","Spectator sports, number of hours spent per week","Dancing","Doing household chores, number of hours spent per week","Number of total hours in an average week exercising for shape/fun (not housework)","Number of times in past week exercised or played sports","Height in Inches","Weight in Pounds","Self-reported weight in pounds","Self-reported height in inches","Self-reported health compared to age peers","Twin number","What is your marital status?","Which of the following alternatives best describes your current work/retirement situation?","Do you smoke cigarettes, cigars or a pipe? - Yes","Do you take snuff? - Yes","Have you smoked more than 6 cigarettes, 4 cigars or used pipe tobacco or snuff during the last month?","..more than 1 bottle, i.e.____bottles (state number of bottles): GBOTVIN","Do you ever drink alcoholic beverages?","Do you ever drink alcoholic drinks? - Yes","Do you ever drink alcoholic drinks? -No I quit. When? 19__","How much beer do you usually drink at a time?","How much hard liquot do you usually drink at time?","How much wine do you usually drink at a time?","How often do you consume more than five bottles of beer or more than one bottle of wine or more than 1/2 bottle liquot at one occasion?","How often do you drink beer (not light beer)?","How often do you usually drink hard liquor? (e.g. aquavit, whiskey, gin, brandy, punsch. Also liquot in cocktails and long drinks)","How often do you usually drink wine (red or white)?","Here are seven different options concerning exercise during your leisure time. Which one of these options best fits how you yourself exercise on a yearly basis?","How tall are you? (cm)","How much do you weigh? (kg)","How do you judge your general state of health compared to other people your age?","How do you judge your general state of health?","BMI ((htcm/100)^2)",null,null,"age at Q3","Education",null,"year of birth","male or female","marital status","highest educational degree obtained","current job situation","ever smoked daily","smoke at the present time","how many years smoked","beverages consumed last 6 months","freq more than 2 glasses beer in a day","freq more than 2 glasses wine in a day","freq more than 2 hard liquor in a day","sports or activities that are vigorous","activities requiring a moderate level of energy","how tall are you?","weight of respondent","health in general question v 1","health in general question v 2","health in general question v 2","health in general question v 1","interview year","yeshiva, religious high institution","nursing school","polytechnic","university, Bachelors degree","university, graduate degree","still in further education or training","no further education","other further education","refused","dont know","Anonymised ID","Age at interview assuming DOB is 1st of specified month","Gender","gd002 - Is this respondent male or female?","SOCmarried  Currently married","cs006  Are you...?","mar4  Marital Status","dm001  What is the highest level of education you have completed","we001  Which one of these would you say best describes your current situation?","we003  Did you, nevertheless, do any paid work during the last week, either as an em?","bh001  Have you ever smoked cigarettes, cigars, cigarillos or a pipe daily for a per?","bh002  Do you smoke at the present time?","bh003  How old were you when you stopped smoking?","BEHsmoker  Smoker","SCQalcohol  drink alcohol","SCQalcofreq  frequency of drinking alcohol","SCQalcono1  more than two drinks in a single day","SCQalcono2  How many drinks consumed on days drink taken","BEHalc_freq_week  Average times drinking per week","BEHalc_drinksperday  Standard drinks per day","BEHalc_drinksperweek  Standard drinks a week","bh101  During the last 7 days, on how many days did you do vigorous physical activit?","bh102  How much time did you usually spend doing vigorous physical activities on one?","bh102a  How much time did you usually spend doing vigorous physical activities on one?","bh103  During the last 7 days, on how many days did you do moderate physical activit?","bh104  How much time did you usually spend doing moderate physical activities on one?","bh104a  How much time did you usually spend doing moderate physical activities on one?","bh105  During the last 7 days, on how many days did you walk for at least 10 minutes?","bh106  How much time did you usually spend walking on one of those days? HOURS","bh106a  How much time did you usually spend walking on one of those days? MINS","bh107  During the last 7 days, how much time did you spend sitting on a week day? HO?","bh107a  During the last 7 days, how much time did you spend sitting on a week day? MINS","IPAQmetminutes  Phsyical activity met-minutes","IPAQmetminutes  Phsyical activity met-minutes","SR_Height_Centimetres","Respondent height","SR_Weight_Kilogrammes","Respondent weight","ph001  Now I would like to ask you some questions about your health.  Would you say ?","ph009  In general, compared to other people your age, would you say your health is"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th> \u003c/th>\n      <th>study_name\u003c/th>\n      <th>name\u003c/th>\n      <th>item\u003c/th>\n      <th>construct\u003c/th>\n      <th>type\u003c/th>\n      <th>categories\u003c/th>\n      <th>label_short\u003c/th>\n      <th>label\u003c/th>\n    \u003c/tr>\n  \u003c/thead>\n\u003c/table>","options":{"pageLength":6,"autoWidth":true,"columnDefs":[{"className":"dt-right","targets":6},{"orderable":false,"targets":0}],"order":[],"orderClasses":false,"orderCellsTop":true,"lengthMenu":[6,10,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

<!-- Tweak the datasets.   -->


<!-- Basic table view.   -->



## (I.B) Target-H

> Everybody wants to be somebody.

We query metadata set to retrieve all variables potentially tapping the construct `smoking`. These are the candidates to enter the DataSchema and contribute to  computing harmonized variables. 

***NOTE***: what is being retrieved depends on the manually entered values in the column `construct` of the metadata file `./data/shared/meta-data-map.csv`. To specify a different group of variables, edit the  metadata, not the script. 


```r
dto[["metaData"]] %>%
  dplyr::filter(construct %in% c('age')) %>% 
  dplyr::select(-url, -label, -notes) %>%
  dplyr::arrange(study_name, item) %>%
  base::print()  
```

```
  study_name   name         label_short          item construct type categories
1       alsa    AGE                 Age           age       age demo         38
2       lbsl  AGE94         Age in 1994      age_1994       age demo         65
3      satsa  QAGE3 Age at current wave        age_q3       age demo        879
4      satsa YRBORN           Year born     year_born       age demo         62
5      share DN0030           Year born     born_year       age demo         57
6      tilda    AGE                     age_interview       age demo         33
```

View [descriptives : smoking](/reports/harmonization-smoking/harmonization-smoking-basic-graphs.md) for closer examination of each candidate.  After reviewing  these descriptives and relevant codebooks, the following operationalization of the harmonized variables for `smoking` have been adopted:

#### (1) `smoke_now` :  **Are you a smoker presently?**  
  - `0` - NO - *healthy choice*  
  - `1` - YES - *unhealthy choice*     
  
#### (2) `smoked_ever` **Have you ever smoked?**  
  - `0` - NO - *healthy choice*  
  - `1` - YES - *unhealthy choice*  

These two variables will be manufactured by qualitative harmonization in the Development section. 
 
# (II) Development

In this section we will define the schema sets for harmonizing `smoking` construct (i.e.  specify which variables from which studies will be contributing to computing harmonized variables ). Each of these schema sets (e.g. `"alsa" = c("SMOKER", "PIPCIGAR")`) will have a particular pattern of possible response values to these variables(e.g. "id_1" = c("SMOKER"="YES", "PIPCIGAR"="NO")), which we will export for inspection as `.csv` tables. We then will manually edit these `.csv` tables, populating new columns that will map values of harmonized variables to the specific response pattern of the schema set variables. We then will import harmonization algorithms encoded in `.csv` tables and apply them to compute harmonized variables in the dataset combining raw and harmonized variables for `smoking` construct across studies.



```r
# s ="alsa"
dmls <- list()
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]]
  (varnames <- names(ds))
  (get_these_variables <- c("id","year_of_wave", "AGE","QAGE3","AGE94","YRBORN","DN0030"))
  (variables_present <- varnames %in% get_these_variables)
  dmls[[s]] <- ds[,variables_present]
}
# view the contents of the list object
lapply(dmls, names)
```

```
$alsa
[1] "id"           "AGE"          "year_of_wave"

$lbsl
[1] "id"           "AGE94"        "year_of_wave"

$satsa
[1] "id"           "YRBORN"       "QAGE3"        "year_of_wave"

$share
[1] "id"           "DN0030"       "year_of_wave"

$tilda
[1] "id"           "AGE"          "year_of_wave"
```

### ALSA

```r
# transform into harmonized variable
ds <- dmls[['alsa']]; head(ds)
```

```
   id AGE year_of_wave
1  41  86         1992
2  42  78         1992
3  61  89         1992
4  71  78         1992
5  91  85         1992
6 121  92         1992
```

```r
ds <- ds %>%
  dplyr::mutate(age_in_years = AGE, # direct transform
                   year_born = year_of_wave - age_in_years) %>% 
  dplyr::select(-AGE)
head(ds)
```

```
   id year_of_wave age_in_years year_born
1  41         1992           86      1906
2  42         1992           78      1914
3  61         1992           89      1903
4  71         1992           78      1914
5  91         1992           85      1907
6 121         1992           92      1900
```

```r
dmls[['alsa']] <- ds
```

### LBSL

```r
# transform into harmonized variable
ds <- dmls[['lbsl']]; head(ds)
```

```
       id AGE94 year_of_wave
1 4001026    68         1994
2 4012015    94         1994
3 4012032    94         1994
4 4022004    93         1994
5 4022026    93         1994
6 4031031    92         1994
```

```r
ds <- ds %>%
  dplyr::mutate(age_in_years = AGE94, # direct transform
                year_born = year_of_wave - age_in_years) %>% 
  dplyr::select(-AGE94)
head(ds)
```

```
       id year_of_wave age_in_years year_born
1 4001026         1994           68      1926
2 4012015         1994           94      1900
3 4012032         1994           94      1900
4 4022004         1994           93      1901
5 4022026         1994           93      1901
6 4031031         1994           92      1902
```

```r
dmls[['lbsl']] <- ds
```

### SATSA

```r
# transform into harmonized variable
ds <- dmls[['satsa']]; head(ds)
```

```
     id YRBORN    QAGE3 year_of_wave
1  2321     26 64.81331         1991
2  2322     26 64.81331         1991
3  2501     26 64.80330         1991
4  2502     26 64.80330         1991
5  2621     26 64.75332         1991
6 11301      0 90.20333         1991
```

```r
ds <- ds %>%
  dplyr::mutate(age_in_years = QAGE3, # direct transform; (??) should it be rounded (??)
                year_born = YRBORN +1900) %>%  
  dplyr::select(-QAGE3, - YRBORN )
head(ds)
```

```
     id year_of_wave age_in_years year_born
1  2321         1991     64.81331      1926
2  2322         1991     64.81331      1926
3  2501         1991     64.80330      1926
4  2502         1991     64.80330      1926
5  2621         1991     64.75332      1926
6 11301         1991     90.20333      1900
```

```r
dmls[['satsa']] <- ds
# Reconcile the difference between (YEAR_BORN) and (year_born)
```

### TILDA

```r
# transform into harmonized variable
ds <- dmls[['tilda']]; head(ds)
```

```
                  id AGE year_of_wave
1 1091                80         2009
2 1111                51         2009
3 1112                51         2009
4 1151                60         2009
5 1281                72         2009
6 1411                66         2009
```

```r
ds <- ds %>%
  dplyr::mutate(age_in_years = AGE, # direct transform
                year_born = year_of_wave - age_in_years) %>% 
  dplyr::select(-AGE)
head(ds)
```

```
                  id year_of_wave age_in_years year_born
1 1091                       2009           80      1929
2 1111                       2009           51      1958
3 1112                       2009           51      1958
4 1151                       2009           60      1949
5 1281                       2009           72      1937
6 1411                       2009           66      1943
```

```r
dmls[['tilda']] <- ds
# Reconcile the difference between (YEAR_BORN) and (year_born)
```

# III. Recapitulation

```r
ds <- plyr::ldply(dmls,data.frame,.id = "study_name")
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
head(ds)
```

```
  study_name id year_of_wave age_in_years year_born DN0030
1       alsa  1         1992           86      1906     NA
2       alsa  2         1992           78      1914     NA
3       alsa  3         1992           89      1903     NA
4       alsa  4         1992           78      1914     NA
5       alsa  5         1992           85      1907     NA
6       alsa  6         1992           92      1900     NA
```




