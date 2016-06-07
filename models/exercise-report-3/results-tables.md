# Results tables

<!-- These two chunks should be added in the beginning of every .Rmd that you want to source an .R script -->
<!--  The 1st mandatory chunck  -->
<!--  Set the working directory to the repository's base directory -->


<!--  The 2nd mandatory chunck  -->
<!-- Set the report-wide options, and point to the external code file. -->


> This report prints the restuls tables from estimated models

<!-- Load 'sourced' R files.  Suppress the output when loading packages. --> 



<!-- Load the sources.  Suppress the output when loading sources. --> 



<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 


Relies on the previous execution of the following scripts:
- `./reports/report-governor`
- `./models/../compile-models.R`
- `./models/../compile-tables.R`

<!-- Load the datasets.   -->

```r
# prepared by Ellis Island and ./reports/report-governor.R
dto <- readRDS("./data/unshared/derived/dto_h.rds")

# prepared by ../compile-models.R
models_pooled <- readRDS("./data/shared/derived/models/models_pooled.rds")#  glm objects
subset_pooled <- readRDS("./data/shared/derived/models/subset_pooled.rds")#  glmulti objects

models_local <- readRDS("./data/shared/derived/models/models_local.rds")
subset_local <- readRDS("./data/shared/derived/models/subset_local.rds")

# prepared by ../compile-tables.R
tables_pooled <- readRDS("./data/shared/derived/tables/tables_pooled.rds")
tables_local <- readRDS("./data/shared/derived/tables/tables_local.rds")
tables_bw_pooled <- readRDS("./data/shared/derived/tables/tables_bw_pooled.rds")
tables_bw_local <- readRDS("./data/shared/derived/tables/tables_bw_local.rds")

ds_within <- readRDS("./data/shared/derived/tables/ds_within.rds")
ds_between <- readRDS("./data/shared/derived/tables/ds_between.rds")
```

<!-- Inspect the datasets.   -->


<!-- Tweak the datasets.   -->


<!-- Basic table view.   -->



# Guide to Models

Each of the following models (`A`, `B`, `AA`, and `BB`) are fitted to the data from each study separately. When fitted to the pooled data, an additional predictor, `study_name` is added after the intercept. 


|predictors/model   | A | B |AA |BB | best |
|---|---|---|---|---|---|
|age              |age_in_years_70 |age_in_years_70   |age_in_years_70   |age_in_years_70   | ?|
|sex              |female       |female         |female         |female         | ?|
|education        |educ3        |educ3          |educ3          |educ3          | ?|
|marital status   |single       |single         |single         |single         | ?|
|health           |             |poor_health    |               |poor_health    | ?|
|physical activity|             |sedentary      |               |sedentary      | ?|
|employment       |             |current_work   |               |current_work   | ?|
|alcohol use      |             |current_drink_2|               |current_drink_2| ?|
|INTERACTIONS     |  *NONE*         | *NONE*            |*ALL PAIRWISE*   |*ALL PAIRWISE*   | ?|


Odds-ratios with 95% confidence intervals are reported. The model labeled "best" represents the solution suggested by the top ranked model from the best subset search propelled by genetic algorithm with AICC as the guiding selection criteria. 

# Dynamic tables

## Between models
The following table reports comparison across five model types (A, B, AA, BB, best) and six datasets (alsa, lbsl, satsa, share, tilda, pooled).   You can think of this as multiple tables stacked on top of each other. You select a single table by choosing the value for `study_name`.  (you may need to adjust the number of entries to view, at the top left of the dynamic table)
<!--html_preserve--><div id="htmlwidget-1598" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1598">{"x":{"filter":"top","filterHTML":"<tr>\n  <td>\u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"alsa\">alsa\u003c/option>\n        <option value=\"lbsl\">lbsl\u003c/option>\n        <option value=\"satsa\">satsa\u003c/option>\n        <option value=\"share\">share\u003c/option>\n        <option value=\"tilda\">tilda\u003c/option>\n        <option value=\"pooled\">pooled\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n\u003c/tr>","caption":"<caption>Comparison across models || identifiable by : study_name\u003c/caption>","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","151","152","153","154","155","156","157","158","159","160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179","180","181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200","201","202","203","204","205","206","207","208","209","210","211","212","213","214","215","216","217","218","219","220","221","222","223","224","225","226","227","228","229","230","231","232","233","234","235","236","237","238","239","240","241","242","243","244","245","246","247","248","249","250","251","252","253","254","255","256","257","258","259","260","261","262","263","264","265","266","267","268","269","270","271","272","273","274"],["alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled"],["(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","(Intercept)","study_name_f(LBLS)","study_name_f(SATSA)","study_name_f(SHARE)","study_name_f(TILDA)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE"],[".19(.14,.26)***",".95(.93,.97)***",".57(.42,.76)***","1.23(.81,1.84) ","1.06(.77,1.45) ","1.28(.92,1.77) ","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",".09(.05,.17)***",".97(.95,.99)**","1.45(.84,2.53) ","1.58(.67,3.59) ",".84(.46,1.57) ","1.65(.97,2.81).","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",".25(.15,.42)***",".95(.94,.96)***",".44(.34,.57)***","1.17(.72,1.98) ","1.03(.51,2.06) ","1.46(1.09,1.94)*","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",".19(.15,.24)***","1(.99,1.01) ","1.11(.89,1.39) ","1(.78,1.29) ",".84(.64,1.11) ",".86(.64,1.13) ","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",".11(.09,.13)***",".95(.95,.96)***",".93(.81,1.07) ","1.27(1.09,1.47)**",".39(.25,.58)***","1.82(1.56,2.12)***","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",".16(.14,.19)***",".86(.63,1.15) ","1.32(1.05,1.65)*",".91(.75,1.11) ",".85(.71,1.03).",".96(.96,.97)***",".81(.73,.89)***","1.22(1.08,1.37)***",".77(.66,.91)**","1.48(1.33,1.65)***","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""],[".14(.09,.21)***",".95(.93,.97)***",".6(.44,.81)***","1.22(.8,1.82) ","1.05(.76,1.44) ","1.3(.93,1.79) ","1.12(.82,1.53) ","1.16(.85,1.56) ","1.75(.64,4.1) ","1.38(1.01,1.92)*","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",".11(.05,.22)***",".97(.94,.99)**","1.35(.78,2.39) ","1.62(.67,3.77) ",".95(.51,1.8) ","1.68(.97,2.9).",".73(.42,1.27) ","2.97(1.56,5.55)***",".9(.45,1.78) ",".64(.37,1.11) ","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",".08(.04,.15)***",".95(.93,.96)***",".48(.37,.63)***","1.27(.77,2.17) ","1.13(.56,2.28) ","1.59(1.18,2.13)**","1.19(.9,1.57) ","1.58(1.19,2.12)**",".67(.46,.97)*","2.87(2.03,4.12)***","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",".18(.13,.24)***","1(.99,1.01) ","1.09(.87,1.37) ","1.03(.8,1.32) ",".85(.64,1.12) ",".85(.63,1.12) ",".88(.7,1.11) ","1.23(.94,1.58) ",".94(.72,1.23) ","1.45(1.15,1.83)**","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",".08(.07,.11)***",".94(.93,.95)***",".91(.79,1.05) ","1.18(1.01,1.38)*",".42(.27,.63)***","1.8(1.54,2.1)***","1.59(1.35,1.87)***","1.54(1.29,1.83)***",".64(.54,.76)***","1.36(1.16,1.61)***","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",".1(.08,.12)***",".93(.68,1.26) ","1.24(.98,1.55).","1.14(.93,1.41) ",".97(.8,1.18) ",".96(.95,.96)***",".81(.73,.9)***","1.18(1.05,1.32)**",".8(.68,.93)**","1.49(1.33,1.66)***","1.26(1.13,1.4)***","1.45(1.29,1.62)***",".71(.63,.81)***","1.53(1.36,1.71)***","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""],[".15(.09,.24)***",".98(.93,1.03) ",".96(.53,1.71) ","1.43(.64,3.1) ","1.16(.64,2.11) ","1.02(.45,2.19) ","","","","",".92(.87,.98)**","1.02(.95,1.1) ",".98(.93,1.04) ","1(.95,1.05) ","","","","",".45(.16,1.18) ",".78(.39,1.53) ","1.7(.84,3.54) ","","","","",".74(.28,1.93) ","1.37(.67,2.84) ","","","","","","","","","","","","","","","","","","",".1(.04,.23)***",".95(.9,1)*",".86(.25,2.98) ","1.45(.25,6.78) ","1.02(.37,3.14) ","1.2(.27,4.83) ","","","","","1.03(.99,1.08) ",".98(.89,1.07) ","1.03(.99,1.08) ",".97(.93,1.01) ","","","","","2.06(.28,16.57) ","1.71(.43,6.72) ","2.37(.71,8.72) ","","","","",".85(.11,6.93) ",".49(.13,1.83) ","","","","","","","","","","","","","","","","","","",".13(.04,.34)***",".93(.87,.98)*",".66(.22,1.98) ","2.93(1.13,9.05)*","1.39(.36,5.56) ","2.17(.66,7.31) ","","","","",".96(.93,.98)***","1.05(.99,1.12) ","1.02(.95,1.11) ","1(.98,1.02) ","","","","",".4(.13,1.19).",".69(.16,2.95) ",".76(.42,1.36) ","","","","",".8(.24,2.62) ","1.17(.25,5.51) ","","","","","","","","","","","","","","","","","","",".19(.13,.26)***",".99(.97,1.02) ","1.07(.7,1.65) ","1.09(.71,1.67) ",".8(.5,1.29) ",".74(.37,1.42) ","","","","","1(.97,1.02) ","1.02(.99,1.04) ","1.01(.98,1.04) ","1(.97,1.03) ","","","","",".93(.55,1.57) ","1.24(.69,2.22) ",".99(.54,1.89) ","","","","","1.31(.68,2.57) ","1.13(.52,2.42) ","","","","","","","","","","","","","","","","","","",".15(.11,.2)***",".97(.95,.99)**",".65(.47,.9)*",".88(.65,1.2) ",".47(.22,.91)*","1.69(1.17,2.41)**","","","","",".98(.96,1)*",".99(.97,1.01) ","1.02(.97,1.07) ",".99(.98,1.01) ","","","","","1.49(1.1,2.03)*",".94(.36,2.38) ",".81(.59,1.1) ","","","","","1.29(.92,1.82) ","1.16(.46,2.81) ","","","","","","","","","","","","","","","","","","",".16(.13,.19)***",".99(.72,1.35) ","1.47(1.17,1.86)**","1.04(.84,1.28) ",".95(.78,1.17) ",".97(.96,.99)***",".77(.62,.94)*","1.14(.94,1.38) ",".77(.6,.99)*","1.4(1.1,1.78)**","","","","",".98(.97,.99)***","1(.99,1.01) ","1.02(1.01,1.04)**",".99(.98,1)*","","","","",".96(.77,1.21) ","1.2(.87,1.65) ",".85(.68,1.06) ","","","","","1.23(.95,1.58) ","1(.71,1.41) ","","","","","","","","","","","","","","","","","",""],[".18(.07,.42)***",".94(.87,1.01) ",".65(.28,1.56) ","1.44(.41,4.83) ","1.01(.42,2.43) ",".69(.23,1.91) ","1.17(.48,2.83) ",".96(.38,2.35) ","61.72(.52,19638.03) ",".7(.31,1.64) ",".92(.87,.98)**","1(.93,1.08) ",".98(.92,1.04) ","1.01(.95,1.07) ","1(.94,1.06) ","1.01(.96,1.07) ",".75(.47,1.02) ","1.05(.99,1.12).",".31(.1,.89)*",".72(.35,1.47) ","2.1(1,4.55).","1.36(.66,2.79) ","1.35(.67,2.76) ",".14(0,4) ","1.39(.66,2.92) ",".88(.32,2.41) ","1.33(.63,2.86) ",".99(.4,2.46) ",".77(.37,1.57) ","2.71(1.11,6.82)*","1.1(.54,2.24) ","1.09(.03,37.99) ",".46(.02,6.09) ",".67(.26,1.75) ","1.38(.65,2.93) ","1.1(.53,2.28) ",".63(.3,1.28) ","2.3(.17,38.18) ","1.63(.76,3.59) ",".72(.37,1.42) ","8.41(.69,204.5) ","1.01(.5,2.07) ","3.27(.31,51.92) ","1.02(.51,2.05) ",".02(0,.81).",".05(.01,.28)**",".9(.83,.98)*",".31(.04,2.11) ","5.35(.33,70.89) ","2.01(.35,13.01) ","2.27(.29,17.5) ",".66(.11,3.76) ","10.07(1.43,71.57)*","1.53(.16,11.94) ","1(.16,6.62) ","1.02(.97,1.08) ",".92(.81,1.03) ","1.01(.95,1.07) ",".97(.92,1.03) ","1.03(.97,1.09) ","1.04(.97,1.12) ","1.05(.99,1.11).","1.04(.98,1.1) ","1.17(.1,14.18) ","1.89(.37,10.14) ","5.13(1.23,25.99)*","1.73(.43,7.25) ",".98(.18,5.75) ",".81(.17,3.82) ","2.01(.44,9.83) ","3.16(.23,49.8) ",".46(.08,2.41) ",".81(.1,6.52) ",".96(.23,4.04) ",".89(.09,10.33) ",".33(.06,1.78) ",".12(0,2.21) ",".3(.05,1.56) ",".28(.03,2.56) ","1.1(.23,5.45) ",".52(.13,2.15) ",".64(.12,3.32) ","1.78(.35,9.33) ",".26(.05,1.12).","1.33(.3,6.14) ",".85(.16,4.09) ","1.82(.47,7.41) ","6.53(.89,55.81).",".25(.04,1.24) ","1.94(.39,11.33) ",".03(0,.25)**",".76(.64,.87)***",".7(.15,3.2) ","4.14(.47,73.97) ","3.51(.24,85.22) ","4.75(.97,24.56).","1.68(.34,7.77) ",".64(.14,3.08) ",".01(0,.1)***","9.1(1.32,119.98)*",".98(.95,1.02) ","1.23(1.1,1.45)**","1.15(1,1.37).","1.01(.98,1.05) ","1(.97,1.03) ","1(.96,1.03) ",".99(.96,1.03) ","1.04(.99,1.08) ",".44(.12,1.62) ",".6(.11,3.15) ",".78(.42,1.45) ",".73(.4,1.33) ","1.1(.6,2.05) ","2.04(.91,4.59).",".99(.46,2.11) ",".81(.19,3.26) ",".89(.15,5.09) ","1.18(.32,4.77) ","1.29(.24,7.39) ","1.83(.49,6.57) ","2.03(.36,11.93) ","30.16(3.81,392.84)**","10.75(.78,201.89).",".36(.03,2.06) ",".22(.02,2.01) ",".54(.28,1.02).",".66(.35,1.27) ","1.26(.5,3.16) ",".8(.37,1.71) ","1.09(.57,2.11) ","1.38(.61,3.1) ",".62(.29,1.31) ","1.25(.53,2.99) ","1.43(.64,3.15) ","1.56(.54,4.67) ",".23(.14,.39)***",".98(.95,1.02) ",".71(.4,1.26) ",".58(.32,1.07).",".78(.4,1.52) ","1.24(.52,2.81) ",".86(.48,1.54) ","1.02(.49,2.07) ",".82(.4,1.64) ",".75(.39,1.43) ","1(.97,1.03) ","1(.97,1.03) ","1(.96,1.04) ","1(.97,1.03) ","1.03(1,1.05).","1(.97,1.04) ","1.01(.97,1.05) ","1.01(.98,1.04) ",".91(.52,1.59) ","1.22(.68,2.22) ",".95(.5,1.84) ","1.31(.79,2.21) ","1.16(.66,2.04) ","1.46(.81,2.62) ","1.43(.87,2.36) ","1.52(.75,3.12) ","1.1(.49,2.44) ","2.14(1.22,3.79)**","1.01(.52,1.95) ","2.11(1.1,4.09)*","1.13(.54,2.31) ",".76(.38,1.48) ",".57(.28,1.14) ","1.24(.69,2.23) ","1.5(.82,2.74) ",".47(.24,.91)*",".48(.2,1.05).",".75(.33,1.65) ","1.13(.61,2.07) ",".49(.27,.9)*",".91(.49,1.66) ","1.03(.6,1.78) ","1.41(.74,2.72) ","1.36(.7,2.6) ","1.93(1.04,3.6)*",".07(.04,.12)***",".97(.94,1).",".78(.49,1.24) ","1.26(.79,2.05) ",".16(.02,.75)*","1.39(.83,2.31) ","1.85(1.07,3.18)*","2.3(1.28,4.09)**",".88(.49,1.59) ","2.09(1.29,3.46)**",".98(.96,1)*",".99(.97,1.01) ","1.03(.97,1.09) ","1(.98,1.02) ",".98(.96,1) ","1.01(.99,1.04) ","1(.98,1.03) ",".99(.97,1.01) ","1.3(.94,1.79) ",".95(.36,2.47) ",".86(.62,1.19) ","1.01(.71,1.43) ",".94(.65,1.36) ","1.01(.71,1.44) ",".79(.55,1.12) ","1.32(.93,1.89) ","1.34(.51,3.38) ","1.06(.72,1.57) ","1.63(.45,5.1) ",".84(.56,1.26) ","2.02(.67,5.72) ",".88(.62,1.26) ","1.53(.54,4.48) ",".64(.43,.95)*","2.1(.51,14.64) ","1.03(.72,1.48) ","1.08(.72,1.61) ",".98(.67,1.43) ","1.21(.84,1.76) ",".76(.51,1.12) ",".63(.41,.96)*",".78(.54,1.14) ",".96(.61,1.48) ",".88(.59,1.32) ",".91(.6,1.41) ",".11(.08,.16)***","1.06(.76,1.45) ","1.26(.99,1.61).","1.2(.96,1.51) ","1.03(.83,1.27) ",".97(.96,.99)**",".78(.59,1.03).",".97(.72,1.31) ",".87(.59,1.28) ","1.35(.97,1.87).","1.29(.95,1.74).","1.4(1.02,1.92)*",".82(.56,1.2) ","1.26(.96,1.67).",".99(.98,1)*","1(.98,1.01) ","1.02(1,1.03) ",".99(.98,1) ","1(.99,1.01) ","1(.98,1.01) ","1.01(.99,1.02) ",".99(.98,1).",".98(.78,1.24) ","1.18(.85,1.63) ",".9(.72,1.13) ","1.06(.85,1.33) ",".84(.67,1.05) ","1.19(.91,1.54) ",".95(.76,1.18) ","1.26(.97,1.63).",".99(.7,1.41) ","1.33(1.03,1.71)*",".86(.61,1.22) ","1.16(.9,1.51) ","1.05(.73,1.49) ",".88(.67,1.17) ",".82(.54,1.25) ","1.01(.79,1.3) ",".99(.71,1.38) ",".83(.65,1.05) ",".89(.69,1.14) ",".92(.69,1.23) ","1.24(.98,1.58).",".76(.6,.96)*",".82(.62,1.09) ","1.03(.83,1.3) ","1.15(.86,1.53) ","1.2(.95,1.51) ",".99(.76,1.31) "],[".14(.13,.15)***",".98(.97,.99)***","","","","1.39(1.13,1.69)**","","","","",".99(.99,1).","","","","","","",".98(.98,.99)***","","","","","","","","","","","","","","","","","","","","","1.52(1.26,1.83)***","","","","","","",".14(.13,.15)***",".98(.96,.99)***","","","","","","1.6(1.43,1.77)***","","",".99(.99,1) ","","",".99(.98,1) ",".99(.98,1)*","","1.02(1.01,1.03)***",".98(.97,.99)***","","",".82(.71,.95)*","","","","","","","","","","","","","","","","","","1.84(1.59,2.13)***","","","","","","",".13(.11,.15)***",".96(.95,.97)***",".74(.66,.84)***","","","1.6(1.4,1.84)***","1.39(1.22,1.58)***","",".64(.5,.8)***","1.25(1.12,1.4)***","",".99(.98,1.01) ","1.01(.99,1.03) ","","",".99(.98,1)**","","","","","","","","1.36(1.1,1.67)**","","","","","","","","","","","",".85(.68,1.06) ","","","","","","","","","",".13(.11,.15)***","",".64(.56,.74)***","1.08(.94,1.24) ",".83(.69,1).","","1.31(1.04,1.65)*","",".63(.51,.77)***","","","","","","","","","1(.98,1.01) ","","","","","","","1.4(1.2,1.64)***","","","1.37(1.08,1.74)*",".92(.65,1.29) ","","","","","","","","1.5(1.21,1.87)***","","",".71(.57,.88)**","","","","","1.21(.95,1.56) ",".1(.08,.13)***","",".74(.61,.89)**","","","1.51(1.35,1.68)***","1.35(1.19,1.53)***","1.53(1.37,1.7)***",".77(.67,.9)***","1.46(1.21,1.77)***","","","","","","","","","1.17(.95,1.45) ",".85(.63,1.14) ","","","","","","","","","","","","","","","","","","","","",".79(.6,1.04) ","","","","",".12(.08,.19)***",".75(.3,1.8) ",".56(.24,1.26) ","1.33(.77,2.31) ",".61(.36,1.04).",".96(.93,.98)***",".67(.49,.92)*","1.28(.8,2.03) ",".94(.61,1.46) ","1.4(1,1.95)*","1.35(.92,1.96) ","1.28(.94,1.75) ","2.25(.8,5.41).","1.35(.94,1.96) ",".98(.97,.99)***","","","","","","","","","","","","","","","","","1.29(.98,1.69).",".87(.59,1.26) ","","",".89(.68,1.15) ",".63(.42,.94)*",".77(.59,1.02).","1.23(.85,1.79) ",".83(.66,1.05) ","","","",".76(.59,.96)*",".81(.63,1.05) ","","","",""]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th> \u003c/th>\n      <th>study_name\u003c/th>\n      <th>coef_name\u003c/th>\n      <th>A\u003c/th>\n      <th>B\u003c/th>\n      <th>AA\u003c/th>\n      <th>BB\u003c/th>\n      <th>best\u003c/th>\n    \u003c/tr>\n  \u003c/thead>\n\u003c/table>","options":{"pageLength":6,"autoWidth":true,"order":[],"orderClasses":false,"columnDefs":[{"orderable":false,"targets":0}],"orderCellsTop":true,"lengthMenu":[6,10,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


