# Harmonize: alcohol

<!-- These two chunks should be added in the beginning of every .Rmd that you want to source an .R script -->
<!--  The 1st mandatory chunck  -->
<!--  Set the working directory to the repository's base directory -->


<!--  The 2nd mandatory chunck  -->
<!-- Set the report-wide options, and point to the external code file. -->


This report lists the candidate variable for DataScheme variables of the construct **alcohol**.

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
Source: local data frame [656 x 35]

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
  year_born (dbl), female (lgl), marital (chr), single (lgl), educ3 (chr), current_work_2 (lgl)
```


### Meta

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

<!--html_preserve--><div id="htmlwidget-618" style="width:100%;height:auto;" class="datatables"></div>
<script type="application/json" data-for="htmlwidget-618">{"x":{"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"],["alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda"],["SEQNUM","EXRTHOUS","HWMNWK2W","LSVEXC2W","LSVIGEXC","TMHVYEXR","TMVEXC2W","VIGEXC2W","VIGEXCS","WALK2WKS","BTSM12MN","HLTHBTSM","HLTHLIFE","AGE","SEX","MARITST","SCHOOL","TYPQUAL","RETIRED","SMOKER","FR6ORMOR","NOSTDRNK","FREQALCH","WEIGHT","PIPCIGAR","CURRWORK","ID","AGE94","SEX94","MSTAT94","EDUC94","NOWRK94","SMK94","SMOKE","ALCOHOL","WINE","BEER","HARDLIQ","SPORT94","FIT94","WALK94","SPEC94","DANCE94","CHORE94","EXCERTOT","EXCERWK","HEIGHT94","WEIGHT94","HWEIGHT","HHEIGHT","SRHEALTH","ID","GMARITAL","GAMTWORK","GEVRSMK","GEVRSNS","GSMOKNOW","GALCOHOL","GBEERX","GBOTVIN","GDRLOTS","GEVRALK","GFREQBER","GFREQLIQ","GFREQVIN","GLIQX","GSTOPALK","GVINX","GEXERCIS","GHTCM","GWTKG","GHLTHOTH","GGENHLTH","GPI","SEX","YRBORN","QAGE3","EDUC","SAMPID.rec","DN0030","GENDER","DN0140","DN0100","EP0050","BR0010","BR0020","BR0030","BR0100","BR0110","BR0120","BR0130","BR0150","BR0160","PH0130","PH0120","PH0020","PH0030","PH0520","PH0530","INT.YEAR","DN012D01","DN012D02","DN012D03","DN012D04","DN012D05","DN012D09","DN012DNO","DN012DOT","DN012DRF","DN012DDK","ID","AGE","SEX","GD002","SOCMARRIED","CS006","MAR_4","DM001","WE001","WE003","BH001","BH002","BH003","BEHSMOKER","BEHALC.DRINKSPERDAY","BEHALC.DRINKSPERWEEK","BEHALC.FREQ.WEEK","SCQALCOFREQ","SCQALCOHOL","SCQALCONO1","SCQALCONO2","BH101","BH102","BH102A","BH103","BH104","BH104A","BH105","BH106","BH106A","BH107","BH107A","IPAQMETMINUTES","IPAQEXERCISE3","SR.HEIGHT.CENTIMETRES","HEIGHT","SR.WEIGHT.KILOGRAMMES","WEIGHT","PH001","PH009"],["id","","","","","","","","","","health_12ago","health_others","healt_self","age","sex","marital","age_left_school","edu_hight","retired","smoke_now","","","","weight_kg","smoke_pipecigar","employed","id","age_1994","sex","marital","school_years","employed","smoke_now","smoke_history","","","","","","","","","","","","","height_in","weight_lb","weight_lb_sr","height_in_sr","","twin_id","marital","work_status","smoke_history","snuff_history","smoke_now","","","","","","","","","","","","","height_in","weight_kg","","","","sex","year_born","age_q3","edu","id","born_year","sex","marital","edu","current_job","smoke_history","smoke_now","smoke_years","","","","","","","","","","","","","","","","","","","","","","","","id","age_interview","sex","sex_gender","marital_2","marital_6","marital_4","edu_highest","work_status","work_extra","smoke_history","smoke_now","smoke_age","smoke_history2","","","","","","","","","","","","","","","","","","","","","","","","","",""],["id","physact","physact","physact","physact","physact","physact","physact","physact","physact","health","health","health","age","sex","marital","education","education","work_status","smoking","alcohol","alcohol","alcohol","physique","smoking","work_status","id","age","sex","marital","education","work_status","smoking","smoking","alcohol","alcohol","alcohol","alcohol","physact","physact","physact","physact","physact","physact","physact","physact","physique","physique","physique","physique","health","id","marital","work_status","smoking","smoking","smoking","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","physact","physique","physique","health","health","physique","sex","age","age","education","id","age","sex","marital","education","work_status","smoking","smoking","smoking","alcohol","alcohol","alcohol","alcohol","physact","physact","physique","physique","health","health","health","health","year","education","education","education","education","education","education","education","education","education","education","id","age","sex","sex","marital","marital","marital","education","work_status","work_status","smoking","smoking","smoking","smoking","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","physact","physact","physact","physact","physact","physact","physact","physact","physact","physact","physact","physact","physact","physique","physique","physique","physique","health","health"],["demo","activity","activity","activity","activity","activity","activity","activity","activity","activity","physical","physical","physical","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","physical","substance","demo","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","substance","substance","activity","activity","activity","activity","activity","activity","activity","activity","physical","physical","physical","physical","physical","demo","demo","demo","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","activity","physical","physical","physical","physical","physical","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","substance","substance","substance","activity","activity","physical","physical","physical","physical","physical","physical","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","physical","physical","physical","physical","physical","physical"],[2087,null,null,null,null,null,null,null,null,null,null,null,null,38,2,7,8,10,2,2,5,5,5,null,2,null,656,65,2,6,18,9,2,3,7,17,16,15,null,null,null,null,null,null,null,null,null,null,null,null,null,1498,5,11,3,3,2,2,7,4,8,3,9,9,9,8,32,6,null,null,null,null,null,null,2,62,879,4,2598,57,2,9,13,10,2,2,null,7,7,8,8,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,8504,33,2,2,2,6,4,4,9,9,2,2,null,3,35,120,7,7,2,7,19,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],["Sequence Number","Exertion around house","Times walked in past two weeks","Less vigor sessions last 2 weeks","Less vigor past 2 weeks","Time heavy physical exertion","Vigor Time past 2 weeks","Vigor Sessions in past 2 weeks","Vigorous exercise","Walking past 2 weeks","Health comp with 12mths ago","Health compared to others","Self-rated health","Age","Sex","Marital status","Age left school","Highest qualification","Are you retired from your last job?","Do you currently smoke cigarettes?","Frequency six or more drinks","Number of standard drinks","Frequency alcohol","Weight in kilograms","Do you regularly smoke pipe or cigar?","Currently working","Id","Age in 1994","Sex","Marital Status in 1994","Years of school completed","Working at present time?","Currently smoke?","Smoke, tobacco use","Alcohol use","Number of glasses of wine last week","Number of cans/bottles of beer last week","Number of drinks containing hard liquor last week","Participant sports, number of hours","Physical fitness, number of hours each week","Walking, number of hours per week","Spectator sports, number of hours spent per week","Dancing","Doing household chores (hrs/wk)","Exercising for shape/fun (hrs/wk)","Exercised or played sports (oc/wk)","Height in Inches","Weight in Pounds","Self-reported weight in pounds","Self-reported height in inches","Self-reported health compared to age peers","Twin number","What is your marital status?","Describe current work/retirement situation","Do you smoke tobacco?","Do you take snuff?","Smoked some last month?","Do you ever drink alcoholic beverages?","How much beer do you usually drink at a time?","…more than 1 bottle","How often more than 5 beers?","Do you ever drink alcoholic drinks? - Yes","How often do you drink beer (not light beer)?","How often do you usually drink hard liquor?","How often do you usually drink wine (red or white)?","How much hard liquot do you usually drink at time?","Do you ever drink alcoholic drinks? -No I quit. When? 19__","How much wine do you usually drink at a time?","What option best describes your exercise on a yearly basis?","","","Judge your health compared to others your age?","How do you judge your general state of health?","","Sex","Year born","Age at current wave","Education","id","Year born","Sex","Marital Status","Edcuation","Current job situation","Ever smoked tobacco daily for a year?","Smoke at present?","How many years smoked?","beverages consumed last 6 months","freq more than 2 glasses beer in a day","freq more than 2 glasses wine in a day","freq more than 2 hard liquor in a day","sports or activities that are vigorous","activities requiring a moderate level of energy","how tall are you?","weight of respondent","health in general question v 1","health in general question v 2","health in general question v 2","health in general question v 1","interview year","yeshiva, religious high institution","nursing school","polytechnic","university, Bachelors degree","university, graduate degree","still in further education or training","no further education","other further education","refused","dont know","Anonymised ID","","Gender","Male or Female?","","","","","Describe current job situation","Any paid work last week?","Ever smoked tobacco daily for a year?","Smoke at present?","Age when stopped smoking","Respondent is a smoker","Standard drinks per day","Standard drinks a week","Average times drinking per week","Frequency of drinking alcohol","Alcoholic drinks","More than 2 drinks/day","How many drinks consumed on days drink taken","During the last 7 days, on how many days did you do vigorous physical activit?","How much time did you usually spend doing vigorous physical activities on one?","How much time did you usually spend doing vigorous physical activities on one?","During the last 7 days, on how many days did you do moderate physical activit?","How much time did you usually spend doing moderate physical activities on one?","How much time did you usually spend doing moderate physical activities on one?","During the last 7 days, on how many days did you walk for at least 10 minutes?","How much time did you usually spend walking on one of those days? HOURS","How much time did you usually spend walking on one of those days? MINS","During the last 7 days, how much time did you spend sitting on a week day? HO?","During the last 7 days, how much time did you spend sitting on a week day? MINS","Physical activity met (minutes)","Physical activity met (minutes)","Height Centimetres","Respondent height","Weight Kilogrammes","Respondent weight","What about your health.  Would you say ?","Compared to others  your age,  your health is"],["Sequence Number","Exertion around house","Times walked in past two weeks","Less vigor sessions last 2 weeks","Less vigor past 2 weeks","Time heavy physical exertion","Vigor Time past 2 weeks","Vigor Sessions in past 2 weeks","Vigorous exercise","Walking past 2 weeks","Health comp with 12mths ago","Health compared to others","Self-rated health","Age","Sex","Marital status","Age left school","Highest qualification","Are you retired from your last job?","Do you currently smoke cigarettes?","Frequency six or more drinks","Number of standard drinks","Frequency alcohol","Weight in kilograms","Do you regularly smoke pipe or cigar?","Currently working",null,"Age in 1994","Sex","Marital Status in 1994","Number of Years of school completed (1-20)","Working at present time?","Currently smoke?","Smoke, tobacco use","Alcohol use","Number of glasses of wine last week","Number of cans/bottles of beer last week","Number of drinks containing hard liquor last week","Participant sports, number of hours","Physical fitness, number of hours each week","Walking, number of hours per week","Spectator sports, number of hours spent per week","Dancing","Doing household chores, number of hours spent per week","Number of total hours in an average week exercising for shape/fun (not housework)","Number of times in past week exercised or played sports","Height in Inches","Weight in Pounds","Self-reported weight in pounds","Self-reported height in inches","Self-reported health compared to age peers","Twin number","What is your marital status?","Which of the following alternatives best describes your current work/retirement situation?","Do you smoke cigarettes, cigars or a pipe? - Yes","Do you take snuff? - Yes","Have you smoked more than 6 cigarettes, 4 cigars or used pipe tobacco or snuff during the last month?","Do you ever drink alcoholic beverages?","How much beer do you usually drink at a time?","..more than 1 bottle, i.e.____bottles (state number of bottles): GBOTVIN","How often do you consume more than five bottles of beer or more than one bottle of wine or more than 1/2 bottle liquot at one occasion?","Do you ever drink alcoholic drinks? - Yes","How often do you drink beer (not light beer)?","How often do you usually drink hard liquor? (e.g. aquavit, whiskey, gin, brandy, punsch. Also liquot in cocktails and long drinks)","How often do you usually drink wine (red or white)?","How much hard liquot do you usually drink at time?","Do you ever drink alcoholic drinks? -No I quit. When? 19__","How much wine do you usually drink at a time?","Here are seven different options concerning exercise during your leisure time. Which one of these options best fits how you yourself exercise on a yearly basis?","How tall are you? (cm)","How much do you weigh? (kg)","How do you judge your general state of health compared to other people your age?","How do you judge your general state of health?","BMI ((htcm/100)^2)",null,null,"age at Q3","Education",null,"year of birth","male or female","marital status","highest educational degree obtained","current job situation","ever smoked daily","smoke at the present time","how many years smoked","beverages consumed last 6 months","freq more than 2 glasses beer in a day","freq more than 2 glasses wine in a day","freq more than 2 hard liquor in a day","sports or activities that are vigorous","activities requiring a moderate level of energy","how tall are you?","weight of respondent","health in general question v 1","health in general question v 2","health in general question v 2","health in general question v 1","interview year","yeshiva, religious high institution","nursing school","polytechnic","university, Bachelors degree","university, graduate degree","still in further education or training","no further education","other further education","refused","dont know","Anonymised ID","Age at interview assuming DOB is 1st of specified month","Gender","gd002 - Is this respondent male or female?","SOCmarried  Currently married","cs006  Are you...?","mar4  Marital Status","dm001  What is the highest level of education you have completed","Which one of these would you say best describes your current situation?","Did you, nevertheless, do any paid work during the last week, either as an em?","bh001  Have you ever smoked cigarettes, cigars, cigarillos or a pipe daily for a per?","bh002  Do you smoke at the present time?","bh003  How old were you when you stopped smoking?","BEHsmoker  Smoker","BEHalc_drinksperday  Standard drinks per day","BEHalc_drinksperweek  Standard drinks a week","BEHalc_freq_week  Average times drinking per week","SCQalcofreq  frequency of drinking alcohol","SCQalcohol  drink alcohol","SCQalcono1  more than two drinks in a single day","SCQalcono2  How many drinks consumed on days drink taken","bh101  During the last 7 days, on how many days did you do vigorous physical activit?","bh102  How much time did you usually spend doing vigorous physical activities on one?","bh102a  How much time did you usually spend doing vigorous physical activities on one?","bh103  During the last 7 days, on how many days did you do moderate physical activit?","bh104  How much time did you usually spend doing moderate physical activities on one?","bh104a  How much time did you usually spend doing moderate physical activities on one?","bh105  During the last 7 days, on how many days did you walk for at least 10 minutes?","bh106  How much time did you usually spend walking on one of those days? HOURS","bh106a  How much time did you usually spend walking on one of those days? MINS","bh107  During the last 7 days, how much time did you spend sitting on a week day? HO?","bh107a  During the last 7 days, how much time did you spend sitting on a week day? MINS","IPAQmetminutes  Phsyical activity met-minutes","IPAQmetminutes  Phsyical activity met-minutes","SR_Height_Centimetres","Respondent height","SR_Weight_Kilogrammes","Respondent weight","ph001  Now I would like to ask you some questions about your health.  Would you say ?","ph009  In general, compared to other people your age, would you say your health is"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th> </th>\n      <th>study_name</th>\n      <th>name</th>\n      <th>item</th>\n      <th>construct</th>\n      <th>type</th>\n      <th>categories</th>\n      <th>label_short</th>\n      <th>label</th>\n    </tr>\n  </thead>\n</table>","options":{"pageLength":6,"autoWidth":true,"columnDefs":[{"className":"dt-right","targets":6},{"orderable":false,"targets":0}],"order":[],"orderClasses":false,"orderCellsTop":true,"lengthMenu":[6,10,25,50,100]},"callback":null,"caption":"<caption>This is the primary metadata file. Edit at `./data/shared/meta-data-map.csv</caption>","filter":"top","filterHTML":"<tr>\n  <td></td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"alsa\">alsa</option>\n        <option value=\"lbsl\">lbsl</option>\n        <option value=\"satsa\">satsa</option>\n        <option value=\"share\">share</option>\n        <option value=\"tilda\">tilda</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"AGE\">AGE</option>\n        <option value=\"AGE94\">AGE94</option>\n        <option value=\"ALCOHOL\">ALCOHOL</option>\n        <option value=\"BEER\">BEER</option>\n        <option value=\"BEHALC.DRINKSPERDAY\">BEHALC.DRINKSPERDAY</option>\n        <option value=\"BEHALC.DRINKSPERWEEK\">BEHALC.DRINKSPERWEEK</option>\n        <option value=\"BEHALC.FREQ.WEEK\">BEHALC.FREQ.WEEK</option>\n        <option value=\"BEHSMOKER\">BEHSMOKER</option>\n        <option value=\"BH001\">BH001</option>\n        <option value=\"BH002\">BH002</option>\n        <option value=\"BH003\">BH003</option>\n        <option value=\"BH101\">BH101</option>\n        <option value=\"BH102\">BH102</option>\n        <option value=\"BH102A\">BH102A</option>\n        <option value=\"BH103\">BH103</option>\n        <option value=\"BH104\">BH104</option>\n        <option value=\"BH104A\">BH104A</option>\n        <option value=\"BH105\">BH105</option>\n        <option value=\"BH106\">BH106</option>\n        <option value=\"BH106A\">BH106A</option>\n        <option value=\"BH107\">BH107</option>\n        <option value=\"BH107A\">BH107A</option>\n        <option value=\"BR0010\">BR0010</option>\n        <option value=\"BR0020\">BR0020</option>\n        <option value=\"BR0030\">BR0030</option>\n        <option value=\"BR0100\">BR0100</option>\n        <option value=\"BR0110\">BR0110</option>\n        <option value=\"BR0120\">BR0120</option>\n        <option value=\"BR0130\">BR0130</option>\n        <option value=\"BR0150\">BR0150</option>\n        <option value=\"BR0160\">BR0160</option>\n        <option value=\"BTSM12MN\">BTSM12MN</option>\n        <option value=\"CHORE94\">CHORE94</option>\n        <option value=\"CS006\">CS006</option>\n        <option value=\"CURRWORK\">CURRWORK</option>\n        <option value=\"DANCE94\">DANCE94</option>\n        <option value=\"DM001\">DM001</option>\n        <option value=\"DN0030\">DN0030</option>\n        <option value=\"DN0100\">DN0100</option>\n        <option value=\"DN012D01\">DN012D01</option>\n        <option value=\"DN012D02\">DN012D02</option>\n        <option value=\"DN012D03\">DN012D03</option>\n        <option value=\"DN012D04\">DN012D04</option>\n        <option value=\"DN012D05\">DN012D05</option>\n        <option value=\"DN012D09\">DN012D09</option>\n        <option value=\"DN012DDK\">DN012DDK</option>\n        <option value=\"DN012DNO\">DN012DNO</option>\n        <option value=\"DN012DOT\">DN012DOT</option>\n        <option value=\"DN012DRF\">DN012DRF</option>\n        <option value=\"DN0140\">DN0140</option>\n        <option value=\"EDUC\">EDUC</option>\n        <option value=\"EDUC94\">EDUC94</option>\n        <option value=\"EP0050\">EP0050</option>\n        <option value=\"EXCERTOT\">EXCERTOT</option>\n        <option value=\"EXCERWK\">EXCERWK</option>\n        <option value=\"EXRTHOUS\">EXRTHOUS</option>\n        <option value=\"FIT94\">FIT94</option>\n        <option value=\"FR6ORMOR\">FR6ORMOR</option>\n        <option value=\"FREQALCH\">FREQALCH</option>\n        <option value=\"GALCOHOL\">GALCOHOL</option>\n        <option value=\"GAMTWORK\">GAMTWORK</option>\n        <option value=\"GBEERX\">GBEERX</option>\n        <option value=\"GBOTVIN\">GBOTVIN</option>\n        <option value=\"GD002\">GD002</option>\n        <option value=\"GDRLOTS\">GDRLOTS</option>\n        <option value=\"GENDER\">GENDER</option>\n        <option value=\"GEVRALK\">GEVRALK</option>\n        <option value=\"GEVRSMK\">GEVRSMK</option>\n        <option value=\"GEVRSNS\">GEVRSNS</option>\n        <option value=\"GEXERCIS\">GEXERCIS</option>\n        <option value=\"GFREQBER\">GFREQBER</option>\n        <option value=\"GFREQLIQ\">GFREQLIQ</option>\n        <option value=\"GFREQVIN\">GFREQVIN</option>\n        <option value=\"GGENHLTH\">GGENHLTH</option>\n        <option value=\"GHLTHOTH\">GHLTHOTH</option>\n        <option value=\"GHTCM\">GHTCM</option>\n        <option value=\"GLIQX\">GLIQX</option>\n        <option value=\"GMARITAL\">GMARITAL</option>\n        <option value=\"GPI\">GPI</option>\n        <option value=\"GSMOKNOW\">GSMOKNOW</option>\n        <option value=\"GSTOPALK\">GSTOPALK</option>\n        <option value=\"GVINX\">GVINX</option>\n        <option value=\"GWTKG\">GWTKG</option>\n        <option value=\"HARDLIQ\">HARDLIQ</option>\n        <option value=\"HEIGHT\">HEIGHT</option>\n        <option value=\"HEIGHT94\">HEIGHT94</option>\n        <option value=\"HHEIGHT\">HHEIGHT</option>\n        <option value=\"HLTHBTSM\">HLTHBTSM</option>\n        <option value=\"HLTHLIFE\">HLTHLIFE</option>\n        <option value=\"HWEIGHT\">HWEIGHT</option>\n        <option value=\"HWMNWK2W\">HWMNWK2W</option>\n        <option value=\"ID\">ID</option>\n        <option value=\"INT.YEAR\">INT.YEAR</option>\n        <option value=\"IPAQEXERCISE3\">IPAQEXERCISE3</option>\n        <option value=\"IPAQMETMINUTES\">IPAQMETMINUTES</option>\n        <option value=\"LSVEXC2W\">LSVEXC2W</option>\n        <option value=\"LSVIGEXC\">LSVIGEXC</option>\n        <option value=\"MAR_4\">MAR_4</option>\n        <option value=\"MARITST\">MARITST</option>\n        <option value=\"MSTAT94\">MSTAT94</option>\n        <option value=\"NOSTDRNK\">NOSTDRNK</option>\n        <option value=\"NOWRK94\">NOWRK94</option>\n        <option value=\"PH001\">PH001</option>\n        <option value=\"PH0020\">PH0020</option>\n        <option value=\"PH0030\">PH0030</option>\n        <option value=\"PH009\">PH009</option>\n        <option value=\"PH0120\">PH0120</option>\n        <option value=\"PH0130\">PH0130</option>\n        <option value=\"PH0520\">PH0520</option>\n        <option value=\"PH0530\">PH0530</option>\n        <option value=\"PIPCIGAR\">PIPCIGAR</option>\n        <option value=\"QAGE3\">QAGE3</option>\n        <option value=\"RETIRED\">RETIRED</option>\n        <option value=\"SAMPID.rec\">SAMPID.rec</option>\n        <option value=\"SCHOOL\">SCHOOL</option>\n        <option value=\"SCQALCOFREQ\">SCQALCOFREQ</option>\n        <option value=\"SCQALCOHOL\">SCQALCOHOL</option>\n        <option value=\"SCQALCONO1\">SCQALCONO1</option>\n        <option value=\"SCQALCONO2\">SCQALCONO2</option>\n        <option value=\"SEQNUM\">SEQNUM</option>\n        <option value=\"SEX\">SEX</option>\n        <option value=\"SEX94\">SEX94</option>\n        <option value=\"SMK94\">SMK94</option>\n        <option value=\"SMOKE\">SMOKE</option>\n        <option value=\"SMOKER\">SMOKER</option>\n        <option value=\"SOCMARRIED\">SOCMARRIED</option>\n        <option value=\"SPEC94\">SPEC94</option>\n        <option value=\"SPORT94\">SPORT94</option>\n        <option value=\"SR.HEIGHT.CENTIMETRES\">SR.HEIGHT.CENTIMETRES</option>\n        <option value=\"SR.WEIGHT.KILOGRAMMES\">SR.WEIGHT.KILOGRAMMES</option>\n        <option value=\"SRHEALTH\">SRHEALTH</option>\n        <option value=\"TMHVYEXR\">TMHVYEXR</option>\n        <option value=\"TMVEXC2W\">TMVEXC2W</option>\n        <option value=\"TYPQUAL\">TYPQUAL</option>\n        <option value=\"VIGEXC2W\">VIGEXC2W</option>\n        <option value=\"VIGEXCS\">VIGEXCS</option>\n        <option value=\"WALK2WKS\">WALK2WKS</option>\n        <option value=\"WALK94\">WALK94</option>\n        <option value=\"WE001\">WE001</option>\n        <option value=\"WE003\">WE003</option>\n        <option value=\"WEIGHT\">WEIGHT</option>\n        <option value=\"WEIGHT94\">WEIGHT94</option>\n        <option value=\"WINE\">WINE</option>\n        <option value=\"YRBORN\">YRBORN</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"\"></option>\n        <option value=\"age\">age</option>\n        <option value=\"age_1994\">age_1994</option>\n        <option value=\"age_interview\">age_interview</option>\n        <option value=\"age_left_school\">age_left_school</option>\n        <option value=\"age_q3\">age_q3</option>\n        <option value=\"born_year\">born_year</option>\n        <option value=\"current_job\">current_job</option>\n        <option value=\"edu\">edu</option>\n        <option value=\"edu_highest\">edu_highest</option>\n        <option value=\"edu_hight\">edu_hight</option>\n        <option value=\"employed\">employed</option>\n        <option value=\"healt_self\">healt_self</option>\n        <option value=\"health_12ago\">health_12ago</option>\n        <option value=\"health_others\">health_others</option>\n        <option value=\"height_in\">height_in</option>\n        <option value=\"height_in_sr\">height_in_sr</option>\n        <option value=\"id\">id</option>\n        <option value=\"marital\">marital</option>\n        <option value=\"marital_2\">marital_2</option>\n        <option value=\"marital_4\">marital_4</option>\n        <option value=\"marital_6\">marital_6</option>\n        <option value=\"retired\">retired</option>\n        <option value=\"school_years\">school_years</option>\n        <option value=\"sex\">sex</option>\n        <option value=\"sex_gender\">sex_gender</option>\n        <option value=\"smoke_age\">smoke_age</option>\n        <option value=\"smoke_history\">smoke_history</option>\n        <option value=\"smoke_history2\">smoke_history2</option>\n        <option value=\"smoke_now\">smoke_now</option>\n        <option value=\"smoke_pipecigar\">smoke_pipecigar</option>\n        <option value=\"smoke_years\">smoke_years</option>\n        <option value=\"snuff_history\">snuff_history</option>\n        <option value=\"twin_id\">twin_id</option>\n        <option value=\"weight_kg\">weight_kg</option>\n        <option value=\"weight_lb\">weight_lb</option>\n        <option value=\"weight_lb_sr\">weight_lb_sr</option>\n        <option value=\"work_extra\">work_extra</option>\n        <option value=\"work_status\">work_status</option>\n        <option value=\"year_born\">year_born</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"age\">age</option>\n        <option value=\"alcohol\">alcohol</option>\n        <option value=\"education\">education</option>\n        <option value=\"health\">health</option>\n        <option value=\"id\">id</option>\n        <option value=\"marital\">marital</option>\n        <option value=\"physact\">physact</option>\n        <option value=\"physique\">physique</option>\n        <option value=\"sex\">sex</option>\n        <option value=\"smoking\">smoking</option>\n        <option value=\"work_status\">work_status</option>\n        <option value=\"year\">year</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"activity\">activity</option>\n        <option value=\"demo\">demo</option>\n        <option value=\"physical\">physical</option>\n        <option value=\"substance\">substance</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"integer\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"2\" data-max=\"8504\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"\"></option>\n        <option value=\"…more than 1 bottle\">…more than 1 bottle</option>\n        <option value=\"activities requiring a moderate level of energy\">activities requiring a moderate level of energy</option>\n        <option value=\"Age\">Age</option>\n        <option value=\"Age at current wave\">Age at current wave</option>\n        <option value=\"Age in 1994\">Age in 1994</option>\n        <option value=\"Age left school\">Age left school</option>\n        <option value=\"Age when stopped smoking\">Age when stopped smoking</option>\n        <option value=\"Alcohol use\">Alcohol use</option>\n        <option value=\"Alcoholic drinks\">Alcoholic drinks</option>\n        <option value=\"Anonymised ID\">Anonymised ID</option>\n        <option value=\"Any paid work last week?\">Any paid work last week?</option>\n        <option value=\"Are you retired from your last job?\">Are you retired from your last job?</option>\n        <option value=\"Average times drinking per week\">Average times drinking per week</option>\n        <option value=\"beverages consumed last 6 months\">beverages consumed last 6 months</option>\n        <option value=\"Compared to others  your age,  your health is\">Compared to others  your age,  your health is</option>\n        <option value=\"Current job situation\">Current job situation</option>\n        <option value=\"Currently smoke?\">Currently smoke?</option>\n        <option value=\"Currently working\">Currently working</option>\n        <option value=\"Dancing\">Dancing</option>\n        <option value=\"Describe current job situation\">Describe current job situation</option>\n        <option value=\"Describe current work/retirement situation\">Describe current work/retirement situation</option>\n        <option value=\"Do you currently smoke cigarettes?\">Do you currently smoke cigarettes?</option>\n        <option value=\"Do you ever drink alcoholic beverages?\">Do you ever drink alcoholic beverages?</option>\n        <option value=\"Do you ever drink alcoholic drinks? - Yes\">Do you ever drink alcoholic drinks? - Yes</option>\n        <option value=\"Do you ever drink alcoholic drinks? -No I quit. When? 19__\">Do you ever drink alcoholic drinks? -No I quit. When? 19__</option>\n        <option value=\"Do you regularly smoke pipe or cigar?\">Do you regularly smoke pipe or cigar?</option>\n        <option value=\"Do you smoke tobacco?\">Do you smoke tobacco?</option>\n        <option value=\"Do you take snuff?\">Do you take snuff?</option>\n        <option value=\"Doing household chores (hrs/wk)\">Doing household chores (hrs/wk)</option>\n        <option value=\"dont know\">dont know</option>\n        <option value=\"During the last 7 days, how much time did you spend sitting on a week day? HO?\">During the last 7 days, how much time did you spend sitting on a week day? HO?</option>\n        <option value=\"During the last 7 days, how much time did you spend sitting on a week day? MINS\">During the last 7 days, how much time did you spend sitting on a week day? MINS</option>\n        <option value=\"During the last 7 days, on how many days did you do moderate physical activit?\">During the last 7 days, on how many days did you do moderate physical activit?</option>\n        <option value=\"During the last 7 days, on how many days did you do vigorous physical activit?\">During the last 7 days, on how many days did you do vigorous physical activit?</option>\n        <option value=\"During the last 7 days, on how many days did you walk for at least 10 minutes?\">During the last 7 days, on how many days did you walk for at least 10 minutes?</option>\n        <option value=\"Edcuation\">Edcuation</option>\n        <option value=\"Education\">Education</option>\n        <option value=\"Ever smoked tobacco daily for a year?\">Ever smoked tobacco daily for a year?</option>\n        <option value=\"Exercised or played sports (oc/wk)\">Exercised or played sports (oc/wk)</option>\n        <option value=\"Exercising for shape/fun (hrs/wk)\">Exercising for shape/fun (hrs/wk)</option>\n        <option value=\"Exertion around house\">Exertion around house</option>\n        <option value=\"freq more than 2 glasses beer in a day\">freq more than 2 glasses beer in a day</option>\n        <option value=\"freq more than 2 glasses wine in a day\">freq more than 2 glasses wine in a day</option>\n        <option value=\"freq more than 2 hard liquor in a day\">freq more than 2 hard liquor in a day</option>\n        <option value=\"Frequency alcohol\">Frequency alcohol</option>\n        <option value=\"Frequency of drinking alcohol\">Frequency of drinking alcohol</option>\n        <option value=\"Frequency six or more drinks\">Frequency six or more drinks</option>\n        <option value=\"Gender\">Gender</option>\n        <option value=\"Health comp with 12mths ago\">Health comp with 12mths ago</option>\n        <option value=\"Health compared to others\">Health compared to others</option>\n        <option value=\"health in general question v 1\">health in general question v 1</option>\n        <option value=\"health in general question v 2\">health in general question v 2</option>\n        <option value=\"Height Centimetres\">Height Centimetres</option>\n        <option value=\"Height in Inches\">Height in Inches</option>\n        <option value=\"Highest qualification\">Highest qualification</option>\n        <option value=\"How do you judge your general state of health?\">How do you judge your general state of health?</option>\n        <option value=\"How many drinks consumed on days drink taken\">How many drinks consumed on days drink taken</option>\n        <option value=\"How many years smoked?\">How many years smoked?</option>\n        <option value=\"How much beer do you usually drink at a time?\">How much beer do you usually drink at a time?</option>\n        <option value=\"How much hard liquot do you usually drink at time?\">How much hard liquot do you usually drink at time?</option>\n        <option value=\"How much time did you usually spend doing moderate physical activities on one?\">How much time did you usually spend doing moderate physical activities on one?</option>\n        <option value=\"How much time did you usually spend doing vigorous physical activities on one?\">How much time did you usually spend doing vigorous physical activities on one?</option>\n        <option value=\"How much time did you usually spend walking on one of those days? HOURS\">How much time did you usually spend walking on one of those days? HOURS</option>\n        <option value=\"How much time did you usually spend walking on one of those days? MINS\">How much time did you usually spend walking on one of those days? MINS</option>\n        <option value=\"How much wine do you usually drink at a time?\">How much wine do you usually drink at a time?</option>\n        <option value=\"How often do you drink beer (not light beer)?\">How often do you drink beer (not light beer)?</option>\n        <option value=\"How often do you usually drink hard liquor?\">How often do you usually drink hard liquor?</option>\n        <option value=\"How often do you usually drink wine (red or white)?\">How often do you usually drink wine (red or white)?</option>\n        <option value=\"How often more than 5 beers?\">How often more than 5 beers?</option>\n        <option value=\"how tall are you?\">how tall are you?</option>\n        <option value=\"id\">id</option>\n        <option value=\"Id\">Id</option>\n        <option value=\"interview year\">interview year</option>\n        <option value=\"Judge your health compared to others your age?\">Judge your health compared to others your age?</option>\n        <option value=\"Less vigor past 2 weeks\">Less vigor past 2 weeks</option>\n        <option value=\"Less vigor sessions last 2 weeks\">Less vigor sessions last 2 weeks</option>\n        <option value=\"Male or Female?\">Male or Female?</option>\n        <option value=\"Marital status\">Marital status</option>\n        <option value=\"Marital Status\">Marital Status</option>\n        <option value=\"Marital Status in 1994\">Marital Status in 1994</option>\n        <option value=\"More than 2 drinks/day\">More than 2 drinks/day</option>\n        <option value=\"no further education\">no further education</option>\n        <option value=\"Number of cans/bottles of beer last week\">Number of cans/bottles of beer last week</option>\n        <option value=\"Number of drinks containing hard liquor last week\">Number of drinks containing hard liquor last week</option>\n        <option value=\"Number of glasses of wine last week\">Number of glasses of wine last week</option>\n        <option value=\"Number of standard drinks\">Number of standard drinks</option>\n        <option value=\"nursing school\">nursing school</option>\n        <option value=\"other further education\">other further education</option>\n        <option value=\"Participant sports, number of hours\">Participant sports, number of hours</option>\n        <option value=\"Physical activity met (minutes)\">Physical activity met (minutes)</option>\n        <option value=\"Physical fitness, number of hours each week\">Physical fitness, number of hours each week</option>\n        <option value=\"polytechnic\">polytechnic</option>\n        <option value=\"refused\">refused</option>\n        <option value=\"Respondent height\">Respondent height</option>\n        <option value=\"Respondent is a smoker\">Respondent is a smoker</option>\n        <option value=\"Respondent weight\">Respondent weight</option>\n        <option value=\"Self-rated health\">Self-rated health</option>\n        <option value=\"Self-reported health compared to age peers\">Self-reported health compared to age peers</option>\n        <option value=\"Self-reported height in inches\">Self-reported height in inches</option>\n        <option value=\"Self-reported weight in pounds\">Self-reported weight in pounds</option>\n        <option value=\"Sequence Number\">Sequence Number</option>\n        <option value=\"Sex\">Sex</option>\n        <option value=\"Smoke at present?\">Smoke at present?</option>\n        <option value=\"Smoke, tobacco use\">Smoke, tobacco use</option>\n        <option value=\"Smoked some last month?\">Smoked some last month?</option>\n        <option value=\"Spectator sports, number of hours spent per week\">Spectator sports, number of hours spent per week</option>\n        <option value=\"sports or activities that are vigorous\">sports or activities that are vigorous</option>\n        <option value=\"Standard drinks a week\">Standard drinks a week</option>\n        <option value=\"Standard drinks per day\">Standard drinks per day</option>\n        <option value=\"still in further education or training\">still in further education or training</option>\n        <option value=\"Time heavy physical exertion\">Time heavy physical exertion</option>\n        <option value=\"Times walked in past two weeks\">Times walked in past two weeks</option>\n        <option value=\"Twin number\">Twin number</option>\n        <option value=\"university, Bachelors degree\">university, Bachelors degree</option>\n        <option value=\"university, graduate degree\">university, graduate degree</option>\n        <option value=\"Vigor Sessions in past 2 weeks\">Vigor Sessions in past 2 weeks</option>\n        <option value=\"Vigor Time past 2 weeks\">Vigor Time past 2 weeks</option>\n        <option value=\"Vigorous exercise\">Vigorous exercise</option>\n        <option value=\"Walking past 2 weeks\">Walking past 2 weeks</option>\n        <option value=\"Walking, number of hours per week\">Walking, number of hours per week</option>\n        <option value=\"Weight in kilograms\">Weight in kilograms</option>\n        <option value=\"Weight in Pounds\">Weight in Pounds</option>\n        <option value=\"Weight Kilogrammes\">Weight Kilogrammes</option>\n        <option value=\"weight of respondent\">weight of respondent</option>\n        <option value=\"What about your health.  Would you say ?\">What about your health.  Would you say ?</option>\n        <option value=\"What is your marital status?\">What is your marital status?</option>\n        <option value=\"What option best describes your exercise on a yearly basis?\">What option best describes your exercise on a yearly basis?</option>\n        <option value=\"Working at present time?\">Working at present time?</option>\n        <option value=\"Year born\">Year born</option>\n        <option value=\"Years of school completed\">Years of school completed</option>\n        <option value=\"yeshiva, religious high institution\">yeshiva, religious high institution</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"..more than 1 bottle, i.e.____bottles (state number of bottles): GBOTVIN\">..more than 1 bottle, i.e.____bottles (state number of bottles): GBOTVIN</option>\n        <option value=\"activities requiring a moderate level of energy\">activities requiring a moderate level of energy</option>\n        <option value=\"Age\">Age</option>\n        <option value=\"Age at interview assuming DOB is 1st of specified month\">Age at interview assuming DOB is 1st of specified month</option>\n        <option value=\"age at Q3\">age at Q3</option>\n        <option value=\"Age in 1994\">Age in 1994</option>\n        <option value=\"Age left school\">Age left school</option>\n        <option value=\"Alcohol use\">Alcohol use</option>\n        <option value=\"Anonymised ID\">Anonymised ID</option>\n        <option value=\"Are you retired from your last job?\">Are you retired from your last job?</option>\n        <option value=\"BEHalc_drinksperday  Standard drinks per day\">BEHalc_drinksperday  Standard drinks per day</option>\n        <option value=\"BEHalc_drinksperweek  Standard drinks a week\">BEHalc_drinksperweek  Standard drinks a week</option>\n        <option value=\"BEHalc_freq_week  Average times drinking per week\">BEHalc_freq_week  Average times drinking per week</option>\n        <option value=\"BEHsmoker  Smoker\">BEHsmoker  Smoker</option>\n        <option value=\"beverages consumed last 6 months\">beverages consumed last 6 months</option>\n        <option value=\"bh001  Have you ever smoked cigarettes, cigars, cigarillos or a pipe daily for a per?\">bh001  Have you ever smoked cigarettes, cigars, cigarillos or a pipe daily for a per?</option>\n        <option value=\"bh002  Do you smoke at the present time?\">bh002  Do you smoke at the present time?</option>\n        <option value=\"bh003  How old were you when you stopped smoking?\">bh003  How old were you when you stopped smoking?</option>\n        <option value=\"bh101  During the last 7 days, on how many days did you do vigorous physical activit?\">bh101  During the last 7 days, on how many days did you do vigorous physical activit?</option>\n        <option value=\"bh102  How much time did you usually spend doing vigorous physical activities on one?\">bh102  How much time did you usually spend doing vigorous physical activities on one?</option>\n        <option value=\"bh102a  How much time did you usually spend doing vigorous physical activities on one?\">bh102a  How much time did you usually spend doing vigorous physical activities on one?</option>\n        <option value=\"bh103  During the last 7 days, on how many days did you do moderate physical activit?\">bh103  During the last 7 days, on how many days did you do moderate physical activit?</option>\n        <option value=\"bh104  How much time did you usually spend doing moderate physical activities on one?\">bh104  How much time did you usually spend doing moderate physical activities on one?</option>\n        <option value=\"bh104a  How much time did you usually spend doing moderate physical activities on one?\">bh104a  How much time did you usually spend doing moderate physical activities on one?</option>\n        <option value=\"bh105  During the last 7 days, on how many days did you walk for at least 10 minutes?\">bh105  During the last 7 days, on how many days did you walk for at least 10 minutes?</option>\n        <option value=\"bh106  How much time did you usually spend walking on one of those days? HOURS\">bh106  How much time did you usually spend walking on one of those days? HOURS</option>\n        <option value=\"bh106a  How much time did you usually spend walking on one of those days? MINS\">bh106a  How much time did you usually spend walking on one of those days? MINS</option>\n        <option value=\"bh107  During the last 7 days, how much time did you spend sitting on a week day? HO?\">bh107  During the last 7 days, how much time did you spend sitting on a week day? HO?</option>\n        <option value=\"bh107a  During the last 7 days, how much time did you spend sitting on a week day? MINS\">bh107a  During the last 7 days, how much time did you spend sitting on a week day? MINS</option>\n        <option value=\"BMI ((htcm/100)^2)\">BMI ((htcm/100)^2)</option>\n        <option value=\"cs006  Are you...?\">cs006  Are you...?</option>\n        <option value=\"current job situation\">current job situation</option>\n        <option value=\"Currently smoke?\">Currently smoke?</option>\n        <option value=\"Currently working\">Currently working</option>\n        <option value=\"Dancing\">Dancing</option>\n        <option value=\"Did you, nevertheless, do any paid work during the last week, either as an em?\">Did you, nevertheless, do any paid work during the last week, either as an em?</option>\n        <option value=\"dm001  What is the highest level of education you have completed\">dm001  What is the highest level of education you have completed</option>\n        <option value=\"Do you currently smoke cigarettes?\">Do you currently smoke cigarettes?</option>\n        <option value=\"Do you ever drink alcoholic beverages?\">Do you ever drink alcoholic beverages?</option>\n        <option value=\"Do you ever drink alcoholic drinks? - Yes\">Do you ever drink alcoholic drinks? - Yes</option>\n        <option value=\"Do you ever drink alcoholic drinks? -No I quit. When? 19__\">Do you ever drink alcoholic drinks? -No I quit. When? 19__</option>\n        <option value=\"Do you regularly smoke pipe or cigar?\">Do you regularly smoke pipe or cigar?</option>\n        <option value=\"Do you smoke cigarettes, cigars or a pipe? - Yes\">Do you smoke cigarettes, cigars or a pipe? - Yes</option>\n        <option value=\"Do you take snuff? - Yes\">Do you take snuff? - Yes</option>\n        <option value=\"Doing household chores, number of hours spent per week\">Doing household chores, number of hours spent per week</option>\n        <option value=\"dont know\">dont know</option>\n        <option value=\"Education\">Education</option>\n        <option value=\"ever smoked daily\">ever smoked daily</option>\n        <option value=\"Exertion around house\">Exertion around house</option>\n        <option value=\"freq more than 2 glasses beer in a day\">freq more than 2 glasses beer in a day</option>\n        <option value=\"freq more than 2 glasses wine in a day\">freq more than 2 glasses wine in a day</option>\n        <option value=\"freq more than 2 hard liquor in a day\">freq more than 2 hard liquor in a day</option>\n        <option value=\"Frequency alcohol\">Frequency alcohol</option>\n        <option value=\"Frequency six or more drinks\">Frequency six or more drinks</option>\n        <option value=\"gd002 - Is this respondent male or female?\">gd002 - Is this respondent male or female?</option>\n        <option value=\"Gender\">Gender</option>\n        <option value=\"Have you smoked more than 6 cigarettes, 4 cigars or used pipe tobacco or snuff during the last month?\">Have you smoked more than 6 cigarettes, 4 cigars or used pipe tobacco or snuff during the last month?</option>\n        <option value=\"Health comp with 12mths ago\">Health comp with 12mths ago</option>\n        <option value=\"Health compared to others\">Health compared to others</option>\n        <option value=\"health in general question v 1\">health in general question v 1</option>\n        <option value=\"health in general question v 2\">health in general question v 2</option>\n        <option value=\"Height in Inches\">Height in Inches</option>\n        <option value=\"Here are seven different options concerning exercise during your leisure time. Which one of these options best fits how you yourself exercise on a yearly basis?\">Here are seven different options concerning exercise during your leisure time. Which one of these options best fits how you yourself exercise on a yearly basis?</option>\n        <option value=\"highest educational degree obtained\">highest educational degree obtained</option>\n        <option value=\"Highest qualification\">Highest qualification</option>\n        <option value=\"How do you judge your general state of health compared to other people your age?\">How do you judge your general state of health compared to other people your age?</option>\n        <option value=\"How do you judge your general state of health?\">How do you judge your general state of health?</option>\n        <option value=\"how many years smoked\">how many years smoked</option>\n        <option value=\"How much beer do you usually drink at a time?\">How much beer do you usually drink at a time?</option>\n        <option value=\"How much do you weigh? (kg)\">How much do you weigh? (kg)</option>\n        <option value=\"How much hard liquot do you usually drink at time?\">How much hard liquot do you usually drink at time?</option>\n        <option value=\"How much wine do you usually drink at a time?\">How much wine do you usually drink at a time?</option>\n        <option value=\"How often do you consume more than five bottles of beer or more than one bottle of wine or more than 1/2 bottle liquot at one occasion?\">How often do you consume more than five bottles of beer or more than one bottle of wine or more than 1/2 bottle liquot at one occasion?</option>\n        <option value=\"How often do you drink beer (not light beer)?\">How often do you drink beer (not light beer)?</option>\n        <option value=\"How often do you usually drink hard liquor? (e.g. aquavit, whiskey, gin, brandy, punsch. Also liquot in cocktails and long drinks)\">How often do you usually drink hard liquor? (e.g. aquavit, whiskey, gin, brandy, punsch. Also liquot in cocktails and long drinks)</option>\n        <option value=\"How often do you usually drink wine (red or white)?\">How often do you usually drink wine (red or white)?</option>\n        <option value=\"how tall are you?\">how tall are you?</option>\n        <option value=\"How tall are you? (cm)\">How tall are you? (cm)</option>\n        <option value=\"interview year\">interview year</option>\n        <option value=\"IPAQmetminutes  Phsyical activity met-minutes\">IPAQmetminutes  Phsyical activity met-minutes</option>\n        <option value=\"Less vigor past 2 weeks\">Less vigor past 2 weeks</option>\n        <option value=\"Less vigor sessions last 2 weeks\">Less vigor sessions last 2 weeks</option>\n        <option value=\"male or female\">male or female</option>\n        <option value=\"mar4  Marital Status\">mar4  Marital Status</option>\n        <option value=\"marital status\">marital status</option>\n        <option value=\"Marital status\">Marital status</option>\n        <option value=\"Marital Status in 1994\">Marital Status in 1994</option>\n        <option value=\"no further education\">no further education</option>\n        <option value=\"Number of cans/bottles of beer last week\">Number of cans/bottles of beer last week</option>\n        <option value=\"Number of drinks containing hard liquor last week\">Number of drinks containing hard liquor last week</option>\n        <option value=\"Number of glasses of wine last week\">Number of glasses of wine last week</option>\n        <option value=\"Number of standard drinks\">Number of standard drinks</option>\n        <option value=\"Number of times in past week exercised or played sports\">Number of times in past week exercised or played sports</option>\n        <option value=\"Number of total hours in an average week exercising for shape/fun (not housework)\">Number of total hours in an average week exercising for shape/fun (not housework)</option>\n        <option value=\"Number of Years of school completed (1-20)\">Number of Years of school completed (1-20)</option>\n        <option value=\"nursing school\">nursing school</option>\n        <option value=\"other further education\">other further education</option>\n        <option value=\"Participant sports, number of hours\">Participant sports, number of hours</option>\n        <option value=\"ph001  Now I would like to ask you some questions about your health.  Would you say ?\">ph001  Now I would like to ask you some questions about your health.  Would you say ?</option>\n        <option value=\"ph009  In general, compared to other people your age, would you say your health is\">ph009  In general, compared to other people your age, would you say your health is</option>\n        <option value=\"Physical fitness, number of hours each week\">Physical fitness, number of hours each week</option>\n        <option value=\"polytechnic\">polytechnic</option>\n        <option value=\"refused\">refused</option>\n        <option value=\"Respondent height\">Respondent height</option>\n        <option value=\"Respondent weight\">Respondent weight</option>\n        <option value=\"SCQalcofreq  frequency of drinking alcohol\">SCQalcofreq  frequency of drinking alcohol</option>\n        <option value=\"SCQalcohol  drink alcohol\">SCQalcohol  drink alcohol</option>\n        <option value=\"SCQalcono1  more than two drinks in a single day\">SCQalcono1  more than two drinks in a single day</option>\n        <option value=\"SCQalcono2  How many drinks consumed on days drink taken\">SCQalcono2  How many drinks consumed on days drink taken</option>\n        <option value=\"Self-rated health\">Self-rated health</option>\n        <option value=\"Self-reported health compared to age peers\">Self-reported health compared to age peers</option>\n        <option value=\"Self-reported height in inches\">Self-reported height in inches</option>\n        <option value=\"Self-reported weight in pounds\">Self-reported weight in pounds</option>\n        <option value=\"Sequence Number\">Sequence Number</option>\n        <option value=\"Sex\">Sex</option>\n        <option value=\"smoke at the present time\">smoke at the present time</option>\n        <option value=\"Smoke, tobacco use\">Smoke, tobacco use</option>\n        <option value=\"SOCmarried  Currently married\">SOCmarried  Currently married</option>\n        <option value=\"Spectator sports, number of hours spent per week\">Spectator sports, number of hours spent per week</option>\n        <option value=\"sports or activities that are vigorous\">sports or activities that are vigorous</option>\n        <option value=\"SR_Height_Centimetres\">SR_Height_Centimetres</option>\n        <option value=\"SR_Weight_Kilogrammes\">SR_Weight_Kilogrammes</option>\n        <option value=\"still in further education or training\">still in further education or training</option>\n        <option value=\"Time heavy physical exertion\">Time heavy physical exertion</option>\n        <option value=\"Times walked in past two weeks\">Times walked in past two weeks</option>\n        <option value=\"Twin number\">Twin number</option>\n        <option value=\"university, Bachelors degree\">university, Bachelors degree</option>\n        <option value=\"university, graduate degree\">university, graduate degree</option>\n        <option value=\"Vigor Sessions in past 2 weeks\">Vigor Sessions in past 2 weeks</option>\n        <option value=\"Vigor Time past 2 weeks\">Vigor Time past 2 weeks</option>\n        <option value=\"Vigorous exercise\">Vigorous exercise</option>\n        <option value=\"Walking past 2 weeks\">Walking past 2 weeks</option>\n        <option value=\"Walking, number of hours per week\">Walking, number of hours per week</option>\n        <option value=\"Weight in kilograms\">Weight in kilograms</option>\n        <option value=\"Weight in Pounds\">Weight in Pounds</option>\n        <option value=\"weight of respondent\">weight of respondent</option>\n        <option value=\"What is your marital status?\">What is your marital status?</option>\n        <option value=\"Which of the following alternatives best describes your current work/retirement situation?\">Which of the following alternatives best describes your current work/retirement situation?</option>\n        <option value=\"Which one of these would you say best describes your current situation?\">Which one of these would you say best describes your current situation?</option>\n        <option value=\"Working at present time?\">Working at present time?</option>\n        <option value=\"year of birth\">year of birth</option>\n        <option value=\"yeshiva, religious high institution\">yeshiva, religious high institution</option>\n      </select>\n    </div>\n  </td>\n</tr>"},"evals":[]}</script><!--/html_preserve-->

