# Harmonize: marital

<!-- These two chunks should be added in the beginning of every .Rmd that you want to source an .R script -->
<!--  The 1st mandatory chunck  -->
<!--  Set the working directory to the repository's base directory -->


<!--  The 2nd mandatory chunck  -->
<!-- Set the report-wide options, and point to the external code file. -->


This report lists the candidate variable for DataScheme variables of the construct **marital**.

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
Source: local data frame [656 x 31]

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
  year_born (dbl), female (lgl)
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

<!--html_preserve--><div id="htmlwidget-2443" style="width:100%;height:auto;" class="datatables"></div>
<script type="application/json" data-for="htmlwidget-2443">{"x":{"data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"],["alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda"],["SEQNUM","EXRTHOUS","HWMNWK2W","LSVEXC2W","LSVIGEXC","TMHVYEXR","TMVEXC2W","VIGEXC2W","VIGEXCS","WALK2WKS","BTSM12MN","HLTHBTSM","HLTHLIFE","AGE","SEX","MARITST","SCHOOL","TYPQUAL","RETIRED","SMOKER","FR6ORMOR","NOSTDRNK","FREQALCH","WEIGHT","PIPCIGAR","CURRWORK","ID","AGE94","SEX94","MSTAT94","EDUC94","NOWRK94","SMK94","SMOKE","ALCOHOL","WINE","BEER","HARDLIQ","SPORT94","FIT94","WALK94","SPEC94","DANCE94","CHORE94","EXCERTOT","EXCERWK","HEIGHT94","WEIGHT94","HWEIGHT","HHEIGHT","SRHEALTH","ID","GMARITAL","GAMTWORK","GEVRSMK","GEVRSNS","GSMOKNOW","GALCOHOL","GBEERX","GBOTVIN","GDRLOTS","GEVRALK","GFREQBER","GFREQLIQ","GFREQVIN","GLIQX","GSTOPALK","GVINX","GEXERCIS","GHTCM","GWTKG","GHLTHOTH","GGENHLTH","GPI","SEX","YRBORN","QAGE3","EDUC","SAMPID.rec","DN0030","GENDER","DN0140","DN0100","EP0050","BR0010","BR0020","BR0030","BR0100","BR0110","BR0120","BR0130","BR0150","BR0160","PH0130","PH0120","PH0020","PH0030","PH0520","PH0530","INT.YEAR","DN012D01","DN012D02","DN012D03","DN012D04","DN012D05","DN012D09","DN012DNO","DN012DOT","DN012DRF","DN012DDK","ID","AGE","SEX","GD002","SOCMARRIED","CS006","MAR_4","DM001","WE001","WE003","BH001","BH002","BH003","BEHSMOKER","BEHALC.DRINKSPERDAY","BEHALC.DRINKSPERWEEK","BEHALC.FREQ.WEEK","SCQALCOFREQ","SCQALCOHOL","SCQALCONO1","SCQALCONO2","BH101","BH102","BH102A","BH103","BH104","BH104A","BH105","BH106","BH106A","BH107","BH107A","IPAQMETMINUTES","IPAQEXERCISE3","SR.HEIGHT.CENTIMETRES","HEIGHT","SR.WEIGHT.KILOGRAMMES","WEIGHT","PH001","PH009"],["id","","","","","","","","","","health_12ago","health_others","healt_self","age","sex","marital","age_left_school","edu_hight","retired","smoke_now","","","","weight_kg","smoke_pipecigar","employed","id","age_1994","sex","marital","school_years","employed","smoke_now","smoke_history","","","","","","","","","","","","","height_in","weight_lb","weight_lb_sr","height_in_sr","","twin_id","marital","work_status","smoke_history","snuff_history","smoke_now","","","","","","","","","","","","","height_in","weight_kg","","","","sex","year_born","age_q3","edu","id","born_year","sex","marital","edu","current_job","smoke_history","smoke_now","smoke_years","","","","","","","","","","","","","","","","","","","","","","","","id","age_interview","sex","sex_gender","marital_2","marital_6","marital_4","edu_highest","work_status","work_extra","smoke_history","smoke_now","smoke_age","smoke_history2","","","","","","","","","","","","","","","","","","","","","","","","","",""],["id","physact","physact","physact","physact","physact","physact","physact","physact","physact","health","health","health","age","sex","marital","education","education","work_status","smoking","alcohol","alcohol","alcohol","physique","smoking","work_status","id","age","sex","marital","education","work_status","smoking","smoking","alcohol","alcohol","alcohol","alcohol","physact","physact","physact","physact","physact","physact","physact","physact","physique","physique","physique","physique","health","id","marital","work_status","smoking","smoking","smoking","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","physact","physique","physique","health","health","physique","sex","age","age","education","id","age","sex","marital","education","work_status","smoking","smoking","smoking","alcohol","alcohol","alcohol","alcohol","physact","physact","physique","physique","health","health","health","health","year","education","education","education","education","education","education","education","education","education","education","id","age","sex","sex","marital","marital","marital","education","work_status","work_status","smoking","smoking","smoking","smoking","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","alcohol","physact","physact","physact","physact","physact","physact","physact","physact","physact","physact","physact","physact","physact","physique","physique","physique","physique","health","health"],["demo","activity","activity","activity","activity","activity","activity","activity","activity","activity","physical","physical","physical","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","physical","substance","demo","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","substance","substance","activity","activity","activity","activity","activity","activity","activity","activity","physical","physical","physical","physical","physical","demo","demo","demo","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","activity","physical","physical","physical","physical","physical","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","substance","substance","substance","activity","activity","physical","physical","physical","physical","physical","physical","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","demo","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","substance","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","activity","physical","physical","physical","physical","physical","physical"],[2087,null,null,null,null,null,null,null,null,null,null,null,null,38,2,7,8,10,2,2,5,5,5,null,2,null,656,65,2,6,18,9,2,3,7,17,16,15,null,null,null,null,null,null,null,null,null,null,null,null,null,1498,5,11,3,3,2,2,7,4,8,3,9,9,9,8,32,6,null,null,null,null,null,null,2,62,879,4,2598,57,2,9,13,10,2,2,null,7,7,8,8,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,8504,33,2,2,2,6,4,4,9,9,2,2,null,3,35,120,7,7,2,7,19,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],["Sequence Number","Exertion around house","Times walked in past two weeks","Less vigor sessions last 2 weeks","Less vigor past 2 weeks","Time heavy physical exertion","Vigor Time past 2 weeks","Vigor Sessions in past 2 weeks","Vigorous exercise","Walking past 2 weeks","Health comp with 12mths ago","Health compared to others","Self-rated health","Age","Sex","Marital status","Age left school","Highest qualification","Are you retired from your last job?","Do you currently smoke cigarettes?","Frequency six or more drinks","Number of standard drinks","Frequency alcohol","Weight in kilograms","Do you regularly smoke pipe or cigar?","Currently working","Id","Age in 1994","Sex","Marital Status in 1994","Years of school completed","Working at present time?","Currently smoke?","Smoke, tobacco use","Alcohol use","Number of glasses of wine last week","Number of cans/bottles of beer last week","Number of drinks containing hard liquor last week","Participant sports, number of hours","Physical fitness, number of hours each week","Walking, number of hours per week","Spectator sports, number of hours spent per week","Dancing","Doing household chores (hrs/wk)","Exercising for shape/fun (hrs/wk)","Exercised or played sports (oc/wk)","Height in Inches","Weight in Pounds","Self-reported weight in pounds","Self-reported height in inches","Self-reported health compared to age peers","Twin number","What is your marital status?","Describe current work/retirement situation","Do you smoke tobacco?","Do you take snuff?","Smoked some last month?","Do you ever drink alcoholic beverages?","How much beer do you usually drink at a time?","…more than 1 bottle","How often more than 5 beers?","Do you ever drink alcoholic drinks? - Yes","How often do you drink beer (not light beer)?","How often do you usually drink hard liquor?","How often do you usually drink wine (red or white)?","How much hard liquot do you usually drink at time?","Do you ever drink alcoholic drinks? -No I quit. When? 19__","How much wine do you usually drink at a time?","What option best describes your exercise on a yearly basis?","","","Judge your health compared to others your age?","How do you judge your general state of health?","","Sex","Year born","Age at current wave","Education","id","Year born","Sex","Marital Status","Edcuation","Current job situation","Ever smoked tobacco daily for a year?","Smoke at present?","How many years smoked?","beverages consumed last 6 months","freq more than 2 glasses beer in a day","freq more than 2 glasses wine in a day","freq more than 2 hard liquor in a day","sports or activities that are vigorous","activities requiring a moderate level of energy","how tall are you?","weight of respondent","health in general question v 1","health in general question v 2","health in general question v 2","health in general question v 1","interview year","yeshiva, religious high institution","nursing school","polytechnic","university, Bachelors degree","university, graduate degree","still in further education or training","no further education","other further education","refused","dont know","Anonymised ID","","Gender","Male or Female?","","","","","Describe current job situation","Any paid work last week?","Ever smoked tobacco daily for a year?","Smoke at present?","Age when stopped smoking","Respondent is a smoker","Standard drinks per day","Standard drinks a week","Average times drinking per week","Frequency of drinking alcohol","Alcoholic drinks","More than 2 drinks/day","How many drinks consumed on days drink taken","During the last 7 days, on how many days did you do vigorous physical activit?","How much time did you usually spend doing vigorous physical activities on one?","How much time did you usually spend doing vigorous physical activities on one?","During the last 7 days, on how many days did you do moderate physical activit?","How much time did you usually spend doing moderate physical activities on one?","How much time did you usually spend doing moderate physical activities on one?","During the last 7 days, on how many days did you walk for at least 10 minutes?","How much time did you usually spend walking on one of those days? HOURS","How much time did you usually spend walking on one of those days? MINS","During the last 7 days, how much time did you spend sitting on a week day? HO?","During the last 7 days, how much time did you spend sitting on a week day? MINS","Physical activity met (minutes)","Physical activity met (minutes)","Height Centimetres","Respondent height","Weight Kilogrammes","Respondent weight","What about your health.  Would you say ?","Compared to others  your age,  your health is"],["Sequence Number","Exertion around house","Times walked in past two weeks","Less vigor sessions last 2 weeks","Less vigor past 2 weeks","Time heavy physical exertion","Vigor Time past 2 weeks","Vigor Sessions in past 2 weeks","Vigorous exercise","Walking past 2 weeks","Health comp with 12mths ago","Health compared to others","Self-rated health","Age","Sex","Marital status","Age left school","Highest qualification","Are you retired from your last job?","Do you currently smoke cigarettes?","Frequency six or more drinks","Number of standard drinks","Frequency alcohol","Weight in kilograms","Do you regularly smoke pipe or cigar?","Currently working",null,"Age in 1994","Sex","Marital Status in 1994","Number of Years of school completed (1-20)","Working at present time?","Currently smoke?","Smoke, tobacco use","Alcohol use","Number of glasses of wine last week","Number of cans/bottles of beer last week","Number of drinks containing hard liquor last week","Participant sports, number of hours","Physical fitness, number of hours each week","Walking, number of hours per week","Spectator sports, number of hours spent per week","Dancing","Doing household chores, number of hours spent per week","Number of total hours in an average week exercising for shape/fun (not housework)","Number of times in past week exercised or played sports","Height in Inches","Weight in Pounds","Self-reported weight in pounds","Self-reported height in inches","Self-reported health compared to age peers","Twin number","What is your marital status?","Which of the following alternatives best describes your current work/retirement situation?","Do you smoke cigarettes, cigars or a pipe? - Yes","Do you take snuff? - Yes","Have you smoked more than 6 cigarettes, 4 cigars or used pipe tobacco or snuff during the last month?","Do you ever drink alcoholic beverages?","How much beer do you usually drink at a time?","..more than 1 bottle, i.e.____bottles (state number of bottles): GBOTVIN","How often do you consume more than five bottles of beer or more than one bottle of wine or more than 1/2 bottle liquot at one occasion?","Do you ever drink alcoholic drinks? - Yes","How often do you drink beer (not light beer)?","How often do you usually drink hard liquor? (e.g. aquavit, whiskey, gin, brandy, punsch. Also liquot in cocktails and long drinks)","How often do you usually drink wine (red or white)?","How much hard liquot do you usually drink at time?","Do you ever drink alcoholic drinks? -No I quit. When? 19__","How much wine do you usually drink at a time?","Here are seven different options concerning exercise during your leisure time. Which one of these options best fits how you yourself exercise on a yearly basis?","How tall are you? (cm)","How much do you weigh? (kg)","How do you judge your general state of health compared to other people your age?","How do you judge your general state of health?","BMI ((htcm/100)^2)",null,null,"age at Q3","Education",null,"year of birth","male or female","marital status","highest educational degree obtained","current job situation","ever smoked daily","smoke at the present time","how many years smoked","beverages consumed last 6 months","freq more than 2 glasses beer in a day","freq more than 2 glasses wine in a day","freq more than 2 hard liquor in a day","sports or activities that are vigorous","activities requiring a moderate level of energy","how tall are you?","weight of respondent","health in general question v 1","health in general question v 2","health in general question v 2","health in general question v 1","interview year","yeshiva, religious high institution","nursing school","polytechnic","university, Bachelors degree","university, graduate degree","still in further education or training","no further education","other further education","refused","dont know","Anonymised ID","Age at interview assuming DOB is 1st of specified month","Gender","gd002 - Is this respondent male or female?","SOCmarried  Currently married","cs006  Are you...?","mar4  Marital Status","dm001  What is the highest level of education you have completed","Which one of these would you say best describes your current situation?","Did you, nevertheless, do any paid work during the last week, either as an em?","bh001  Have you ever smoked cigarettes, cigars, cigarillos or a pipe daily for a per?","bh002  Do you smoke at the present time?","bh003  How old were you when you stopped smoking?","BEHsmoker  Smoker","BEHalc_drinksperday  Standard drinks per day","BEHalc_drinksperweek  Standard drinks a week","BEHalc_freq_week  Average times drinking per week","SCQalcofreq  frequency of drinking alcohol","SCQalcohol  drink alcohol","SCQalcono1  more than two drinks in a single day","SCQalcono2  How many drinks consumed on days drink taken","bh101  During the last 7 days, on how many days did you do vigorous physical activit?","bh102  How much time did you usually spend doing vigorous physical activities on one?","bh102a  How much time did you usually spend doing vigorous physical activities on one?","bh103  During the last 7 days, on how many days did you do moderate physical activit?","bh104  How much time did you usually spend doing moderate physical activities on one?","bh104a  How much time did you usually spend doing moderate physical activities on one?","bh105  During the last 7 days, on how many days did you walk for at least 10 minutes?","bh106  How much time did you usually spend walking on one of those days? HOURS","bh106a  How much time did you usually spend walking on one of those days? MINS","bh107  During the last 7 days, how much time did you spend sitting on a week day? HO?","bh107a  During the last 7 days, how much time did you spend sitting on a week day? MINS","IPAQmetminutes  Phsyical activity met-minutes","IPAQmetminutes  Phsyical activity met-minutes","SR_Height_Centimetres","Respondent height","SR_Weight_Kilogrammes","Respondent weight","ph001  Now I would like to ask you some questions about your health.  Would you say ?","ph009  In general, compared to other people your age, would you say your health is"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th> </th>\n      <th>study_name</th>\n      <th>name</th>\n      <th>item</th>\n      <th>construct</th>\n      <th>type</th>\n      <th>categories</th>\n      <th>label_short</th>\n      <th>label</th>\n    </tr>\n  </thead>\n</table>","options":{"pageLength":6,"autoWidth":true,"columnDefs":[{"className":"dt-right","targets":6},{"orderable":false,"targets":0}],"order":[],"orderClasses":false,"orderCellsTop":true,"lengthMenu":[6,10,25,50,100]},"callback":null,"caption":"<caption>This is the primary metadata file. Edit at `./data/shared/meta-data-map.csv</caption>","filter":"top","filterHTML":"<tr>\n  <td></td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"alsa\">alsa</option>\n        <option value=\"lbsl\">lbsl</option>\n        <option value=\"satsa\">satsa</option>\n        <option value=\"share\">share</option>\n        <option value=\"tilda\">tilda</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"AGE\">AGE</option>\n        <option value=\"AGE94\">AGE94</option>\n        <option value=\"ALCOHOL\">ALCOHOL</option>\n        <option value=\"BEER\">BEER</option>\n        <option value=\"BEHALC.DRINKSPERDAY\">BEHALC.DRINKSPERDAY</option>\n        <option value=\"BEHALC.DRINKSPERWEEK\">BEHALC.DRINKSPERWEEK</option>\n        <option value=\"BEHALC.FREQ.WEEK\">BEHALC.FREQ.WEEK</option>\n        <option value=\"BEHSMOKER\">BEHSMOKER</option>\n        <option value=\"BH001\">BH001</option>\n        <option value=\"BH002\">BH002</option>\n        <option value=\"BH003\">BH003</option>\n        <option value=\"BH101\">BH101</option>\n        <option value=\"BH102\">BH102</option>\n        <option value=\"BH102A\">BH102A</option>\n        <option value=\"BH103\">BH103</option>\n        <option value=\"BH104\">BH104</option>\n        <option value=\"BH104A\">BH104A</option>\n        <option value=\"BH105\">BH105</option>\n        <option value=\"BH106\">BH106</option>\n        <option value=\"BH106A\">BH106A</option>\n        <option value=\"BH107\">BH107</option>\n        <option value=\"BH107A\">BH107A</option>\n        <option value=\"BR0010\">BR0010</option>\n        <option value=\"BR0020\">BR0020</option>\n        <option value=\"BR0030\">BR0030</option>\n        <option value=\"BR0100\">BR0100</option>\n        <option value=\"BR0110\">BR0110</option>\n        <option value=\"BR0120\">BR0120</option>\n        <option value=\"BR0130\">BR0130</option>\n        <option value=\"BR0150\">BR0150</option>\n        <option value=\"BR0160\">BR0160</option>\n        <option value=\"BTSM12MN\">BTSM12MN</option>\n        <option value=\"CHORE94\">CHORE94</option>\n        <option value=\"CS006\">CS006</option>\n        <option value=\"CURRWORK\">CURRWORK</option>\n        <option value=\"DANCE94\">DANCE94</option>\n        <option value=\"DM001\">DM001</option>\n        <option value=\"DN0030\">DN0030</option>\n        <option value=\"DN0100\">DN0100</option>\n        <option value=\"DN012D01\">DN012D01</option>\n        <option value=\"DN012D02\">DN012D02</option>\n        <option value=\"DN012D03\">DN012D03</option>\n        <option value=\"DN012D04\">DN012D04</option>\n        <option value=\"DN012D05\">DN012D05</option>\n        <option value=\"DN012D09\">DN012D09</option>\n        <option value=\"DN012DDK\">DN012DDK</option>\n        <option value=\"DN012DNO\">DN012DNO</option>\n        <option value=\"DN012DOT\">DN012DOT</option>\n        <option value=\"DN012DRF\">DN012DRF</option>\n        <option value=\"DN0140\">DN0140</option>\n        <option value=\"EDUC\">EDUC</option>\n        <option value=\"EDUC94\">EDUC94</option>\n        <option value=\"EP0050\">EP0050</option>\n        <option value=\"EXCERTOT\">EXCERTOT</option>\n        <option value=\"EXCERWK\">EXCERWK</option>\n        <option value=\"EXRTHOUS\">EXRTHOUS</option>\n        <option value=\"FIT94\">FIT94</option>\n        <option value=\"FR6ORMOR\">FR6ORMOR</option>\n        <option value=\"FREQALCH\">FREQALCH</option>\n        <option value=\"GALCOHOL\">GALCOHOL</option>\n        <option value=\"GAMTWORK\">GAMTWORK</option>\n        <option value=\"GBEERX\">GBEERX</option>\n        <option value=\"GBOTVIN\">GBOTVIN</option>\n        <option value=\"GD002\">GD002</option>\n        <option value=\"GDRLOTS\">GDRLOTS</option>\n        <option value=\"GENDER\">GENDER</option>\n        <option value=\"GEVRALK\">GEVRALK</option>\n        <option value=\"GEVRSMK\">GEVRSMK</option>\n        <option value=\"GEVRSNS\">GEVRSNS</option>\n        <option value=\"GEXERCIS\">GEXERCIS</option>\n        <option value=\"GFREQBER\">GFREQBER</option>\n        <option value=\"GFREQLIQ\">GFREQLIQ</option>\n        <option value=\"GFREQVIN\">GFREQVIN</option>\n        <option value=\"GGENHLTH\">GGENHLTH</option>\n        <option value=\"GHLTHOTH\">GHLTHOTH</option>\n        <option value=\"GHTCM\">GHTCM</option>\n        <option value=\"GLIQX\">GLIQX</option>\n        <option value=\"GMARITAL\">GMARITAL</option>\n        <option value=\"GPI\">GPI</option>\n        <option value=\"GSMOKNOW\">GSMOKNOW</option>\n        <option value=\"GSTOPALK\">GSTOPALK</option>\n        <option value=\"GVINX\">GVINX</option>\n        <option value=\"GWTKG\">GWTKG</option>\n        <option value=\"HARDLIQ\">HARDLIQ</option>\n        <option value=\"HEIGHT\">HEIGHT</option>\n        <option value=\"HEIGHT94\">HEIGHT94</option>\n        <option value=\"HHEIGHT\">HHEIGHT</option>\n        <option value=\"HLTHBTSM\">HLTHBTSM</option>\n        <option value=\"HLTHLIFE\">HLTHLIFE</option>\n        <option value=\"HWEIGHT\">HWEIGHT</option>\n        <option value=\"HWMNWK2W\">HWMNWK2W</option>\n        <option value=\"ID\">ID</option>\n        <option value=\"INT.YEAR\">INT.YEAR</option>\n        <option value=\"IPAQEXERCISE3\">IPAQEXERCISE3</option>\n        <option value=\"IPAQMETMINUTES\">IPAQMETMINUTES</option>\n        <option value=\"LSVEXC2W\">LSVEXC2W</option>\n        <option value=\"LSVIGEXC\">LSVIGEXC</option>\n        <option value=\"MAR_4\">MAR_4</option>\n        <option value=\"MARITST\">MARITST</option>\n        <option value=\"MSTAT94\">MSTAT94</option>\n        <option value=\"NOSTDRNK\">NOSTDRNK</option>\n        <option value=\"NOWRK94\">NOWRK94</option>\n        <option value=\"PH001\">PH001</option>\n        <option value=\"PH0020\">PH0020</option>\n        <option value=\"PH0030\">PH0030</option>\n        <option value=\"PH009\">PH009</option>\n        <option value=\"PH0120\">PH0120</option>\n        <option value=\"PH0130\">PH0130</option>\n        <option value=\"PH0520\">PH0520</option>\n        <option value=\"PH0530\">PH0530</option>\n        <option value=\"PIPCIGAR\">PIPCIGAR</option>\n        <option value=\"QAGE3\">QAGE3</option>\n        <option value=\"RETIRED\">RETIRED</option>\n        <option value=\"SAMPID.rec\">SAMPID.rec</option>\n        <option value=\"SCHOOL\">SCHOOL</option>\n        <option value=\"SCQALCOFREQ\">SCQALCOFREQ</option>\n        <option value=\"SCQALCOHOL\">SCQALCOHOL</option>\n        <option value=\"SCQALCONO1\">SCQALCONO1</option>\n        <option value=\"SCQALCONO2\">SCQALCONO2</option>\n        <option value=\"SEQNUM\">SEQNUM</option>\n        <option value=\"SEX\">SEX</option>\n        <option value=\"SEX94\">SEX94</option>\n        <option value=\"SMK94\">SMK94</option>\n        <option value=\"SMOKE\">SMOKE</option>\n        <option value=\"SMOKER\">SMOKER</option>\n        <option value=\"SOCMARRIED\">SOCMARRIED</option>\n        <option value=\"SPEC94\">SPEC94</option>\n        <option value=\"SPORT94\">SPORT94</option>\n        <option value=\"SR.HEIGHT.CENTIMETRES\">SR.HEIGHT.CENTIMETRES</option>\n        <option value=\"SR.WEIGHT.KILOGRAMMES\">SR.WEIGHT.KILOGRAMMES</option>\n        <option value=\"SRHEALTH\">SRHEALTH</option>\n        <option value=\"TMHVYEXR\">TMHVYEXR</option>\n        <option value=\"TMVEXC2W\">TMVEXC2W</option>\n        <option value=\"TYPQUAL\">TYPQUAL</option>\n        <option value=\"VIGEXC2W\">VIGEXC2W</option>\n        <option value=\"VIGEXCS\">VIGEXCS</option>\n        <option value=\"WALK2WKS\">WALK2WKS</option>\n        <option value=\"WALK94\">WALK94</option>\n        <option value=\"WE001\">WE001</option>\n        <option value=\"WE003\">WE003</option>\n        <option value=\"WEIGHT\">WEIGHT</option>\n        <option value=\"WEIGHT94\">WEIGHT94</option>\n        <option value=\"WINE\">WINE</option>\n        <option value=\"YRBORN\">YRBORN</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"\"></option>\n        <option value=\"age\">age</option>\n        <option value=\"age_1994\">age_1994</option>\n        <option value=\"age_interview\">age_interview</option>\n        <option value=\"age_left_school\">age_left_school</option>\n        <option value=\"age_q3\">age_q3</option>\n        <option value=\"born_year\">born_year</option>\n        <option value=\"current_job\">current_job</option>\n        <option value=\"edu\">edu</option>\n        <option value=\"edu_highest\">edu_highest</option>\n        <option value=\"edu_hight\">edu_hight</option>\n        <option value=\"employed\">employed</option>\n        <option value=\"healt_self\">healt_self</option>\n        <option value=\"health_12ago\">health_12ago</option>\n        <option value=\"health_others\">health_others</option>\n        <option value=\"height_in\">height_in</option>\n        <option value=\"height_in_sr\">height_in_sr</option>\n        <option value=\"id\">id</option>\n        <option value=\"marital\">marital</option>\n        <option value=\"marital_2\">marital_2</option>\n        <option value=\"marital_4\">marital_4</option>\n        <option value=\"marital_6\">marital_6</option>\n        <option value=\"retired\">retired</option>\n        <option value=\"school_years\">school_years</option>\n        <option value=\"sex\">sex</option>\n        <option value=\"sex_gender\">sex_gender</option>\n        <option value=\"smoke_age\">smoke_age</option>\n        <option value=\"smoke_history\">smoke_history</option>\n        <option value=\"smoke_history2\">smoke_history2</option>\n        <option value=\"smoke_now\">smoke_now</option>\n        <option value=\"smoke_pipecigar\">smoke_pipecigar</option>\n        <option value=\"smoke_years\">smoke_years</option>\n        <option value=\"snuff_history\">snuff_history</option>\n        <option value=\"twin_id\">twin_id</option>\n        <option value=\"weight_kg\">weight_kg</option>\n        <option value=\"weight_lb\">weight_lb</option>\n        <option value=\"weight_lb_sr\">weight_lb_sr</option>\n        <option value=\"work_extra\">work_extra</option>\n        <option value=\"work_status\">work_status</option>\n        <option value=\"year_born\">year_born</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"age\">age</option>\n        <option value=\"alcohol\">alcohol</option>\n        <option value=\"education\">education</option>\n        <option value=\"health\">health</option>\n        <option value=\"id\">id</option>\n        <option value=\"marital\">marital</option>\n        <option value=\"physact\">physact</option>\n        <option value=\"physique\">physique</option>\n        <option value=\"sex\">sex</option>\n        <option value=\"smoking\">smoking</option>\n        <option value=\"work_status\">work_status</option>\n        <option value=\"year\">year</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"activity\">activity</option>\n        <option value=\"demo\">demo</option>\n        <option value=\"physical\">physical</option>\n        <option value=\"substance\">substance</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"integer\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"2\" data-max=\"8504\"></div>\n      <span style=\"float: left;\"></span>\n      <span style=\"float: right;\"></span>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"\"></option>\n        <option value=\"…more than 1 bottle\">…more than 1 bottle</option>\n        <option value=\"activities requiring a moderate level of energy\">activities requiring a moderate level of energy</option>\n        <option value=\"Age\">Age</option>\n        <option value=\"Age at current wave\">Age at current wave</option>\n        <option value=\"Age in 1994\">Age in 1994</option>\n        <option value=\"Age left school\">Age left school</option>\n        <option value=\"Age when stopped smoking\">Age when stopped smoking</option>\n        <option value=\"Alcohol use\">Alcohol use</option>\n        <option value=\"Alcoholic drinks\">Alcoholic drinks</option>\n        <option value=\"Anonymised ID\">Anonymised ID</option>\n        <option value=\"Any paid work last week?\">Any paid work last week?</option>\n        <option value=\"Are you retired from your last job?\">Are you retired from your last job?</option>\n        <option value=\"Average times drinking per week\">Average times drinking per week</option>\n        <option value=\"beverages consumed last 6 months\">beverages consumed last 6 months</option>\n        <option value=\"Compared to others  your age,  your health is\">Compared to others  your age,  your health is</option>\n        <option value=\"Current job situation\">Current job situation</option>\n        <option value=\"Currently smoke?\">Currently smoke?</option>\n        <option value=\"Currently working\">Currently working</option>\n        <option value=\"Dancing\">Dancing</option>\n        <option value=\"Describe current job situation\">Describe current job situation</option>\n        <option value=\"Describe current work/retirement situation\">Describe current work/retirement situation</option>\n        <option value=\"Do you currently smoke cigarettes?\">Do you currently smoke cigarettes?</option>\n        <option value=\"Do you ever drink alcoholic beverages?\">Do you ever drink alcoholic beverages?</option>\n        <option value=\"Do you ever drink alcoholic drinks? - Yes\">Do you ever drink alcoholic drinks? - Yes</option>\n        <option value=\"Do you ever drink alcoholic drinks? -No I quit. When? 19__\">Do you ever drink alcoholic drinks? -No I quit. When? 19__</option>\n        <option value=\"Do you regularly smoke pipe or cigar?\">Do you regularly smoke pipe or cigar?</option>\n        <option value=\"Do you smoke tobacco?\">Do you smoke tobacco?</option>\n        <option value=\"Do you take snuff?\">Do you take snuff?</option>\n        <option value=\"Doing household chores (hrs/wk)\">Doing household chores (hrs/wk)</option>\n        <option value=\"dont know\">dont know</option>\n        <option value=\"During the last 7 days, how much time did you spend sitting on a week day? HO?\">During the last 7 days, how much time did you spend sitting on a week day? HO?</option>\n        <option value=\"During the last 7 days, how much time did you spend sitting on a week day? MINS\">During the last 7 days, how much time did you spend sitting on a week day? MINS</option>\n        <option value=\"During the last 7 days, on how many days did you do moderate physical activit?\">During the last 7 days, on how many days did you do moderate physical activit?</option>\n        <option value=\"During the last 7 days, on how many days did you do vigorous physical activit?\">During the last 7 days, on how many days did you do vigorous physical activit?</option>\n        <option value=\"During the last 7 days, on how many days did you walk for at least 10 minutes?\">During the last 7 days, on how many days did you walk for at least 10 minutes?</option>\n        <option value=\"Edcuation\">Edcuation</option>\n        <option value=\"Education\">Education</option>\n        <option value=\"Ever smoked tobacco daily for a year?\">Ever smoked tobacco daily for a year?</option>\n        <option value=\"Exercised or played sports (oc/wk)\">Exercised or played sports (oc/wk)</option>\n        <option value=\"Exercising for shape/fun (hrs/wk)\">Exercising for shape/fun (hrs/wk)</option>\n        <option value=\"Exertion around house\">Exertion around house</option>\n        <option value=\"freq more than 2 glasses beer in a day\">freq more than 2 glasses beer in a day</option>\n        <option value=\"freq more than 2 glasses wine in a day\">freq more than 2 glasses wine in a day</option>\n        <option value=\"freq more than 2 hard liquor in a day\">freq more than 2 hard liquor in a day</option>\n        <option value=\"Frequency alcohol\">Frequency alcohol</option>\n        <option value=\"Frequency of drinking alcohol\">Frequency of drinking alcohol</option>\n        <option value=\"Frequency six or more drinks\">Frequency six or more drinks</option>\n        <option value=\"Gender\">Gender</option>\n        <option value=\"Health comp with 12mths ago\">Health comp with 12mths ago</option>\n        <option value=\"Health compared to others\">Health compared to others</option>\n        <option value=\"health in general question v 1\">health in general question v 1</option>\n        <option value=\"health in general question v 2\">health in general question v 2</option>\n        <option value=\"Height Centimetres\">Height Centimetres</option>\n        <option value=\"Height in Inches\">Height in Inches</option>\n        <option value=\"Highest qualification\">Highest qualification</option>\n        <option value=\"How do you judge your general state of health?\">How do you judge your general state of health?</option>\n        <option value=\"How many drinks consumed on days drink taken\">How many drinks consumed on days drink taken</option>\n        <option value=\"How many years smoked?\">How many years smoked?</option>\n        <option value=\"How much beer do you usually drink at a time?\">How much beer do you usually drink at a time?</option>\n        <option value=\"How much hard liquot do you usually drink at time?\">How much hard liquot do you usually drink at time?</option>\n        <option value=\"How much time did you usually spend doing moderate physical activities on one?\">How much time did you usually spend doing moderate physical activities on one?</option>\n        <option value=\"How much time did you usually spend doing vigorous physical activities on one?\">How much time did you usually spend doing vigorous physical activities on one?</option>\n        <option value=\"How much time did you usually spend walking on one of those days? HOURS\">How much time did you usually spend walking on one of those days? HOURS</option>\n        <option value=\"How much time did you usually spend walking on one of those days? MINS\">How much time did you usually spend walking on one of those days? MINS</option>\n        <option value=\"How much wine do you usually drink at a time?\">How much wine do you usually drink at a time?</option>\n        <option value=\"How often do you drink beer (not light beer)?\">How often do you drink beer (not light beer)?</option>\n        <option value=\"How often do you usually drink hard liquor?\">How often do you usually drink hard liquor?</option>\n        <option value=\"How often do you usually drink wine (red or white)?\">How often do you usually drink wine (red or white)?</option>\n        <option value=\"How often more than 5 beers?\">How often more than 5 beers?</option>\n        <option value=\"how tall are you?\">how tall are you?</option>\n        <option value=\"id\">id</option>\n        <option value=\"Id\">Id</option>\n        <option value=\"interview year\">interview year</option>\n        <option value=\"Judge your health compared to others your age?\">Judge your health compared to others your age?</option>\n        <option value=\"Less vigor past 2 weeks\">Less vigor past 2 weeks</option>\n        <option value=\"Less vigor sessions last 2 weeks\">Less vigor sessions last 2 weeks</option>\n        <option value=\"Male or Female?\">Male or Female?</option>\n        <option value=\"Marital status\">Marital status</option>\n        <option value=\"Marital Status\">Marital Status</option>\n        <option value=\"Marital Status in 1994\">Marital Status in 1994</option>\n        <option value=\"More than 2 drinks/day\">More than 2 drinks/day</option>\n        <option value=\"no further education\">no further education</option>\n        <option value=\"Number of cans/bottles of beer last week\">Number of cans/bottles of beer last week</option>\n        <option value=\"Number of drinks containing hard liquor last week\">Number of drinks containing hard liquor last week</option>\n        <option value=\"Number of glasses of wine last week\">Number of glasses of wine last week</option>\n        <option value=\"Number of standard drinks\">Number of standard drinks</option>\n        <option value=\"nursing school\">nursing school</option>\n        <option value=\"other further education\">other further education</option>\n        <option value=\"Participant sports, number of hours\">Participant sports, number of hours</option>\n        <option value=\"Physical activity met (minutes)\">Physical activity met (minutes)</option>\n        <option value=\"Physical fitness, number of hours each week\">Physical fitness, number of hours each week</option>\n        <option value=\"polytechnic\">polytechnic</option>\n        <option value=\"refused\">refused</option>\n        <option value=\"Respondent height\">Respondent height</option>\n        <option value=\"Respondent is a smoker\">Respondent is a smoker</option>\n        <option value=\"Respondent weight\">Respondent weight</option>\n        <option value=\"Self-rated health\">Self-rated health</option>\n        <option value=\"Self-reported health compared to age peers\">Self-reported health compared to age peers</option>\n        <option value=\"Self-reported height in inches\">Self-reported height in inches</option>\n        <option value=\"Self-reported weight in pounds\">Self-reported weight in pounds</option>\n        <option value=\"Sequence Number\">Sequence Number</option>\n        <option value=\"Sex\">Sex</option>\n        <option value=\"Smoke at present?\">Smoke at present?</option>\n        <option value=\"Smoke, tobacco use\">Smoke, tobacco use</option>\n        <option value=\"Smoked some last month?\">Smoked some last month?</option>\n        <option value=\"Spectator sports, number of hours spent per week\">Spectator sports, number of hours spent per week</option>\n        <option value=\"sports or activities that are vigorous\">sports or activities that are vigorous</option>\n        <option value=\"Standard drinks a week\">Standard drinks a week</option>\n        <option value=\"Standard drinks per day\">Standard drinks per day</option>\n        <option value=\"still in further education or training\">still in further education or training</option>\n        <option value=\"Time heavy physical exertion\">Time heavy physical exertion</option>\n        <option value=\"Times walked in past two weeks\">Times walked in past two weeks</option>\n        <option value=\"Twin number\">Twin number</option>\n        <option value=\"university, Bachelors degree\">university, Bachelors degree</option>\n        <option value=\"university, graduate degree\">university, graduate degree</option>\n        <option value=\"Vigor Sessions in past 2 weeks\">Vigor Sessions in past 2 weeks</option>\n        <option value=\"Vigor Time past 2 weeks\">Vigor Time past 2 weeks</option>\n        <option value=\"Vigorous exercise\">Vigorous exercise</option>\n        <option value=\"Walking past 2 weeks\">Walking past 2 weeks</option>\n        <option value=\"Walking, number of hours per week\">Walking, number of hours per week</option>\n        <option value=\"Weight in kilograms\">Weight in kilograms</option>\n        <option value=\"Weight in Pounds\">Weight in Pounds</option>\n        <option value=\"Weight Kilogrammes\">Weight Kilogrammes</option>\n        <option value=\"weight of respondent\">weight of respondent</option>\n        <option value=\"What about your health.  Would you say ?\">What about your health.  Would you say ?</option>\n        <option value=\"What is your marital status?\">What is your marital status?</option>\n        <option value=\"What option best describes your exercise on a yearly basis?\">What option best describes your exercise on a yearly basis?</option>\n        <option value=\"Working at present time?\">Working at present time?</option>\n        <option value=\"Year born\">Year born</option>\n        <option value=\"Years of school completed\">Years of school completed</option>\n        <option value=\"yeshiva, religious high institution\">yeshiva, religious high institution</option>\n      </select>\n    </div>\n  </td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\"></span>\n    </div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"..more than 1 bottle, i.e.____bottles (state number of bottles): GBOTVIN\">..more than 1 bottle, i.e.____bottles (state number of bottles): GBOTVIN</option>\n        <option value=\"activities requiring a moderate level of energy\">activities requiring a moderate level of energy</option>\n        <option value=\"Age\">Age</option>\n        <option value=\"Age at interview assuming DOB is 1st of specified month\">Age at interview assuming DOB is 1st of specified month</option>\n        <option value=\"age at Q3\">age at Q3</option>\n        <option value=\"Age in 1994\">Age in 1994</option>\n        <option value=\"Age left school\">Age left school</option>\n        <option value=\"Alcohol use\">Alcohol use</option>\n        <option value=\"Anonymised ID\">Anonymised ID</option>\n        <option value=\"Are you retired from your last job?\">Are you retired from your last job?</option>\n        <option value=\"BEHalc_drinksperday  Standard drinks per day\">BEHalc_drinksperday  Standard drinks per day</option>\n        <option value=\"BEHalc_drinksperweek  Standard drinks a week\">BEHalc_drinksperweek  Standard drinks a week</option>\n        <option value=\"BEHalc_freq_week  Average times drinking per week\">BEHalc_freq_week  Average times drinking per week</option>\n        <option value=\"BEHsmoker  Smoker\">BEHsmoker  Smoker</option>\n        <option value=\"beverages consumed last 6 months\">beverages consumed last 6 months</option>\n        <option value=\"bh001  Have you ever smoked cigarettes, cigars, cigarillos or a pipe daily for a per?\">bh001  Have you ever smoked cigarettes, cigars, cigarillos or a pipe daily for a per?</option>\n        <option value=\"bh002  Do you smoke at the present time?\">bh002  Do you smoke at the present time?</option>\n        <option value=\"bh003  How old were you when you stopped smoking?\">bh003  How old were you when you stopped smoking?</option>\n        <option value=\"bh101  During the last 7 days, on how many days did you do vigorous physical activit?\">bh101  During the last 7 days, on how many days did you do vigorous physical activit?</option>\n        <option value=\"bh102  How much time did you usually spend doing vigorous physical activities on one?\">bh102  How much time did you usually spend doing vigorous physical activities on one?</option>\n        <option value=\"bh102a  How much time did you usually spend doing vigorous physical activities on one?\">bh102a  How much time did you usually spend doing vigorous physical activities on one?</option>\n        <option value=\"bh103  During the last 7 days, on how many days did you do moderate physical activit?\">bh103  During the last 7 days, on how many days did you do moderate physical activit?</option>\n        <option value=\"bh104  How much time did you usually spend doing moderate physical activities on one?\">bh104  How much time did you usually spend doing moderate physical activities on one?</option>\n        <option value=\"bh104a  How much time did you usually spend doing moderate physical activities on one?\">bh104a  How much time did you usually spend doing moderate physical activities on one?</option>\n        <option value=\"bh105  During the last 7 days, on how many days did you walk for at least 10 minutes?\">bh105  During the last 7 days, on how many days did you walk for at least 10 minutes?</option>\n        <option value=\"bh106  How much time did you usually spend walking on one of those days? HOURS\">bh106  How much time did you usually spend walking on one of those days? HOURS</option>\n        <option value=\"bh106a  How much time did you usually spend walking on one of those days? MINS\">bh106a  How much time did you usually spend walking on one of those days? MINS</option>\n        <option value=\"bh107  During the last 7 days, how much time did you spend sitting on a week day? HO?\">bh107  During the last 7 days, how much time did you spend sitting on a week day? HO?</option>\n        <option value=\"bh107a  During the last 7 days, how much time did you spend sitting on a week day? MINS\">bh107a  During the last 7 days, how much time did you spend sitting on a week day? MINS</option>\n        <option value=\"BMI ((htcm/100)^2)\">BMI ((htcm/100)^2)</option>\n        <option value=\"cs006  Are you...?\">cs006  Are you...?</option>\n        <option value=\"current job situation\">current job situation</option>\n        <option value=\"Currently smoke?\">Currently smoke?</option>\n        <option value=\"Currently working\">Currently working</option>\n        <option value=\"Dancing\">Dancing</option>\n        <option value=\"Did you, nevertheless, do any paid work during the last week, either as an em?\">Did you, nevertheless, do any paid work during the last week, either as an em?</option>\n        <option value=\"dm001  What is the highest level of education you have completed\">dm001  What is the highest level of education you have completed</option>\n        <option value=\"Do you currently smoke cigarettes?\">Do you currently smoke cigarettes?</option>\n        <option value=\"Do you ever drink alcoholic beverages?\">Do you ever drink alcoholic beverages?</option>\n        <option value=\"Do you ever drink alcoholic drinks? - Yes\">Do you ever drink alcoholic drinks? - Yes</option>\n        <option value=\"Do you ever drink alcoholic drinks? -No I quit. When? 19__\">Do you ever drink alcoholic drinks? -No I quit. When? 19__</option>\n        <option value=\"Do you regularly smoke pipe or cigar?\">Do you regularly smoke pipe or cigar?</option>\n        <option value=\"Do you smoke cigarettes, cigars or a pipe? - Yes\">Do you smoke cigarettes, cigars or a pipe? - Yes</option>\n        <option value=\"Do you take snuff? - Yes\">Do you take snuff? - Yes</option>\n        <option value=\"Doing household chores, number of hours spent per week\">Doing household chores, number of hours spent per week</option>\n        <option value=\"dont know\">dont know</option>\n        <option value=\"Education\">Education</option>\n        <option value=\"ever smoked daily\">ever smoked daily</option>\n        <option value=\"Exertion around house\">Exertion around house</option>\n        <option value=\"freq more than 2 glasses beer in a day\">freq more than 2 glasses beer in a day</option>\n        <option value=\"freq more than 2 glasses wine in a day\">freq more than 2 glasses wine in a day</option>\n        <option value=\"freq more than 2 hard liquor in a day\">freq more than 2 hard liquor in a day</option>\n        <option value=\"Frequency alcohol\">Frequency alcohol</option>\n        <option value=\"Frequency six or more drinks\">Frequency six or more drinks</option>\n        <option value=\"gd002 - Is this respondent male or female?\">gd002 - Is this respondent male or female?</option>\n        <option value=\"Gender\">Gender</option>\n        <option value=\"Have you smoked more than 6 cigarettes, 4 cigars or used pipe tobacco or snuff during the last month?\">Have you smoked more than 6 cigarettes, 4 cigars or used pipe tobacco or snuff during the last month?</option>\n        <option value=\"Health comp with 12mths ago\">Health comp with 12mths ago</option>\n        <option value=\"Health compared to others\">Health compared to others</option>\n        <option value=\"health in general question v 1\">health in general question v 1</option>\n        <option value=\"health in general question v 2\">health in general question v 2</option>\n        <option value=\"Height in Inches\">Height in Inches</option>\n        <option value=\"Here are seven different options concerning exercise during your leisure time. Which one of these options best fits how you yourself exercise on a yearly basis?\">Here are seven different options concerning exercise during your leisure time. Which one of these options best fits how you yourself exercise on a yearly basis?</option>\n        <option value=\"highest educational degree obtained\">highest educational degree obtained</option>\n        <option value=\"Highest qualification\">Highest qualification</option>\n        <option value=\"How do you judge your general state of health compared to other people your age?\">How do you judge your general state of health compared to other people your age?</option>\n        <option value=\"How do you judge your general state of health?\">How do you judge your general state of health?</option>\n        <option value=\"how many years smoked\">how many years smoked</option>\n        <option value=\"How much beer do you usually drink at a time?\">How much beer do you usually drink at a time?</option>\n        <option value=\"How much do you weigh? (kg)\">How much do you weigh? (kg)</option>\n        <option value=\"How much hard liquot do you usually drink at time?\">How much hard liquot do you usually drink at time?</option>\n        <option value=\"How much wine do you usually drink at a time?\">How much wine do you usually drink at a time?</option>\n        <option value=\"How often do you consume more than five bottles of beer or more than one bottle of wine or more than 1/2 bottle liquot at one occasion?\">How often do you consume more than five bottles of beer or more than one bottle of wine or more than 1/2 bottle liquot at one occasion?</option>\n        <option value=\"How often do you drink beer (not light beer)?\">How often do you drink beer (not light beer)?</option>\n        <option value=\"How often do you usually drink hard liquor? (e.g. aquavit, whiskey, gin, brandy, punsch. Also liquot in cocktails and long drinks)\">How often do you usually drink hard liquor? (e.g. aquavit, whiskey, gin, brandy, punsch. Also liquot in cocktails and long drinks)</option>\n        <option value=\"How often do you usually drink wine (red or white)?\">How often do you usually drink wine (red or white)?</option>\n        <option value=\"how tall are you?\">how tall are you?</option>\n        <option value=\"How tall are you? (cm)\">How tall are you? (cm)</option>\n        <option value=\"interview year\">interview year</option>\n        <option value=\"IPAQmetminutes  Phsyical activity met-minutes\">IPAQmetminutes  Phsyical activity met-minutes</option>\n        <option value=\"Less vigor past 2 weeks\">Less vigor past 2 weeks</option>\n        <option value=\"Less vigor sessions last 2 weeks\">Less vigor sessions last 2 weeks</option>\n        <option value=\"male or female\">male or female</option>\n        <option value=\"mar4  Marital Status\">mar4  Marital Status</option>\n        <option value=\"marital status\">marital status</option>\n        <option value=\"Marital status\">Marital status</option>\n        <option value=\"Marital Status in 1994\">Marital Status in 1994</option>\n        <option value=\"no further education\">no further education</option>\n        <option value=\"Number of cans/bottles of beer last week\">Number of cans/bottles of beer last week</option>\n        <option value=\"Number of drinks containing hard liquor last week\">Number of drinks containing hard liquor last week</option>\n        <option value=\"Number of glasses of wine last week\">Number of glasses of wine last week</option>\n        <option value=\"Number of standard drinks\">Number of standard drinks</option>\n        <option value=\"Number of times in past week exercised or played sports\">Number of times in past week exercised or played sports</option>\n        <option value=\"Number of total hours in an average week exercising for shape/fun (not housework)\">Number of total hours in an average week exercising for shape/fun (not housework)</option>\n        <option value=\"Number of Years of school completed (1-20)\">Number of Years of school completed (1-20)</option>\n        <option value=\"nursing school\">nursing school</option>\n        <option value=\"other further education\">other further education</option>\n        <option value=\"Participant sports, number of hours\">Participant sports, number of hours</option>\n        <option value=\"ph001  Now I would like to ask you some questions about your health.  Would you say ?\">ph001  Now I would like to ask you some questions about your health.  Would you say ?</option>\n        <option value=\"ph009  In general, compared to other people your age, would you say your health is\">ph009  In general, compared to other people your age, would you say your health is</option>\n        <option value=\"Physical fitness, number of hours each week\">Physical fitness, number of hours each week</option>\n        <option value=\"polytechnic\">polytechnic</option>\n        <option value=\"refused\">refused</option>\n        <option value=\"Respondent height\">Respondent height</option>\n        <option value=\"Respondent weight\">Respondent weight</option>\n        <option value=\"SCQalcofreq  frequency of drinking alcohol\">SCQalcofreq  frequency of drinking alcohol</option>\n        <option value=\"SCQalcohol  drink alcohol\">SCQalcohol  drink alcohol</option>\n        <option value=\"SCQalcono1  more than two drinks in a single day\">SCQalcono1  more than two drinks in a single day</option>\n        <option value=\"SCQalcono2  How many drinks consumed on days drink taken\">SCQalcono2  How many drinks consumed on days drink taken</option>\n        <option value=\"Self-rated health\">Self-rated health</option>\n        <option value=\"Self-reported health compared to age peers\">Self-reported health compared to age peers</option>\n        <option value=\"Self-reported height in inches\">Self-reported height in inches</option>\n        <option value=\"Self-reported weight in pounds\">Self-reported weight in pounds</option>\n        <option value=\"Sequence Number\">Sequence Number</option>\n        <option value=\"Sex\">Sex</option>\n        <option value=\"smoke at the present time\">smoke at the present time</option>\n        <option value=\"Smoke, tobacco use\">Smoke, tobacco use</option>\n        <option value=\"SOCmarried  Currently married\">SOCmarried  Currently married</option>\n        <option value=\"Spectator sports, number of hours spent per week\">Spectator sports, number of hours spent per week</option>\n        <option value=\"sports or activities that are vigorous\">sports or activities that are vigorous</option>\n        <option value=\"SR_Height_Centimetres\">SR_Height_Centimetres</option>\n        <option value=\"SR_Weight_Kilogrammes\">SR_Weight_Kilogrammes</option>\n        <option value=\"still in further education or training\">still in further education or training</option>\n        <option value=\"Time heavy physical exertion\">Time heavy physical exertion</option>\n        <option value=\"Times walked in past two weeks\">Times walked in past two weeks</option>\n        <option value=\"Twin number\">Twin number</option>\n        <option value=\"university, Bachelors degree\">university, Bachelors degree</option>\n        <option value=\"university, graduate degree\">university, graduate degree</option>\n        <option value=\"Vigor Sessions in past 2 weeks\">Vigor Sessions in past 2 weeks</option>\n        <option value=\"Vigor Time past 2 weeks\">Vigor Time past 2 weeks</option>\n        <option value=\"Vigorous exercise\">Vigorous exercise</option>\n        <option value=\"Walking past 2 weeks\">Walking past 2 weeks</option>\n        <option value=\"Walking, number of hours per week\">Walking, number of hours per week</option>\n        <option value=\"Weight in kilograms\">Weight in kilograms</option>\n        <option value=\"Weight in Pounds\">Weight in Pounds</option>\n        <option value=\"weight of respondent\">weight of respondent</option>\n        <option value=\"What is your marital status?\">What is your marital status?</option>\n        <option value=\"Which of the following alternatives best describes your current work/retirement situation?\">Which of the following alternatives best describes your current work/retirement situation?</option>\n        <option value=\"Which one of these would you say best describes your current situation?\">Which one of these would you say best describes your current situation?</option>\n        <option value=\"Working at present time?\">Working at present time?</option>\n        <option value=\"year of birth\">year of birth</option>\n        <option value=\"yeshiva, religious high institution\">yeshiva, religious high institution</option>\n      </select>\n    </div>\n  </td>\n</tr>"},"evals":[]}</script><!--/html_preserve-->

<!-- Tweak the datasets.   -->


<!-- Basic table view.   -->



## (I.B) Target-H

> Everybody wants to be somebody.

We query metadata set to retrieve all variables potentially tapping the construct `marital`. These are the candidates to enter the DataSchema and contribute to  computing harmonized variables. 

***NOTE***: what is being retrieved depends on the manually entered values in the column `construct` of the metadata file `./data/shared/meta-data-map.csv`. To specify a different group of variables, edit the  metadata, not the script. 


```r
meta_data <- dto[["metaData"]] %>%
  dplyr::filter(construct %in% c('marital')) %>% 
  dplyr::select(study_name, name, construct, label_short, categories, url) %>%
  dplyr::arrange(construct, study_name)
knitr::kable(meta_data)
```



study_name   name         construct   label_short                     categories  url 
-----------  -----------  ----------  -----------------------------  -----------  ----
alsa         MARITST      marital     Marital status                           7      
lbsl         MSTAT94      marital     Marital Status in 1994                   6      
satsa        GMARITAL     marital     What is your marital status?             5      
share        DN0140       marital     Marital Status                           9      
tilda        SOCMARRIED   marital                                              2      
tilda        CS006        marital                                              6      
tilda        MAR_4        marital                                              4      

View [descriptives : marital](https://rawgit.com/IALSA/ialsa-2016-groningen-public/master/describe-marital.html) for closer examination of each candidate. 

The responses to variables loading on the construct `marital` are as such:
![marital raw](../../libs/images/harmonize/harmonize-marital-raw.PNG )

After reorganizing the possible repsonses, the following clustering has emerged

![marital harmonized](../../libs/images/harmonize/harmonize-marital-harmonized.PNG )

After reviewing descriptives and relevant codebooks, the following operationalization of the harmonized variables for `marital` have been adopted:

#### Target (1) : `marital`   
  - `-1` - `mar_cohab` - married or cohabiting
  - `0` - `single`- not married - REFERENCE
  - `1` - `sep_divorced` - separated or divorced
  - `2` - `widowed` - widowed
  
#### Target (2) : `single`
  - `0` - `FALSE` - Reference group
  - `1` - `TRUE` - Risk factor
  
These variables will be generated next, in the Development section. 

# (II) Development

The particulare goal of this section is to ensure that the schema to encode the values for the `marital` variable is consisten across studies. 

In this section we will define the schema sets for harmonizing `marital` construct (i.e.  specify which variables from which studies will be contributing to computing harmonized variables ). Each of these schema sets will have a particular pattern of possible response values to these variables, which we will export for inspection as `.csv` tables. We then will manually edit these `.csv` tables, populating new columns that will map values of harmonized variables to the specific response pattern of the schema set variables. We then will import harmonization algorithms encoded in `.csv` tables and apply them to compute harmonized variables in the dataset combining raw and harmonized variables for `marital` construct across studies.

## (II.A) 


### (1) Schema sets
Having all potential variables in categorical format we have defined the sets of data schema variables thus: 

Each of these schema sets  have a particular pattern of possible response values, for example:


We output these tables into self-standing `.csv` files, so we can manually provide the logic of computing harmonized variables.



You can examine them in [`./data/meta/response-profiles-live/](https://github.com/IALSA/ialsa-2016-groningen/tree/master/data/meta/response-profiles-live)

## (II.B) `marital`

#### Target : `marital`   
  - `1` - `mar_cohab` - married or cohabiting
  - `2` - `sep_divorced` - separated or divorced
  - `3` - `single`- not married
  - `4` - `widowed` - widowed
  

### ALSA

Items that can contribute to generating values for the harmonized variable `marital`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name=="alsa", construct %in% c("marital")) %>%
  dplyr::select(study_name, name, label,categories)
```

```
  study_name    name          label categories
1       alsa MARITST Marital status          7
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "alsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-marital-alsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("MARITST"), 
  harmony_name = "marital"
)
```

```
Source: local data frame [7 x 3]
Groups: MARITST [?]

        MARITST      marital     n
          (chr)        (chr) (int)