## Within models
The following table reports estimates and odds from every model that has been fit during the exercise. You can think of this as multiple tables of various heights stacked on top of each other. You select a single table by chosing the values for `study_name` and `model_type`.   (you may need to adjust the number of entries to view, at the top left of the dynamic table)
<!--html_preserve--><div id="htmlwidget-7829" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-7829">{"x":{"filter":"top","filterHTML":"<tr>\n  <td>\u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"pooled\">pooled\u003c/option>\n        <option value=\"alsa\">alsa\u003c/option>\n        <option value=\"lbsl\">lbsl\u003c/option>\n        <option value=\"satsa\">satsa\u003c/option>\n        <option value=\"share\">share\u003c/option>\n        <option value=\"tilda\">tilda\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"A\">A\u003c/option>\n        <option value=\"B\">B\u003c/option>\n        <option value=\"AA\">AA\u003c/option>\n        <option value=\"BB\">BB\u003c/option>\n        <option value=\"best\">best\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"***\">***\u003c/option>\n        <option value=\"**\">**\u003c/option>\n        <option value=\"*\">*\u003c/option>\n        <option value=\".\">.\u003c/option>\n        <option value=\" \"> \u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"(Intercept)\">(Intercept)\u003c/option>\n        <option value=\"age_in_years_70\">age_in_years_70\u003c/option>\n        <option value=\"educ3_f( &lt; HS )\">educ3_f( &lt; HS )\u003c/option>\n        <option value=\"educ3_f( HS &lt; )\">educ3_f( HS &lt; )\u003c/option>\n        <option value=\"femaleTRUE\">femaleTRUE\u003c/option>\n        <option value=\"singleTRUE\">singleTRUE\u003c/option>\n        <option value=\"study_name_f(LBLS)\">study_name_f(LBLS)\u003c/option>\n        <option value=\"study_name_f(SATSA)\">study_name_f(SATSA)\u003c/option>\n        <option value=\"study_name_f(SHARE)\">study_name_f(SHARE)\u003c/option>\n        <option value=\"study_name_f(TILDA)\">study_name_f(TILDA)\u003c/option>\n        <option value=\"current_drinkTRUE\">current_drinkTRUE\u003c/option>\n        <option value=\"current_work_2TRUE\">current_work_2TRUE\u003c/option>\n        <option value=\"poor_healthTRUE\">poor_healthTRUE\u003c/option>\n        <option value=\"sedentaryTRUE\">sedentaryTRUE\u003c/option>\n        <option value=\"age_in_years_70:educ3_f( &lt; HS )\">age_in_years_70:educ3_f( &lt; HS )\u003c/option>\n        <option value=\"age_in_years_70:educ3_f( HS &lt; )\">age_in_years_70:educ3_f( HS &lt; )\u003c/option>\n        <option value=\"age_in_years_70:femaleTRUE\">age_in_years_70:femaleTRUE\u003c/option>\n        <option value=\"age_in_years_70:singleTRUE\">age_in_years_70:singleTRUE\u003c/option>\n        <option value=\"educ3_f( &lt; HS ):singleTRUE\">educ3_f( &lt; HS ):singleTRUE\u003c/option>\n        <option value=\"educ3_f( HS &lt; ):singleTRUE\">educ3_f( HS &lt; ):singleTRUE\u003c/option>\n        <option value=\"femaleTRUE:educ3_f( &lt; HS )\">femaleTRUE:educ3_f( &lt; HS )\u003c/option>\n        <option value=\"femaleTRUE:educ3_f( HS &lt; )\">femaleTRUE:educ3_f( HS &lt; )\u003c/option>\n        <option value=\"femaleTRUE:singleTRUE\">femaleTRUE:singleTRUE\u003c/option>\n        <option value=\"age_in_years_70:current_drinkTRUE\">age_in_years_70:current_drinkTRUE\u003c/option>\n        <option value=\"age_in_years_70:current_work_2TRUE\">age_in_years_70:current_work_2TRUE\u003c/option>\n        <option value=\"age_in_years_70:poor_healthTRUE\">age_in_years_70:poor_healthTRUE\u003c/option>\n        <option value=\"age_in_years_70:sedentaryTRUE\">age_in_years_70:sedentaryTRUE\u003c/option>\n        <option value=\"current_work_2TRUE:current_drinkTRUE\">current_work_2TRUE:current_drinkTRUE\u003c/option>\n        <option value=\"educ3_f( &lt; HS ):current_drinkTRUE\">educ3_f( &lt; HS ):current_drinkTRUE\u003c/option>\n        <option value=\"educ3_f( &lt; HS ):current_work_2TRUE\">educ3_f( &lt; HS ):current_work_2TRUE\u003c/option>\n        <option value=\"educ3_f( &lt; HS ):poor_healthTRUE\">educ3_f( &lt; HS ):poor_healthTRUE\u003c/option>\n        <option value=\"educ3_f( &lt; HS ):sedentaryTRUE\">educ3_f( &lt; HS ):sedentaryTRUE\u003c/option>\n        <option value=\"educ3_f( HS &lt; ):current_drinkTRUE\">educ3_f( HS &lt; ):current_drinkTRUE\u003c/option>\n        <option value=\"educ3_f( HS &lt; ):current_work_2TRUE\">educ3_f( HS &lt; ):current_work_2TRUE\u003c/option>\n        <option value=\"educ3_f( HS &lt; ):poor_healthTRUE\">educ3_f( HS &lt; ):poor_healthTRUE\u003c/option>\n        <option value=\"educ3_f( HS &lt; ):sedentaryTRUE\">educ3_f( HS &lt; ):sedentaryTRUE\u003c/option>\n        <option value=\"femaleTRUE:current_drinkTRUE\">femaleTRUE:current_drinkTRUE\u003c/option>\n        <option value=\"femaleTRUE:current_work_2TRUE\">femaleTRUE:current_work_2TRUE\u003c/option>\n        <option value=\"femaleTRUE:poor_healthTRUE\">femaleTRUE:poor_healthTRUE\u003c/option>\n        <option value=\"femaleTRUE:sedentaryTRUE\">femaleTRUE:sedentaryTRUE\u003c/option>\n        <option value=\"poor_healthTRUE:current_drinkTRUE\">poor_healthTRUE:current_drinkTRUE\u003c/option>\n        <option value=\"poor_healthTRUE:current_work_2TRUE\">poor_healthTRUE:current_work_2TRUE\u003c/option>\n        <option value=\"poor_healthTRUE:sedentaryTRUE\">poor_healthTRUE:sedentaryTRUE\u003c/option>\n        <option value=\"sedentaryTRUE:current_drinkTRUE\">sedentaryTRUE:current_drinkTRUE\u003c/option>\n        <option value=\"sedentaryTRUE:current_work_2TRUE\">sedentaryTRUE:current_work_2TRUE\u003c/option>\n        <option value=\"singleTRUE:current_drinkTRUE\">singleTRUE:current_drinkTRUE\u003c/option>\n        <option value=\"singleTRUE:current_work_2TRUE\">singleTRUE:current_work_2TRUE\u003c/option>\n        <option value=\"singleTRUE:poor_healthTRUE\">singleTRUE:poor_healthTRUE\u003c/option>\n        <option value=\"singleTRUE:sedentaryTRUE\">singleTRUE:sedentaryTRUE\u003c/option>\n        <option value=\"study_name_f(LBLS):age_in_years_70\">study_name_f(LBLS):age_in_years_70\u003c/option>\n        <option value=\"study_name_f(LBLS):current_drinkTRUE\">study_name_f(LBLS):current_drinkTRUE\u003c/option>\n        <option value=\"study_name_f(LBLS):current_work_2TRUE\">study_name_f(LBLS):current_work_2TRUE\u003c/option>\n        <option value=\"study_name_f(LBLS):educ3_f( &lt; HS )\">study_name_f(LBLS):educ3_f( &lt; HS )\u003c/option>\n        <option value=\"study_name_f(LBLS):educ3_f( HS &lt; )\">study_name_f(LBLS):educ3_f( HS &lt; )\u003c/option>\n        <option value=\"study_name_f(LBLS):femaleTRUE\">study_name_f(LBLS):femaleTRUE\u003c/option>\n        <option value=\"study_name_f(LBLS):poor_healthTRUE\">study_name_f(LBLS):poor_healthTRUE\u003c/option>\n        <option value=\"study_name_f(LBLS):sedentaryTRUE\">study_name_f(LBLS):sedentaryTRUE\u003c/option>\n        <option value=\"study_name_f(LBLS):singleTRUE\">study_name_f(LBLS):singleTRUE\u003c/option>\n        <option value=\"study_name_f(SATSA):age_in_years_70\">study_name_f(SATSA):age_in_years_70\u003c/option>\n        <option value=\"study_name_f(SATSA):current_drinkTRUE\">study_name_f(SATSA):current_drinkTRUE\u003c/option>\n        <option value=\"study_name_f(SATSA):current_work_2TRUE\">study_name_f(SATSA):current_work_2TRUE\u003c/option>\n        <option value=\"study_name_f(SATSA):educ3_f( &lt; HS )\">study_name_f(SATSA):educ3_f( &lt; HS )\u003c/option>\n        <option value=\"study_name_f(SATSA):educ3_f( HS &lt; )\">study_name_f(SATSA):educ3_f( HS &lt; )\u003c/option>\n        <option value=\"study_name_f(SATSA):femaleTRUE\">study_name_f(SATSA):femaleTRUE\u003c/option>\n        <option value=\"study_name_f(SATSA):poor_healthTRUE\">study_name_f(SATSA):poor_healthTRUE\u003c/option>\n        <option value=\"study_name_f(SATSA):sedentaryTRUE\">study_name_f(SATSA):sedentaryTRUE\u003c/option>\n        <option value=\"study_name_f(SATSA):singleTRUE\">study_name_f(SATSA):singleTRUE\u003c/option>\n        <option value=\"study_name_f(SHARE):age_in_years_70\">study_name_f(SHARE):age_in_years_70\u003c/option>\n        <option value=\"study_name_f(SHARE):current_drinkTRUE\">study_name_f(SHARE):current_drinkTRUE\u003c/option>\n        <option value=\"study_name_f(SHARE):current_work_2TRUE\">study_name_f(SHARE):current_work_2TRUE\u003c/option>\n        <option value=\"study_name_f(SHARE):educ3_f( &lt; HS )\">study_name_f(SHARE):educ3_f( &lt; HS )\u003c/option>\n        <option value=\"study_name_f(SHARE):educ3_f( HS &lt; )\">study_name_f(SHARE):educ3_f( HS &lt; )\u003c/option>\n        <option value=\"study_name_f(SHARE):femaleTRUE\">study_name_f(SHARE):femaleTRUE\u003c/option>\n        <option value=\"study_name_f(SHARE):poor_healthTRUE\">study_name_f(SHARE):poor_healthTRUE\u003c/option>\n        <option value=\"study_name_f(SHARE):sedentaryTRUE\">study_name_f(SHARE):sedentaryTRUE\u003c/option>\n        <option value=\"study_name_f(SHARE):singleTRUE\">study_name_f(SHARE):singleTRUE\u003c/option>\n        <option value=\"study_name_f(TILDA):age_in_years_70\">study_name_f(TILDA):age_in_years_70\u003c/option>\n        <option value=\"study_name_f(TILDA):current_drinkTRUE\">study_name_f(TILDA):current_drinkTRUE\u003c/option>\n        <option value=\"study_name_f(TILDA):current_work_2TRUE\">study_name_f(TILDA):current_work_2TRUE\u003c/option>\n        <option value=\"study_name_f(TILDA):educ3_f( &lt; HS )\">study_name_f(TILDA):educ3_f( &lt; HS )\u003c/option>\n        <option value=\"study_name_f(TILDA):educ3_f( HS &lt; )\">study_name_f(TILDA):educ3_f( HS &lt; )\u003c/option>\n        <option value=\"study_name_f(TILDA):femaleTRUE\">study_name_f(TILDA):femaleTRUE\u003c/option>\n        <option value=\"study_name_f(TILDA):poor_healthTRUE\">study_name_f(TILDA):poor_healthTRUE\u003c/option>\n        <option value=\"study_name_f(TILDA):sedentaryTRUE\">study_name_f(TILDA):sedentaryTRUE\u003c/option>\n        <option value=\"study_name_f(TILDA):singleTRUE\">study_name_f(TILDA):singleTRUE\u003c/option>\n        <option value=\"singleTRUE:femaleTRUE\">singleTRUE:femaleTRUE\u003c/option>\n        <option value=\"current_drinkTRUE:sedentaryTRUE\">current_drinkTRUE:sedentaryTRUE\u003c/option>\n        <option value=\"current_work_2TRUE:educ3_f( &lt; HS )\">current_work_2TRUE:educ3_f( &lt; HS )\u003c/option>\n        <option value=\"current_work_2TRUE:educ3_f( HS &lt; )\">current_work_2TRUE:educ3_f( HS &lt; )\u003c/option>\n        <option value=\"poor_healthFALSE:age_in_years_70\">poor_healthFALSE:age_in_years_70\u003c/option>\n        <option value=\"poor_healthFALSE:singleTRUE\">poor_healthFALSE:singleTRUE\u003c/option>\n        <option value=\"poor_healthTRUE:age_in_years_70\">poor_healthTRUE:age_in_years_70\u003c/option>\n        <option value=\"poor_healthTRUE:singleTRUE\">poor_healthTRUE:singleTRUE\u003c/option>\n        <option value=\"singleFALSE:sedentaryTRUE\">singleFALSE:sedentaryTRUE\u003c/option>\n        <option value=\"current_drinkTRUE:educ3_f( &lt; HS )\">current_drinkTRUE:educ3_f( &lt; HS )\u003c/option>\n        <option value=\"current_drinkTRUE:educ3_f( HS &lt; )\">current_drinkTRUE:educ3_f( HS &lt; )\u003c/option>\n        <option value=\"femaleFALSE:age_in_years_70\">femaleFALSE:age_in_years_70\u003c/option>\n        <option value=\"femaleFALSE:educ3_f( &lt; HS )\">femaleFALSE:educ3_f( &lt; HS )\u003c/option>\n        <option value=\"femaleFALSE:educ3_f( HS &lt; )\">femaleFALSE:educ3_f( HS &lt; )\u003c/option>\n        <option value=\"femaleTRUE:age_in_years_70\">femaleTRUE:age_in_years_70\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"character\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"number\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"display: none; position: absolute; width: 200px;\">\n      <div data-min=\"0\" data-max=\"0.9984\" data-scale=\"4\">\u003c/div>\n      <span style=\"float: left;\">\u003c/span>\n      <span style=\"float: right;\">\u003c/span>\n    \u003c/div>\n  \u003c/td>\n  <td data-type=\"factor\" style=\"vertical-align: top;\">\n    <div class=\"form-group has-feedback\" style=\"margin-bottom: auto;\">\n      <input type=\"search\" placeholder=\"All\" class=\"form-control\" style=\"width: 100%;\"/>\n      <span class=\"glyphicon glyphicon-remove-circle form-control-feedback\">\u003c/span>\n    \u003c/div>\n    <div style=\"width: 100%; display: none;\">\n      <select multiple=\"multiple\" style=\"width: 100%;\">\n        <option value=\"&lt;=.001\">&lt;=.001\u003c/option>\n        <option value=\"&lt;=.01\">&lt;=.01\u003c/option>\n        <option value=\"&lt;=.05\">&lt;=.05\u003c/option>\n        <option value=\"&lt;=.10\">&lt;=.10\u003c/option>\n        <option value=\"&gt; .10\">&gt; .10\u003c/option>\n      \u003c/select>\n    \u003c/div>\n  \u003c/td>\n\u003c/tr>","caption":"<caption>Individual model solution || identifiable by : study_name and model_type\u003c/caption>","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150","151","152","153","154","155","156","157","158","159","160","161","162","163","164","165","166","167","168","169","170","171","172","173","174","175","176","177","178","179","180","181","182","183","184","185","186","187","188","189","190","191","192","193","194","195","196","197","198","199","200","201","202","203","204","205","206","207","208","209","210","211","212","213","214","215","216","217","218","219","220","221","222","223","224","225","226","227","228","229","230","231","232","233","234","235","236","237","238","239","240","241","242","243","244","245","246","247","248","249","250","251","252","253","254","255","256","257","258","259","260","261","262","263","264","265","266","267","268","269","270","271","272","273","274","275","276","277","278","279","280","281","282","283","284","285","286","287","288","289","290","291","292","293","294","295","296","297","298","299","300","301","302","303","304","305","306","307","308","309","310","311","312","313","314","315","316","317","318","319","320","321","322","323","324","325","326","327","328","329","330","331","332","333","334","335","336","337","338","339","340","341","342","343","344","345","346","347","348","349","350","351","352","353","354","355","356","357","358","359","360","361","362","363","364","365","366","367","368","369","370","371","372","373","374","375","376","377","378","379","380","381","382","383","384","385","386","387","388","389","390","391","392","393","394","395","396","397","398","399","400","401","402","403","404","405","406","407","408","409","410","411","412","413","414","415","416","417","418","419","420","421","422","423","424","425","426","427","428","429","430","431","432","433","434","435","436","437","438","439","440","441","442","443","444","445","446","447","448","449","450","451","452","453","454","455","456","457","458","459","460","461","462","463","464","465","466","467","468","469","470","471","472","473","474","475","476","477","478","479","480","481","482","483","484","485","486","487","488","489","490","491","492","493","494","495","496","497","498","499","500","501","502","503","504","505","506","507","508","509","510","511","512","513","514","515","516","517","518","519","520","521","522","523","524","525","526","527","528","529","530","531","532","533","534","535","536","537","538","539","540","541","542","543","544","545","546","547","548","549","550","551","552","553","554","555","556","557","558","559","560","561","562","563","564","565","566","567","568","569","570","571","572","573","574","575","576","577","578","579","580","581","582","583","584","585","586","587","588","589","590","591","592","593","594","595","596","597","598","599"],["pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","pooled","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","alsa","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","lbsl","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","satsa","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","share","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda","tilda"],["A","A","A","A","A","A","A","A","A","A","B","B","B","B","B","B","B","B","B","B","B","B","B","B","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","A","A","A","A","A","A","B","B","B","B","B","B","B","B","B","B","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","best","best","best","best","best","best","best","A","A","A","A","A","A","B","B","B","B","B","B","B","B","B","B","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","best","best","best","best","best","best","best","best","best","best","A","A","A","A","A","A","B","B","B","B","B","B","B","B","B","B","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","A","A","A","A","A","A","B","B","B","B","B","B","B","B","B","B","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","A","A","A","A","A","A","B","B","B","B","B","B","B","B","B","B","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","AA","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","BB","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best","best"],["***"," ","*"," ",".","***","***","***","**","***","***"," ","."," "," ","***","***","**","**","***","***","***","***","***","***"," ","**"," "," ","***","**"," ",".","**","***"," ","**","*"," "," "," "," "," ","***"," ","."," "," ","***","."," "," ",".",".","*"," "," ","*"," "," "," "," "," "," ","."," "," "," "," "," "," "," ","."," ","*"," "," "," "," "," "," "," "," "," "," ",".","*"," "," "," "," "," ","***"," "," "," ","."," "," ","***","*","*"," "," ","."," "," "," "," "," "," "," "," ","**","***"," ","*"," "," "," ","***"," ",".","*"," "," "," "," ",".","."," "," "," "," ","**"," "," "," "," ","."," ","*","*","***"," "," ","."," "," ","*","."," ","***","***","***"," "," "," ","***","***","***"," "," "," "," "," "," ","*","***"," "," "," "," "," ","**"," "," "," "," "," "," "," "," ","***"," "," "," "," "," "," "," "," "," ","**"," "," "," "," "," "," ",".","*"," ","."," "," "," "," "," "," "," "," ","*"," "," "," "," "," "," "," "," "," "," "," "," "," "," ",".","***","***","**"," ","***","***","***","***","**"," "," "," ",".","***","**"," "," "," ","."," ","***"," "," ","***","*"," "," "," "," "," "," "," "," "," "," "," "," "," ","**","*"," "," "," "," "," ","*"," "," "," "," "," "," "," "," ","."," "," "," ","*"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," ","."," "," "," ","."," "," ","***","***","***"," "," ","**","*","***","***","***","***","***","***"," "," ","*","***","***","***"," "," ","**"," ","**","*","***","***","*"," ","*"," "," ","***"," "," "," ","."," "," "," "," ","**","***"," "," "," ","."," "," ","***","*"," ","**","."," "," "," "," "," "," "," "," "," "," ","."," "," "," "," "," "," "," ","**","."," "," ","."," "," "," "," "," "," "," "," "," ","***","***","***","***","***","***","***"," ","**","**","***"," "," "," ",".","***"," "," "," "," "," ","***"," "," "," "," "," "," "," "," ","**","***"," "," "," "," "," "," "," "," "," "," "," "," "," "," ","***"," "," ","."," "," "," "," "," "," "," "," "," "," ","."," "," "," "," "," "," "," "," "," "," "," "," ","**"," ","*"," "," "," "," "," ","*","."," "," ","*"," "," "," "," ","*","***"," ","*","***","*","***","***","***","***","***","***","***","**"," ","***"," ","**"," ","***","***"," ","**","***","***","***","***"," ","*","***","***","***","***","***","***","***","**","*"," ","*","**","*"," "," "," ","*"," "," "," "," ","***","."," "," ","*"," ","*","**"," ","**","*"," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," "," ","*"," "," "," "," "," "," ","*"," "," "," "," ","***","**","***","***","***","***","***","***","***"," "," ","."," "," "," "," "," "],["(Intercept)","study_name_f(LBLS)","study_name_f(SATSA)","study_name_f(SHARE)","study_name_f(TILDA)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","(Intercept)","study_name_f(LBLS)","study_name_f(SATSA)","study_name_f(SHARE)","study_name_f(TILDA)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","(Intercept)","study_name_f(LBLS)","study_name_f(SATSA)","study_name_f(SHARE)","study_name_f(TILDA)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","(Intercept)","study_name_f(LBLS)","study_name_f(SATSA)","study_name_f(SHARE)","study_name_f(TILDA)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","(Intercept)","study_name_f(LBLS)","study_name_f(SATSA)","study_name_f(SHARE)","study_name_f(TILDA)","educ3_f( &lt; HS )","educ3_f( HS &lt; )","age_in_years_70","femaleTRUE","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","study_name_f(LBLS):educ3_f( &lt; HS )","study_name_f(SATSA):educ3_f( &lt; HS )","study_name_f(SHARE):educ3_f( &lt; HS )","study_name_f(TILDA):educ3_f( &lt; HS )","study_name_f(LBLS):educ3_f( HS &lt; )","study_name_f(SATSA):educ3_f( HS &lt; )","study_name_f(SHARE):educ3_f( HS &lt; )","study_name_f(TILDA):educ3_f( HS &lt; )","age_in_years_70:femaleTRUE","singleTRUE:poor_healthTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","study_name_f(LBLS):age_in_years_70","study_name_f(SATSA):age_in_years_70","study_name_f(SHARE):age_in_years_70","study_name_f(TILDA):age_in_years_70","study_name_f(LBLS):femaleTRUE","study_name_f(SATSA):femaleTRUE","study_name_f(SHARE):femaleTRUE","study_name_f(TILDA):femaleTRUE","study_name_f(LBLS):singleTRUE","study_name_f(SATSA):singleTRUE","study_name_f(SHARE):singleTRUE","study_name_f(TILDA):singleTRUE","study_name_f(LBLS):poor_healthTRUE","study_name_f(SATSA):poor_healthTRUE","study_name_f(SHARE):poor_healthTRUE","study_name_f(TILDA):poor_healthTRUE","study_name_f(LBLS):sedentaryTRUE","study_name_f(SATSA):sedentaryTRUE","study_name_f(SHARE):sedentaryTRUE","study_name_f(TILDA):sedentaryTRUE","study_name_f(LBLS):current_work_2TRUE","study_name_f(SATSA):current_work_2TRUE","study_name_f(SHARE):current_work_2TRUE","study_name_f(TILDA):current_work_2TRUE","study_name_f(LBLS):current_drinkTRUE","study_name_f(SATSA):current_drinkTRUE","study_name_f(SHARE):current_drinkTRUE","study_name_f(TILDA):current_drinkTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","(Intercept)","age_in_years_70","singleTRUE","age_in_years_70:femaleTRUE","singleTRUE:femaleTRUE","age_in_years_70:current_drinkTRUE","singleTRUE:current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","(Intercept)","age_in_years_70","sedentaryTRUE","age_in_years_70:femaleTRUE","age_in_years_70:singleTRUE","femaleTRUE:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","singleTRUE:current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","singleTRUE","poor_healthTRUE","current_work_2TRUE","current_drinkTRUE","singleTRUE:poor_healthTRUE","age_in_years_70:sedentaryTRUE","femaleTRUE:current_work_2TRUE","current_drinkTRUE:sedentaryTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","current_work_2TRUE:educ3_f( &lt; HS )","current_work_2TRUE:educ3_f( HS &lt; )","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","(Intercept)","educ3_f( &lt; HS )","educ3_f( HS &lt; )","femaleTRUE","poor_healthTRUE","current_work_2TRUE","poor_healthFALSE:age_in_years_70","poor_healthTRUE:age_in_years_70","poor_healthFALSE:singleTRUE","poor_healthTRUE:singleTRUE","singleFALSE:sedentaryTRUE","singleTRUE:sedentaryTRUE","poor_healthTRUE:sedentaryTRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","(Intercept)","age_in_years_70","femaleTRUE","educ3_f( &lt; HS )","educ3_f( HS &lt; )","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","age_in_years_70:femaleTRUE","age_in_years_70:educ3_f( &lt; HS )","age_in_years_70:educ3_f( HS &lt; )","age_in_years_70:singleTRUE","age_in_years_70:poor_healthTRUE","age_in_years_70:sedentaryTRUE","age_in_years_70:current_work_2TRUE","age_in_years_70:current_drinkTRUE","femaleTRUE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( HS &lt; )","femaleTRUE:singleTRUE","femaleTRUE:poor_healthTRUE","femaleTRUE:sedentaryTRUE","femaleTRUE:current_work_2TRUE","femaleTRUE:current_drinkTRUE","educ3_f( &lt; HS ):singleTRUE","educ3_f( HS &lt; ):singleTRUE","educ3_f( &lt; HS ):poor_healthTRUE","educ3_f( HS &lt; ):poor_healthTRUE","educ3_f( &lt; HS ):sedentaryTRUE","educ3_f( HS &lt; ):sedentaryTRUE","educ3_f( &lt; HS ):current_work_2TRUE","educ3_f( HS &lt; ):current_work_2TRUE","educ3_f( &lt; HS ):current_drinkTRUE","educ3_f( HS &lt; ):current_drinkTRUE","singleTRUE:poor_healthTRUE","singleTRUE:sedentaryTRUE","singleTRUE:current_work_2TRUE","singleTRUE:current_drinkTRUE","poor_healthTRUE:sedentaryTRUE","poor_healthTRUE:current_work_2TRUE","poor_healthTRUE:current_drinkTRUE","sedentaryTRUE:current_work_2TRUE","sedentaryTRUE:current_drinkTRUE","current_work_2TRUE:current_drinkTRUE","(Intercept)","femaleTRUE","singleTRUE","poor_healthTRUE","sedentaryTRUE","current_work_2TRUE","current_drinkTRUE","femaleFALSE:age_in_years_70","femaleTRUE:age_in_years_70","poor_healthTRUE:age_in_years_70","poor_healthTRUE:current_work_2TRUE","femaleFALSE:educ3_f( &lt; HS )","femaleTRUE:educ3_f( &lt; HS )","femaleFALSE:educ3_f( HS &lt; )","femaleTRUE:educ3_f( HS &lt; )","current_drinkTRUE:educ3_f( &lt; HS )","current_drinkTRUE:educ3_f( HS &lt; )"],[".16",".86","1.32",".85",".85",".96",".81","1.22",".77","1.48",".1",".93","1.24","1.04",".97",".96",".81","1.18",".8","1.49","1.26","1.45",".71","1.53",".16",".98","1.48",".97",".95",".97",".76","1.13",".79","1.4",".98","1","1.02",".99",".97","1.19",".85","1.23","1",".11","1.05","1.26","1.1","1.03",".97",".77",".97",".89","1.35","1.3","1.4",".82","1.25",".99","1","1.01",".99","1","1","1.01",".99",".99","1.17",".9","1.06",".84","1.19",".95","1.26",".99","1.33",".86","1.17","1.05",".89",".81","1.02",".98",".82",".89",".93","1.25",".76",".83","1.03","1.15","1.2",".99",".12",".75",".56","1.36",".61","1.28",".94",".96",".67","1.4","1.35","1.28","2.25","1.35","1.33","1.16",".81","1.12","1.11","1.29","1.08",".47",".98",".83",".76",".81","1.02","1","1.06","1","1.83",".57","1.39","1.13","1.4","1.27",".68","1.4",".7","1.02",".72","1.19","2.82","1.37","1.08","1.34",".56",".39",".53",".33",".44","2.59","1.12","1.19","1.29",".87",".89",".63",".77","1.23",".19",".95",".57","1.23","1.06","1.28",".14",".95",".6","1.22","1.05","1.3","1.12","1.16","1.75","1.38",".15",".98",".96","1.43","1.16","1.02",".92","1.02",".98","1",".45",".78","1.7",".74","1.37",".18",".94",".65","1.44","1.01",".69","1.17",".96","61.72",".7",".92","1",".98","1.01","1","1.01",".75","1.05",".31",".72","2.1","1.36","1.35",".14","1.39",".88","1.33",".99",".77","2.71","1.1","1.09",".46",".67","1.38","1.1",".63","2.3","1.63",".72","8.41","1.01","3.27","1.02",".02",".14",".98","1.39",".99",".7",".98","1.52",".09",".97","1.45","1.58",".84","1.65",".11",".97","1.35","1.62",".95","1.68",".73","2.97",".9",".64",".1",".95",".86","1.45","1.02","1.2","1.03",".98","1.03",".97","2.06","1.71","2.37",".85",".49",".05",".9",".31","5.35","2.01","2.27",".66","10.07","1.53","1","1.02",".92","1.01",".97","1.03","1.04","1.05","1.04","1.17","1.89","5.13","1.73",".98",".81","2.01","3.16",".46",".81",".96",".89",".33",".12",".3",".28","1.1",".52",".64","1.78",".26","1.33",".85","1.82","6.53",".25","1.94",".13",".98","1.6","1",".99",".82",".99","1.02",".98","1.85",".25",".95",".44","1.17","1.03","1.46",".08",".95",".48","1.27","1.13","1.59","1.19","1.58",".67","2.87",".13",".93",".66","2.93","1.39","2.17",".96","1.05","1.02","1",".4",".69",".76",".8","1.17",".03",".76",".7","4.14","3.51","4.75","1.68",".64",".01","9.1",".98","1.23","1.15","1.01","1","1",".99","1.04",".44",".6",".78",".73","1.1","2.04",".99",".81",".89","1.18","1.29","1.83","2.03","30.16","10.75",".36",".22",".54",".66","1.26",".8","1.09","1.38",".62","1.25","1.43","1.56",".13",".96",".74","1.62","1.38",".63","1.28",".85",".99","1.36","1.55",".99","1.01","1.02",".71",".19","1","1.11","1",".84",".86",".18","1","1.09","1.03",".85",".85",".88","1.23",".94","1.45",".19",".99","1.06","1.12",".82",".74","1","1.02","1.01","1",".93","1.24",".99","1.31","1.13",".23",".98",".71",".58",".78","1.24",".9","1.03",".83",".77","1","1","1","1","1.03","1","1.01","1.01",".91","1.22",".95","1.31","1.16","1.46","1.43","1.52","1.1","2.14","1.01","2.11","1.13",".76",".57","1.24","1.5",".47",".48",".75","1.13",".49",".91","1.03","1.41","1.36","1.93",".13","1.09",".82",".64","1.29",".62",".96",".96","1.7","1.41","1.83","1.51",".72",".99","1.41","1.22","1.37",".92",".11",".95",".93","1.27",".39","1.82",".08",".94",".91","1.18",".42","1.8","1.59","1.54",".64","1.36",".15",".97",".65",".88",".47","1.69",".98",".99","1.02",".99","1.49",".94",".81","1.29","1.16",".07",".97",".78","1.26",".16","1.39","1.85","2.3",".88","2.09",".98",".99","1.03","1",".98","1.01","1",".99","1.3",".95",".86","1.01",".94","1.01",".79","1.32","1.34","1.06","1.63",".84","2.02",".88","1.53",".64","2.1","1.03","1.08",".98","1.21",".76",".63",".78",".96",".88",".91",".1",".73","1.52","1.34","1.54",".77","1.5",".96",".95","1",".81","1.23","1.19",".8",".84","1.02",".97"],["(.14,.19)","(.63,1.15)","(1.05,1.65)","(.69,1.04)","(.71,1.03)","(.96,.97)","(.73,.89)","(1.08,1.37)","(.66,.91)","(1.33,1.65)","(.08,.12)","(.68,1.26)","(.98,1.55)","(.85,1.29)","(.8,1.18)","(.95,.96)","(.73,.9)","(1.05,1.32)","(.68,.93)","(1.33,1.66)","(1.13,1.4)","(1.29,1.62)","(.63,.81)","(1.36,1.71)","(.13,.19)","(.72,1.34)","(1.17,1.87)","(.78,1.2)","(.78,1.17)","(.96,.98)","(.61,.93)","(.93,1.38)","(.61,1.01)","(1.09,1.78)","(.97,.99)","(.99,1.01)","(1.01,1.03)","(.98,1)","(.77,1.21)","(.87,1.64)","(.68,1.06)","(.95,1.58)","(.7,1.41)","(.08,.16)","(.76,1.43)","(.99,1.61)","(.88,1.39)","(.83,1.27)","(.95,.99)","(.58,1.01)","(.72,1.31)","(.61,1.31)","(.97,1.86)","(.96,1.75)","(1.01,1.92)","(.56,1.2)","(.95,1.65)","(.98,1)","(.98,1.01)","(1,1.03)","(.98,1.01)","(.99,1.01)","(.98,1.01)","(.99,1.02)","(.98,1)","(.78,1.24)","(.85,1.61)","(.72,1.13)","(.85,1.33)","(.67,1.05)","(.91,1.54)","(.77,1.18)","(.97,1.63)","(.7,1.4)","(1.03,1.71)","(.61,1.22)","(.9,1.51)","(.73,1.49)","(.67,1.17)","(.53,1.23)","(.8,1.3)","(.71,1.37)","(.65,1.04)","(.69,1.14)","(.7,1.25)","(.99,1.59)","(.6,.96)","(.63,1.11)","(.82,1.29)","(.86,1.53)","(.96,1.52)","(.75,1.3)","(.08,.19)","(.3,1.8)","(.24,1.26)","(.79,2.37)","(.36,1.04)","(.8,2.03)","(.61,1.46)","(.93,.98)","(.49,.92)","(1,1.95)","(.92,1.96)","(.94,1.75)","(.8,5.41)","(.94,1.96)","(.5,3.46)","(.6,2.31)","(.5,1.35)","(.71,1.77)","(.54,2.32)","(.58,2.87)","(.66,1.75)","(.26,.81)","(.97,.99)","(.66,1.05)","(.59,.96)","(.63,1.05)","(.99,1.06)","(.97,1.03)","(1.03,1.09)","(.97,1.02)","(.95,3.53)","(.37,.89)","(.93,2.1)","(.78,1.64)","(.74,2.66)","(.82,1.98)","(.44,1.05)","(.98,2.02)","(.36,1.34)","(.63,1.64)","(.48,1.08)","(.8,1.77)","(1.39,5.64)","(.9,2.08)","(.72,1.6)","(.94,1.9)","(.18,1.88)","(.15,1.15)","(.22,1.51)","(.13,.92)","(.23,.85)","(1.55,4.35)","(.75,1.67)","(.8,1.77)","(.98,1.69)","(.59,1.26)","(.68,1.15)","(.42,.94)","(.59,1.02)","(.85,1.79)","(.14,.26)","(.93,.97)","(.42,.76)","(.81,1.84)","(.77,1.45)","(.92,1.77)","(.09,.21)","(.93,.97)","(.44,.81)","(.8,1.82)","(.76,1.44)","(.93,1.79)","(.82,1.53)","(.85,1.56)","(.64,4.1)","(1.01,1.92)","(.09,.24)","(.93,1.03)","(.53,1.71)","(.64,3.1)","(.64,2.11)","(.45,2.19)","(.87,.98)","(.95,1.1)","(.93,1.04)","(.95,1.05)","(.16,1.18)","(.39,1.53)","(.84,3.54)","(.28,1.93)","(.67,2.84)","(.07,.42)","(.87,1.01)","(.28,1.56)","(.41,4.83)","(.42,2.43)","(.23,1.91)","(.48,2.83)","(.38,2.35)","(.52,19638.03)","(.31,1.64)","(.87,.98)","(.93,1.08)","(.92,1.04)","(.95,1.07)","(.94,1.06)","(.96,1.07)","(.47,1.02)","(.99,1.12)","(.1,.89)","(.35,1.47)","(1,4.55)","(.66,2.79)","(.67,2.76)","(0,4)","(.66,2.92)","(.32,2.41)","(.63,2.86)","(.4,2.46)","(.37,1.57)","(1.11,6.82)","(.54,2.24)","(.03,37.99)","(.02,6.09)","(.26,1.75)","(.65,2.93)","(.53,2.28)","(.3,1.28)","(.17,38.18)","(.76,3.59)","(.37,1.42)","(.69,204.5)","(.5,2.07)","(.31,51.92)","(.51,2.05)","(0,.81)","(.13,.15)","(.97,.99)","(1.14,1.7)","(.99,1)","(.59,.84)","(.97,.99)","(1.26,1.83)","(.05,.17)","(.95,.99)","(.84,2.53)","(.67,3.59)","(.46,1.57)","(.97,2.81)","(.05,.22)","(.94,.99)","(.78,2.39)","(.67,3.77)","(.51,1.8)","(.97,2.9)","(.42,1.27)","(1.56,5.55)","(.45,1.78)","(.37,1.11)","(.04,.23)","(.9,1)","(.25,2.98)","(.25,6.78)","(.37,3.14)","(.27,4.83)","(.99,1.08)","(.89,1.07)","(.99,1.08)","(.93,1.01)","(.28,16.57)","(.43,6.72)","(.71,8.72)","(.11,6.93)","(.13,1.83)","(.01,.28)","(.83,.98)","(.04,2.11)","(.33,70.89)","(.35,13.01)","(.29,17.5)","(.11,3.76)","(1.43,71.57)","(.16,11.94)","(.16,6.62)","(.97,1.08)","(.81,1.03)","(.95,1.07)","(.92,1.03)","(.97,1.09)","(.97,1.12)","(.99,1.11)","(.98,1.1)","(.1,14.18)","(.37,10.14)","(1.23,25.99)","(.43,7.25)","(.18,5.75)","(.17,3.82)","(.44,9.83)","(.23,49.8)","(.08,2.41)","(.1,6.52)","(.23,4.04)","(.09,10.33)","(.06,1.78)","(0,2.21)","(.05,1.56)","(.03,2.56)","(.23,5.45)","(.13,2.15)","(.12,3.32)","(.35,9.33)","(.05,1.12)","(.3,6.14)","(.16,4.09)","(.47,7.41)","(.89,55.81)","(.04,1.24)","(.39,11.33)","(.12,.15)","(.97,.99)","(1.44,1.78)","(.99,1)","(.98,1)","(.7,.95)","(.98,1)","(1.01,1.03)","(.97,.99)","(1.6,2.15)","(.15,.42)","(.94,.96)","(.34,.57)","(.72,1.98)","(.51,2.06)","(1.09,1.94)","(.04,.15)","(.93,.96)","(.37,.63)","(.77,2.17)","(.56,2.28)","(1.18,2.13)","(.9,1.57)","(1.19,2.12)","(.46,.97)","(2.03,4.12)","(.04,.34)","(.87,.98)","(.22,1.98)","(1.13,9.05)","(.36,5.56)","(.66,7.31)","(.93,.98)","(.99,1.12)","(.95,1.11)","(.98,1.02)","(.13,1.19)","(.16,2.95)","(.42,1.36)","(.24,2.62)","(.25,5.51)","(0,.25)","(.64,.87)","(.15,3.2)","(.47,73.97)","(.24,85.22)","(.97,24.56)","(.34,7.77)","(.14,3.08)","(0,.1)","(1.32,119.98)","(.95,1.02)","(1.1,1.45)","(1,1.37)","(.98,1.05)","(.97,1.03)","(.96,1.03)","(.96,1.03)","(.99,1.08)","(.12,1.62)","(.11,3.15)","(.42,1.45)","(.4,1.33)","(.6,2.05)","(.91,4.59)","(.46,2.11)","(.19,3.26)","(.15,5.09)","(.32,4.77)","(.24,7.39)","(.49,6.57)","(.36,11.93)","(3.81,392.84)","(.78,201.89)","(.03,2.06)","(.02,2.01)","(.28,1.02)","(.35,1.27)","(.5,3.16)","(.37,1.71)","(.57,2.11)","(.61,3.1)","(.29,1.31)","(.53,2.99)","(.64,3.15)","(.54,4.67)","(.11,.14)","(.95,.97)","(.66,.84)","(1.41,1.85)","(1.21,1.56)","(.5,.8)","(1.14,1.43)","(.68,1.06)","(.98,1)","(1.1,1.67)","(1.34,1.8)","(.98,1.01)","(.99,1.02)","(.79,1.31)","(.49,1.01)","(.15,.25)","(.99,1.01)","(.89,1.39)","(.78,1.29)","(.64,1.11)","(.64,1.13)","(.13,.24)","(.99,1.01)","(.87,1.37)","(.8,1.32)","(.64,1.12)","(.63,1.12)","(.7,1.11)","(.94,1.58)","(.72,1.23)","(1.15,1.83)","(.13,.26)","(.97,1.02)","(.68,1.68)","(.72,1.76)","(.5,1.36)","(.37,1.43)","(.97,1.02)","(.99,1.04)","(.98,1.04)","(.97,1.03)","(.55,1.57)","(.69,2.22)","(.54,1.89)","(.68,2.57)","(.52,2.42)","(.13,.39)","(.95,1.02)","(.39,1.29)","(.31,1.08)","(.39,1.55)","(.52,2.82)","(.5,1.64)","(.49,2.11)","(.39,1.73)","(.4,1.48)","(.97,1.03)","(.97,1.03)","(.96,1.04)","(.97,1.03)","(1,1.05)","(.97,1.04)","(.97,1.05)","(.98,1.04)","(.52,1.59)","(.68,2.22)","(.5,1.84)","(.79,2.21)","(.66,2.04)","(.81,2.62)","(.87,2.36)","(.75,3.12)","(.49,2.44)","(1.22,3.79)","(.52,1.95)","(1.1,4.09)","(.54,2.31)","(.38,1.48)","(.28,1.14)","(.69,2.23)","(.82,2.74)","(.24,.91)","(.2,1.05)","(.33,1.65)","(.61,2.07)","(.27,.9)","(.49,1.66)","(.6,1.78)","(.74,2.72)","(.7,2.6)","(1.04,3.6)","(.11,.15)","(.95,1.24)","(.68,.99)","(.56,.73)","(1.02,1.63)","(.5,.77)","(.95,.97)","(.95,.97)","(1.46,1.98)","(1.16,1.72)","(1.58,2.13)","(1.21,1.87)","(.57,.89)","(.98,1)","(1.21,1.65)","(.95,1.57)","(1.08,1.75)","(.66,1.3)","(.09,.13)","(.95,.96)","(.81,1.07)","(1.09,1.47)","(.25,.58)","(1.56,2.12)","(.07,.11)","(.93,.95)","(.79,1.05)","(1.01,1.38)","(.27,.63)","(1.54,2.1)","(1.35,1.87)","(1.29,1.83)","(.54,.76)","(1.16,1.61)","(.11,.2)","(.95,.99)","(.47,.9)","(.65,1.2)","(.22,.91)","(1.17,2.41)","(.96,1)","(.97,1.01)","(.97,1.07)","(.98,1.01)","(1.1,2.03)","(.36,2.38)","(.59,1.1)","(.92,1.82)","(.46,2.81)","(.04,.12)","(.94,1)","(.49,1.24)","(.79,2.05)","(.02,.75)","(.83,2.31)","(1.07,3.18)","(1.28,4.09)","(.49,1.59)","(1.29,3.46)","(.96,1)","(.97,1.01)","(.97,1.09)","(.98,1.02)","(.96,1)","(.99,1.04)","(.98,1.03)","(.97,1.01)","(.94,1.79)","(.36,2.47)","(.62,1.19)","(.71,1.43)","(.65,1.36)","(.71,1.44)","(.55,1.12)","(.93,1.89)","(.51,3.38)","(.72,1.57)","(.45,5.1)","(.56,1.26)","(.67,5.72)","(.62,1.26)","(.54,4.48)","(.43,.95)","(.51,14.64)","(.72,1.48)","(.72,1.61)","(.67,1.43)","(.84,1.76)","(.51,1.12)","(.41,.96)","(.54,1.14)","(.61,1.48)","(.59,1.32)","(.6,1.41)","(.08,.12)","(.6,.88)","(1.36,1.69)","(1.18,1.52)","(1.38,1.71)","(.66,.89)","(1.24,1.82)","(.96,.97)","(.94,.96)","(.99,1.01)","(.61,1.06)","(.97,1.56)","(.97,1.47)","(.58,1.09)","(.62,1.13)","(.8,1.29)","(.7,1.34)"],["-1.82","-.16",".28","-.17","-.16","-.04","-.21",".2","-.26",".39","-2.29","-.07",".21",".04","-.03","-.05","-.21",".16","-.23",".4",".23",".37","-.34",".42","-1.85","-.02",".39","-.03","-.05","-.03","-.28",".13","-.24",".34","-.02","0",".02","-.01","-.03",".17","-.16",".2","0","-2.17",".04",".23",".1",".03","-.03","-.26","-.03","-.11",".3",".26",".33","-.2",".22","-.01","0",".01","-.01","0","0",".01","-.01","-.01",".16","-.1",".06","-.17",".17","-.05",".23","-.01",".28","-.15",".15",".05","-.12","-.21",".02","-.02","-.2","-.12","-.07",".22","-.28","-.18",".03",".14",".19","-.01","-2.1","-.29","-.58",".31","-.5",".25","-.06","-.04","-.39",".34",".3",".25",".81",".3",".29",".15","-.21",".11",".1",".26",".07","-.76","-.02","-.18","-.28","-.21",".02","0",".06","0",".6","-.56",".33",".12",".34",".24","-.39",".34","-.35",".02","-.33",".17","1.04",".31",".08",".29","-.58","-.95","-.63","-1.11","-.82",".95",".11",".18",".25","-.14","-.12","-.46","-.26",".21","-1.65","-.05","-.57",".21",".06",".25","-2","-.05","-.51",".2",".05",".26",".12",".15",".56",".33","-1.9","-.02","-.04",".36",".15",".02","-.08",".02","-.02","0","-.8","-.25",".53","-.3",".31","-1.69","-.06","-.43",".36",".01","-.37",".16","-.04","4.12","-.35","-.08","0","-.02",".01","0",".01","-.28",".05","-1.17","-.33",".74",".31",".3","-1.98",".33","-.13",".29","-.01","-.26","1",".1",".09","-.77","-.4",".32",".1","-.47",".83",".49","-.32","2.13",".01","1.18",".02","-3.77","-1.95","-.02",".33","-.01","-.36","-.02",".42","-2.39","-.03",".37",".46","-.17",".5","-2.22","-.03",".3",".48","-.05",".52","-.31","1.09","-.1","-.45","-2.29","-.05","-.15",".37",".02",".18",".03","-.02",".03","-.03",".72",".54",".86","-.17","-.7","-2.96","-.1","-1.17","1.68",".7",".82","-.41","2.31",".43","0",".02","-.09",".01","-.03",".03",".04",".05",".04",".16",".64","1.63",".55","-.02","-.21",".7","1.15","-.77","-.21","-.04","-.12","-1.11","-2.09","-1.22","-1.29",".1","-.64","-.44",".57","-1.35",".29","-.17",".6","1.88","-1.38",".66","-2","-.02",".47","0","-.01","-.2","-.01",".02","-.02",".62","-1.37","-.06","-.83",".16",".03",".38","-2.5","-.06","-.73",".24",".12",".46",".17",".46","-.4","1.05","-2.02","-.08","-.41","1.08",".33",".78","-.05",".05",".02","0","-.91","-.37","-.28","-.22",".16","-3.63","-.28","-.36","1.42","1.25","1.56",".52","-.44","-4.72","2.21","-.02",".21",".14",".01","0","0","-.01",".03","-.82","-.5","-.25","-.31",".1",".71","-.01","-.2","-.11",".17",".25",".6",".71","3.41","2.38","-1.02","-1.49","-.62","-.41",".24","-.23",".09",".32","-.48",".22",".36",".45","-2.07","-.04","-.3",".48",".32","-.46",".25","-.17","-.01",".31",".44","-.01",".01",".02","-.35","-1.64","0",".1","0","-.17","-.16","-1.72","0",".09",".03","-.17","-.17","-.13",".21","-.06",".37","-1.68","-.01",".06",".12","-.19","-.3","0",".02",".01","0","-.07",".22","-.01",".27",".12","-1.49","-.02","-.34","-.55","-.25",".21","-.1",".03","-.18","-.26","0","0","0","0",".02","0",".01",".01","-.09",".2","-.05",".27",".15",".38",".36",".42",".1",".76",".01",".75",".12","-.28","-.57",".21",".41","-.75","-.74","-.29",".12","-.71","-.09",".03",".35",".31",".66","-2.06",".08","-.19","-.45",".26","-.47","-.04","-.04",".53",".34",".61",".41","-.33","-.01",".35",".2",".32","-.08","-2.19","-.05","-.07",".24","-.94",".6","-2.48","-.06","-.09",".16","-.86",".59",".46",".43","-.44",".31","-1.89","-.03","-.43","-.13","-.76",".52","-.02","-.01",".02","-.01",".4","-.06","-.21",".25",".15","-2.62","-.03","-.25",".23","-1.82",".33",".61",".83","-.12",".74","-.02","-.01",".03","0","-.02",".01","0","-.01",".26","-.05","-.15",".01","-.06",".01","-.24",".28",".29",".06",".49","-.17",".71","-.13",".43","-.45",".74",".03",".08","-.02",".19","-.28","-.46","-.24","-.04","-.13","-.09","-2.29","-.32",".42",".29",".43","-.26",".41","-.04","-.05","0","-.22",".21",".17","-.23","-.17",".02","-.03"],[".09",".16",".11",".1",".1","0",".05",".06",".08",".06",".11",".16",".12",".11",".1","0",".05",".06",".08",".06",".06",".06",".06",".06",".1",".16",".12",".11",".1",".01",".11",".1",".13",".12","0",".01",".01","0",".11",".16",".11",".13",".18",".17",".16",".13",".12",".11",".01",".14",".15",".2",".17",".15",".16",".2",".14",".01",".01",".01",".01",".01",".01",".01",".01",".12",".16",".12",".11",".11",".13",".11",".13",".18",".13",".18",".13",".18",".14",".22",".13",".17",".12",".13",".15",".12",".12",".15",".11",".15",".12",".14",".24",".45",".42",".28",".27",".24",".22",".01",".16",".17",".19",".16",".48",".19",".49",".34",".25",".23",".37",".41",".25",".29",".01",".12",".12",".13",".02",".02",".01",".01",".33",".23",".21",".19",".32",".23",".22",".18",".33",".24",".21",".2",".36",".21",".2",".18",".59",".52",".49",".48",".33",".26",".21",".2",".14",".19",".13",".21",".14",".19",".16",".01",".15",".21",".16",".17",".22",".01",".16",".21",".16",".17",".16",".15",".47",".16",".24",".03",".3",".4",".3",".4",".03",".04",".03",".03",".5",".35",".37",".49",".37",".44",".04",".44",".63",".45",".54",".45",".46","2.53",".42",".03",".04",".03",".03",".03",".03",".19",".03",".55",".36",".39",".37",".36","1.95",".38",".52",".39",".46",".36",".46",".36","1.67","1.38",".49",".38",".37",".37","1.32",".4",".34","1.38",".36","1.24",".35","2.13",".04","0",".1","0",".09","0",".09",".32",".01",".28",".42",".31",".27",".38",".01",".29",".44",".32",".28",".28",".32",".35",".28",".46",".03",".62",".82",".54",".73",".02",".05",".02",".02","1.02",".69",".63","1.05",".67",".94",".04","1","1.34",".91","1.04",".89",".99","1.08",".94",".03",".06",".03",".03",".03",".04",".03",".03","1.25",".83",".77",".72",".87",".79",".78","1.35",".85","1.05",".73","1.2",".87","1.55",".85","1.14",".8",".72",".84",".83",".77",".76",".82",".7","1.04",".84",".85",".04",".01",".05","0","0",".08","0","0","0",".08",".26",".01",".13",".26",".35",".15",".33",".01",".14",".26",".36",".15",".14",".15",".19",".18",".52",".03",".55",".53",".69",".61",".01",".03",".04",".01",".55",".74",".3",".6",".79","1.31",".07",".77","1.25","1.46",".82",".79",".78","1.34","1.11",".02",".07",".08",".02",".02",".02",".02",".02",".66",".84",".32",".3",".31",".41",".39",".71",".89",".68",".87",".66",".89","1.17","1.4","1.02","1.2",".33",".33",".47",".39",".33",".41",".39",".44",".41",".55",".07",".01",".06",".07",".07",".12",".06",".11","0",".11",".08",".01",".01",".13",".18",".12",".01",".11",".13",".14",".15",".15",".01",".12",".13",".14",".15",".12",".13",".14",".12",".18",".01",".23",".23",".26",".34",".01",".01",".02",".01",".27",".3",".32",".34",".39",".28",".02",".3",".32",".35",".43",".3",".37",".38",".34",".01",".02",".02",".02",".01",".02",".02",".02",".29",".3",".33",".26",".29",".3",".26",".36",".41",".29",".34",".33",".37",".35",".36",".3",".31",".34",".42",".41",".31",".31",".31",".28",".33",".33",".32",".07",".07",".09",".07",".12",".11","0",".01",".08",".1",".08",".11",".11",".01",".08",".13",".12",".17",".09","0",".07",".08",".21",".08",".12","0",".07",".08",".21",".08",".08",".09",".08",".08",".14",".01",".17",".16",".36",".18",".01",".01",".03",".01",".16",".48",".16",".17",".46",".27",".02",".24",".24",".88",".26",".28",".3",".3",".25",".01",".01",".03",".01",".01",".01",".01",".01",".16",".49",".16",".18",".19",".18",".18",".18",".48",".2",".61",".21",".54",".18",".54",".2",".82",".18",".21",".19",".19",".2",".22",".19",".22",".21",".22",".11",".1",".06",".06",".05",".08",".1","0","0",".01",".14",".12",".11",".16",".15",".12",".17"],[0,0.3147,0.0162,0.1029,0.0979,0,0,0.001,0.0019,0,0,0.6513,0.0687,0.6868,0.766,0,0,0.0068,0.0054,0,0,0,0,0,0,0.9165,0.0011,0.7592,0.6355,0,0.0085,0.2101,0.0573,0.0068,0.0003,0.5561,0.0055,0.0492,0.7734,0.2837,0.1525,0.1111,0.9885,0,0.7829,0.0659,0.4007,0.8043,0.0007,0.061,0.8408,0.5667,0.0746,0.0882,0.0408,0.302,0.1184,0.0245,0.5821,0.1425,0.2926,0.6316,0.5225,0.3672,0.0899,0.9049,0.3414,0.3702,0.5916,0.133,0.1983,0.6647,0.0817,0.9501,0.0279,0.4105,0.2488,0.7971,0.3982,0.322,0.8742,0.9217,0.1022,0.3496,0.6386,0.0672,0.02,0.2173,0.7887,0.3333,0.1158,0.9172,0,0.5297,0.1644,0.2682,0.0647,0.2933,0.794,0.0008,0.0141,0.0486,0.1241,0.1169,0.0905,0.1113,0.5555,0.657,0.4194,0.6326,0.7807,0.5244,0.7619,0.0079,0.0001,0.1165,0.022,0.1209,0.2339,0.9971,0.0001,0.7631,0.071,0.0143,0.1121,0.527,0.2956,0.2921,0.0803,0.0674,0.2852,0.9382,0.1078,0.3919,0.0037,0.1402,0.7107,0.1021,0.3254,0.0658,0.1961,0.0211,0.0135,0.0003,0.579,0.3901,0.0654,0.46,0.3639,0.0239,0.068,0.2805,0,0,0.0002,0.3191,0.7215,0.1327,0,0.0001,0.0009,0.3455,0.7644,0.1201,0.4687,0.3424,0.23,0.0487,0,0.3972,0.8809,0.3695,0.6276,0.9673,0.0046,0.531,0.5682,0.9437,0.1141,0.4639,0.1477,0.5408,0.395,0.0001,0.1157,0.3311,0.5615,0.9771,0.4889,0.7236,0.9378,0.1036,0.4003,0.0055,0.9132,0.5117,0.7665,0.992,0.6563,0.1321,0.0968,0.0339,0.3642,0.0543,0.3975,0.404,0.3098,0.3824,0.808,0.4551,0.9886,0.477,0.0304,0.7884,0.9584,0.5762,0.4083,0.4004,0.7914,0.2051,0.5278,0.2191,0.3468,0.1217,0.9782,0.3392,0.9583,0.0768,0,0,0.0013,0.1005,0.0001,0,0,0,0.0038,0.1873,0.2823,0.5807,0.0668,0,0.0052,0.2908,0.2667,0.8646,0.0621,0.274,0.0007,0.7647,0.1108,0,0.0383,0.8135,0.6502,0.9733,0.8008,0.1418,0.6083,0.1543,0.159,0.482,0.4388,0.1731,0.8732,0.2953,0.0017,0.0165,0.2404,0.2115,0.4446,0.431,0.6446,0.0192,0.6926,0.9984,0.4195,0.1511,0.7474,0.2938,0.4032,0.2757,0.0909,0.1938,0.8983,0.445,0.0332,0.4437,0.9813,0.7878,0.3717,0.3926,0.3631,0.8411,0.9584,0.9222,0.202,0.1778,0.1531,0.2578,0.9024,0.3689,0.5982,0.4892,0.0793,0.7089,0.8383,0.3917,0.0724,0.102,0.4373,0,0,0,0.2072,0.1648,0.0084,0.0361,0,0,0,0,0,0,0.5407,0.9352,0.0103,0,0,0,0.3553,0.7405,0.0023,0.2304,0.0019,0.0369,0,0.0001,0.0131,0.4559,0.0409,0.6362,0.202,0.0001,0.114,0.5602,0.9965,0.0983,0.618,0.353,0.7145,0.8376,0.0057,0.0002,0.6411,0.2572,0.391,0.0569,0.5146,0.573,0.0004,0.0473,0.345,0.0027,0.072,0.4881,0.9173,0.9352,0.6923,0.122,0.2104,0.5495,0.4375,0.3048,0.7555,0.0836,0.9831,0.774,0.9002,0.805,0.7694,0.3578,0.4266,0.0035,0.0892,0.3147,0.2118,0.057,0.217,0.6142,0.5613,0.7878,0.4389,0.209,0.6182,0.3738,0.4145,0,0,0,0,0,0.0001,0,0.1416,0.0087,0.0037,0,0.3509,0.3134,0.8847,0.0595,0,0.8531,0.3571,0.9787,0.2177,0.2816,0,0.8845,0.4469,0.8397,0.2371,0.2554,0.277,0.12,0.666,0.0017,0,0.5547,0.7871,0.6091,0.4476,0.3883,0.8562,0.2182,0.4082,0.932,0.784,0.4643,0.9814,0.4224,0.7612,0,0.3026,0.2608,0.0848,0.4801,0.6192,0.7354,0.9376,0.6319,0.4456,0.9366,0.8265,0.9352,0.9585,0.085,0.884,0.5474,0.3921,0.7435,0.5041,0.8718,0.2996,0.6111,0.2016,0.1648,0.249,0.8077,0.0084,0.9766,0.0257,0.7489,0.4234,0.1092,0.4766,0.187,0.0251,0.0775,0.4727,0.7046,0.0222,0.7627,0.9063,0.2988,0.3549,0.0371,0,0.2348,0.0395,0,0.0315,0,0,0,0,0.0007,0,0.0002,0.003,0.2842,0,0.1141,0.0097,0.6466,0,0,0.3197,0.0023,0,0,0,0,0.209,0.0362,0,0,0,0,0,0.0003,0,0.0015,0.0102,0.4142,0.0344,0.0045,0.0133,0.415,0.3972,0.5054,0.01,0.895,0.1793,0.1442,0.7476,0,0.0917,0.2971,0.341,0.0393,0.2045,0.0268,0.0048,0.6828,0.0035,0.0156,0.2212,0.3278,0.8225,0.1056,0.2551,0.7688,0.2739,0.1142,0.9189,0.3658,0.9472,0.7424,0.9528,0.1921,0.1226,0.5412,0.7747,0.4254,0.3957,0.1928,0.4885,0.4264,0.0273,0.3667,0.8577,0.7149,0.9173,0.3114,0.1601,0.0325,0.2023,0.8447,0.5315,0.6784,0,0.0012,0,0,0,0.0005,0,0,0,0.6401,0.1264,0.0824,0.1049,0.1518,0.2539,0.8948,0.8453],["&lt;=.001","&gt; .10","&lt;=.05","&gt; .10","&lt;=.10","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.01","&lt;=.001","&lt;=.001","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&lt;=.001","&lt;=.001","&lt;=.01","&lt;=.01","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&gt; .10","&lt;=.01","&gt; .10","&gt; .10","&lt;=.001","&lt;=.01","&gt; .10","&lt;=.10","&lt;=.01","&lt;=.001","&gt; .10","&lt;=.01","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.001","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&lt;=.001","&lt;=.10","&gt; .10","&gt; .10","&lt;=.10","&lt;=.10","&lt;=.05","&gt; .10","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.001","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&lt;=.001","&lt;=.05","&lt;=.05","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.01","&lt;=.001","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&lt;=.001","&gt; .10","&lt;=.10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.01","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&lt;=.05","&lt;=.05","&lt;=.001","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&lt;=.05","&lt;=.10","&gt; .10","&lt;=.001","&lt;=.001","&lt;=.001","&gt; .10","&gt; .10","&gt; .10","&lt;=.001","&lt;=.001","&lt;=.001","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.05","&lt;=.001","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.01","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.001","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.01","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&lt;=.05","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&lt;=.001","&lt;=.001","&lt;=.01","&gt; .10","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.01","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&lt;=.001","&lt;=.01","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&lt;=.001","&gt; .10","&gt; .10","&lt;=.001","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.01","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&lt;=.001","&lt;=.001","&lt;=.001","&gt; .10","&gt; .10","&lt;=.01","&lt;=.05","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&gt; .10","&gt; .10","&lt;=.05","&lt;=.001","&lt;=.001","&lt;=.001","&gt; .10","&gt; .10","&lt;=.01","&gt; .10","&lt;=.01","&lt;=.05","&lt;=.001","&lt;=.001","&lt;=.05","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&lt;=.001","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.01","&lt;=.001","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&lt;=.001","&lt;=.05","&gt; .10","&lt;=.01","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.01","&lt;=.10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&gt; .10","&lt;=.01","&lt;=.01","&lt;=.001","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&lt;=.001","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.001","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.01","&lt;=.001","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.001","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.01","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.05","&lt;=.10","&gt; .10","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.05","&lt;=.001","&gt; .10","&lt;=.05","&lt;=.001","&lt;=.05","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.01","&gt; .10","&lt;=.001","&gt; .10","&lt;=.01","&gt; .10","&lt;=.001","&lt;=.001","&gt; .10","&lt;=.01","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&gt; .10","&lt;=.05","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.01","&lt;=.05","&gt; .10","&lt;=.05","&lt;=.01","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.001","&lt;=.10","&gt; .10","&gt; .10","&lt;=.05","&gt; .10","&lt;=.05","&lt;=.01","&gt; .10","&lt;=.01","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.05","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&lt;=.001","&lt;=.01","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&lt;=.001","&gt; .10","&gt; .10","&lt;=.10","&gt; .10","&gt; .10","&gt; .10","&gt; .10","&gt; .10"]],"container":"<table class=\"cell-border stripe\">\n  <thead>\n    <tr>\n      <th> \u003c/th>\n      <th>study_name\u003c/th>\n      <th>model_type\u003c/th>\n      <th>sign\u003c/th>\n      <th>coef_name\u003c/th>\n      <th>odds\u003c/th>\n      <th>odds_ci\u003c/th>\n      <th>est\u003c/th>\n      <th>se\u003c/th>\n      <th>p\u003c/th>\n      <th>sign_\u003c/th>\n    \u003c/tr>\n  \u003c/thead>\n\u003c/table>","options":{"pageLength":6,"autoWidth":true,"columnDefs":[{"className":"dt-right","targets":9},{"orderable":false,"targets":0}],"order":[],"orderClasses":false,"orderCellsTop":true,"lengthMenu":[6,10,25,50,100]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


# Static tables


## pooled

### BETWEEN

coef_name                              A                    B                    AA                  BB                 best            
-------------------------------------  -------------------  -------------------  ------------------  -----------------  ----------------
(Intercept)                            .16(.14,.19)***      .1(.08,.12)***       .16(.13,.19)***     .11(.08,.16)***    .12(.08,.19)*** 
study_name_f(LBLS)                     .86(.63,1.15)        .93(.68,1.26)        .99(.72,1.35)       1.06(.76,1.45)     .75(.3,1.8)     
study_name_f(SATSA)                    1.32(1.05,1.65)*     1.24(.98,1.55).      1.47(1.17,1.86)**   1.26(.99,1.61).    .56(.24,1.26)   
study_name_f(SHARE)                    .91(.75,1.11)        1.14(.93,1.41)       1.04(.84,1.28)      1.2(.96,1.51)      1.33(.77,2.31)  
study_name_f(TILDA)                    .85(.71,1.03).       .97(.8,1.18)         .95(.78,1.17)       1.03(.83,1.27)     .61(.36,1.04).  
age_in_years_70                        .96(.96,.97)***      .96(.95,.96)***      .97(.96,.99)***     .97(.96,.99)**     .96(.93,.98)*** 
femaleTRUE                             .81(.73,.89)***      .81(.73,.9)***       .77(.62,.94)*       .78(.59,1.03).     .67(.49,.92)*   
educ3_f( < HS )                        1.22(1.08,1.37)***   1.18(1.05,1.32)**    1.14(.94,1.38)      .97(.72,1.31)      1.28(.8,2.03)   
educ3_f( HS < )                        .77(.66,.91)**       .8(.68,.93)**        .77(.6,.99)*        .87(.59,1.28)      .94(.61,1.46)   
singleTRUE                             1.48(1.33,1.65)***   1.49(1.33,1.66)***   1.4(1.1,1.78)**     1.35(.97,1.87).    1.4(1,1.95)*    
poor_healthTRUE                                             1.26(1.13,1.4)***                        1.29(.95,1.74).    1.35(.92,1.96)  
sedentaryTRUE                                               1.45(1.29,1.62)***                       1.4(1.02,1.92)*    1.28(.94,1.75)  
current_work_2TRUE                                          .71(.63,.81)***                          .82(.56,1.2)       2.25(.8,5.41).  
current_drinkTRUE                                           1.53(1.36,1.71)***                       1.26(.96,1.67).    1.35(.94,1.96)  
age_in_years_70:femaleTRUE                                                       .98(.97,.99)***     .99(.98,1)*        .98(.97,.99)*** 
age_in_years_70:educ3_f( < HS )                                                  1(.99,1.01)         1(.98,1.01)                        
age_in_years_70:educ3_f( HS < )                                                  1.02(1.01,1.04)**   1.02(1,1.03)                       
age_in_years_70:singleTRUE                                                       .99(.98,1)*         .99(.98,1)                         
age_in_years_70:poor_healthTRUE                                                                      1(.99,1.01)                        
age_in_years_70:sedentaryTRUE                                                                        1(.98,1.01)                        
age_in_years_70:current_work_2TRUE                                                                   1.01(.99,1.02)                     
age_in_years_70:current_drinkTRUE                                                                    .99(.98,1).                        
femaleTRUE:educ3_f( < HS )                                                       .96(.77,1.21)       .98(.78,1.24)                      
femaleTRUE:educ3_f( HS < )                                                       1.2(.87,1.65)       1.18(.85,1.63)                     
femaleTRUE:singleTRUE                                                            .85(.68,1.06)       .9(.72,1.13)                       
femaleTRUE:poor_healthTRUE                                                                           1.06(.85,1.33)                     
femaleTRUE:sedentaryTRUE                                                                             .84(.67,1.05)                      
femaleTRUE:current_work_2TRUE                                                                        1.19(.91,1.54)                     
femaleTRUE:current_drinkTRUE                                                                         .95(.76,1.18)                      
educ3_f( < HS ):singleTRUE                                                       1.23(.95,1.58)      1.26(.97,1.63).                    
educ3_f( HS < ):singleTRUE                                                       1(.71,1.41)         .99(.7,1.41)                       
educ3_f( < HS ):poor_healthTRUE                                                                      1.33(1.03,1.71)*   1.29(.98,1.69). 
educ3_f( HS < ):poor_healthTRUE                                                                      .86(.61,1.22)      .87(.59,1.26)   
educ3_f( < HS ):sedentaryTRUE                                                                        1.16(.9,1.51)                      
educ3_f( HS < ):sedentaryTRUE                                                                        1.05(.73,1.49)                     
educ3_f( < HS ):current_work_2TRUE                                                                   .88(.67,1.17)      .89(.68,1.15)   
educ3_f( HS < ):current_work_2TRUE                                                                   .82(.54,1.25)      .63(.42,.94)*   
educ3_f( < HS ):current_drinkTRUE                                                                    1.01(.79,1.3)      .77(.59,1.02).  
educ3_f( HS < ):current_drinkTRUE                                                                    .99(.71,1.38)      1.23(.85,1.79)  
singleTRUE:poor_healthTRUE                                                                           .83(.65,1.05)      .83(.66,1.05)   
singleTRUE:sedentaryTRUE                                                                             .89(.69,1.14)                      
singleTRUE:current_work_2TRUE                                                                        .92(.69,1.23)                      
singleTRUE:current_drinkTRUE                                                                         1.24(.98,1.58).                    
poor_healthTRUE:sedentaryTRUE                                                                        .76(.6,.96)*       .76(.59,.96)*   
poor_healthTRUE:current_work_2TRUE                                                                   .82(.62,1.09)      .81(.63,1.05)   
poor_healthTRUE:current_drinkTRUE                                                                    1.03(.83,1.3)                      
sedentaryTRUE:current_work_2TRUE                                                                     1.15(.86,1.53)                     
sedentaryTRUE:current_drinkTRUE                                                                      1.2(.95,1.51)                      
current_work_2TRUE:current_drinkTRUE                                                                 .99(.76,1.31)                      


###  A

 solution of model **A** fit to combined and harmonized data from **ALL** studies

    logLik       dev       AIC       BIC   df_Null   df_Model   df_drop
----------  --------  --------  --------  --------  ---------  --------
 -5326.851   10653.7   10673.7   10747.9     12327      12318         9


sign   coef_name             odds   odds_ci       est     se          p  sign_  
-----  --------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)           .16    (.14,.19)     -1.82   .09    0.0000  <=.001 
       study_name_f(LBLS)    .86    (.63,1.15)    -.16    .16    0.3147  > .10  
*      study_name_f(SATSA)   1.32   (1.05,1.65)   .28     .11    0.0162  <=.05  
       study_name_f(SHARE)   .85    (.69,1.04)    -.17    .1     0.1029  > .10  
.      study_name_f(TILDA)   .85    (.71,1.03)    -.16    .1     0.0979  <=.10  
***    age_in_years_70       .96    (.96,.97)     -.04    0      0.0000  <=.001 
***    femaleTRUE            .81    (.73,.89)     -.21    .05    0.0000  <=.001 
***    educ3_f( < HS )       1.22   (1.08,1.37)   .2      .06    0.0010  <=.001 
**     educ3_f( HS < )       .77    (.66,.91)     -.26    .08    0.0019  <=.01  
***    singleTRUE            1.48   (1.33,1.65)   .39     .06    0.0000  <=.001 


###  B

 solution of model **B** fit to combined and harmonized data from **ALL** studies

   logLik        dev       AIC       BIC   df_Null   df_Model   df_drop
---------  ---------  --------  --------  --------  ---------  --------
 -5258.86   10517.72   10545.7   10649.6     12327      12314        13


sign   coef_name             odds   odds_ci       est     se          p  sign_  
-----  --------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)           .1     (.08,.12)     -2.29   .11    0.0000  <=.001 
       study_name_f(LBLS)    .93    (.68,1.26)    -.07    .16    0.6513  > .10  