<!-- Tweak the datasets.   -->


<!-- Basic table view.   -->



## (I.B) Target-H

> Everybody wants to be somebody.

We query metadata set to retrieve all variables potentially tapping the construct `alcohol`. These are the candidates to enter the DataSchema and contribute to  computing harmonized variables. 

***NOTE***: what is being retrieved depends on the manually entered values in the column `construct` of the metadata file `./data/shared/meta-data-map.csv`. To specify a different group of variables, edit the  metadata, not the script. 


```r
meta_data <- dto[["metaData"]] %>%
  dplyr::filter(construct %in% c('alcohol')) %>% 
  dplyr::select(study_name, name, construct, label_short, categories, url) %>%
  dplyr::arrange(construct, study_name)
knitr::kable(meta_data)
```



study_name   name                   construct   label_short                                                   categories  url 
-----------  ---------------------  ----------  -----------------------------------------------------------  -----------  ----
alsa         FR6ORMOR               alcohol     Frequency six or more drinks                                           5      
alsa         NOSTDRNK               alcohol     Number of standard drinks                                              5      
alsa         FREQALCH               alcohol     Frequency alcohol                                                      5      
lbsl         ALCOHOL                alcohol     Alcohol use                                                            7      
lbsl         WINE                   alcohol     Number of glasses of wine last week                                   17      
lbsl         BEER                   alcohol     Number of cans/bottles of beer last week                              16      
lbsl         HARDLIQ                alcohol     Number of drinks containing hard liquor last week                     15      
satsa        GALCOHOL               alcohol     Do you ever drink alcoholic beverages?                                 2      
satsa        GBEERX                 alcohol     How much beer do you usually drink at a time?                          7      
satsa        GBOTVIN                alcohol     …more than 1 bottle                                                    4      
satsa        GDRLOTS                alcohol     How often more than 5 beers?                                           8      
satsa        GEVRALK                alcohol     Do you ever drink alcoholic drinks? - Yes                              3      
satsa        GFREQBER               alcohol     How often do you drink beer (not light beer)?                          9      
satsa        GFREQLIQ               alcohol     How often do you usually drink hard liquor?                            9      
satsa        GFREQVIN               alcohol     How often do you usually drink wine (red or white)?                    9      
satsa        GLIQX                  alcohol     How much hard liquot do you usually drink at time?                     8      
satsa        GSTOPALK               alcohol     Do you ever drink alcoholic drinks? -No I quit. When? 19__            32      
satsa        GVINX                  alcohol     How much wine do you usually drink at a time?                          6      
share        BR0100                 alcohol     beverages consumed last 6 months                                       7      
share        BR0110                 alcohol     freq more than 2 glasses beer in a day                                 7      
share        BR0120                 alcohol     freq more than 2 glasses wine in a day                                 8      
share        BR0130                 alcohol     freq more than 2 hard liquor in a day                                  8      
tilda        BEHALC.DRINKSPERDAY    alcohol     Standard drinks per day                                               35      
tilda        BEHALC.DRINKSPERWEEK   alcohol     Standard drinks a week                                               120      
tilda        BEHALC.FREQ.WEEK       alcohol     Average times drinking per week                                        7      
tilda        SCQALCOFREQ            alcohol     Frequency of drinking alcohol                                          7      
tilda        SCQALCOHOL             alcohol     Alcoholic drinks                                                       2      
tilda        SCQALCONO1             alcohol     More than 2 drinks/day                                                 7      
tilda        SCQALCONO2             alcohol     How many drinks consumed on days drink taken                          19      