1      De facto    mar_cohab     6
2      Divorced sep_divorced    33
3       Married    mar_cohab  1361
4 Never married       single    76
5     Separated sep_divorced    16
6       Widowed      widowed   594
7            NA           NA     1
```

```r
# verify
dto[["unitData"]][["alsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "MARITST","marital")
```

```
      id MARITST   marital
1   4791 Married mar_cohab
2   8281 Widowed   widowed
3  10782 Married mar_cohab
4  13451 Married mar_cohab
5  17972 Married mar_cohab
6  19011 Married mar_cohab
7  24211 Married mar_cohab
8  25652 Married mar_cohab
9  26151 Widowed   widowed
10 32002 Married mar_cohab
```


### LBSL
Items that can contribute to generating values for the harmonized variable `marital`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "lbsl", construct == "marital") %>%
  # dplyr::filter(name %in% c("MSTAT94")) %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
  study_name    name            label_short categories
1       lbsl MSTAT94 Marital Status in 1994          6
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "lbsl"
path_to_hrule <- "./data/meta/h-rules/h-rules-marital-lbsl.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("MSTAT94"), 
  harmony_name = "marital"
)
```

```
Source: local data frame [6 x 3]
Groups: MSTAT94 [?]

    MSTAT94      marital     n
      (chr)        (chr) (int)
1  divorced sep_divorced    73
2   married    mar_cohab   326
3 separated sep_divorced     4
4    single       single    22
5   widowed      widowed   134
6        NA           NA    97
```

```r
# verify
dto[["unitData"]][["lbsl"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "MSTAT94", "marital")
```

```
        id MSTAT94   marital
1  4111082 married mar_cohab
2  4141201    <NA>      <NA>
3  4141209 married mar_cohab
4  4192094 married mar_cohab
5  4241084    <NA>      <NA>
6  4281045 married mar_cohab
7  4311077 married mar_cohab
8  4332014 married mar_cohab
9  4342073 married mar_cohab
10 4381021 married mar_cohab
```


### SATSA

Items that can contribute to generating values for the harmonized variable `marital`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "satsa", construct == "marital") %>%
  # dplyr::filter(name %in% c("GMARITAL")) %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
  study_name     name                  label_short categories
1      satsa GMARITAL What is your marital status?          5
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "satsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-marital-satsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("GMARITAL"), 
  harmony_name = "marital"
)
```

```
Source: local data frame [5 x 3]
Groups: GMARITAL [?]

                              GMARITAL      marital     n
                                 (chr)        (chr) (int)