.      study_name_f(SATSA)   1.24   (.98,1.55)    .21     .12    0.0687  <=.10  
       study_name_f(SHARE)   1.04   (.85,1.29)    .04     .11    0.6868  > .10  
       study_name_f(TILDA)   .97    (.8,1.18)     -.03    .1     0.7660  > .10  
***    age_in_years_70       .96    (.95,.96)     -.05    0      0.0000  <=.001 
***    femaleTRUE            .81    (.73,.9)      -.21    .05    0.0000  <=.001 
**     educ3_f( < HS )       1.18   (1.05,1.32)   .16     .06    0.0068  <=.01  
**     educ3_f( HS < )       .8     (.68,.93)     -.23    .08    0.0054  <=.01  
***    singleTRUE            1.49   (1.33,1.66)   .4      .06    0.0000  <=.001 
***    poor_healthTRUE       1.26   (1.13,1.4)    .23     .06    0.0000  <=.001 
***    sedentaryTRUE         1.45   (1.29,1.62)   .37     .06    0.0000  <=.001 
***    current_work_2TRUE    .71    (.63,.81)     -.34    .06    0.0000  <=.001 
***    current_drinkTRUE     1.53   (1.36,1.71)   .42     .06    0.0000  <=.001 


###  AA

 solution of model **AA** fit to combined and harmonized data from **ALL** studies

   logLik        dev     AIC     BIC   df_Null   df_Model   df_drop