View [descriptives : alcohol](https://rawgit.com/IALSA/ialsa-2016-groningen-public/master/describe-alcohol.html) for closer examination of each candidate. 

After reviewing descriptives and relevant codebooks, the following operationalization of the harmonized variables for `alcohol` have been adopted:


#### Target: `current_drink`   
  - `0` - `FALSE` *healthy choice* - REFERENCE group
  - `1` - `TRUE` *risk factor*  

  

These variables will be generated next, in the Development section. 

# (II) Development

The particulare goal of this section is to ensure that the schema to encode the values for the `alcohol` variable is consisten across studies. 

In this section we will define the schema sets for harmonizing `alcohol` construct (i.e.  specify which variables from which studies will be contributing to computing harmonized variables ). Each of these schema sets will have a particular pattern of possible response values to these variables, which we will export for inspection as `.csv` tables. We then will manually edit these `.csv` tables, populating new columns that will map values of harmonized variables to the specific response pattern of the schema set variables. We then will import harmonization algorithms encoded in `.csv` tables and apply them to compute harmonized variables in the dataset combining raw and harmonized variables for `alcohol` construct across studies.

## (II.A) 


### (1) Schema sets
Having all potential variables in categorical format we have defined the sets of data schema variables thus: 

```r
schema_sets <- list(
  "alsa" = c("FREQALCH","NOSTDRNK","FR6ORMOR"),
  "lbsl" = c("ALCOHOL", "BEER","HARDLIQ","WINE"),
  "satsa" =  c("GALCOHOL","GEVRALK","GBEERX","GLIQX","GVINX" ),
  "share" = c("BR0100","BR0110", "BR0120","BR0130"), 
  "tilda" = c("SCQALCOHOL","BEHALC.DRINKSPERDAY","BEHALC.DRINKSPERWEEK") 
)
```
Each of these schema sets  have a particular pattern of possible response values, for example:


```r
# view the profile of responses
dto[["unitData"]][["alsa"]] %>% 
  dplyr::group_by_("FREQALCH","NOSTDRNK","FR6ORMOR") %>% 
  dplyr::summarize(count = n()) 
```

```
Source: local data frame [51 x 4]
Groups: FREQALCH, NOSTDRNK [?]

                    FREQALCH      NOSTDRNK          FR6ORMOR count
                      (fctr)        (fctr)            (fctr) (int)
1                      Never            NA                NA   774
2            Monthly or less    One or two             Never   337
3            Monthly or less    One or two Less than monthly     6
4            Monthly or less Three or four             Never    18
5            Monthly or less Three or four Less than monthly     3
6            Monthly or less   Five or six Less than monthly     2
7            Monthly or less Seven to nine Less than monthly     1
8            Monthly or less            NA                NA     1
9  Two to four times a month    One or two             Never   132
10 Two to four times a month    One or two Less than monthly     4
..                       ...           ...               ...   ...
```
We output these tables into self-standing `.csv` files, so we can manually provide the logic of computing harmonized variables.


```r
# define function to extract profiles
response_profile <- function(dto, h_target, study, varnames_values){
  ds <- dto[["unitData"]][[study]]
  varnames_values <- lapply(varnames_values, as.symbol)   # Convert character vector to list of symbols
  d <- ds %>% 
    dplyr::group_by_(.dots=varnames_values) %>% 
    dplyr::summarize(count = n()) 
  write.csv(d,paste0("./data/meta/response-profiles-live/",h_target,"-",study,".csv"))
}
# extract response profile for data schema set from each study
for(s in names(schema_sets)){
  response_profile(dto,
                   study = s,
                   h_target = 'alcohol',
                   varnames_values = schema_sets[[s]]
  )
}
```

You can examine them in [`./data/meta/response-profiles-live/](https://github.com/IALSA/ialsa-2016-groningen/tree/master/data/meta/response-profiles-live)

## (II.B) `current_drink`

#### Target (1) : `current_drink`   
  - `0` - `FALSE` *healthy choice* 
  - `1` - `TRUE` *risk factor*  

### ALSA

Items that can contribute to generating values for the harmonized variable `alcohol`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name=="alsa", construct %in% c("alcohol")) %>%
  dplyr::select(study_name, name, label,categories)
```

```
  study_name     name                        label categories
1       alsa FR6ORMOR Frequency six or more drinks          5
2       alsa NOSTDRNK    Number of standard drinks          5
3       alsa FREQALCH            Frequency alcohol          5
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "alsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-alcohol-alsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("FREQALCH", "NOSTDRNK", "FR6ORMOR"), 
  harmony_name = "current_drink"
)
```

```
Source: local data frame [51 x 5]
Groups: FREQALCH, NOSTDRNK, FR6ORMOR [?]

                    FREQALCH      NOSTDRNK              FR6ORMOR current_drink     n
                       (chr)         (chr)                 (chr)         (lgl) (int)
1  Four or more times a week   Five or six Daily or almost daily          TRUE    12
2  Four or more times a week   Five or six     Less than monthly          TRUE     2
3  Four or more times a week   Five or six               Monthly          TRUE     5
4  Four or more times a week   Five or six                 Never          TRUE     6
5  Four or more times a week   Five or six                Weekly          TRUE     6
6  Four or more times a week    One or two     Less than monthly          TRUE    49
7  Four or more times a week    One or two               Monthly          TRUE     7
8  Four or more times a week    One or two                 Never          TRUE   324
9  Four or more times a week    One or two                Weekly          TRUE     3
10 Four or more times a week Seven to nine Daily or almost daily          TRUE     8
11 Four or more times a week Seven to nine               Monthly          TRUE     2
12 Four or more times a week Seven to nine                 Never          TRUE     1
13 Four or more times a week   Ten or more Daily or almost daily          TRUE     1
14 Four or more times a week Three or four Daily or almost daily          TRUE     1
15 Four or more times a week Three or four     Less than monthly          TRUE    35
16 Four or more times a week Three or four               Monthly          TRUE    15
17 Four or more times a week Three or four                 Never          TRUE    52
18 Four or more times a week Three or four                Weekly          TRUE    15
19           Monthly or less   Five or six     Less than monthly          TRUE     2
20           Monthly or less    One or two     Less than monthly          TRUE     6
21           Monthly or less    One or two                 Never          TRUE   337
22           Monthly or less Seven to nine     Less than monthly          TRUE     1
23           Monthly or less Three or four     Less than monthly          TRUE     3
24           Monthly or less Three or four                 Never          TRUE    18
25           Monthly or less            NA                    NA          TRUE     1
26                     Never            NA                    NA         FALSE   774
27 Two to four times a month   Five or six     Less than monthly          TRUE     1
28 Two to four times a month   Five or six                 Never          TRUE     2
29 Two to four times a month   Five or six                Weekly          TRUE     1
30 Two to four times a month    One or two     Less than monthly          TRUE     4
31 Two to four times a month    One or two               Monthly          TRUE     2
32 Two to four times a month    One or two                 Never          TRUE   132
33 Two to four times a month Seven to nine               Monthly          TRUE     1
34 Two to four times a month Seven to nine                Weekly          TRUE     1
35 Two to four times a month Three or four     Less than monthly          TRUE     5
36 Two to four times a month Three or four                 Never          TRUE    18
37 Two to three times a week   Five or six Daily or almost daily          TRUE     1
38 Two to three times a week   Five or six     Less than monthly          TRUE     3
39 Two to three times a week   Five or six               Monthly          TRUE     1
40 Two to three times a week   Five or six                 Never          TRUE     1
41 Two to three times a week   Five or six                Weekly          TRUE     3
42 Two to three times a week    One or two     Less than monthly          TRUE    14
43 Two to three times a week    One or two               Monthly          TRUE     6
44 Two to three times a week    One or two                 Never          TRUE   149
45 Two to three times a week Seven to nine                 Never          TRUE     1
46 Two to three times a week Seven to nine                Weekly          TRUE     1
47 Two to three times a week   Ten or more                Weekly          TRUE     1
48 Two to three times a week Three or four     Less than monthly          TRUE     9
49 Two to three times a week Three or four                 Never          TRUE    23
50 Two to three times a week Three or four                Weekly          TRUE     1
51                        NA            NA                    NA            NA    20
```

```r
# verify
dto[["unitData"]][["alsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "FREQALCH", "NOSTDRNK", "FR6ORMOR", "current_drink")
```

```
      id                  FREQALCH   NOSTDRNK FR6ORMOR current_drink
1    641 Two to four times a month One or two    Never          TRUE
2   7201                     Never       <NA>     <NA>         FALSE
3  10862           Monthly or less One or two    Never          TRUE
4  11012 Two to three times a week One or two    Never          TRUE
5  11071                     Never       <NA>     <NA>         FALSE
6  18201                     Never       <NA>     <NA>         FALSE
7  24941                     Never       <NA>     <NA>         FALSE
8  25682                     Never       <NA>     <NA>         FALSE
9  25941 Four or more times a week One or two    Never          TRUE
10 38911                     Never       <NA>     <NA>         FALSE
```


### LBSL
Items that can contribute to generating values for the harmonized variable `alcohol`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "lbsl", construct == "alcohol") %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
  study_name    name                                       label_short categories
1       lbsl ALCOHOL                                       Alcohol use          7
2       lbsl    WINE               Number of glasses of wine last week         17
3       lbsl    BEER          Number of cans/bottles of beer last week         16
4       lbsl HARDLIQ Number of drinks containing hard liquor last week         15
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "lbsl"
path_to_hrule <- "./data/meta/h-rules/h-rules-alcohol-lbsl.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("ALCOHOL", "BEER" ,   "HARDLIQ", "WINE" ), 
  harmony_name = "current_drink"
)
```

```
Source: local data frame [174 x 6]
Groups: ALCOHOL, BEER, HARDLIQ, WINE [?]

                  ALCOHOL  BEER HARDLIQ  WINE current_drink     n
                    (chr) (chr)   (chr) (chr)         (lgl) (int)