1                             divorced sep_divorced   113
2 married /living together with person    mar_cohab   961
3                          Not married       single   149
4                        widow/widower      widowed   259
5                                   NA           NA    15
```

```r
# verify
dto[["unitData"]][["satsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "GMARITAL", "marital")
```

```
        id                             GMARITAL      marital
1   160321 married /living together with person    mar_cohab
2   179862                             divorced sep_divorced
3   180102 married /living together with person    mar_cohab
4   260401 married /living together with person    mar_cohab
5  2133602 married /living together with person    mar_cohab
6  2150842 married /living together with person    mar_cohab
7  2189202 married /living together with person    mar_cohab
8  2211702                             divorced sep_divorced
9  2281712                             divorced sep_divorced
10 2444562                          Not married       single
```

### SHARE

Items that can contribute to generating values for the harmonized variable `marital`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "share", construct == "marital") %>%
  # dplyr::filter(name %in% c("DN0140")) %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
  study_name   name    label_short categories
1      share DN0140 Marital Status          9
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "share"
path_to_hrule <- "./data/meta/h-rules/h-rules-marital-share.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("DN0140"), 
  harmony_name = "marital"
)
```

```
Source: local data frame [9 x 3]
Groups: DN0140 [?]

                                   DN0140      marital     n
                                    (chr)        (chr) (int)
1                                divorced sep_divorced   140
2                              don't know           NA     1
3 married and living together with spouse    mar_cohab  2039
4   married, living separated from spouse sep_divorced    19
5                           never married       single    51
6                                 refusal           NA     1
7                  registered partnership    mar_cohab    10
8                                 widowed      widowed   336
9                                      NA           NA     1
```

```r
# verify
dto[["unitData"]][["share"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "DN0140", "marital")
```

```
             id                                  DN0140      marital
1  2.505202e+12                           never married       single
2  2.505233e+12                                 widowed      widowed
3  2.505245e+12 married and living together with spouse    mar_cohab
4  2.505253e+12                                 widowed      widowed
5  2.505271e+12 married and living together with spouse    mar_cohab
6  2.505277e+12                                divorced sep_divorced
7  2.505293e+12 married and living together with spouse    mar_cohab
8  2.605233e+12 married and living together with spouse    mar_cohab
9  2.605246e+12 married and living together with spouse    mar_cohab
10 2.605258e+12 married and living together with spouse    mar_cohab
```


### TILDA

Items that can contribute to generating values for the harmonized variable `marital`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "tilda", construct == "marital") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
  study_name       name label_short categories
1      tilda SOCMARRIED                      2
2      tilda      CS006                      6
3      tilda      MAR_4                      4
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "tilda"
path_to_hrule <- "./data/meta/h-rules/h-rules-marital-tilda.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("SOCMARRIED", "MAR_4", "CS006"), 
  harmony_name = "marital"
)
```

```
Source: local data frame [6 x 5]
Groups: SOCMARRIED, MAR_4, CS006 [?]

   SOCMARRIED         MAR_4                               CS006      marital     n
        (chr)         (chr)                               (chr)        (chr) (int)