---------  ---------  ------  ------  --------  ---------  --------
 -5308.01   10616.02   10654   10795     12327      12309        18


sign   coef_name                         odds   odds_ci       est     se          p  sign_  
-----  --------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                       .16    (.13,.19)     -1.85   .1     0.0000  <=.001 
       study_name_f(LBLS)                .98    (.72,1.34)    -.02    .16    0.9165  > .10  
**     study_name_f(SATSA)               1.48   (1.17,1.87)   .39     .12    0.0011  <=.01  
       study_name_f(SHARE)               .97    (.78,1.2)     -.03    .11    0.7592  > .10  
       study_name_f(TILDA)               .95    (.78,1.17)    -.05    .1     0.6355  > .10  
***    age_in_years_70                   .97    (.96,.98)     -.03    .01    0.0000  <=.001 
**     femaleTRUE                        .76    (.61,.93)     -.28    .11    0.0085  <=.01  
       educ3_f( < HS )                   1.13   (.93,1.38)    .13     .1     0.2101  > .10  
.      educ3_f( HS < )                   .79    (.61,1.01)    -.24    .13    0.0573  <=.10  
**     singleTRUE                        1.4    (1.09,1.78)   .34     .12    0.0068  <=.01  
***    age_in_years_70:femaleTRUE        .98    (.97,.99)     -.02    0      0.0003  <=.001 
       age_in_years_70:educ3_f( < HS )   1      (.99,1.01)    0       .01    0.5561  > .10  