1   daily or almost daily     0       0    10          TRUE     1
2   daily or almost daily     0       0    14          TRUE     1
3   daily or almost daily     0       0    15          TRUE     2
4   daily or almost daily     0       0     6          TRUE     1
5   daily or almost daily     0       0     7          TRUE     4
6   daily or almost daily     0       0     8          TRUE     1
7   daily or almost daily     0       0     9          TRUE     1
8   daily or almost daily     0       1    10          TRUE     1
9   daily or almost daily     0       1     5          TRUE     1
10  daily or almost daily     0       1     6          TRUE     1
11  daily or almost daily     0      14     0          TRUE     2
12  daily or almost daily     0      14     1          TRUE     1
13  daily or almost daily     0      14    10          TRUE     1
14  daily or almost daily     0       2    10          TRUE     1
15  daily or almost daily     0       2    14          TRUE     3
16  daily or almost daily     0       2    15          TRUE     1
17  daily or almost daily     0       2     5          TRUE     1
18  daily or almost daily     0      25     0          TRUE     1
19  daily or almost daily     0       4    12          TRUE     1
20  daily or almost daily     0       4     4          TRUE     1
21  daily or almost daily     0       4     5          TRUE     1
22  daily or almost daily     0       5     0          TRUE     2
23  daily or almost daily     0       6     3          TRUE     1
24  daily or almost daily     0       7     0          TRUE     3
25  daily or almost daily     0       7     3          TRUE     1
26  daily or almost daily     0       7     5          TRUE     1
27  daily or almost daily     0       7     7          TRUE     2
28  daily or almost daily     0       8     0          TRUE     1
29  daily or almost daily     1      14     0          TRUE     1
30  daily or almost daily     1      14    12          TRUE     1
31  daily or almost daily     1      14     2          TRUE     1
32  daily or almost daily     1       2    15          TRUE     1
33  daily or almost daily     1       2     6          TRUE     1
34  daily or almost daily    10       0     0          TRUE     2
35  daily or almost daily    10       0     1          TRUE     1
36  daily or almost daily    10       2     0          TRUE     1
37  daily or almost daily    10       5    NA          TRUE     1
38  daily or almost daily    12       0     6          TRUE     2
39  daily or almost daily    14       3     7          TRUE     1
40  daily or almost daily     2      10     0          TRUE     1
41  daily or almost daily     2      14    10          TRUE     1
42  daily or almost daily     2       7     3          TRUE     1
43  daily or almost daily    25       3     0          TRUE     1
44  daily or almost daily     3       0    12          TRUE     1
45  daily or almost daily     3       0     7          TRUE     1
46  daily or almost daily     3       6     0          TRUE     1
47  daily or almost daily    30       0     0          TRUE     1
48  daily or almost daily     4      12     0          TRUE     1
49  daily or almost daily     4       3     2          TRUE     1
50  daily or almost daily     5       6     0          TRUE     1
51  daily or almost daily     6       0     0          TRUE     1
52  daily or almost daily     6       3     2          TRUE     1
53  daily or almost daily     7       0     0          TRUE     1
54  daily or almost daily     7       0     2          TRUE     1
55  daily or almost daily     7       2     0          TRUE     1
56  daily or almost daily     7       2     3          TRUE     1
57  daily or almost daily     7       7    NA          TRUE     1
58  daily or almost daily     8       0     0          TRUE     1
59  daily or almost daily     8       0     8          TRUE     1
60  daily or almost daily     9       0     0          TRUE     1
61  daily or almost daily    NA      14    NA          TRUE     1
62  daily or almost daily    NA      15     3          TRUE     1
63  daily or almost daily    NA      21    NA          TRUE     1
64  daily or almost daily    NA       7     7          TRUE     1
65  daily or almost daily    NA       7    NA          TRUE     3
66  daily or almost daily    NA      NA    21          TRUE     1
67  daily or almost daily    NA      NA     7          TRUE     1
68       few times a year     0       0     0          TRUE    69
69       few times a year     0       0     1          TRUE    10
70       few times a year     0       0     2          TRUE     2
71       few times a year     0       1     0          TRUE     1
72       few times a year     1       0     0          TRUE     5
73       few times a year     1       0     1          TRUE     1
74       few times a year     1       0     2          TRUE     2
75       few times a year     1      NA     1          TRUE     1
76       few times a year     1      NA    NA          TRUE     1
77       few times a year     2       0     0          TRUE     3
78       few times a year     2       0     1          TRUE     2
79       few times a year     2       0     5          TRUE     1
80       few times a year     3       0     0          TRUE     1
81       few times a year     9       9     9          TRUE     1
82       few times a year    NA      NA    NA          TRUE    43
83            never drank     0       0     0         FALSE    10
84            never drank    NA      NA    NA         FALSE    82
85       not in last year     0       0     0         FALSE    13
86       not in last year     1       0     0         FALSE     1
87       not in last year    NA      NA    NA         FALSE    78
88            once a week     0       0     0          TRUE     5
89            once a week     0       0     1          TRUE     2
90            once a week     0       0     2          TRUE     5
91            once a week     0       0     3          TRUE     1
92            once a week     0       0     4          TRUE     1
93            once a week     0       0     5          TRUE     1
94            once a week     0       0     6          TRUE     1
95            once a week     0       1     0          TRUE     2
96            once a week     0       1     1          TRUE     3
97            once a week     0       1     3          TRUE     1
98            once a week     0       2     0          TRUE     4
99            once a week     0       2     1          TRUE     1
100           once a week     0       4     1          TRUE     1
..                    ...   ...     ...   ...           ...   ...
```

```r
# verify
dto[["unitData"]][["lbsl"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "ALCOHOL", "BEER" ,   "HARDLIQ", "WINE", "current_drink")
```

```
        id                   ALCOHOL BEER HARDLIQ WINE current_drink
1  4051065                      <NA>   NA      NA   NA            NA
2  4111190          few times a year    0       0    0          TRUE
3  4122041               never drank   NA      NA   NA         FALSE
4  4182077 two or three times weekly    1       0    4          TRUE
5  4282083          not in last year   NA      NA   NA         FALSE
6  4372036          not in last year   NA      NA   NA         FALSE
7  4441041               once a week    0       1    0          TRUE
8  4472033               never drank   NA      NA   NA         FALSE
9  4472034                      <NA>   NA      NA   NA            NA
10 4511021          not in last year   NA      NA   NA         FALSE
```


### SATSA

Items that can contribute to generating values for the harmonized variable `alcohol`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "satsa", construct == "alcohol") %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
   study_name     name                                                label_short categories
1       satsa GALCOHOL                     Do you ever drink alcoholic beverages?          2
2       satsa   GBEERX              How much beer do you usually drink at a time?          7
3       satsa  GBOTVIN                                        <U+0085>more than 1 bottle          4
4       satsa  GDRLOTS                               How often more than 5 beers?          8
5       satsa  GEVRALK                  Do you ever drink alcoholic drinks? - Yes          3
6       satsa GFREQBER              How often do you drink beer (not light beer)?          9
7       satsa GFREQLIQ                How often do you usually drink hard liquor?          9
8       satsa GFREQVIN        How often do you usually drink wine (red or white)?          9
9       satsa    GLIQX         How much hard liquot do you usually drink at time?          8
10      satsa GSTOPALK Do you ever drink alcoholic drinks? -No I quit. When? 19__         32
11      satsa    GVINX              How much wine do you usually drink at a time?          6
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "satsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-alcohol-satsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("GALCOHOL","GEVRALK","GBEERX","GLIQX" ,"GVINX" ), 
  harmony_name = "current_drink"
)
```

```
Source: local data frame [231 x 7]
Groups: GALCOHOL, GEVRALK, GBEERX, GLIQX, GVINX [?]

    GALCOHOL                                 GEVRALK           GBEERX                                     GLIQX
       (chr)                                   (chr)            (chr)                                     (chr)
1         No No, I have never drunk alcoholic drinks 1 bottle (33 cl) 4 cl (approx. a small shot or equivalent)
2         No No, I have never drunk alcoholic drinks 1 bottle (33 cl)                                        NA
3         No No, I have never drunk alcoholic drinks  1 glass or less                                        NA
4         No No, I have never drunk alcoholic drinks  1 glass or less                                        NA
5         No No, I have never drunk alcoholic drinks               NA 4 cl (approx. a small shot or equivalent)
6         No No, I have never drunk alcoholic drinks               NA 4 cl (approx. a small shot or equivalent)
7         No No, I have never drunk alcoholic drinks               NA                                        NA
8         No No, I have never drunk alcoholic drinks               NA                                        NA
9         No                             No, I quit. 1 bottle (33 cl) 4 cl (approx. a small shot or equivalent)
10        No                             No, I quit. 1 bottle (33 cl)                                        NA
11        No                             No, I quit.  1 glass or less 4 cl (approx. a small shot or equivalent)
12        No                             No, I quit.  1 glass or less                                        NA
13        No                             No, I quit.               NA                                      8 cl
14        No                             No, I quit.               NA                                        NA
15        No                             No, I quit.               NA                                        NA
16        No                             No, I quit.               NA                                        NA
17        No                                     Yes 1 bottle (33 cl) 4 cl (approx. a small shot or equivalent)
18        No                                     Yes  1 glass or less 4 cl (approx. a small shot or equivalent)
19        No                                     Yes  1 glass or less                                        NA
20        No                                     Yes  1 glass or less                                        NA
21        No                                     Yes               NA 4 cl (approx. a small shot or equivalent)
22        No                                     Yes               NA 4 cl (approx. a small shot or equivalent)
23        No                                     Yes               NA 4 cl (approx. a small shot or equivalent)
24        No                                     Yes               NA                                        NA
25        No                                     Yes               NA                                        NA
26        No                                     Yes               NA                                        NA
27        No                                      NA  1 glass or less 4 cl (approx. a small shot or equivalent)
28        No                                      NA  1 glass or less 4 cl (approx. a small shot or equivalent)
29        No                                      NA  1 glass or less                                        NA
30        No                                      NA               NA 4 cl (approx. a small shot or equivalent)
31        No                                      NA               NA 4 cl (approx. a small shot or equivalent)
32        No                                      NA               NA                                        NA
33        No                                      NA               NA                                        NA
34       Yes No, I have never drunk alcoholic drinks 1 bottle (33 cl)                                        NA
35       Yes No, I have never drunk alcoholic drinks  1 glass or less                                        NA
36       Yes No, I have never drunk alcoholic drinks  1 glass or less                                        NA
37       Yes No, I have never drunk alcoholic drinks  1 glass or less                                        NA
38       Yes No, I have never drunk alcoholic drinks        2 bottles 4 cl (approx. a small shot or equivalent)
39       Yes No, I have never drunk alcoholic drinks               NA 4 cl (approx. a small shot or equivalent)
40       Yes No, I have never drunk alcoholic drinks               NA                                        NA
41       Yes No, I have never drunk alcoholic drinks               NA                                        NA
42       Yes                             No, I quit. 1 bottle (33 cl)           6 cl (a big shot or equivalent)
43       Yes                             No, I quit. 1 bottle (33 cl)                                        NA
44       Yes                             No, I quit. 1 bottle (33 cl)                                        NA
45       Yes                             No, I quit.  1 glass or less                                        NA
46       Yes                             No, I quit.  1 glass or less                                        NA
47       Yes                                     Yes 1 bottle (33 cl)                                     12 cl
48       Yes                                     Yes 1 bottle (33 cl)                                     12 cl
49       Yes                                     Yes 1 bottle (33 cl)                                     12 cl
50       Yes                                     Yes 1 bottle (33 cl)                                     12 cl
51       Yes                                     Yes 1 bottle (33 cl)                                     12 cl
52       Yes                                     Yes 1 bottle (33 cl)                                     18 cl
53       Yes                                     Yes 1 bottle (33 cl)                                     18 cl
54       Yes                                     Yes 1 bottle (33 cl)                                     18 cl
55       Yes                                     Yes 1 bottle (33 cl)                                     18 cl
56       Yes                                     Yes 1 bottle (33 cl)                                     18 cl
57       Yes                                     Yes 1 bottle (33 cl)                     37 cl (half a bottle)
58       Yes                                     Yes 1 bottle (33 cl)                     37 cl (half a bottle)
59       Yes                                     Yes 1 bottle (33 cl)                     37 cl (half a bottle)
60       Yes                                     Yes 1 bottle (33 cl)                     37 cl (half a bottle)
61       Yes                                     Yes 1 bottle (33 cl)                     37 cl (half a bottle)
62       Yes                                     Yes 1 bottle (33 cl)                     37 cl (half a bottle)
63       Yes                                     Yes 1 bottle (33 cl) 4 cl (approx. a small shot or equivalent)
64       Yes                                     Yes 1 bottle (33 cl) 4 cl (approx. a small shot or equivalent)
65       Yes                                     Yes 1 bottle (33 cl) 4 cl (approx. a small shot or equivalent)
66       Yes                                     Yes 1 bottle (33 cl) 4 cl (approx. a small shot or equivalent)
67       Yes                                     Yes 1 bottle (33 cl)           6 cl (a big shot or equivalent)
68       Yes                                     Yes 1 bottle (33 cl)           6 cl (a big shot or equivalent)
69       Yes                                     Yes 1 bottle (33 cl)           6 cl (a big shot or equivalent)
70       Yes                                     Yes 1 bottle (33 cl)           6 cl (a big shot or equivalent)
71       Yes                                     Yes 1 bottle (33 cl)           6 cl (a big shot or equivalent)
72       Yes                                     Yes 1 bottle (33 cl)                    75 cl (1 whole bottle)
73       Yes                                     Yes 1 bottle (33 cl)                                      8 cl
74       Yes                                     Yes 1 bottle (33 cl)                                      8 cl
75       Yes                                     Yes 1 bottle (33 cl)                                      8 cl
76       Yes                                     Yes 1 bottle (33 cl)                                      8 cl
77       Yes                                     Yes 1 bottle (33 cl)                                      8 cl
78       Yes                                     Yes 1 bottle (33 cl)                                      8 cl
79       Yes                                     Yes 1 bottle (33 cl)                                        NA
80       Yes                                     Yes 1 bottle (33 cl)                                        NA
81       Yes                                     Yes 1 bottle (33 cl)                                        NA
82       Yes                                     Yes 1 bottle (33 cl)                                        NA
83       Yes                                     Yes 1 bottle (33 cl)                                        NA
84       Yes                                     Yes 1 bottle (33 cl)                                        NA
85       Yes                                     Yes  1 glass or less                                     12 cl
86       Yes                                     Yes  1 glass or less                                     12 cl
87       Yes                                     Yes  1 glass or less                                     12 cl
88       Yes                                     Yes  1 glass or less                                     12 cl
89       Yes                                     Yes  1 glass or less                                     18 cl
90       Yes                                     Yes  1 glass or less                                     18 cl
91       Yes                                     Yes  1 glass or less                                     18 cl
92       Yes                                     Yes  1 glass or less                                     18 cl
93       Yes                                     Yes  1 glass or less                     37 cl (half a bottle)
94       Yes                                     Yes  1 glass or less                     37 cl (half a bottle)
95       Yes                                     Yes  1 glass or less 4 cl (approx. a small shot or equivalent)
96       Yes                                     Yes  1 glass or less 4 cl (approx. a small shot or equivalent)
97       Yes                                     Yes  1 glass or less 4 cl (approx. a small shot or equivalent)
98       Yes                                     Yes  1 glass or less 4 cl (approx. a small shot or equivalent)
99       Yes                                     Yes  1 glass or less           6 cl (a big shot or equivalent)
100      Yes                                     Yes  1 glass or less           6 cl (a big shot or equivalent)
..       ...                                     ...              ...                                       ...
Variables not shown: GVINX (chr), current_drink (lgl), n (int)
```

```r
# verify
dto[["unitData"]][["satsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "GALCOHOL","GEVRALK","GBEERX","GLIQX" ,"GVINX", "current_drink")
```

```
        id GALCOHOL                                 GEVRALK           GBEERX                           GLIQX
1   124441       No                             No, I quit.             <NA>                            <NA>
2   152211       No No, I have never drunk alcoholic drinks             <NA>                            <NA>
3   169502       No No, I have never drunk alcoholic drinks             <NA>                            <NA>
4   172011      Yes                                     Yes  1 glass or less                            <NA>
5   225241       No No, I have never drunk alcoholic drinks             <NA>                            <NA>
6  2131821      Yes                                     Yes             <NA> 6 cl (a big shot or equivalent)
7  2141092      Yes                                     Yes 1 bottle (33 cl)                            8 cl
8  2178401       No No, I have never drunk alcoholic drinks             <NA>                            <NA>
9  2284602      Yes                                     Yes 1 bottle (33 cl)                           12 cl
10 2317811      Yes                                     Yes  1 glass or less 6 cl (a big shot or equivalent)
                   GVINX current_drink
1                   <NA>         FALSE
2                   <NA>         FALSE
3                   <NA>         FALSE
4   10 cl (1 wine glass)          TRUE
5                   <NA>         FALSE
6                   <NA>          TRUE
7  37 cl (half a bottle)          TRUE
8                   <NA>         FALSE
9  37 cl (half a bottle)          TRUE
10  10 cl (1 wine glass)          TRUE
```

### SHARE

Items that can contribute to generating values for the harmonized variable `alcohol`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "share", construct == "alcohol") %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
  study_name   name                            label_short categories