1     Married       Married Living with a partner as if married    mar_cohab   218
2     Married       Married                             Married    mar_cohab  5748
3 Not married Never married              Single (never married)       single   791
4 Not married  Sep/divorced                            Divorced sep_divorced   200
5 Not married  Sep/divorced                           Separated sep_divorced   352
6 Not married       Widowed                             Widowed      widowed  1195
```

```r
# verify
dto[["unitData"]][["tilda"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "SOCMARRIED", "MAR_4", "CS006", "marital")
```

```
                   id  SOCMARRIED        MAR_4     CS006      marital
1  26282                  Married      Married   Married    mar_cohab
2  70031                  Married      Married   Married    mar_cohab
3  82052                  Married      Married   Married    mar_cohab
4  82321              Not married      Widowed   Widowed      widowed
5  101792                 Married      Married   Married    mar_cohab
6  161181             Not married Sep/divorced Separated sep_divorced
7  179911                 Married      Married   Married    mar_cohab
8  189482                 Married      Married   Married    mar_cohab
9  304501                 Married      Married   Married    mar_cohab
10 457051             Not married      Widowed   Widowed      widowed
```

## (II.B) `single`

#### Target (2) : `single`
  - `0` - `FALSE` - Reference group
  - `1` - `TRUE` - Risk factor
  

### ALSA

Items that can contribute to generating values for the harmonized variable `single`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name=="alsa", construct %in% c("marital")) %>%
  dplyr::select(study_name, name, label,categories)
```

```
  study_name    name          label categories
1       alsa MARITST Marital status          7
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "alsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-marital-alsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("MARITST"), 
  harmony_name = "single"
)
```

```
Source: local data frame [7 x 3]
Groups: MARITST [?]

        MARITST single     n
          (chr)  (lgl) (int)
1      De facto  FALSE     6
2      Divorced   TRUE    33
3       Married  FALSE  1361
4 Never married   TRUE    76
5     Separated   TRUE    16
6       Widowed   TRUE   594
7            NA     NA     1
```

```r
# verify
dto[["unitData"]][["alsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "MARITST","single")
```

```
      id MARITST single
1   5261 Widowed   TRUE
2   8462 Married  FALSE
3   8701 Widowed   TRUE
4  13031 Married  FALSE
5  14162 Married  FALSE
6  15731 Married  FALSE
7  19282 Married  FALSE
8  21041 Married  FALSE
9  25731 Widowed   TRUE
10 27921 Widowed   TRUE
```


### LBLS
Items that can contribute to generating values for the harmonized variable `single`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "lbsl", construct == "marital") %>%
  # dplyr::filter(name %in% c("MSTAT94")) %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
  study_name    name            label_short categories