**     age_in_years_70:educ3_f( HS < )   1.02   (1.01,1.03)   .02     .01    0.0055  <=.01  
*      age_in_years_70:singleTRUE        .99    (.98,1)       -.01    0      0.0492  <=.05  
       femaleTRUE:educ3_f( < HS )        .97    (.77,1.21)    -.03    .11    0.7734  > .10  
       femaleTRUE:educ3_f( HS < )        1.19   (.87,1.64)    .17     .16    0.2837  > .10  
       femaleTRUE:singleTRUE             .85    (.68,1.06)    -.16    .11    0.1525  > .10  
       educ3_f( < HS ):singleTRUE        1.23   (.95,1.58)    .2      .13    0.1111  > .10  
       educ3_f( HS < ):singleTRUE        1      (.7,1.41)     0       .18    0.9885  > .10  


###  BB

 solution of model **BB** fit to combined and harmonized data from **ALL** studies

    logLik        dev       AIC       BIC   df_Null   df_Model   df_drop
----------  ---------  --------  --------  --------  ---------  --------
 -5221.406   10442.81   10540.8   10904.4     12327      12279        48


sign   coef_name                              odds   odds_ci       est     se          p  sign_  
-----  -------------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                            .11    (.08,.16)     -2.17   .17    0.0000  <=.001 
       study_name_f(LBLS)                     1.05   (.76,1.43)    .04     .16    0.7829  > .10  
.      study_name_f(SATSA)                    1.26   (.99,1.61)    .23     .13    0.0659  <=.10  
       study_name_f(SHARE)                    1.1    (.88,1.39)    .1      .12    0.4007  > .10  
       study_name_f(TILDA)                    1.03   (.83,1.27)    .03     .11    0.8043  > .10  
***    age_in_years_70                        .97    (.95,.99)     -.03    .01    0.0007  <=.001 
.      femaleTRUE                             .77    (.58,1.01)    -.26    .14    0.0610  <=.10  
       educ3_f( < HS )                        .97    (.72,1.31)    -.03    .15    0.8408  > .10  
       educ3_f( HS < )                        .89    (.61,1.31)    -.11    .2     0.5667  > .10  
.      singleTRUE                             1.35   (.97,1.86)    .3      .17    0.0746  <=.10  
.      poor_healthTRUE                        1.3    (.96,1.75)    .26     .15    0.0882  <=.10  
*      sedentaryTRUE                          1.4    (1.01,1.92)   .33     .16    0.0408  <=.05  
       current_work_2TRUE                     .82    (.56,1.2)     -.2     .2     0.3020  > .10  
       current_drinkTRUE                      1.25   (.95,1.65)    .22     .14    0.1184  > .10  
*      age_in_years_70:femaleTRUE             .99    (.98,1)       -.01    .01    0.0245  <=.05  
       age_in_years_70:educ3_f( < HS )        1      (.98,1.01)    0       .01    0.5821  > .10  
       age_in_years_70:educ3_f( HS < )        1.01   (1,1.03)      .01     .01    0.1425  > .10  
       age_in_years_70:singleTRUE             .99    (.98,1.01)    -.01    .01    0.2926  > .10  
       age_in_years_70:poor_healthTRUE        1      (.99,1.01)    0       .01    0.6316  > .10  
       age_in_years_70:sedentaryTRUE          1      (.98,1.01)    0       .01    0.5225  > .10  
       age_in_years_70:current_work_2TRUE     1.01   (.99,1.02)    .01     .01    0.3672  > .10  
.      age_in_years_70:current_drinkTRUE      .99    (.98,1)       -.01    .01    0.0899  <=.10  
       femaleTRUE:educ3_f( < HS )             .99    (.78,1.24)    -.01    .12    0.9049  > .10  
       femaleTRUE:educ3_f( HS < )             1.17   (.85,1.61)    .16     .16    0.3414  > .10  
       femaleTRUE:singleTRUE                  .9     (.72,1.13)    -.1     .12    0.3702  > .10  
       femaleTRUE:poor_healthTRUE             1.06   (.85,1.33)    .06     .11    0.5916  > .10  
       femaleTRUE:sedentaryTRUE               .84    (.67,1.05)    -.17    .11    0.1330  > .10  
       femaleTRUE:current_work_2TRUE          1.19   (.91,1.54)    .17     .13    0.1983  > .10  
       femaleTRUE:current_drinkTRUE           .95    (.77,1.18)    -.05    .11    0.6647  > .10  
.      educ3_f( < HS ):singleTRUE             1.26   (.97,1.63)    .23     .13    0.0817  <=.10  
       educ3_f( HS < ):singleTRUE             .99    (.7,1.4)      -.01    .18    0.9501  > .10  
*      educ3_f( < HS ):poor_healthTRUE        1.33   (1.03,1.71)   .28     .13    0.0279  <=.05  
       educ3_f( HS < ):poor_healthTRUE        .86    (.61,1.22)    -.15    .18    0.4105  > .10  
       educ3_f( < HS ):sedentaryTRUE          1.17   (.9,1.51)     .15     .13    0.2488  > .10  
       educ3_f( HS < ):sedentaryTRUE          1.05   (.73,1.49)    .05     .18    0.7971  > .10  
       educ3_f( < HS ):current_work_2TRUE     .89    (.67,1.17)    -.12    .14    0.3982  > .10  
       educ3_f( HS < ):current_work_2TRUE     .81    (.53,1.23)    -.21    .22    0.3220  > .10  
       educ3_f( < HS ):current_drinkTRUE      1.02   (.8,1.3)      .02     .13    0.8742  > .10  
       educ3_f( HS < ):current_drinkTRUE      .98    (.71,1.37)    -.02    .17    0.9217  > .10  
       singleTRUE:poor_healthTRUE             .82    (.65,1.04)    -.2     .12    0.1022  > .10  
       singleTRUE:sedentaryTRUE               .89    (.69,1.14)    -.12    .13    0.3496  > .10  
       singleTRUE:current_work_2TRUE          .93    (.7,1.25)     -.07    .15    0.6386  > .10  
.      singleTRUE:current_drinkTRUE           1.25   (.99,1.59)    .22     .12    0.0672  <=.10  
*      poor_healthTRUE:sedentaryTRUE          .76    (.6,.96)      -.28    .12    0.0200  <=.05  
       poor_healthTRUE:current_work_2TRUE     .83    (.63,1.11)    -.18    .15    0.2173  > .10  
       poor_healthTRUE:current_drinkTRUE      1.03   (.82,1.29)    .03     .11    0.7887  > .10  
       sedentaryTRUE:current_work_2TRUE       1.15   (.86,1.53)    .14     .15    0.3333  > .10  
       sedentaryTRUE:current_drinkTRUE        1.2    (.96,1.52)    .19     .12    0.1158  > .10  
       current_work_2TRUE:current_drinkTRUE   .99    (.75,1.3)     -.01    .14    0.9172  > .10  


###  best

 solution of model **best** fit to combined and harmonized data from **ALL** studies

    logLik        dev       AIC       BIC   df_Null   df_Model   df_drop
----------  ---------  --------  --------  --------  ---------  --------
 -5143.964   10287.93   10407.9   10853.1     12327      12268        59


sign   coef_name                                odds   odds_ci       est     se          p  sign_  
-----  ---------------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                              .12    (.08,.19)     -2.1    .24    0.0000  <=.001 
       study_name_f(LBLS)                       .75    (.3,1.8)      -.29    .45    0.5297  > .10  
       study_name_f(SATSA)                      .56    (.24,1.26)    -.58    .42    0.1644  > .10  
       study_name_f(SHARE)                      1.36   (.79,2.37)    .31     .28    0.2682  > .10  
.      study_name_f(TILDA)                      .61    (.36,1.04)    -.5     .27    0.0647  <=.10  
       educ3_f( < HS )                          1.28   (.8,2.03)     .25     .24    0.2933  > .10  
       educ3_f( HS < )                          .94    (.61,1.46)    -.06    .22    0.7940  > .10  
***    age_in_years_70                          .96    (.93,.98)     -.04    .01    0.0008  <=.001 
*      femaleTRUE                               .67    (.49,.92)     -.39    .16    0.0141  <=.05  
*      singleTRUE                               1.4    (1,1.95)      .34     .17    0.0486  <=.05  
       poor_healthTRUE                          1.35   (.92,1.96)    .3      .19    0.1241  > .10  
       sedentaryTRUE                            1.28   (.94,1.75)    .25     .16    0.1169  > .10  
.      current_work_2TRUE                       2.25   (.8,5.41)     .81     .48    0.0905  <=.10  
       current_drinkTRUE                        1.35   (.94,1.96)    .3      .19    0.1113  > .10  
       study_name_f(LBLS):educ3_f( < HS )       1.33   (.5,3.46)     .29     .49    0.5555  > .10  
       study_name_f(SATSA):educ3_f( < HS )      1.16   (.6,2.31)     .15     .34    0.6570  > .10  
       study_name_f(SHARE):educ3_f( < HS )      .81    (.5,1.35)     -.21    .25    0.4194  > .10  
       study_name_f(TILDA):educ3_f( < HS )      1.12   (.71,1.77)    .11     .23    0.6326  > .10  
       study_name_f(LBLS):educ3_f( HS < )       1.11   (.54,2.32)    .1      .37    0.7807  > .10  
       study_name_f(SATSA):educ3_f( HS < )      1.29   (.58,2.87)    .26     .41    0.5244  > .10  
       study_name_f(SHARE):educ3_f( HS < )      1.08   (.66,1.75)    .07     .25    0.7619  > .10  
**     study_name_f(TILDA):educ3_f( HS < )      .47    (.26,.81)     -.76    .29    0.0079  <=.01  
***    age_in_years_70:femaleTRUE               .98    (.97,.99)     -.02    .01    0.0001  <=.001 
       singleTRUE:poor_healthTRUE               .83    (.66,1.05)    -.18    .12    0.1165  > .10  
*      poor_healthTRUE:sedentaryTRUE            .76    (.59,.96)     -.28    .12    0.0220  <=.05  
       poor_healthTRUE:current_work_2TRUE       .81    (.63,1.05)    -.21    .13    0.1209  > .10  
       study_name_f(LBLS):age_in_years_70       1.02   (.99,1.06)    .02     .02    0.2339  > .10  
       study_name_f(SATSA):age_in_years_70      1      (.97,1.03)    0       .02    0.9971  > .10  
***    study_name_f(SHARE):age_in_years_70      1.06   (1.03,1.09)   .06     .01    0.0001  <=.001 
       study_name_f(TILDA):age_in_years_70      1      (.97,1.02)    0       .01    0.7631  > .10  
.      study_name_f(LBLS):femaleTRUE            1.83   (.95,3.53)    .6      .33    0.0710  <=.10  
*      study_name_f(SATSA):femaleTRUE           .57    (.37,.89)     -.56    .23    0.0143  <=.05  
       study_name_f(SHARE):femaleTRUE           1.39   (.93,2.1)     .33     .21    0.1121  > .10  
       study_name_f(TILDA):femaleTRUE           1.13   (.78,1.64)    .12     .19    0.5270  > .10  
       study_name_f(LBLS):singleTRUE            1.4    (.74,2.66)    .34     .32    0.2956  > .10  
       study_name_f(SATSA):singleTRUE           1.27   (.82,1.98)    .24     .23    0.2921  > .10  
.      study_name_f(SHARE):singleTRUE           .68    (.44,1.05)    -.39    .22    0.0803  <=.10  
.      study_name_f(TILDA):singleTRUE           1.4    (.98,2.02)    .34     .18    0.0674  <=.10  
       study_name_f(LBLS):poor_healthTRUE       .7     (.36,1.34)    -.35    .33    0.2852  > .10  
       study_name_f(SATSA):poor_healthTRUE      1.02   (.63,1.64)    .02     .24    0.9382  > .10  
       study_name_f(SHARE):poor_healthTRUE      .72    (.48,1.08)    -.33    .21    0.1078  > .10  
       study_name_f(TILDA):poor_healthTRUE      1.19   (.8,1.77)     .17     .2     0.3919  > .10  
**     study_name_f(LBLS):sedentaryTRUE         2.82   (1.39,5.64)   1.04    .36    0.0037  <=.01  
       study_name_f(SATSA):sedentaryTRUE        1.37   (.9,2.08)     .31     .21    0.1402  > .10  
       study_name_f(SHARE):sedentaryTRUE        1.08   (.72,1.6)     .08     .2     0.7107  > .10  
       study_name_f(TILDA):sedentaryTRUE        1.34   (.94,1.9)     .29     .18    0.1021  > .10  
       study_name_f(LBLS):current_work_2TRUE    .56    (.18,1.88)    -.58    .59    0.3254  > .10  
.      study_name_f(SATSA):current_work_2TRUE   .39    (.15,1.15)    -.95    .52    0.0658  <=.10  
       study_name_f(SHARE):current_work_2TRUE   .53    (.22,1.51)    -.63    .49    0.1961  > .10  
*      study_name_f(TILDA):current_work_2TRUE   .33    (.13,.92)     -1.11   .48    0.0211  <=.05  
*      study_name_f(LBLS):current_drinkTRUE     .44    (.23,.85)     -.82    .33    0.0135  <=.05  
***    study_name_f(SATSA):current_drinkTRUE    2.59   (1.55,4.35)   .95     .26    0.0003  <=.001 
       study_name_f(SHARE):current_drinkTRUE    1.12   (.75,1.67)    .11     .21    0.5790  > .10  
       study_name_f(TILDA):current_drinkTRUE    1.19   (.8,1.77)     .18     .2     0.3901  > .10  
.      educ3_f( < HS ):poor_healthTRUE          1.29   (.98,1.69)    .25     .14    0.0654  <=.10  
       educ3_f( HS < ):poor_healthTRUE          .87    (.59,1.26)    -.14    .19    0.4600  > .10  
       educ3_f( < HS ):current_work_2TRUE       .89    (.68,1.15)    -.12    .13    0.3639  > .10  
*      educ3_f( HS < ):current_work_2TRUE       .63    (.42,.94)     -.46    .21    0.0239  <=.05  
.      educ3_f( < HS ):current_drinkTRUE        .77    (.59,1.02)    -.26    .14    0.0680  <=.10  
       educ3_f( HS < ):current_drinkTRUE        1.23   (.85,1.79)    .21     .19    0.2805  > .10  



##  alsa

### BETWEEN

coef_name                              A                 B                  AA                BB                    best               
-------------------------------------  ----------------  -----------------  ----------------  --------------------  -------------------
(Intercept)                            .19(.14,.26)***   .14(.09,.21)***    .15(.09,.24)***   .18(.07,.42)***       .14(.13,.15)***    
age_in_years_70                        .95(.93,.97)***   .95(.93,.97)***    .98(.93,1.03)     .94(.87,1.01)         .98(.97,.99)***    
femaleTRUE                             .57(.42,.76)***   .6(.44,.81)***     .96(.53,1.71)     .65(.28,1.56)                            
educ3_f( < HS )                        1.23(.81,1.84)    1.22(.8,1.82)      1.43(.64,3.1)     1.44(.41,4.83)                           
educ3_f( HS < )                        1.06(.77,1.45)    1.05(.76,1.44)     1.16(.64,2.11)    1.01(.42,2.43)                           
singleTRUE                             1.28(.92,1.77)    1.3(.93,1.79)      1.02(.45,2.19)    .69(.23,1.91)         1.39(1.13,1.69)**  
poor_healthTRUE                                          1.12(.82,1.53)                       1.17(.48,2.83)                           
sedentaryTRUE                                            1.16(.85,1.56)                       .96(.38,2.35)                            
current_work_2TRUE                                       1.75(.64,4.1)                        61.72(.52,19638.03)                      
current_drinkTRUE                                        1.38(1.01,1.92)*                     .7(.31,1.64)                             
age_in_years_70:femaleTRUE                                                  .92(.87,.98)**    .92(.87,.98)**        .99(.99,1).        
age_in_years_70:educ3_f( < HS )                                             1.02(.95,1.1)     1(.93,1.08)                              
age_in_years_70:educ3_f( HS < )                                             .98(.93,1.04)     .98(.92,1.04)                            
age_in_years_70:singleTRUE                                                  1(.95,1.05)       1.01(.95,1.07)                           
age_in_years_70:poor_healthTRUE                                                               1(.94,1.06)                              
age_in_years_70:sedentaryTRUE                                                                 1.01(.96,1.07)                           
age_in_years_70:current_work_2TRUE                                                            .75(.47,1.02)                            
age_in_years_70:current_drinkTRUE                                                             1.05(.99,1.12).       .98(.98,.99)***    
femaleTRUE:educ3_f( < HS )                                                  .45(.16,1.18)     .31(.1,.89)*                             
femaleTRUE:educ3_f( HS < )                                                  .78(.39,1.53)     .72(.35,1.47)                            
femaleTRUE:singleTRUE                                                       1.7(.84,3.54)     2.1(1,4.55).                             
femaleTRUE:poor_healthTRUE                                                                    1.36(.66,2.79)                           
femaleTRUE:sedentaryTRUE                                                                      1.35(.67,2.76)                           
femaleTRUE:current_work_2TRUE                                                                 .14(0,4)                                 
femaleTRUE:current_drinkTRUE                                                                  1.39(.66,2.92)                           
educ3_f( < HS ):singleTRUE                                                  .74(.28,1.93)     .88(.32,2.41)                            
educ3_f( HS < ):singleTRUE                                                  1.37(.67,2.84)    1.33(.63,2.86)                           
educ3_f( < HS ):poor_healthTRUE                                                               .99(.4,2.46)                             
educ3_f( HS < ):poor_healthTRUE                                                               .77(.37,1.57)                            
educ3_f( < HS ):sedentaryTRUE                                                                 2.71(1.11,6.82)*                         
educ3_f( HS < ):sedentaryTRUE                                                                 1.1(.54,2.24)                            
educ3_f( < HS ):current_work_2TRUE                                                            1.09(.03,37.99)                          
educ3_f( HS < ):current_work_2TRUE                                                            .46(.02,6.09)                            
educ3_f( < HS ):current_drinkTRUE                                                             .67(.26,1.75)                            
educ3_f( HS < ):current_drinkTRUE                                                             1.38(.65,2.93)                           
singleTRUE:poor_healthTRUE                                                                    1.1(.53,2.28)                            
singleTRUE:sedentaryTRUE                                                                      .63(.3,1.28)                             
singleTRUE:current_work_2TRUE                                                                 2.3(.17,38.18)                           
singleTRUE:current_drinkTRUE                                                                  1.63(.76,3.59)        1.52(1.26,1.83)*** 
poor_healthTRUE:sedentaryTRUE                                                                 .72(.37,1.42)                            
poor_healthTRUE:current_work_2TRUE                                                            8.41(.69,204.5)                          
poor_healthTRUE:current_drinkTRUE                                                             1.01(.5,2.07)                            
sedentaryTRUE:current_work_2TRUE                                                              3.27(.31,51.92)                          
sedentaryTRUE:current_drinkTRUE                                                               1.02(.51,2.05)                           
current_work_2TRUE:current_drinkTRUE                                                          .02(0,.81).                              


###  A

 solution of model **A** fit to data from **alsa** study

    logLik       dev      AIC      BIC   df_Null   df_Model   df_drop
----------  --------  -------  -------  --------  ---------  --------
 -672.2898   1344.58   1356.6   1390.3      2052       2047         5


sign   coef_name         odds   odds_ci      est     se          p  sign_  
-----  ----------------  -----  -----------  ------  ----  -------  -------
***    (Intercept)       .19    (.14,.26)    -1.65   .16    0.0000  <=.001 
***    age_in_years_70   .95    (.93,.97)    -.05    .01    0.0000  <=.001 
***    femaleTRUE        .57    (.42,.76)    -.57    .15    0.0002  <=.001 
       educ3_f( < HS )   1.23   (.81,1.84)   .21     .21    0.3191  > .10  
       educ3_f( HS < )   1.06   (.77,1.45)   .06     .16    0.7215  > .10  
       singleTRUE        1.28   (.92,1.77)   .25     .17    0.1327  > .10  


###  B

 solution of model **B** fit to data from **alsa** study

   logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
---------  ---------  -------  -------  --------  ---------  --------
 -669.032   1338.064   1358.1   1414.3      2052       2043         9


sign   coef_name            odds   odds_ci       est    se          p  sign_  
-----  -------------------  -----  ------------  -----  ----  -------  -------
***    (Intercept)          .14    (.09,.21)     -2     .22    0.0000  <=.001 
***    age_in_years_70      .95    (.93,.97)     -.05   .01    0.0001  <=.001 
***    femaleTRUE           .6     (.44,.81)     -.51   .16    0.0009  <=.001 
       educ3_f( < HS )      1.22   (.8,1.82)     .2     .21    0.3455  > .10  
       educ3_f( HS < )      1.05   (.76,1.44)    .05    .16    0.7644  > .10  
       singleTRUE           1.3    (.93,1.79)    .26    .17    0.1201  > .10  
       poor_healthTRUE      1.12   (.82,1.53)    .12    .16    0.4687  > .10  
       sedentaryTRUE        1.16   (.85,1.56)    .15    .15    0.3424  > .10  
       current_work_2TRUE   1.75   (.64,4.1)     .56    .47    0.2300  > .10  
*      current_drinkTRUE    1.38   (1.01,1.92)   .33    .16    0.0487  <=.05  


###  AA

 solution of model **AA** fit to data from **alsa** study

   logLik        dev    AIC      BIC   df_Null   df_Model   df_drop
---------  ---------  -----  -------  --------  ---------  --------
 -664.002   1328.004   1358   1442.4      2052       2038        14


sign   coef_name                         odds   odds_ci      est    se          p  sign_  
-----  --------------------------------  -----  -----------  -----  ----  -------  -------
***    (Intercept)                       .15    (.09,.24)    -1.9   .24    0.0000  <=.001 
       age_in_years_70                   .98    (.93,1.03)   -.02   .03    0.3972  > .10  
       femaleTRUE                        .96    (.53,1.71)   -.04   .3     0.8809  > .10  
       educ3_f( < HS )                   1.43   (.64,3.1)    .36    .4     0.3695  > .10  
       educ3_f( HS < )                   1.16   (.64,2.11)   .15    .3     0.6276  > .10  
       singleTRUE                        1.02   (.45,2.19)   .02    .4     0.9673  > .10  
**     age_in_years_70:femaleTRUE        .92    (.87,.98)    -.08   .03    0.0046  <=.01  
       age_in_years_70:educ3_f( < HS )   1.02   (.95,1.1)    .02    .04    0.5310  > .10  
       age_in_years_70:educ3_f( HS < )   .98    (.93,1.04)   -.02   .03    0.5682  > .10  
       age_in_years_70:singleTRUE        1      (.95,1.05)   0      .03    0.9437  > .10  
       femaleTRUE:educ3_f( < HS )        .45    (.16,1.18)   -.8    .5     0.1141  > .10  
       femaleTRUE:educ3_f( HS < )        .78    (.39,1.53)   -.25   .35    0.4639  > .10  
       femaleTRUE:singleTRUE             1.7    (.84,3.54)   .53    .37    0.1477  > .10  
       educ3_f( < HS ):singleTRUE        .74    (.28,1.93)   -.3    .49    0.5408  > .10  
       educ3_f( HS < ):singleTRUE        1.37   (.67,2.84)   .31    .37    0.3950  > .10  


###  BB

 solution of model **BB** fit to data from **alsa** study

    logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
----------  ---------  -------  -------  --------  ---------  --------
 -647.6469   1295.294   1385.3   1638.5      2052       2008        44