1      share BR0100       beverages consumed last 6 months          7
2      share BR0110 freq more than 2 glasses beer in a day          7
3      share BR0120 freq more than 2 glasses wine in a day          8
4      share BR0130  freq more than 2 hard liquor in a day          8
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "share"
path_to_hrule <- "./data/meta/h-rules/h-rules-alcohol-share.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("BR0100", "BR0110", "BR0120", "BR0130"), 
  harmony_name = "current_drink"
)
```

```
Source: local data frame [168 x 6]
Groups: BR0100, BR0110, BR0120, BR0130 [?]

                             BR0100                          BR0110                          BR0120
                              (chr)                           (chr)                           (chr)
1                  almost every day                almost every day                almost every day
2                  almost every day                almost every day          less than once a month
3                  almost every day                almost every day            once or twice a week
4                  almost every day                almost every day            once or twice a week
5                  almost every day         five or six days a week         five or six days a week
6                  almost every day         five or six days a week not at all in the last 6 months
7                  almost every day          less than once a month          less than once a month
8                  almost every day          less than once a month          less than once a month
9                  almost every day          less than once a month not at all in the last 6 months
10                 almost every day          less than once a month           once or twice a month
11                 almost every day          less than once a month           once or twice a month
12                 almost every day not at all in the last 6 months                almost every day
13                 almost every day not at all in the last 6 months                almost every day
14                 almost every day not at all in the last 6 months                almost every day
15                 almost every day not at all in the last 6 months          less than once a month
16                 almost every day not at all in the last 6 months          less than once a month
17                 almost every day not at all in the last 6 months not at all in the last 6 months
18                 almost every day not at all in the last 6 months not at all in the last 6 months
19                 almost every day not at all in the last 6 months not at all in the last 6 months
20                 almost every day not at all in the last 6 months not at all in the last 6 months
21                 almost every day not at all in the last 6 months           once or twice a month
22                 almost every day not at all in the last 6 months            once or twice a week
23                 almost every day not at all in the last 6 months            once or twice a week
24                 almost every day not at all in the last 6 months            once or twice a week
25                 almost every day not at all in the last 6 months            once or twice a week
26                 almost every day not at all in the last 6 months       three or four days a week
27                 almost every day           once or twice a month                almost every day
28                 almost every day           once or twice a month                almost every day
29                 almost every day           once or twice a month not at all in the last 6 months
30                 almost every day           once or twice a month            once or twice a week
31                 almost every day           once or twice a month            once or twice a week
32                 almost every day            once or twice a week                almost every day
33                 almost every day            once or twice a week                almost every day
34                 almost every day            once or twice a week           once or twice a month
35                 almost every day            once or twice a week            once or twice a week
36                 almost every day       three or four days a week          less than once a month
37                 almost every day       three or four days a week       three or four days a week
38          five or six days a week         five or six days a week not at all in the last 6 months
39          five or six days a week          less than once a month          less than once a month
40          five or six days a week          less than once a month           once or twice a month
41          five or six days a week          less than once a month       three or four days a week
42          five or six days a week not at all in the last 6 months not at all in the last 6 months
43          five or six days a week not at all in the last 6 months           once or twice a month
44          five or six days a week           once or twice a month          less than once a month
45          five or six days a week           once or twice a month not at all in the last 6 months
46           less than once a month          less than once a month          less than once a month
47           less than once a month          less than once a month          less than once a month
48           less than once a month          less than once a month not at all in the last 6 months
49           less than once a month          less than once a month           once or twice a month
50           less than once a month          less than once a month           once or twice a month
51           less than once a month not at all in the last 6 months          less than once a month
52           less than once a month not at all in the last 6 months          less than once a month
53           less than once a month not at all in the last 6 months          less than once a month
54           less than once a month not at all in the last 6 months not at all in the last 6 months
55           less than once a month not at all in the last 6 months not at all in the last 6 months
56           less than once a month not at all in the last 6 months           once or twice a month
57           less than once a month not at all in the last 6 months           once or twice a month
58           less than once a month not at all in the last 6 months           once or twice a month
59           less than once a month not at all in the last 6 months            once or twice a week
60           less than once a month           once or twice a month          less than once a month
61           less than once a month           once or twice a month          less than once a month
62           less than once a month           once or twice a month not at all in the last 6 months
63           less than once a month           once or twice a month           once or twice a month
64           less than once a month           once or twice a month           once or twice a month
65           less than once a month            once or twice a week not at all in the last 6 months
66  not at all in the last 6 months                              NA                              NA
67            once or twice a month                almost every day          less than once a month
68            once or twice a month          less than once a month          less than once a month
69            once or twice a month          less than once a month          less than once a month
70            once or twice a month          less than once a month          less than once a month
71            once or twice a month          less than once a month not at all in the last 6 months
72            once or twice a month          less than once a month           once or twice a month
73            once or twice a month          less than once a month           once or twice a month
74            once or twice a month          less than once a month            once or twice a week
75            once or twice a month not at all in the last 6 months                      don't know
76            once or twice a month not at all in the last 6 months          less than once a month
77            once or twice a month not at all in the last 6 months          less than once a month
78            once or twice a month not at all in the last 6 months not at all in the last 6 months
79            once or twice a month not at all in the last 6 months not at all in the last 6 months
80            once or twice a month not at all in the last 6 months not at all in the last 6 months
81            once or twice a month not at all in the last 6 months not at all in the last 6 months
82            once or twice a month not at all in the last 6 months           once or twice a month
83            once or twice a month not at all in the last 6 months           once or twice a month
84            once or twice a month not at all in the last 6 months            once or twice a week
85            once or twice a month not at all in the last 6 months            once or twice a week
86            once or twice a month           once or twice a month          less than once a month
87            once or twice a month           once or twice a month          less than once a month
88            once or twice a month           once or twice a month not at all in the last 6 months
89            once or twice a month           once or twice a month           once or twice a month
90            once or twice a month           once or twice a month           once or twice a month
91            once or twice a month           once or twice a month           once or twice a month
92            once or twice a month           once or twice a month            once or twice a week
93            once or twice a month           once or twice a month            once or twice a week
94            once or twice a month            once or twice a week           once or twice a month
95            once or twice a month       three or four days a week          less than once a month
96             once or twice a week          less than once a month          less than once a month
97             once or twice a week          less than once a month          less than once a month
98             once or twice a week          less than once a month          less than once a month
99             once or twice a week          less than once a month          less than once a month
100            once or twice a week          less than once a month not at all in the last 6 months
..                              ...                             ...                             ...
Variables not shown: BR0130 (chr), current_drink (lgl), n (int)
```

```r
# verify
knitr::kable(dto[["unitData"]][["share"]] %>%
               dplyr::filter(id %in% sample(unique(id),10)) %>%
               dplyr::select_("id", "BR0100", "BR0110", "BR0120", "BR0130", "current_drink"))