1       lbsl MSTAT94 Marital Status in 1994          6
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "lbsl"
path_to_hrule <- "./data/meta/h-rules/h-rules-marital-lbsl.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("MSTAT94"), 
  harmony_name = "single"
)
```

```
Source: local data frame [6 x 3]
Groups: MSTAT94 [?]

    MSTAT94 single     n
      (chr)  (lgl) (int)
1  divorced   TRUE    73
2   married  FALSE   326
3 separated   TRUE     4
4    single   TRUE    22
5   widowed   TRUE   134
6        NA     NA    97
```

```r
# verify
dto[["unitData"]][["lbsl"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "MSTAT94", "single")
```

```
        id   MSTAT94 single
1  4121170   married  FALSE
2  4122002      <NA>     NA
3  4132186   widowed   TRUE
4  4241079   married  FALSE
5  4251073   married  FALSE
6  4261083   married  FALSE
7  4322073  divorced   TRUE
8  4361043   married  FALSE
9  4442038 separated   TRUE
10 4491032   married  FALSE
```


### SATSA

Items that can contribute to generating values for the harmonized variable `single`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "satsa", construct == "marital") %>%
  # dplyr::filter(name %in% c("GMARITAL")) %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
  study_name     name                  label_short categories
1      satsa GMARITAL What is your marital status?          5
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "satsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-marital-satsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("GMARITAL"), 
  harmony_name = "single"
)
```

```
Source: local data frame [5 x 3]
Groups: GMARITAL [?]

                              GMARITAL single     n
                                 (chr)  (lgl) (int)
1                             divorced   TRUE   113
2 married /living together with person  FALSE   961
3                          Not married   TRUE   149
4                        widow/widower   TRUE   259
5                                   NA     NA    15
```

```r
# verify
dto[["unitData"]][["satsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "GMARITAL", "single")
```

```
        id                             GMARITAL single
1    16991                        widow/widower   TRUE
2   146391 married /living together with person  FALSE
3   146971                        widow/widower   TRUE
4   152801                          Not married   TRUE
5   165201 married /living together with person  FALSE
6   176421 married /living together with person  FALSE
7   299221 married /living together with person  FALSE
8  2176302                             divorced   TRUE
9  2245201                        widow/widower   TRUE
10 2258502 married /living together with person  FALSE
```

### SHARE

Items that can contribute to generating values for the harmonized variable `single`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "share", construct == "marital") %>%
  # dplyr::filter(name %in% c("DN0140")) %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
  study_name   name    label_short categories