sign   coef_name                              odds    odds_ci          est     se           p  sign_  
-----  -------------------------------------  ------  ---------------  ------  -----  -------  -------
***    (Intercept)                            .18     (.07,.42)        -1.69   .44     0.0001  <=.001 
       age_in_years_70                        .94     (.87,1.01)       -.06    .04     0.1157  > .10  
       femaleTRUE                             .65     (.28,1.56)       -.43    .44     0.3311  > .10  
       educ3_f( < HS )                        1.44    (.41,4.83)       .36     .63     0.5615  > .10  
       educ3_f( HS < )                        1.01    (.42,2.43)       .01     .45     0.9771  > .10  
       singleTRUE                             .69     (.23,1.91)       -.37    .54     0.4889  > .10  
       poor_healthTRUE                        1.17    (.48,2.83)       .16     .45     0.7236  > .10  
       sedentaryTRUE                          .96     (.38,2.35)       -.04    .46     0.9378  > .10  
       current_work_2TRUE                     61.72   (.52,19638.03)   4.12    2.53    0.1036  > .10  
       current_drinkTRUE                      .7      (.31,1.64)       -.35    .42     0.4003  > .10  
**     age_in_years_70:femaleTRUE             .92     (.87,.98)        -.08    .03     0.0055  <=.01  
       age_in_years_70:educ3_f( < HS )        1       (.93,1.08)       0       .04     0.9132  > .10  
       age_in_years_70:educ3_f( HS < )        .98     (.92,1.04)       -.02    .03     0.5117  > .10  
       age_in_years_70:singleTRUE             1.01    (.95,1.07)       .01     .03     0.7665  > .10  
       age_in_years_70:poor_healthTRUE        1       (.94,1.06)       0       .03     0.9920  > .10  
       age_in_years_70:sedentaryTRUE          1.01    (.96,1.07)       .01     .03     0.6563  > .10  
       age_in_years_70:current_work_2TRUE     .75     (.47,1.02)       -.28    .19     0.1321  > .10  
.      age_in_years_70:current_drinkTRUE      1.05    (.99,1.12)       .05     .03     0.0968  <=.10  
*      femaleTRUE:educ3_f( < HS )             .31     (.1,.89)         -1.17   .55     0.0339  <=.05  
       femaleTRUE:educ3_f( HS < )             .72     (.35,1.47)       -.33    .36     0.3642  > .10  
.      femaleTRUE:singleTRUE                  2.1     (1,4.55)         .74     .39     0.0543  <=.10  
       femaleTRUE:poor_healthTRUE             1.36    (.66,2.79)       .31     .37     0.3975  > .10  
       femaleTRUE:sedentaryTRUE               1.35    (.67,2.76)       .3      .36     0.4040  > .10  
       femaleTRUE:current_work_2TRUE          .14     (0,4)            -1.98   1.95    0.3098  > .10  
       femaleTRUE:current_drinkTRUE           1.39    (.66,2.92)       .33     .38     0.3824  > .10  
       educ3_f( < HS ):singleTRUE             .88     (.32,2.41)       -.13    .52     0.8080  > .10  
       educ3_f( HS < ):singleTRUE             1.33    (.63,2.86)       .29     .39     0.4551  > .10  
       educ3_f( < HS ):poor_healthTRUE        .99     (.4,2.46)        -.01    .46     0.9886  > .10  
       educ3_f( HS < ):poor_healthTRUE        .77     (.37,1.57)       -.26    .36     0.4770  > .10  
*      educ3_f( < HS ):sedentaryTRUE          2.71    (1.11,6.82)      1       .46     0.0304  <=.05  
       educ3_f( HS < ):sedentaryTRUE          1.1     (.54,2.24)       .1      .36     0.7884  > .10  
       educ3_f( < HS ):current_work_2TRUE     1.09    (.03,37.99)      .09     1.67    0.9584  > .10  
       educ3_f( HS < ):current_work_2TRUE     .46     (.02,6.09)       -.77    1.38    0.5762  > .10  
       educ3_f( < HS ):current_drinkTRUE      .67     (.26,1.75)       -.4     .49     0.4083  > .10  
       educ3_f( HS < ):current_drinkTRUE      1.38    (.65,2.93)       .32     .38     0.4004  > .10  
       singleTRUE:poor_healthTRUE             1.1     (.53,2.28)       .1      .37     0.7914  > .10  
       singleTRUE:sedentaryTRUE               .63     (.3,1.28)        -.47    .37     0.2051  > .10  
       singleTRUE:current_work_2TRUE          2.3     (.17,38.18)      .83     1.32    0.5278  > .10  
       singleTRUE:current_drinkTRUE           1.63    (.76,3.59)       .49     .4      0.2191  > .10  
       poor_healthTRUE:sedentaryTRUE          .72     (.37,1.42)       -.32    .34     0.3468  > .10  
       poor_healthTRUE:current_work_2TRUE     8.41    (.69,204.5)      2.13    1.38    0.1217  > .10  
       poor_healthTRUE:current_drinkTRUE      1.01    (.5,2.07)        .01     .36     0.9782  > .10  
       sedentaryTRUE:current_work_2TRUE       3.27    (.31,51.92)      1.18    1.24    0.3392  > .10  
       sedentaryTRUE:current_drinkTRUE        1.02    (.51,2.05)       .02     .35     0.9583  > .10  
.      current_work_2TRUE:current_drinkTRUE   .02     (0,.81)          -3.77   2.13    0.0768  <=.10  


###  best

 solution of model **best** fit to data from **alsa** study

    logLik        dev       AIC       BIC   df_Null   df_Model   df_drop
----------  ---------  --------  --------  --------  ---------  --------
 -5349.962   10699.92   10713.9   10765.9     12327      12321         6


sign   coef_name                           odds   odds_ci       est     se          p  sign_  
-----  ----------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                         .14    (.13,.15)     -1.94   .04    0.0000  <=.001 
***    age_in_years_70                     .98    (.97,.99)     -.02    0      0.0000  <=.001 
**     singleTRUE                          1.39   (1.13,1.69)   .33     .1     0.0014  <=.01  
.      age_in_years_70:femaleTRUE          .99    (.99,1)       -.01    0      0.0999  <=.10  
***    singleTRUE:femaleTRUE               .7     (.59,.84)     -.35    .09    0.0001  <=.001 
***    age_in_years_70:current_drinkTRUE   .98    (.98,.99)     -.02    0      0.0001  <=.001 
***    singleTRUE:current_drinkTRUE        1.52   (1.26,1.83)   .42     .09    0.0000  <=.001 


##  lbsl

### BETWEEN

coef_name                              A                 B                    AA                BB                   best               
-------------------------------------  ----------------  -------------------  ----------------  -------------------  -------------------
(Intercept)                            .09(.05,.17)***   .11(.05,.22)***      .1(.04,.23)***    .05(.01,.28)**       .14(.13,.15)***    
age_in_years_70                        .97(.95,.99)**    .97(.94,.99)**       .95(.9,1)*        .9(.83,.98)*         .98(.96,.99)***    
femaleTRUE                             1.45(.84,2.53)    1.35(.78,2.39)       .86(.25,2.98)     .31(.04,2.11)                           
educ3_f( < HS )                        1.58(.67,3.59)    1.62(.67,3.77)       1.45(.25,6.78)    5.35(.33,70.89)                         
educ3_f( HS < )                        .84(.46,1.57)     .95(.51,1.8)         1.02(.37,3.14)    2.01(.35,13.01)                         
singleTRUE                             1.65(.97,2.81).   1.68(.97,2.9).       1.2(.27,4.83)     2.27(.29,17.5)                          
poor_healthTRUE                                          .73(.42,1.27)                          .66(.11,3.76)                           
sedentaryTRUE                                            2.97(1.56,5.55)***                     10.07(1.43,71.57)*   1.6(1.43,1.77)***  
current_work_2TRUE                                       .9(.45,1.78)                           1.53(.16,11.94)                         
current_drinkTRUE                                        .64(.37,1.11)                          1(.16,6.62)                             
age_in_years_70:femaleTRUE                                                    1.03(.99,1.08)    1.02(.97,1.08)       .99(.99,1)         
age_in_years_70:educ3_f( < HS )                                               .98(.89,1.07)     .92(.81,1.03)                           
age_in_years_70:educ3_f( HS < )                                               1.03(.99,1.08)    1.01(.95,1.07)                          
age_in_years_70:singleTRUE                                                    .97(.93,1.01)     .97(.92,1.03)        .99(.98,1)         
age_in_years_70:poor_healthTRUE                                                                 1.03(.97,1.09)       .99(.98,1)*        
age_in_years_70:sedentaryTRUE                                                                   1.04(.97,1.12)                          
age_in_years_70:current_work_2TRUE                                                              1.05(.99,1.11).      1.02(1.01,1.03)*** 
age_in_years_70:current_drinkTRUE                                                               1.04(.98,1.1)        .98(.97,.99)***    
femaleTRUE:educ3_f( < HS )                                                    2.06(.28,16.57)   1.17(.1,14.18)                          
femaleTRUE:educ3_f( HS < )                                                    1.71(.43,6.72)    1.89(.37,10.14)                         
femaleTRUE:singleTRUE                                                         2.37(.71,8.72)    5.13(1.23,25.99)*    .82(.71,.95)*      
femaleTRUE:poor_healthTRUE                                                                      1.73(.43,7.25)                          
femaleTRUE:sedentaryTRUE                                                                        .98(.18,5.75)                           
femaleTRUE:current_work_2TRUE                                                                   .81(.17,3.82)                           
femaleTRUE:current_drinkTRUE                                                                    2.01(.44,9.83)                          
educ3_f( < HS ):singleTRUE                                                    .85(.11,6.93)     3.16(.23,49.8)                          
educ3_f( HS < ):singleTRUE                                                    .49(.13,1.83)     .46(.08,2.41)                           
educ3_f( < HS ):poor_healthTRUE                                                                 .81(.1,6.52)                            
educ3_f( HS < ):poor_healthTRUE                                                                 .96(.23,4.04)                           
educ3_f( < HS ):sedentaryTRUE                                                                   .89(.09,10.33)                          
educ3_f( HS < ):sedentaryTRUE                                                                   .33(.06,1.78)                           
educ3_f( < HS ):current_work_2TRUE                                                              .12(0,2.21)                             
educ3_f( HS < ):current_work_2TRUE                                                              .3(.05,1.56)                            
educ3_f( < HS ):current_drinkTRUE                                                               .28(.03,2.56)                           
educ3_f( HS < ):current_drinkTRUE                                                               1.1(.23,5.45)                           
singleTRUE:poor_healthTRUE                                                                      .52(.13,2.15)                           
singleTRUE:sedentaryTRUE                                                                        .64(.12,3.32)                           
singleTRUE:current_work_2TRUE                                                                   1.78(.35,9.33)                          
singleTRUE:current_drinkTRUE                                                                    .26(.05,1.12).       1.84(1.59,2.13)*** 
poor_healthTRUE:sedentaryTRUE                                                                   1.33(.3,6.14)                           
poor_healthTRUE:current_work_2TRUE                                                              .85(.16,4.09)                           
poor_healthTRUE:current_drinkTRUE                                                               1.82(.47,7.41)                          
sedentaryTRUE:current_work_2TRUE                                                                6.53(.89,55.81).                        
sedentaryTRUE:current_drinkTRUE                                                                 .25(.04,1.24)                           
current_work_2TRUE:current_drinkTRUE                                                            1.94(.39,11.33)                         


###  A

 solution of model **A** fit to data from **lbsl** study

   logLik      dev     AIC     BIC   df_Null   df_Model   df_drop
---------  -------  ------  ------  --------  ---------  --------
 -195.815   391.63   403.6   429.2       522        517         5


sign   coef_name         odds   odds_ci      est     se          p  sign_  
-----  ----------------  -----  -----------  ------  ----  -------  -------
***    (Intercept)       .09    (.05,.17)    -2.39   .32    0.0000  <=.001 
**     age_in_years_70   .97    (.95,.99)    -.03    .01    0.0038  <=.01  
       femaleTRUE        1.45   (.84,2.53)   .37     .28    0.1873  > .10  
       educ3_f( < HS )   1.58   (.67,3.59)   .46     .42    0.2823  > .10  
       educ3_f( HS < )   .84    (.46,1.57)   -.17    .31    0.5807  > .10  
.      singleTRUE        1.65   (.97,2.81)   .5      .27    0.0668  <=.10  


###  B

 solution of model **B** fit to data from **lbsl** study

    logLik        dev     AIC     BIC   df_Null   df_Model   df_drop
----------  ---------  ------  ------  --------  ---------  --------
 -188.4152   376.8303   396.8   439.4       522        513         9


sign   coef_name            odds   odds_ci       est     se          p  sign_  
-----  -------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)          .11    (.05,.22)     -2.22   .38    0.0000  <=.001 
**     age_in_years_70      .97    (.94,.99)     -.03    .01    0.0052  <=.01  
       femaleTRUE           1.35   (.78,2.39)    .3      .29    0.2908  > .10  
       educ3_f( < HS )      1.62   (.67,3.77)    .48     .44    0.2667  > .10  
       educ3_f( HS < )      .95    (.51,1.8)     -.05    .32    0.8646  > .10  
.      singleTRUE           1.68   (.97,2.9)     .52     .28    0.0621  <=.10  
       poor_healthTRUE      .73    (.42,1.27)    -.31    .28    0.2740  > .10  
***    sedentaryTRUE        2.97   (1.56,5.55)   1.09    .32    0.0007  <=.001 
       current_work_2TRUE   .9     (.45,1.78)    -.1     .35    0.7647  > .10  
       current_drinkTRUE    .64    (.37,1.11)    -.45    .28    0.1108  > .10  


###  AA

 solution of model **AA** fit to data from **lbsl** study

    logLik        dev   AIC     BIC   df_Null   df_Model   df_drop
----------  ---------  ----  ------  --------  ---------  --------
 -190.5223   381.0446   411   474.9       522        508        14


sign   coef_name                         odds   odds_ci       est     se           p  sign_  
-----  --------------------------------  -----  ------------  ------  -----  -------  -------
***    (Intercept)                       .1     (.04,.23)     -2.29   .46     0.0000  <=.001 
*      age_in_years_70                   .95    (.9,1)        -.05    .03     0.0383  <=.05  
       femaleTRUE                        .86    (.25,2.98)    -.15    .62     0.8135  > .10  
       educ3_f( < HS )                   1.45   (.25,6.78)    .37     .82     0.6502  > .10  
       educ3_f( HS < )                   1.02   (.37,3.14)    .02     .54     0.9733  > .10  
       singleTRUE                        1.2    (.27,4.83)    .18     .73     0.8008  > .10  
       age_in_years_70:femaleTRUE        1.03   (.99,1.08)    .03     .02     0.1418  > .10  
       age_in_years_70:educ3_f( < HS )   .98    (.89,1.07)    -.02    .05     0.6083  > .10  
       age_in_years_70:educ3_f( HS < )   1.03   (.99,1.08)    .03     .02     0.1543  > .10  
       age_in_years_70:singleTRUE        .97    (.93,1.01)    -.03    .02     0.1590  > .10  
       femaleTRUE:educ3_f( < HS )        2.06   (.28,16.57)   .72     1.02    0.4820  > .10  
       femaleTRUE:educ3_f( HS < )        1.71   (.43,6.72)    .54     .69     0.4388  > .10  
       femaleTRUE:singleTRUE             2.37   (.71,8.72)    .86     .63     0.1731  > .10  
       educ3_f( < HS ):singleTRUE        .85    (.11,6.93)    -.17    1.05    0.8732  > .10  
       educ3_f( HS < ):singleTRUE        .49    (.13,1.83)    -.7     .67     0.2953  > .10  


###  BB

 solution of model **BB** fit to data from **lbsl** study

    logLik        dev     AIC     BIC   df_Null   df_Model   df_drop
----------  ---------  ------  ------  --------  ---------  --------
 -171.3046   342.6091   432.6   624.3       522        478        44


sign   coef_name                              odds    odds_ci        est     se           p  sign_ 
-----  -------------------------------------  ------  -------------  ------  -----  -------  ------
**     (Intercept)                            .05     (.01,.28)      -2.96   .94     0.0017  <=.01 
*      age_in_years_70                        .9      (.83,.98)      -.1     .04     0.0165  <=.05 
       femaleTRUE                             .31     (.04,2.11)     -1.17   1       0.2404  > .10 
       educ3_f( < HS )                        5.35    (.33,70.89)    1.68    1.34    0.2115  > .10 
       educ3_f( HS < )                        2.01    (.35,13.01)    .7      .91     0.4446  > .10 
       singleTRUE                             2.27    (.29,17.5)     .82     1.04    0.4310  > .10 
       poor_healthTRUE                        .66     (.11,3.76)     -.41    .89     0.6446  > .10 
*      sedentaryTRUE                          10.07   (1.43,71.57)   2.31    .99     0.0192  <=.05 
       current_work_2TRUE                     1.53    (.16,11.94)    .43     1.08    0.6926  > .10 
       current_drinkTRUE                      1       (.16,6.62)     0       .94     0.9984  > .10 
       age_in_years_70:femaleTRUE             1.02    (.97,1.08)     .02     .03     0.4195  > .10 
       age_in_years_70:educ3_f( < HS )        .92     (.81,1.03)     -.09    .06     0.1511  > .10 
       age_in_years_70:educ3_f( HS < )        1.01    (.95,1.07)     .01     .03     0.7474  > .10 
       age_in_years_70:singleTRUE             .97     (.92,1.03)     -.03    .03     0.2938  > .10 
       age_in_years_70:poor_healthTRUE        1.03    (.97,1.09)     .03     .03     0.4032  > .10 
       age_in_years_70:sedentaryTRUE          1.04    (.97,1.12)     .04     .04     0.2757  > .10 
.      age_in_years_70:current_work_2TRUE     1.05    (.99,1.11)     .05     .03     0.0909  <=.10 
       age_in_years_70:current_drinkTRUE      1.04    (.98,1.1)      .04     .03     0.1938  > .10 
       femaleTRUE:educ3_f( < HS )             1.17    (.1,14.18)     .16     1.25    0.8983  > .10 
       femaleTRUE:educ3_f( HS < )             1.89    (.37,10.14)    .64     .83     0.4450  > .10 
*      femaleTRUE:singleTRUE                  5.13    (1.23,25.99)   1.63    .77     0.0332  <=.05 
       femaleTRUE:poor_healthTRUE             1.73    (.43,7.25)     .55     .72     0.4437  > .10 
       femaleTRUE:sedentaryTRUE               .98     (.18,5.75)     -.02    .87     0.9813  > .10 
       femaleTRUE:current_work_2TRUE          .81     (.17,3.82)     -.21    .79     0.7878  > .10 
       femaleTRUE:current_drinkTRUE           2.01    (.44,9.83)     .7      .78     0.3717  > .10 
       educ3_f( < HS ):singleTRUE             3.16    (.23,49.8)     1.15    1.35    0.3926  > .10 
       educ3_f( HS < ):singleTRUE             .46     (.08,2.41)     -.77    .85     0.3631  > .10 
       educ3_f( < HS ):poor_healthTRUE        .81     (.1,6.52)      -.21    1.05    0.8411  > .10 
       educ3_f( HS < ):poor_healthTRUE        .96     (.23,4.04)     -.04    .73     0.9584  > .10 
       educ3_f( < HS ):sedentaryTRUE          .89     (.09,10.33)    -.12    1.2     0.9222  > .10 
       educ3_f( HS < ):sedentaryTRUE          .33     (.06,1.78)     -1.11   .87     0.2020  > .10 
       educ3_f( < HS ):current_work_2TRUE     .12     (0,2.21)       -2.09   1.55    0.1778  > .10 
       educ3_f( HS < ):current_work_2TRUE     .3      (.05,1.56)     -1.22   .85     0.1531  > .10 
       educ3_f( < HS ):current_drinkTRUE      .28     (.03,2.56)     -1.29   1.14    0.2578  > .10 
       educ3_f( HS < ):current_drinkTRUE      1.1     (.23,5.45)     .1      .8      0.9024  > .10 
       singleTRUE:poor_healthTRUE             .52     (.13,2.15)     -.64    .72     0.3689  > .10 
       singleTRUE:sedentaryTRUE               .64     (.12,3.32)     -.44    .84     0.5982  > .10 
       singleTRUE:current_work_2TRUE          1.78    (.35,9.33)     .57     .83     0.4892  > .10 
.      singleTRUE:current_drinkTRUE           .26     (.05,1.12)     -1.35   .77     0.0793  <=.10 
       poor_healthTRUE:sedentaryTRUE          1.33    (.3,6.14)      .29     .76     0.7089  > .10 
       poor_healthTRUE:current_work_2TRUE     .85     (.16,4.09)     -.17    .82     0.8383  > .10 
       poor_healthTRUE:current_drinkTRUE      1.82    (.47,7.41)     .6      .7      0.3917  > .10 
.      sedentaryTRUE:current_work_2TRUE       6.53    (.89,55.81)    1.88    1.04    0.0724  <=.10 
       sedentaryTRUE:current_drinkTRUE        .25     (.04,1.24)     -1.38   .84     0.1020  > .10 
       current_work_2TRUE:current_drinkTRUE   1.94    (.39,11.33)    .66     .85     0.4373  > .10 


###  best

 solution of model **best** fit to data from **lbsl** study

    logLik        dev       AIC       BIC   df_Null   df_Model   df_drop
----------  ---------  --------  --------  --------  ---------  --------
 -5303.738   10607.48   10627.5   10701.7     12327      12318         9


sign   coef_name                            odds   odds_ci       est     se          p  sign_  
-----  -----------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                          .14    (.13,.15)     -1.99   .04    0.0000  <=.001 
***    age_in_years_70                      .98    (.96,.99)     -.03    .01    0.0000  <=.001 
***    sedentaryTRUE                        1.6    (1.43,1.77)   .47     .05    0.0000  <=.001 
       age_in_years_70:femaleTRUE           .99    (.99,1)       -.01    0      0.1992  > .10  
       age_in_years_70:singleTRUE           .99    (.98,1)       -.01    0      0.1566  > .10  
*      femaleTRUE:singleTRUE                .82    (.71,.95)     -.2     .08    0.0103  <=.05  
*      age_in_years_70:poor_healthTRUE      .99    (.98,1)       -.01    0      0.0321  <=.05  
***    age_in_years_70:current_work_2TRUE   1.02   (1.01,1.03)   .02     0      0.0000  <=.001 
***    age_in_years_70:current_drinkTRUE    .98    (.97,.99)     -.02    0      0.0000  <=.001 
***    singleTRUE:current_drinkTRUE         1.84   (1.59,2.13)   .61     .08    0.0000  <=.001 


##  satsa

### BETWEEN