```

           id  BR0100                            BR0110                  BR0120                            BR0130                            current_drink 
-------------  --------------------------------  ----------------------  --------------------------------  --------------------------------  --------------
 2.505224e+12  once or twice a week              once or twice a week    not at all in the last 6 months   not at all in the last 6 months   TRUE          
 2.505231e+12  once or twice a month             once or twice a month   once or twice a month             once or twice a month             TRUE          
 2.505233e+12  not at all in the last 6 months   NA                      NA                                NA                                FALSE         
 2.505255e+12  not at all in the last 6 months   NA                      NA                                NA                                FALSE         
 2.505286e+12  not at all in the last 6 months   NA                      NA                                NA                                FALSE         
 2.505288e+12  not at all in the last 6 months   NA                      NA                                NA                                FALSE         
 2.505289e+12  not at all in the last 6 months   NA                      NA                                NA                                FALSE         
 2.505295e+12  not at all in the last 6 months   NA                      NA                                NA                                FALSE         
 2.605291e+12  not at all in the last 6 months   NA                      NA                                NA                                FALSE         
 2.705274e+12  not at all in the last 6 months   NA                      NA                                NA                                FALSE         


### TILDA

Items that can contribute to generating values for the harmonized variable `alcohol`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "tilda", construct == "alcohol") %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
  study_name                 name                                  label_short categories
1      tilda  BEHALC.DRINKSPERDAY                      Standard drinks per day         35
2      tilda BEHALC.DRINKSPERWEEK                       Standard drinks a week        120
3      tilda     BEHALC.FREQ.WEEK              Average times drinking per week          7
4      tilda          SCQALCOFREQ                Frequency of drinking alcohol          7
5      tilda           SCQALCOHOL                             Alcoholic drinks          2
6      tilda           SCQALCONO1                       More than 2 drinks/day          7
7      tilda           SCQALCONO2 How many drinks consumed on days drink taken         19
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "tilda"
path_to_hrule <- "./data/meta/h-rules/h-rules-alcohol-tilda.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("SCQALCOHOL" ,"BEHALC.DRINKSPERDAY","BEHALC.DRINKSPERWEEK"), 
  harmony_name = "current_drink"
)
```