1      share DN0140 Marital Status          9
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "share"
path_to_hrule <- "./data/meta/h-rules/h-rules-marital-share.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("DN0140"), 
  harmony_name = "single"
)
```

```
Source: local data frame [9 x 3]
Groups: DN0140 [?]

                                   DN0140 single     n
                                    (chr)  (lgl) (int)
1                                divorced   TRUE   140
2                              don't know     NA     1
3 married and living together with spouse  FALSE  2039
4   married, living separated from spouse   TRUE    19
5                           never married   TRUE    51
6                                 refusal     NA     1
7                  registered partnership  FALSE    10
8                                 widowed   TRUE   336
9                                      NA     NA     1
```

```r
# verify
dto[["unitData"]][["share"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "DN0140", "single")
```

```
             id                                  DN0140 single
1  2.505209e+12                                 widowed   TRUE
2  2.505226e+12 married and living together with spouse  FALSE
3  2.505250e+12 married and living together with spouse  FALSE
4  2.505256e+12 married and living together with spouse  FALSE
5  2.505265e+12 married and living together with spouse  FALSE
6  2.505277e+12 married and living together with spouse  FALSE
7  2.505285e+12 married and living together with spouse  FALSE
8  2.505291e+12                                 widowed   TRUE
9  2.505298e+12 married and living together with spouse  FALSE
10 2.605207e+12 married and living together with spouse  FALSE
```


### TILDA

Items that can contribute to generating values for the harmonized variable `single`  are:

```r
dto[["metaData"]] %>%
  dplyr::filter(study_name == "tilda", construct == "marital") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short,categories)