coef_name                              A                  B                    AA                 BB                     best               
-------------------------------------  -----------------  -------------------  -----------------  ---------------------  -------------------
(Intercept)                            .25(.15,.42)***    .08(.04,.15)***      .13(.04,.34)***    .03(0,.25)**           .13(.11,.15)***    
age_in_years_70                        .95(.94,.96)***    .95(.93,.96)***      .93(.87,.98)*      .76(.64,.87)***        .96(.95,.97)***    
femaleTRUE                             .44(.34,.57)***    .48(.37,.63)***      .66(.22,1.98)      .7(.15,3.2)            .74(.66,.84)***    
educ3_f( < HS )                        1.17(.72,1.98)     1.27(.77,2.17)       2.93(1.13,9.05)*   4.14(.47,73.97)                           
educ3_f( HS < )                        1.03(.51,2.06)     1.13(.56,2.28)       1.39(.36,5.56)     3.51(.24,85.22)                           
singleTRUE                             1.46(1.09,1.94)*   1.59(1.18,2.13)**    2.17(.66,7.31)     4.75(.97,24.56).       1.6(1.4,1.84)***   
poor_healthTRUE                                           1.19(.9,1.57)                           1.68(.34,7.77)         1.39(1.22,1.58)*** 
sedentaryTRUE                                             1.58(1.19,2.12)**                       .64(.14,3.08)                             
current_work_2TRUE                                        .67(.46,.97)*                           .01(0,.1)***           .64(.5,.8)***      
current_drinkTRUE                                         2.87(2.03,4.12)***                      9.1(1.32,119.98)*      1.25(1.12,1.4)***  
age_in_years_70:femaleTRUE                                                     .96(.93,.98)***    .98(.95,1.02)                             
age_in_years_70:educ3_f( < HS )                                                1.05(.99,1.12)     1.23(1.1,1.45)**       .99(.98,1.01)      
age_in_years_70:educ3_f( HS < )                                                1.02(.95,1.11)     1.15(1,1.37).          1.01(.99,1.03)     
age_in_years_70:singleTRUE                                                     1(.98,1.02)        1.01(.98,1.05)                            
age_in_years_70:poor_healthTRUE                                                                   1(.97,1.03)                               
age_in_years_70:sedentaryTRUE                                                                     1(.96,1.03)            .99(.98,1)**       
age_in_years_70:current_work_2TRUE                                                                .99(.96,1.03)                             
age_in_years_70:current_drinkTRUE                                                                 1.04(.99,1.08)                            
femaleTRUE:educ3_f( < HS )                                                     .4(.13,1.19).      .44(.12,1.62)                             
femaleTRUE:educ3_f( HS < )                                                     .69(.16,2.95)      .6(.11,3.15)                              
femaleTRUE:singleTRUE                                                          .76(.42,1.36)      .78(.42,1.45)                             
femaleTRUE:poor_healthTRUE                                                                        .73(.4,1.33)                              
femaleTRUE:sedentaryTRUE                                                                          1.1(.6,2.05)                              
femaleTRUE:current_work_2TRUE                                                                     2.04(.91,4.59).        1.36(1.1,1.67)**   
femaleTRUE:current_drinkTRUE                                                                      .99(.46,2.11)                             
educ3_f( < HS ):singleTRUE                                                     .8(.24,2.62)       .81(.19,3.26)                             
educ3_f( HS < ):singleTRUE                                                     1.17(.25,5.51)     .89(.15,5.09)                             
educ3_f( < HS ):poor_healthTRUE                                                                   1.18(.32,4.77)                            
educ3_f( HS < ):poor_healthTRUE                                                                   1.29(.24,7.39)                            
educ3_f( < HS ):sedentaryTRUE                                                                     1.83(.49,6.57)                            
educ3_f( HS < ):sedentaryTRUE                                                                     2.03(.36,11.93)                           
educ3_f( < HS ):current_work_2TRUE                                                                30.16(3.81,392.84)**                      
educ3_f( HS < ):current_work_2TRUE                                                                10.75(.78,201.89).                        
educ3_f( < HS ):current_drinkTRUE                                                                 .36(.03,2.06)                             
educ3_f( HS < ):current_drinkTRUE                                                                 .22(.02,2.01)                             
singleTRUE:poor_healthTRUE                                                                        .54(.28,1.02).         .85(.68,1.06)      
singleTRUE:sedentaryTRUE                                                                          .66(.35,1.27)                             
singleTRUE:current_work_2TRUE                                                                     1.26(.5,3.16)                             
singleTRUE:current_drinkTRUE                                                                      .8(.37,1.71)                              
poor_healthTRUE:sedentaryTRUE                                                                     1.09(.57,2.11)                            
poor_healthTRUE:current_work_2TRUE                                                                1.38(.61,3.1)                             
poor_healthTRUE:current_drinkTRUE                                                                 .62(.29,1.31)                             
sedentaryTRUE:current_work_2TRUE                                                                  1.25(.53,2.99)                            
sedentaryTRUE:current_drinkTRUE                                                                   1.43(.64,3.15)                            
current_work_2TRUE:current_drinkTRUE                                                              1.56(.54,4.67)                            


###  A

 solution of model **A** fit to data from **satsa** study

   logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
---------  ---------  -------  -------  --------  ---------  --------
 -688.693   1377.386   1389.4   1420.6      1351       1346         5


sign   coef_name         odds   odds_ci       est     se          p  sign_  
-----  ----------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)       .25    (.15,.42)     -1.37   .26    0.0000  <=.001 
***    age_in_years_70   .95    (.94,.96)     -.06    .01    0.0000  <=.001 
***    femaleTRUE        .44    (.34,.57)     -.83    .13    0.0000  <=.001 
       educ3_f( < HS )   1.17   (.72,1.98)    .16     .26    0.5407  > .10  
       educ3_f( HS < )   1.03   (.51,2.06)    .03     .35    0.9352  > .10  
*      singleTRUE        1.46   (1.09,1.94)   .38     .15    0.0103  <=.05  


###  B

 solution of model **B** fit to data from **satsa** study

    logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
----------  ---------  -------  -------  --------  ---------  --------
 -663.8472   1327.694   1347.7   1399.8      1351       1342         9


sign   coef_name            odds   odds_ci       est    se          p  sign_  
-----  -------------------  -----  ------------  -----  ----  -------  -------
***    (Intercept)          .08    (.04,.15)     -2.5   .33    0.0000  <=.001 
***    age_in_years_70      .95    (.93,.96)     -.06   .01    0.0000  <=.001 
***    femaleTRUE           .48    (.37,.63)     -.73   .14    0.0000  <=.001 
       educ3_f( < HS )      1.27   (.77,2.17)    .24    .26    0.3553  > .10  
       educ3_f( HS < )      1.13   (.56,2.28)    .12    .36    0.7405  > .10  
**     singleTRUE           1.59   (1.18,2.13)   .46    .15    0.0023  <=.01  
       poor_healthTRUE      1.19   (.9,1.57)     .17    .14    0.2304  > .10  
**     sedentaryTRUE        1.58   (1.19,2.12)   .46    .15    0.0019  <=.01  
*      current_work_2TRUE   .67    (.46,.97)     -.4    .19    0.0369  <=.05  
***    current_drinkTRUE    2.87   (2.03,4.12)   1.05   .18    0.0000  <=.001 


###  AA

 solution of model **AA** fit to data from **satsa** study

    logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
----------  ---------  -------  -------  --------  ---------  --------
 -675.0522   1350.104   1380.1   1458.2      1351       1337        14


sign   coef_name                         odds   odds_ci       est     se          p  sign_  
-----  --------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                       .13    (.04,.34)     -2.02   .52    0.0001  <=.001 
*      age_in_years_70                   .93    (.87,.98)     -.08    .03    0.0131  <=.05  
       femaleTRUE                        .66    (.22,1.98)    -.41    .55    0.4559  > .10  
*      educ3_f( < HS )                   2.93   (1.13,9.05)   1.08    .53    0.0409  <=.05  
       educ3_f( HS < )                   1.39   (.36,5.56)    .33     .69    0.6362  > .10  
       singleTRUE                        2.17   (.66,7.31)    .78     .61    0.2020  > .10  
***    age_in_years_70:femaleTRUE        .96    (.93,.98)     -.05    .01    0.0001  <=.001 
       age_in_years_70:educ3_f( < HS )   1.05   (.99,1.12)    .05     .03    0.1140  > .10  
       age_in_years_70:educ3_f( HS < )   1.02   (.95,1.11)    .02     .04    0.5602  > .10  
       age_in_years_70:singleTRUE        1      (.98,1.02)    0       .01    0.9965  > .10  
.      femaleTRUE:educ3_f( < HS )        .4     (.13,1.19)    -.91    .55    0.0983  <=.10  
       femaleTRUE:educ3_f( HS < )        .69    (.16,2.95)    -.37    .74    0.6180  > .10  
       femaleTRUE:singleTRUE             .76    (.42,1.36)    -.28    .3     0.3530  > .10  
       educ3_f( < HS ):singleTRUE        .8     (.24,2.62)    -.22    .6     0.7145  > .10  
       educ3_f( HS < ):singleTRUE        1.17   (.25,5.51)    .16     .79    0.8376  > .10  


###  BB

 solution of model **BB** fit to data from **satsa** study

    logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
----------  ---------  -------  -------  --------  ---------  --------
 -635.8426   1271.685   1361.7   1596.1      1351       1307        44


sign   coef_name                              odds    odds_ci         est     se           p  sign_  
-----  -------------------------------------  ------  --------------  ------  -----  -------  -------
**     (Intercept)                            .03     (0,.25)         -3.63   1.31    0.0057  <=.01  
***    age_in_years_70                        .76     (.64,.87)       -.28    .07     0.0002  <=.001 
       femaleTRUE                             .7      (.15,3.2)       -.36    .77     0.6411  > .10  
       educ3_f( < HS )                        4.14    (.47,73.97)     1.42    1.25    0.2572  > .10  
       educ3_f( HS < )                        3.51    (.24,85.22)     1.25    1.46    0.3910  > .10  
.      singleTRUE                             4.75    (.97,24.56)     1.56    .82     0.0569  <=.10  
       poor_healthTRUE                        1.68    (.34,7.77)      .52     .79     0.5146  > .10  
       sedentaryTRUE                          .64     (.14,3.08)      -.44    .78     0.5730  > .10  
***    current_work_2TRUE                     .01     (0,.1)          -4.72   1.34    0.0004  <=.001 
*      current_drinkTRUE                      9.1     (1.32,119.98)   2.21    1.11    0.0473  <=.05  
       age_in_years_70:femaleTRUE             .98     (.95,1.02)      -.02    .02     0.3450  > .10  
**     age_in_years_70:educ3_f( < HS )        1.23    (1.1,1.45)      .21     .07     0.0027  <=.01  
.      age_in_years_70:educ3_f( HS < )        1.15    (1,1.37)        .14     .08     0.0720  <=.10  
       age_in_years_70:singleTRUE             1.01    (.98,1.05)      .01     .02     0.4881  > .10  
       age_in_years_70:poor_healthTRUE        1       (.97,1.03)      0       .02     0.9173  > .10  
       age_in_years_70:sedentaryTRUE          1       (.96,1.03)      0       .02     0.9352  > .10  
       age_in_years_70:current_work_2TRUE     .99     (.96,1.03)      -.01    .02     0.6923  > .10  
       age_in_years_70:current_drinkTRUE      1.04    (.99,1.08)      .03     .02     0.1220  > .10  
       femaleTRUE:educ3_f( < HS )             .44     (.12,1.62)      -.82    .66     0.2104  > .10  
       femaleTRUE:educ3_f( HS < )             .6      (.11,3.15)      -.5     .84     0.5495  > .10  
       femaleTRUE:singleTRUE                  .78     (.42,1.45)      -.25    .32     0.4375  > .10  
       femaleTRUE:poor_healthTRUE             .73     (.4,1.33)       -.31    .3      0.3048  > .10  
       femaleTRUE:sedentaryTRUE               1.1     (.6,2.05)       .1      .31     0.7555  > .10  
.      femaleTRUE:current_work_2TRUE          2.04    (.91,4.59)      .71     .41     0.0836  <=.10  
       femaleTRUE:current_drinkTRUE           .99     (.46,2.11)      -.01    .39     0.9831  > .10  
       educ3_f( < HS ):singleTRUE             .81     (.19,3.26)      -.2     .71     0.7740  > .10  
       educ3_f( HS < ):singleTRUE             .89     (.15,5.09)      -.11    .89     0.9002  > .10  
       educ3_f( < HS ):poor_healthTRUE        1.18    (.32,4.77)      .17     .68     0.8050  > .10  
       educ3_f( HS < ):poor_healthTRUE        1.29    (.24,7.39)      .25     .87     0.7694  > .10  
       educ3_f( < HS ):sedentaryTRUE          1.83    (.49,6.57)      .6      .66     0.3578  > .10  
       educ3_f( HS < ):sedentaryTRUE          2.03    (.36,11.93)     .71     .89     0.4266  > .10  
**     educ3_f( < HS ):current_work_2TRUE     30.16   (3.81,392.84)   3.41    1.17    0.0035  <=.01  
.      educ3_f( HS < ):current_work_2TRUE     10.75   (.78,201.89)    2.38    1.4     0.0892  <=.10  
       educ3_f( < HS ):current_drinkTRUE      .36     (.03,2.06)      -1.02   1.02    0.3147  > .10  
       educ3_f( HS < ):current_drinkTRUE      .22     (.02,2.01)      -1.49   1.2     0.2118  > .10  
.      singleTRUE:poor_healthTRUE             .54     (.28,1.02)      -.62    .33     0.0570  <=.10  
       singleTRUE:sedentaryTRUE               .66     (.35,1.27)      -.41    .33     0.2170  > .10  
       singleTRUE:current_work_2TRUE          1.26    (.5,3.16)       .24     .47     0.6142  > .10  
       singleTRUE:current_drinkTRUE           .8      (.37,1.71)      -.23    .39     0.5613  > .10  
       poor_healthTRUE:sedentaryTRUE          1.09    (.57,2.11)      .09     .33     0.7878  > .10  
       poor_healthTRUE:current_work_2TRUE     1.38    (.61,3.1)       .32     .41     0.4389  > .10  
       poor_healthTRUE:current_drinkTRUE      .62     (.29,1.31)      -.48    .39     0.2090  > .10  
       sedentaryTRUE:current_work_2TRUE       1.25    (.53,2.99)      .22     .44     0.6182  > .10  
       sedentaryTRUE:current_drinkTRUE        1.43    (.64,3.15)      .36     .41     0.3738  > .10  
       current_work_2TRUE:current_drinkTRUE   1.56    (.54,4.67)      .45     .55     0.4145  > .10  


###  best

 solution of model **best** fit to data from **satsa** study

    logLik        dev       AIC       BIC   df_Null   df_Model   df_drop
----------  ---------  --------  --------  --------  ---------  --------
 -5259.315   10518.63   10548.6   10659.9     12327      12313        14


sign   coef_name                            odds   odds_ci       est     se          p  sign_  
-----  -----------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                          .13    (.11,.15)     -2.04   .07    0.0000  <=.001 
***    age_in_years_70                      .96    (.95,.97)     -.04    .01    0.0000  <=.001 
***    femaleTRUE                           .74    (.66,.84)     -.3     .06    0.0000  <=.001 
***    singleTRUE                           1.6    (1.4,1.84)    .47     .07    0.0000  <=.001 
***    poor_healthTRUE                      1.39   (1.22,1.58)   .33     .07    0.0000  <=.001 
***    current_work_2TRUE                   .64    (.5,.8)       -.45    .12    0.0002  <=.001 
***    current_drinkTRUE                    1.25   (1.12,1.4)    .22     .06    0.0001  <=.001 
       singleTRUE:poor_healthTRUE           .85    (.68,1.06)    -.17    .11    0.1415  > .10  
**     age_in_years_70:sedentaryTRUE        .99    (.98,1)       -.01    0      0.0074  <=.01  
**     femaleTRUE:current_work_2TRUE        1.36   (1.1,1.67)    .31     .11    0.0037  <=.01  
***    current_drinkTRUE:sedentaryTRUE      1.54   (1.32,1.79)   .43     .08    0.0000  <=.001 
       age_in_years_70:educ3_f( < HS )      .99    (.98,1.01)    -.01    .01    0.3706  > .10  
       age_in_years_70:educ3_f( HS < )      1.01   (.99,1.03)    .01     .01    0.3018  > .10  
       current_work_2TRUE:educ3_f( < HS )   1.01   (.78,1.3)     .01     .13    0.9437  > .10  
.      current_work_2TRUE:educ3_f( HS < )   .72    (.5,1.02)     -.33    .18    0.0661  <=.10  


##  share

### BETWEEN

coef_name                              A                 B                   AA                BB                  best              
-------------------------------------  ----------------  ------------------  ----------------  ------------------  ------------------
(Intercept)                            .19(.15,.24)***   .18(.13,.24)***     .19(.13,.26)***   .23(.14,.39)***     .13(.11,.15)***   
age_in_years_70                        1(.99,1.01)       1(.99,1.01)         .99(.97,1.02)     .98(.95,1.02)                         
femaleTRUE                             1.11(.89,1.39)    1.09(.87,1.37)      1.07(.7,1.65)     .71(.4,1.26)        .64(.56,.74)***   
educ3_f( < HS )                        1(.78,1.29)       1.03(.8,1.32)       1.09(.71,1.67)    .58(.32,1.07).      1.08(.94,1.24)    
educ3_f( HS < )                        .84(.64,1.11)     .85(.64,1.12)       .8(.5,1.29)       .78(.4,1.52)        .83(.69,1).       
singleTRUE                             .86(.64,1.13)     .85(.63,1.12)       .74(.37,1.42)     1.24(.52,2.81)                        
poor_healthTRUE                                          .88(.7,1.11)                          .86(.48,1.54)       1.31(1.04,1.65)*  
sedentaryTRUE                                            1.23(.94,1.58)                        1.02(.49,2.07)                        
current_work_2TRUE                                       .94(.72,1.23)                         .82(.4,1.64)        .63(.51,.77)***   
current_drinkTRUE                                        1.45(1.15,1.83)**                     .75(.39,1.43)                         
age_in_years_70:femaleTRUE                                                   1(.97,1.02)       1(.97,1.03)                           
age_in_years_70:educ3_f( < HS )                                              1.02(.99,1.04)    1(.97,1.03)                           
age_in_years_70:educ3_f( HS < )                                              1.01(.98,1.04)    1(.96,1.04)                           
age_in_years_70:singleTRUE                                                   1(.97,1.03)       1(.97,1.03)                           
age_in_years_70:poor_healthTRUE                                                                1.03(1,1.05).                         
age_in_years_70:sedentaryTRUE                                                                  1(.97,1.04)                           
age_in_years_70:current_work_2TRUE                                                             1.01(.97,1.05)                        
age_in_years_70:current_drinkTRUE                                                              1.01(.98,1.04)      1(.98,1.01)       
femaleTRUE:educ3_f( < HS )                                                   .93(.55,1.57)     .91(.52,1.59)                         
femaleTRUE:educ3_f( HS < )                                                   1.24(.69,2.22)    1.22(.68,2.22)                        
femaleTRUE:singleTRUE                                                        .99(.54,1.89)     .95(.5,1.84)                          
femaleTRUE:poor_healthTRUE                                                                     1.31(.79,2.21)                        
femaleTRUE:sedentaryTRUE                                                                       1.16(.66,2.04)                        
femaleTRUE:current_work_2TRUE                                                                  1.46(.81,2.62)                        
femaleTRUE:current_drinkTRUE                                                                   1.43(.87,2.36)      1.4(1.2,1.64)***  
educ3_f( < HS ):singleTRUE                                                   1.31(.68,2.57)    1.52(.75,3.12)                        
educ3_f( HS < ):singleTRUE                                                   1.13(.52,2.42)    1.1(.49,2.44)                         
educ3_f( < HS ):poor_healthTRUE                                                                2.14(1.22,3.79)**   1.37(1.08,1.74)*  
educ3_f( HS < ):poor_healthTRUE                                                                1.01(.52,1.95)      .92(.65,1.29)     
educ3_f( < HS ):sedentaryTRUE                                                                  2.11(1.1,4.09)*                       
educ3_f( HS < ):sedentaryTRUE                                                                  1.13(.54,2.31)                        
educ3_f( < HS ):current_work_2TRUE                                                             .76(.38,1.48)                         
educ3_f( HS < ):current_work_2TRUE                                                             .57(.28,1.14)                         
educ3_f( < HS ):current_drinkTRUE                                                              1.24(.69,2.23)                        
educ3_f( HS < ):current_drinkTRUE                                                              1.5(.82,2.74)                         
singleTRUE:poor_healthTRUE                                                                     .47(.24,.91)*                         
singleTRUE:sedentaryTRUE                                                                       .48(.2,1.05).       1.5(1.21,1.87)*** 
singleTRUE:current_work_2TRUE                                                                  .75(.33,1.65)                         
singleTRUE:current_drinkTRUE                                                                   1.13(.61,2.07)                        
poor_healthTRUE:sedentaryTRUE                                                                  .49(.27,.9)*        .71(.57,.88)**    
poor_healthTRUE:current_work_2TRUE                                                             .91(.49,1.66)                         
poor_healthTRUE:current_drinkTRUE                                                              1.03(.6,1.78)                         
sedentaryTRUE:current_work_2TRUE                                                               1.41(.74,2.72)                        
sedentaryTRUE:current_drinkTRUE                                                                1.36(.7,2.6)                          
current_work_2TRUE:current_drinkTRUE                                                           1.93(1.04,3.6)*     1.21(.95,1.56)    


###  A

 solution of model **A** fit to data from **share** study

    logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
----------  ---------  -------  -------  --------  ---------  --------
 -1115.067   2230.134   2242.1   2277.2      2554       2549         5


sign   coef_name         odds   odds_ci      est     se          p  sign_  
-----  ----------------  -----  -----------  ------  ----  -------  -------
***    (Intercept)       .19    (.15,.24)    -1.65   .12    0.0000  <=.001 
       age_in_years_70   1      (.99,1.01)   0       .01    0.8531  > .10  
       femaleTRUE        1.11   (.89,1.39)   .1      .11    0.3571  > .10  
       educ3_f( < HS )   1      (.78,1.29)   0       .13    0.9787  > .10  
       educ3_f( HS < )   .84    (.64,1.11)   -.17    .14    0.2177  > .10  
       singleTRUE        .86    (.64,1.13)   -.16    .15    0.2816  > .10  


###  B

 solution of model **B** fit to data from **share** study

   logLik        dev      AIC    BIC   df_Null   df_Model   df_drop
---------  ---------  -------  -----  --------  ---------  --------
 -1109.27   2218.539   2238.5   2297      2554       2545         9


sign   coef_name            odds   odds_ci       est     se          p  sign_  
-----  -------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)          .18    (.13,.24)     -1.73   .15    0.0000  <=.001 
       age_in_years_70      1      (.99,1.01)    0       .01    0.8845  > .10  
       femaleTRUE           1.09   (.87,1.37)    .09     .12    0.4469  > .10  
       educ3_f( < HS )      1.03   (.8,1.32)     .03     .13    0.8397  > .10  
       educ3_f( HS < )      .85    (.64,1.12)    -.17    .14    0.2371  > .10  
       singleTRUE           .85    (.63,1.12)    -.17    .15    0.2554  > .10  
       poor_healthTRUE      .88    (.7,1.11)     -.13    .12    0.2770  > .10  
       sedentaryTRUE        1.23   (.94,1.58)    .21     .13    0.1200  > .10  
       current_work_2TRUE   .94    (.72,1.23)    -.06    .14    0.6660  > .10  
**     current_drinkTRUE    1.45   (1.15,1.83)   .37     .12    0.0017  <=.01  


###  AA

 solution of model **AA** fit to data from **share** study

    logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
----------  ---------  -------  -------  --------  ---------  --------
 -1112.934   2225.869   2255.9   2343.6      2554       2540        14


sign   coef_name                         odds   odds_ci      est     se          p  sign_  
-----  --------------------------------  -----  -----------  ------  ----  -------  -------
***    (Intercept)                       .19    (.13,.26)    -1.67   .17    0.0000  <=.001 
       age_in_years_70                   .99    (.97,1.02)   -.01    .01    0.5547  > .10  
       femaleTRUE                        1.07   (.7,1.65)    .07     .22    0.7611  > .10  
       educ3_f( < HS )                   1.09   (.71,1.67)   .08     .22    0.7024  > .10  
       educ3_f( HS < )                   .8     (.5,1.29)    -.22    .24    0.3626  > .10  
       singleTRUE                        .74    (.37,1.42)   -.3     .34    0.3885  > .10  
       age_in_years_70:femaleTRUE        1      (.97,1.02)   0       .01    0.8562  > .10  
       age_in_years_70:educ3_f( < HS )   1.02   (.99,1.04)   .02     .01    0.2182  > .10  
       age_in_years_70:educ3_f( HS < )   1.01   (.98,1.04)   .01     .02    0.4082  > .10  
       age_in_years_70:singleTRUE        1      (.97,1.03)   0       .01    0.9320  > .10  
       femaleTRUE:educ3_f( < HS )        .93    (.55,1.57)   -.07    .27    0.7840  > .10  
       femaleTRUE:educ3_f( HS < )        1.24   (.69,2.22)   .22     .3     0.4643  > .10  
       femaleTRUE:singleTRUE             .99    (.54,1.89)   -.01    .32    0.9814  > .10  
       educ3_f( < HS ):singleTRUE        1.31   (.68,2.57)   .27     .34    0.4224  > .10  
       educ3_f( HS < ):singleTRUE        1.13   (.52,2.42)   .12     .39    0.7612  > .10  


###  BB

 solution of model **BB** fit to data from **share** study

    logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
----------  ---------  -------  -------  --------  ---------  --------
 -1084.736   2169.472   2259.5   2522.5      2554       2510        44


sign   coef_name                              odds   odds_ci       est     se          p  sign_  
-----  -------------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                            .23    (.14,.39)     -1.45   .27    0.0000  <=.001 
       age_in_years_70                        .98    (.95,1.02)    -.02    .02    0.3026  > .10  
       femaleTRUE                             .71    (.4,1.26)     -.34    .29    0.2437  > .10  