```
Source: local data frame [167 x 5]
Groups: SCQALCOHOL, BEHALC.DRINKSPERDAY, BEHALC.DRINKSPERWEEK [?]

    SCQALCOHOL BEHALC.DRINKSPERDAY BEHALC.DRINKSPERWEEK current_drink     n
         (chr)               (chr)                (chr)         (lgl) (int)
1           no                   0                    0         FALSE  1803
2           no                  NA                   NA         FALSE     9
3          yes                   0                    0          TRUE    29
4          yes                   0                   NA          TRUE     3
5          yes                 0.5                    0          TRUE     1
6          yes                 0.5        0.05999999866            NA     3
7          yes                 0.5                 0.75          TRUE     3
8          yes                 0.5                 1.75          TRUE     1
9          yes      0.699999988079        0.08399999887            NA     1
10         yes                   1                    0          TRUE    23
11         yes                   1        0.11999999732            NA   181
12         yes                   1        0.34999999404            NA   152
13         yes                   1                  1.5          TRUE   150
14         yes                   1                  3.5          TRUE    47
15         yes                   1                  5.5          TRUE    28
16         yes                   1                  6.5          TRUE    45
17         yes                   1                   NA          TRUE     5
18         yes                 1.5                    0          TRUE     1
19         yes                 1.5        0.17999999225            NA    19
20         yes                 1.5        0.52499997616            NA    24
21         yes                 1.5                 2.25          TRUE    53
22         yes                 1.5                 5.25          TRUE    23
23         yes                 1.5                 8.25          TRUE     6
24         yes                 1.5                 9.75          TRUE    12
25         yes                 1.5                   NA          TRUE     1
26         yes                  10        1.19999992848            NA     6
27         yes                  10                   15          TRUE    35
28         yes                  10                  3.5          TRUE     9
29         yes                  10                   35          TRUE     9
30         yes                  10                   65          TRUE     7
31         yes                  10                   NA          TRUE     1
32         yes                  11                 16.5          TRUE     2
33         yes                  11                 71.5          TRUE     1
34         yes                  12        1.43999993801            NA     5
35         yes                  12                   18          TRUE    10
36         yes                  12        4.19999980927            NA     5
37         yes                  12                   42          TRUE     4
38         yes                  12                   NA          TRUE     4
39         yes                  13                   NA          TRUE     1
40         yes                  14        1.67999994755            NA     3
41         yes                  14                   21          TRUE     2
42         yes                  15                 22.5          TRUE     1
43         yes                  15                 5.25          TRUE     1
44         yes                  15                 52.5          TRUE     2
45         yes                  15                 82.5          TRUE     1
46         yes                  15                 97.5          TRUE     1
47         yes                  16                   24          TRUE     3
48         yes                  16                   56          TRUE     2
49         yes                  16                   88          TRUE     1
50         yes                  16                   NA          TRUE     2
51         yes                  18                   27          TRUE     2
52         yes                   2                    0          TRUE    20
53         yes                   2        0.23999999464            NA   170
54         yes                   2        0.69999998808            NA   223
55         yes                   2                   11          TRUE    52
56         yes                   2                   13          TRUE    94
57         yes                   2                    3          TRUE   445
58         yes                   2                    7          TRUE   186
59         yes                   2                   NA          TRUE    21
60         yes                 2.5                    0          TRUE     2
61         yes                 2.5        0.29999998212            NA    11
62         yes                 2.5                0.875          TRUE    26
63         yes                 2.5                13.75          TRUE    23
64         yes                 2.5                16.25          TRUE    22
65         yes                 2.5                 3.75          TRUE    77
66         yes                 2.5                 8.75          TRUE    38
67         yes                  20                    0          TRUE     1
68         yes                  20                  110          TRUE     1
69         yes                  20                  130          TRUE     1
70         yes                  20                   30          TRUE     7
71         yes                  20                    7          TRUE     3
72         yes                  20                   70          TRUE     1
73         yes                  20                   NA          TRUE     1
74         yes                  21        7.34999990464            NA     1
75         yes                  22                   77          TRUE     1
76         yes                  24                   36          TRUE     1
77         yes                  24                   84          TRUE     3
78         yes                  25                 37.5          TRUE     1
79         yes                   3                    0          TRUE     8
80         yes                   3         0.3599999845            NA    76
81         yes                   3        1.04999995232            NA   118
82         yes                   3                 10.5          TRUE   152
83         yes                   3                 16.5          TRUE    55
84         yes                   3                 19.5          TRUE    82
85         yes                   3                  4.5          TRUE   321
86         yes                   3                   NA          TRUE    11
87         yes                 3.5        0.41999998689            NA     6
88         yes                 3.5        1.22500002384            NA    12
89         yes                 3.5                12.25          TRUE    33
90         yes                 3.5                19.25          TRUE    10
91         yes                 3.5                22.75          TRUE    13
92         yes                 3.5                 5.25          TRUE    77
93         yes                 3.5                   NA          TRUE     1
94         yes                  30                 10.5          TRUE     1
95         yes                  30                  105          TRUE     2
96         yes                  30                   45          TRUE     1
97         yes                  30                   NA          TRUE     1
98         yes                  35                227.5          TRUE     1
99         yes                   4                    0          TRUE     4
100        yes                   4        0.47999998927            NA    59
..         ...                 ...                  ...           ...   ...
```