```

```
  study_name       name label_short categories
1      tilda SOCMARRIED                      2
2      tilda      CS006                      6
3      tilda      MAR_4                      4
```
We encode the harmonization rule by manually editing the values in a corresponding `.csv` file located in  `./data/meta/h-rules/`. Then, we apply the recoding logic it contains and append the newly created, harmonized variable to the initial data set. 

```r
study_name <- "tilda"
path_to_hrule <- "./data/meta/h-rules/h-rules-marital-tilda.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("SOCMARRIED", "MAR_4", "CS006"), 
  harmony_name = "single"
)
```

```
Source: local data frame [6 x 5]
Groups: SOCMARRIED, MAR_4, CS006 [?]

   SOCMARRIED         MAR_4                               CS006 single     n
        (chr)         (chr)                               (chr)  (lgl) (int)
1     Married       Married Living with a partner as if married  FALSE   218
2     Married       Married                             Married  FALSE  5748
3 Not married Never married              Single (never married)   TRUE   791
4 Not married  Sep/divorced                            Divorced   TRUE   200
5 Not married  Sep/divorced                           Separated   TRUE   352
6 Not married       Widowed                             Widowed   TRUE  1195
```

```r
# verify
dto[["unitData"]][["tilda"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "SOCMARRIED", "MAR_4", "CS006", "single")
```

```
                   id  SOCMARRIED        MAR_4     CS006 single
1  55571                  Married      Married   Married  FALSE
2  81301              Not married      Widowed   Widowed   TRUE
3  138281             Not married Sep/divorced Separated   TRUE
4  152481                 Married      Married   Married  FALSE
5  235791                 Married      Married   Married  FALSE
6  349131                 Married      Married   Married  FALSE
7  367132                 Married      Married   Married  FALSE
8  461252                 Married      Married   Married  FALSE
9  478612                 Married      Married   Married  FALSE
10 524571                 Married      Married   Married  FALSE
```


# (III) Recapitulation 

At this point the `dto[["unitData"]]` elements (raw data files for each study) have been augmented with the harmonized variable `marital`. We retrieve harmonized variables to view frequency counts across studies: 


```r
dumlist <- list()
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]]
  dumlist[[s]] <- ds[,c("id","marital","single")]
}
ds <- plyr::ldply(dumlist,data.frame,.id = "study_name")
head(ds)
```

```
  study_name  id   marital single
1       alsa  41 mar_cohab  FALSE
2       alsa  42 mar_cohab  FALSE
3       alsa  61   widowed   TRUE
4       alsa  71   widowed   TRUE
5       alsa  91   widowed   TRUE
6       alsa 121   widowed   TRUE
```

```r
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
table( ds$marital, ds$study_name, useNA = "always")
```

```
              
               alsa lbsl satsa share tilda <NA>
  mar_cohab    1367  326   961  2049  5966    0
  sep_divorced   49   77   113   159   552    0
  single         76   22   149    51   791    0
  widowed       594  134   259   336  1195    0
  <NA>            1   97    15     3     0    0
```

```r
table( ds$single, ds$study_name, useNA = "always")
```

```
       
        alsa lbsl satsa share tilda <NA>
  FALSE 1367  326   961  2049  5966    0
  TRUE   719  233   521   546  2538    0
  <NA>     1   97    15     3     0    0
```


Finally, we have added the newly created, harmonized variables to the raw source objects and save the data transfer object.


```r
# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
saveRDS(dto, file="./data/unshared/derived/dto.rds", compress="xz")
```