.      educ3_f( < HS )                        .58    (.32,1.07)    -.54    .31    0.0806  <=.10  
       educ3_f( HS < )                        .78    (.4,1.52)     -.24    .34    0.4731  > .10  
       singleTRUE                             1.24   (.52,2.81)    .21     .43    0.6213  > .10  
       poor_healthTRUE                        .86    (.48,1.54)    -.15    .3     0.6107  > .10  
       sedentaryTRUE                          1.02   (.49,2.07)    .02     .37    0.9469  > .10  
       current_work_2TRUE                     .82    (.4,1.64)     -.2     .36    0.5725  > .10  
       current_drinkTRUE                      .75    (.39,1.43)    -.28    .33    0.3909  > .10  
       age_in_years_70:femaleTRUE             1      (.97,1.03)    0       .01    0.9366  > .10  
       age_in_years_70:educ3_f( < HS )        1      (.97,1.03)    0       .02    0.8265  > .10  
       age_in_years_70:educ3_f( HS < )        1      (.96,1.04)    0       .02    0.9352  > .10  
       age_in_years_70:singleTRUE             1      (.97,1.03)    0       .02    0.9585  > .10  
.      age_in_years_70:poor_healthTRUE        1.03   (1,1.05)      .02     .01    0.0850  <=.10  
       age_in_years_70:sedentaryTRUE          1      (.97,1.04)    0       .02    0.8840  > .10  
       age_in_years_70:current_work_2TRUE     1.01   (.97,1.05)    .01     .02    0.5474  > .10  
       age_in_years_70:current_drinkTRUE      1.01   (.98,1.04)    .01     .02    0.3921  > .10  
       femaleTRUE:educ3_f( < HS )             .91    (.52,1.59)    -.09    .29    0.7435  > .10  
       femaleTRUE:educ3_f( HS < )             1.22   (.68,2.22)    .2      .3     0.5041  > .10  
       femaleTRUE:singleTRUE                  .95    (.5,1.84)     -.05    .33    0.8718  > .10  
       femaleTRUE:poor_healthTRUE             1.31   (.79,2.21)    .27     .26    0.2996  > .10  
       femaleTRUE:sedentaryTRUE               1.16   (.66,2.04)    .15     .29    0.6111  > .10  
       femaleTRUE:current_work_2TRUE          1.46   (.81,2.62)    .38     .3     0.2016  > .10  
       femaleTRUE:current_drinkTRUE           1.43   (.87,2.36)    .36     .26    0.1648  > .10  
       educ3_f( < HS ):singleTRUE             1.52   (.75,3.12)    .42     .36    0.2490  > .10  
       educ3_f( HS < ):singleTRUE             1.1    (.49,2.44)    .1      .41    0.8077  > .10  
**     educ3_f( < HS ):poor_healthTRUE        2.14   (1.22,3.79)   .76     .29    0.0084  <=.01  
       educ3_f( HS < ):poor_healthTRUE        1.01   (.52,1.95)    .01     .34    0.9766  > .10  
*      educ3_f( < HS ):sedentaryTRUE          2.11   (1.1,4.09)    .75     .33    0.0257  <=.05  
       educ3_f( HS < ):sedentaryTRUE          1.13   (.54,2.31)    .12     .37    0.7489  > .10  
       educ3_f( < HS ):current_work_2TRUE     .76    (.38,1.48)    -.28    .35    0.4234  > .10  
       educ3_f( HS < ):current_work_2TRUE     .57    (.28,1.14)    -.57    .36    0.1092  > .10  
       educ3_f( < HS ):current_drinkTRUE      1.24   (.69,2.23)    .21     .3     0.4766  > .10  
       educ3_f( HS < ):current_drinkTRUE      1.5    (.82,2.74)    .41     .31    0.1870  > .10  
*      singleTRUE:poor_healthTRUE             .47    (.24,.91)     -.75    .34    0.0251  <=.05  
.      singleTRUE:sedentaryTRUE               .48    (.2,1.05)     -.74    .42    0.0775  <=.10  
       singleTRUE:current_work_2TRUE          .75    (.33,1.65)    -.29    .41    0.4727  > .10  
       singleTRUE:current_drinkTRUE           1.13   (.61,2.07)    .12     .31    0.7046  > .10  
*      poor_healthTRUE:sedentaryTRUE          .49    (.27,.9)      -.71    .31    0.0222  <=.05  
       poor_healthTRUE:current_work_2TRUE     .91    (.49,1.66)    -.09    .31    0.7627  > .10  
       poor_healthTRUE:current_drinkTRUE      1.03   (.6,1.78)     .03     .28    0.9063  > .10  
       sedentaryTRUE:current_work_2TRUE       1.41   (.74,2.72)    .35     .33    0.2988  > .10  
       sedentaryTRUE:current_drinkTRUE        1.36   (.7,2.6)      .31     .33    0.3549  > .10  
*      current_work_2TRUE:current_drinkTRUE   1.93   (1.04,3.6)    .66     .32    0.0371  <=.05  


###  best

 solution of model **best** fit to data from **share** study

    logLik        dev       AIC       BIC   df_Null   df_Model   df_drop
----------  ---------  --------  --------  --------  ---------  --------
 -5259.089   10518.18   10554.2   10687.7     12327      12310        17


sign   coef_name                              odds   odds_ci       est     se          p  sign_  
-----  -------------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                            .13    (.11,.15)     -2.04   .07    0.0000  <=.001 
       educ3_f( < HS )                        1.08   (.94,1.24)    .08     .07    0.2649  > .10  
.      educ3_f( HS < )                        .83    (.69,1)       -.18    .09    0.0500  <=.10  
***    femaleTRUE                             .64    (.56,.74)     -.44    .07    0.0000  <=.001 
*      poor_healthTRUE                        1.31   (1.04,1.65)   .27     .12    0.0227  <=.05  
***    current_work_2TRUE                     .63    (.51,.77)     -.47    .11    0.0000  <=.001 
***    poor_healthFALSE:age_in_years_70       .96    (.95,.97)     -.05    .01    0.0000  <=.001 
***    poor_healthTRUE:age_in_years_70        .96    (.95,.97)     -.04    .01    0.0000  <=.001 
***    poor_healthFALSE:singleTRUE            1.69   (1.45,1.96)   .52     .08    0.0000  <=.001 
***    poor_healthTRUE:singleTRUE             1.41   (1.15,1.71)   .34     .1     0.0007  <=.001 
***    singleFALSE:sedentaryTRUE              1.83   (1.57,2.12)   .6      .08    0.0000  <=.001 
***    singleTRUE:sedentaryTRUE               1.5    (1.21,1.87)   .41     .11    0.0002  <=.001 
**     poor_healthTRUE:sedentaryTRUE          .71    (.57,.88)     -.35    .11    0.0021  <=.01  
       age_in_years_70:current_drinkTRUE      1      (.98,1.01)    0       .01    0.4477  > .10  
***    femaleTRUE:current_drinkTRUE           1.4    (1.2,1.64)    .34     .08    0.0000  <=.001 
       current_work_2TRUE:current_drinkTRUE   1.21   (.95,1.56)    .19     .13    0.1247  > .10  
*      educ3_f( < HS ):poor_healthTRUE        1.37   (1.08,1.74)   .31     .12    0.0107  <=.05  
       educ3_f( HS < ):poor_healthTRUE        .92    (.65,1.29)    -.08    .17    0.6290  > .10  


##  tilda

### BETWEEN

coef_name                              A                    B                    AA                  BB                  best               
-------------------------------------  -------------------  -------------------  ------------------  ------------------  -------------------
(Intercept)                            .11(.09,.13)***      .08(.07,.11)***      .15(.11,.2)***      .07(.04,.12)***     .1(.08,.13)***     
age_in_years_70                        .95(.95,.96)***      .94(.93,.95)***      .97(.95,.99)**      .97(.94,1).                            
femaleTRUE                             .93(.81,1.07)        .91(.79,1.05)        .65(.47,.9)*        .78(.49,1.24)       .74(.61,.89)**     
educ3_f( < HS )                        1.27(1.09,1.47)**    1.18(1.01,1.38)*     .88(.65,1.2)        1.26(.79,2.05)                         
educ3_f( HS < )                        .39(.25,.58)***      .42(.27,.63)***      .47(.22,.91)*       .16(.02,.75)*                          
singleTRUE                             1.82(1.56,2.12)***   1.8(1.54,2.1)***     1.69(1.17,2.41)**   1.39(.83,2.31)      1.51(1.35,1.68)*** 
poor_healthTRUE                                             1.59(1.35,1.87)***                       1.85(1.07,3.18)*    1.35(1.19,1.53)*** 
sedentaryTRUE                                               1.54(1.29,1.83)***                       2.3(1.28,4.09)**    1.53(1.37,1.7)***  
current_work_2TRUE                                          .64(.54,.76)***                          .88(.49,1.59)       .77(.67,.9)***     
current_drinkTRUE                                           1.36(1.16,1.61)***                       2.09(1.29,3.46)**   1.46(1.21,1.77)*** 
age_in_years_70:femaleTRUE                                                       .98(.96,1)*         .98(.96,1)*                            
age_in_years_70:educ3_f( < HS )                                                  .99(.97,1.01)       .99(.97,1.01)                          
age_in_years_70:educ3_f( HS < )                                                  1.02(.97,1.07)      1.03(.97,1.09)                         
age_in_years_70:singleTRUE                                                       .99(.98,1.01)       1(.98,1.02)                            
age_in_years_70:poor_healthTRUE                                                                      .98(.96,1)                             
age_in_years_70:sedentaryTRUE                                                                        1.01(.99,1.04)                         
age_in_years_70:current_work_2TRUE                                                                   1(.98,1.03)                            
age_in_years_70:current_drinkTRUE                                                                    .99(.97,1.01)                          
femaleTRUE:educ3_f( < HS )                                                       1.49(1.1,2.03)*     1.3(.94,1.79)       1.17(.95,1.45)     
femaleTRUE:educ3_f( HS < )                                                       .94(.36,2.38)       .95(.36,2.47)       .85(.63,1.14)      
femaleTRUE:singleTRUE                                                            .81(.59,1.1)        .86(.62,1.19)                          
femaleTRUE:poor_healthTRUE                                                                           1.01(.71,1.43)                         
femaleTRUE:sedentaryTRUE                                                                             .94(.65,1.36)                          
femaleTRUE:current_work_2TRUE                                                                        1.01(.71,1.44)                         
femaleTRUE:current_drinkTRUE                                                                         .79(.55,1.12)                          
educ3_f( < HS ):singleTRUE                                                       1.29(.92,1.82)      1.32(.93,1.89)                         
educ3_f( HS < ):singleTRUE                                                       1.16(.46,2.81)      1.34(.51,3.38)                         
educ3_f( < HS ):poor_healthTRUE                                                                      1.06(.72,1.57)                         
educ3_f( HS < ):poor_healthTRUE                                                                      1.63(.45,5.1)                          
educ3_f( < HS ):sedentaryTRUE                                                                        .84(.56,1.26)                          
educ3_f( HS < ):sedentaryTRUE                                                                        2.02(.67,5.72)                         
educ3_f( < HS ):current_work_2TRUE                                                                   .88(.62,1.26)                          
educ3_f( HS < ):current_work_2TRUE                                                                   1.53(.54,4.48)                         
educ3_f( < HS ):current_drinkTRUE                                                                    .64(.43,.95)*                          
educ3_f( HS < ):current_drinkTRUE                                                                    2.1(.51,14.64)                         
singleTRUE:poor_healthTRUE                                                                           1.03(.72,1.48)                         
singleTRUE:sedentaryTRUE                                                                             1.08(.72,1.61)                         
singleTRUE:current_work_2TRUE                                                                        .98(.67,1.43)                          
singleTRUE:current_drinkTRUE                                                                         1.21(.84,1.76)                         
poor_healthTRUE:sedentaryTRUE                                                                        .76(.51,1.12)                          
poor_healthTRUE:current_work_2TRUE                                                                   .63(.41,.96)*       .79(.6,1.04)       
poor_healthTRUE:current_drinkTRUE                                                                    .78(.54,1.14)                          
sedentaryTRUE:current_work_2TRUE                                                                     .96(.61,1.48)                          
sedentaryTRUE:current_drinkTRUE                                                                      .88(.59,1.32)                          
current_work_2TRUE:current_drinkTRUE                                                                 .91(.6,1.41)                           


###  A

 solution of model **A** fit to data from **tilda** study

    logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
----------  ---------  -------  -------  --------  ---------  --------
 -2588.705   5177.409   5189.4   5229.4      5844       5839         5


sign   coef_name         odds   odds_ci       est     se          p  sign_  
-----  ----------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)       .11    (.09,.13)     -2.19   .09    0.0000  <=.001 
***    age_in_years_70   .95    (.95,.96)     -.05    0      0.0000  <=.001 
       femaleTRUE        .93    (.81,1.07)    -.07    .07    0.3197  > .10  
**     educ3_f( < HS )   1.27   (1.09,1.47)   .24     .08    0.0023  <=.01  
***    educ3_f( HS < )   .39    (.25,.58)     -.94    .21    0.0000  <=.001 
***    singleTRUE        1.82   (1.56,2.12)   .6      .08    0.0000  <=.001 


###  B

 solution of model **B** fit to data from **tilda** study

    logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
----------  ---------  -------  -------  --------  ---------  --------
 -2535.063   5070.126   5090.1   5156.9      5844       5835         9


sign   coef_name            odds   odds_ci       est     se          p  sign_  
-----  -------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)          .08    (.07,.11)     -2.48   .12    0.0000  <=.001 
***    age_in_years_70      .94    (.93,.95)     -.06    0      0.0000  <=.001 
       femaleTRUE           .91    (.79,1.05)    -.09    .07    0.2090  > .10  
*      educ3_f( < HS )      1.18   (1.01,1.38)   .16     .08    0.0362  <=.05  
***    educ3_f( HS < )      .42    (.27,.63)     -.86    .21    0.0000  <=.001 
***    singleTRUE           1.8    (1.54,2.1)    .59     .08    0.0000  <=.001 
***    poor_healthTRUE      1.59   (1.35,1.87)   .46     .08    0.0000  <=.001 
***    sedentaryTRUE        1.54   (1.29,1.83)   .43     .09    0.0000  <=.001 
***    current_work_2TRUE   .64    (.54,.76)     -.44    .08    0.0000  <=.001 
***    current_drinkTRUE    1.36   (1.16,1.61)   .31     .08    0.0003  <=.001 


###  AA

 solution of model **AA** fit to data from **tilda** study

    logLik        dev      AIC    BIC   df_Null   df_Model   df_drop
----------  ---------  -------  -----  --------  ---------  --------
 -2578.473   5156.947   5186.9   5287      5844       5830        14


sign   coef_name                         odds   odds_ci       est     se          p  sign_  
-----  --------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                       .15    (.11,.2)      -1.89   .14    0.0000  <=.001 
**     age_in_years_70                   .97    (.95,.99)     -.03    .01    0.0015  <=.01  
*      femaleTRUE                        .65    (.47,.9)      -.43    .17    0.0102  <=.05  
       educ3_f( < HS )                   .88    (.65,1.2)     -.13    .16    0.4142  > .10  
*      educ3_f( HS < )                   .47    (.22,.91)     -.76    .36    0.0344  <=.05  
**     singleTRUE                        1.69   (1.17,2.41)   .52     .18    0.0045  <=.01  
*      age_in_years_70:femaleTRUE        .98    (.96,1)       -.02    .01    0.0133  <=.05  
       age_in_years_70:educ3_f( < HS )   .99    (.97,1.01)    -.01    .01    0.4150  > .10  
       age_in_years_70:educ3_f( HS < )   1.02   (.97,1.07)    .02     .03    0.3972  > .10  
       age_in_years_70:singleTRUE        .99    (.98,1.01)    -.01    .01    0.5054  > .10  
*      femaleTRUE:educ3_f( < HS )        1.49   (1.1,2.03)    .4      .16    0.0100  <=.05  
       femaleTRUE:educ3_f( HS < )        .94    (.36,2.38)    -.06    .48    0.8950  > .10  
       femaleTRUE:singleTRUE             .81    (.59,1.1)     -.21    .16    0.1793  > .10  
       educ3_f( < HS ):singleTRUE        1.29   (.92,1.82)    .25     .17    0.1442  > .10  
       educ3_f( HS < ):singleTRUE        1.16   (.46,2.81)    .15     .46    0.7476  > .10  


###  BB

 solution of model **BB** fit to data from **tilda** study

    logLik        dev      AIC      BIC   df_Null   df_Model   df_drop
----------  ---------  -------  -------  --------  ---------  --------
 -2512.134   5024.269   5114.3   5414.6      5844       5800        44


sign   coef_name                              odds   odds_ci       est     se          p  sign_  
-----  -------------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                            .07    (.04,.12)     -2.62   .27    0.0000  <=.001 
.      age_in_years_70                        .97    (.94,1)       -.03    .02    0.0917  <=.10  
       femaleTRUE                             .78    (.49,1.24)    -.25    .24    0.2971  > .10  
       educ3_f( < HS )                        1.26   (.79,2.05)    .23     .24    0.3410  > .10  
*      educ3_f( HS < )                        .16    (.02,.75)     -1.82   .88    0.0393  <=.05  
       singleTRUE                             1.39   (.83,2.31)    .33     .26    0.2045  > .10  
*      poor_healthTRUE                        1.85   (1.07,3.18)   .61     .28    0.0268  <=.05  
**     sedentaryTRUE                          2.3    (1.28,4.09)   .83     .3     0.0048  <=.01  
       current_work_2TRUE                     .88    (.49,1.59)    -.12    .3     0.6828  > .10  
**     current_drinkTRUE                      2.09   (1.29,3.46)   .74     .25    0.0035  <=.01  
*      age_in_years_70:femaleTRUE             .98    (.96,1)       -.02    .01    0.0156  <=.05  
       age_in_years_70:educ3_f( < HS )        .99    (.97,1.01)    -.01    .01    0.2212  > .10  
       age_in_years_70:educ3_f( HS < )        1.03   (.97,1.09)    .03     .03    0.3278  > .10  
       age_in_years_70:singleTRUE             1      (.98,1.02)    0       .01    0.8225  > .10  
       age_in_years_70:poor_healthTRUE        .98    (.96,1)       -.02    .01    0.1056  > .10  
       age_in_years_70:sedentaryTRUE          1.01   (.99,1.04)    .01     .01    0.2551  > .10  
       age_in_years_70:current_work_2TRUE     1      (.98,1.03)    0       .01    0.7688  > .10  
       age_in_years_70:current_drinkTRUE      .99    (.97,1.01)    -.01    .01    0.2739  > .10  
       femaleTRUE:educ3_f( < HS )             1.3    (.94,1.79)    .26     .16    0.1142  > .10  
       femaleTRUE:educ3_f( HS < )             .95    (.36,2.47)    -.05    .49    0.9189  > .10  
       femaleTRUE:singleTRUE                  .86    (.62,1.19)    -.15    .16    0.3658  > .10  
       femaleTRUE:poor_healthTRUE             1.01   (.71,1.43)    .01     .18    0.9472  > .10  
       femaleTRUE:sedentaryTRUE               .94    (.65,1.36)    -.06    .19    0.7424  > .10  
       femaleTRUE:current_work_2TRUE          1.01   (.71,1.44)    .01     .18    0.9528  > .10  
       femaleTRUE:current_drinkTRUE           .79    (.55,1.12)    -.24    .18    0.1921  > .10  
       educ3_f( < HS ):singleTRUE             1.32   (.93,1.89)    .28     .18    0.1226  > .10  
       educ3_f( HS < ):singleTRUE             1.34   (.51,3.38)    .29     .48    0.5412  > .10  
       educ3_f( < HS ):poor_healthTRUE        1.06   (.72,1.57)    .06     .2     0.7747  > .10  
       educ3_f( HS < ):poor_healthTRUE        1.63   (.45,5.1)     .49     .61    0.4254  > .10  
       educ3_f( < HS ):sedentaryTRUE          .84    (.56,1.26)    -.17    .21    0.3957  > .10  
       educ3_f( HS < ):sedentaryTRUE          2.02   (.67,5.72)    .71     .54    0.1928  > .10  
       educ3_f( < HS ):current_work_2TRUE     .88    (.62,1.26)    -.13    .18    0.4885  > .10  
       educ3_f( HS < ):current_work_2TRUE     1.53   (.54,4.48)    .43     .54    0.4264  > .10  
*      educ3_f( < HS ):current_drinkTRUE      .64    (.43,.95)     -.45    .2     0.0273  <=.05  
       educ3_f( HS < ):current_drinkTRUE      2.1    (.51,14.64)   .74     .82    0.3667  > .10  
       singleTRUE:poor_healthTRUE             1.03   (.72,1.48)    .03     .18    0.8577  > .10  
       singleTRUE:sedentaryTRUE               1.08   (.72,1.61)    .08     .21    0.7149  > .10  
       singleTRUE:current_work_2TRUE          .98    (.67,1.43)    -.02    .19    0.9173  > .10  
       singleTRUE:current_drinkTRUE           1.21   (.84,1.76)    .19     .19    0.3114  > .10  
       poor_healthTRUE:sedentaryTRUE          .76    (.51,1.12)    -.28    .2     0.1601  > .10  
*      poor_healthTRUE:current_work_2TRUE     .63    (.41,.96)     -.46    .22    0.0325  <=.05  
       poor_healthTRUE:current_drinkTRUE      .78    (.54,1.14)    -.24    .19    0.2023  > .10  
       sedentaryTRUE:current_work_2TRUE       .96    (.61,1.48)    -.04    .22    0.8447  > .10  
       sedentaryTRUE:current_drinkTRUE        .88    (.59,1.32)    -.13    .21    0.5315  > .10  
       current_work_2TRUE:current_drinkTRUE   .91    (.6,1.41)     -.09    .22    0.6784  > .10  


###  best

 solution of model **best** fit to data from **tilda** study

    logLik        dev       AIC     BIC   df_Null   df_Model   df_drop
----------  ---------  --------  ------  --------  ---------  --------
 -5254.911   10509.82   10543.8   10670     12327      12311        16


sign   coef_name                            odds   odds_ci       est     se          p  sign_  
-----  -----------------------------------  -----  ------------  ------  ----  -------  -------
***    (Intercept)                          .1     (.08,.13)     -2.26   .11    0.0000  <=.001 
**     femaleTRUE                           .74    (.61,.89)     -.31    .1     0.0016  <=.01  
***    singleTRUE                           1.51   (1.35,1.68)   .41     .06    0.0000  <=.001 
***    poor_healthTRUE                      1.35   (1.19,1.53)   .3      .06    0.0000  <=.001 
***    sedentaryTRUE                        1.53   (1.37,1.7)    .42     .05    0.0000  <=.001 
***    current_work_2TRUE                   .77    (.67,.9)      -.26    .08    0.0007  <=.001 
***    current_drinkTRUE                    1.46   (1.21,1.77)   .38     .1     0.0001  <=.001 
***    femaleFALSE:age_in_years_70          .96    (.96,.97)     -.04    0      0.0000  <=.001 
***    femaleTRUE:age_in_years_70           .95    (.94,.96)     -.05    0      0.0000  <=.001 
       poor_healthTRUE:age_in_years_70      1      (.99,1.01)    0       .01    0.5072  > .10  
       poor_healthTRUE:current_work_2TRUE   .79    (.6,1.04)     -.23    .14    0.1001  > .10  
.      femaleFALSE:educ3_f( < HS )          1.22   (.96,1.55)    .2      .12    0.0987  <=.10  
       femaleTRUE:educ3_f( < HS )           1.17   (.95,1.45)    .16     .11    0.1384  > .10  
       femaleFALSE:educ3_f( HS < )          .8     (.59,1.1)     -.22    .16    0.1726  > .10  
       femaleTRUE:educ3_f( HS < )           .85    (.63,1.14)    -.16    .15    0.2884  > .10  
       current_drinkTRUE:educ3_f( < HS )    1.02   (.81,1.3)     .02     .12    0.8451  > .10  
       current_drinkTRUE:educ3_f( HS < )    .96    (.7,1.33)     -.04    .17    0.8151  > .10  




# session

```r
sessionInfo()
```

```
R version 3.2.5 (2016-04-14)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 10586)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] ggplot2_2.1.0 magrittr_1.5  knitr_1.12.3 

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.5      munsell_0.4.3    testit_0.5       colorspace_1.2-6 R6_2.1.2         highr_0.5.1     
 [7] stringr_1.0.0    plyr_1.8.3       dplyr_0.4.3      tools_3.2.5      parallel_3.2.5   DT_0.1.40       
[13] grid_3.2.5       gtable_0.2.0     DBI_0.4-1        htmltools_0.3.5  yaml_2.1.13      digest_0.6.9    
[19] assertthat_0.1   formatR_1.3      tidyr_0.4.1      htmlwidgets_0.6  evaluate_0.9     rmarkdown_0.9.6 
[25] stringi_1.0-1    scales_0.4.0     jsonlite_0.9.20 
```