```r
# verify
dto[["unitData"]][["tilda"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id","SCQALCOHOL" ,"BEHALC.DRINKSPERDAY","BEHALC.DRINKSPERWEEK","current_drink")
```

```
                   id SCQALCOHOL BEHALC.DRINKSPERDAY BEHALC.DRINKSPERWEEK current_drink
1  107591                    yes                 3.0                 1.05            NA
2  201131                   <NA>                  NA                   NA            NA
3  239152                    yes                 2.0                 3.00          TRUE
4  329612                    yes                 3.5                 5.25          TRUE
5  405611                    yes                 5.0                17.50          TRUE
6  421891                     no                 0.0                 0.00         FALSE
7  546821                    yes                 4.0                 6.00          TRUE
8  564112                     no                 0.0                 0.00         FALSE
9  576281                     no                 0.0                 0.00         FALSE
10 627361                    yes                 3.0                 4.50          TRUE
```



# (III) Recapitulation 

At this point the `dto[["unitData"]]` elements (raw data files for each study) have been augmented with the harmonized variable `alcohol`. We retrieve harmonized variables to view frequency counts across studies: 


```r
dumlist <- list()
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]]
  dumlist[[s]] <- ds[,c("id","current_drink")]
}
ds <- plyr::ldply(dumlist,data.frame,.id = "study_name")
head(ds)
```

```
  study_name  id current_drink
1       alsa  41          TRUE
2       alsa  42          TRUE
3       alsa  61          TRUE
4       alsa  71          TRUE
5       alsa  91          TRUE
6       alsa 121          TRUE
```

```r
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
table( ds$current_drink, ds$study_name, useNA="always")
```

```
       
        alsa lbsl satsa share tilda <NA>
  FALSE  774  185   537  1855  1812    0
  TRUE  1293  378   934   739  4048    0
  <NA>    20   93    26     4  2644    0
```


Finally, we have added the newly created, harmonized variables to the raw source objects and save the data transfer object.


```r
# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
saveRDS(dto, file="./data/unshared/derived/dto.rds", compress="xz")
```



