# Predictors in focus

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

# prepared by ../compile-tables.R
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


# Static tables




[1] 8
[1] 8
[1] 14
[1] 8
[1] 8
[1] 8
[1] 8
[1] 8




study_name   coef_name     A                 B                 AA                BB                best            
-----------  ------------  ----------------  ----------------  ----------------  ----------------  ----------------
alsa         (Intercept)   .19(.14,.26)***   .14(.09,.21)***   .15(.09,.24)***   .18(.07,.42)***   .14(.13,.15)*** 
lbsl         (Intercept)   .09(.05,.17)***   .11(.05,.22)***   .1(.04,.23)***    .05(.01,.28)**    .14(.13,.15)*** 
satsa        (Intercept)   .25(.15,.42)***   .08(.04,.15)***   .13(.04,.34)***   .03(0,.25)**      .13(.11,.15)*** 
share        (Intercept)   .19(.15,.24)***   .18(.13,.24)***   .19(.13,.26)***   .23(.14,.39)***   .13(.11,.15)*** 
tilda        (Intercept)   .11(.09,.13)***   .08(.07,.11)***   .15(.11,.2)***    .07(.04,.12)***   .1(.08,.13)***  
pooled       (Intercept)   .16(.14,.19)***   .1(.08,.12)***    .16(.13,.19)***   .11(.08,.16)***   .12(.08,.19)*** 


## age_in_years_70

 Main Effects across contexts 


study_name   coef_name         A                 B                 AA                BB                best            
-----------  ----------------  ----------------  ----------------  ----------------  ----------------  ----------------
alsa         age_in_years_70   .95(.93,.97)***   .95(.93,.97)***   .98(.93,1.03)     .94(.87,1.01)     .98(.97,.99)*** 
lbsl         age_in_years_70   .97(.95,.99)**    .97(.94,.99)**    .95(.9,1)*        .9(.83,.98)*      .98(.96,.99)*** 
satsa        age_in_years_70   .95(.94,.96)***   .95(.93,.96)***   .93(.87,.98)*     .76(.64,.87)***   .96(.95,.97)*** 
share        age_in_years_70   1(.99,1.01)       1(.99,1.01)       .99(.97,1.02)     .98(.95,1.02)                     
tilda        age_in_years_70   .95(.95,.96)***   .94(.93,.95)***   .97(.95,.99)**    .97(.94,1).                       
pooled       age_in_years_70   .96(.96,.97)***   .96(.95,.96)***   .97(.96,.99)***   .97(.96,.99)**    .96(.93,.98)*** 


 Interactions across contexts 


study_name   coef_name                            AA                  BB                 best               
-----------  -----------------------------------  ------------------  -----------------  -------------------
alsa         age_in_years_70:femaleTRUE           .92(.87,.98)**      .92(.87,.98)**     .99(.99,1).        
lbsl         age_in_years_70:femaleTRUE           1.03(.99,1.08)      1.02(.97,1.08)     .99(.99,1)         
satsa        age_in_years_70:femaleTRUE           .96(.93,.98)***     .98(.95,1.02)                         
share        age_in_years_70:femaleTRUE           1(.97,1.02)         1(.97,1.03)                           
tilda        age_in_years_70:femaleTRUE           .98(.96,1)*         .98(.96,1)*                           
pooled       age_in_years_70:femaleTRUE           .98(.97,.99)***     .99(.98,1)*        .98(.97,.99)***    
alsa         age_in_years_70:educ3_f( < HS )      1.02(.95,1.1)       1(.93,1.08)                           
lbsl         age_in_years_70:educ3_f( < HS )      .98(.89,1.07)       .92(.81,1.03)                         
satsa        age_in_years_70:educ3_f( < HS )      1.05(.99,1.12)      1.23(1.1,1.45)**   .99(.98,1.01)      
share        age_in_years_70:educ3_f( < HS )      1.02(.99,1.04)      1(.97,1.03)                           
tilda        age_in_years_70:educ3_f( < HS )      .99(.97,1.01)       .99(.97,1.01)                         
pooled       age_in_years_70:educ3_f( < HS )      1(.99,1.01)         1(.98,1.01)                           
alsa         age_in_years_70:educ3_f( HS < )      .98(.93,1.04)       .98(.92,1.04)                         
lbsl         age_in_years_70:educ3_f( HS < )      1.03(.99,1.08)      1.01(.95,1.07)                        
satsa        age_in_years_70:educ3_f( HS < )      1.02(.95,1.11)      1.15(1,1.37).      1.01(.99,1.03)     
share        age_in_years_70:educ3_f( HS < )      1.01(.98,1.04)      1(.96,1.04)                           
tilda        age_in_years_70:educ3_f( HS < )      1.02(.97,1.07)      1.03(.97,1.09)                        
pooled       age_in_years_70:educ3_f( HS < )      1.02(1.01,1.04)**   1.02(1,1.03)                          
alsa         age_in_years_70:singleTRUE           1(.95,1.05)         1.01(.95,1.07)                        
lbsl         age_in_years_70:singleTRUE           .97(.93,1.01)       .97(.92,1.03)      .99(.98,1)         
satsa        age_in_years_70:singleTRUE           1(.98,1.02)         1.01(.98,1.05)                        
share        age_in_years_70:singleTRUE           1(.97,1.03)         1(.97,1.03)                           
tilda        age_in_years_70:singleTRUE           .99(.98,1.01)       1(.98,1.02)                           
pooled       age_in_years_70:singleTRUE           .99(.98,1)*         .99(.98,1)                            
alsa         age_in_years_70:poor_healthTRUE                          1(.94,1.06)                           
lbsl         age_in_years_70:poor_healthTRUE                          1.03(.97,1.09)     .99(.98,1)*        
satsa        age_in_years_70:poor_healthTRUE                          1(.97,1.03)                           
share        age_in_years_70:poor_healthTRUE                          1.03(1,1.05).                         
tilda        age_in_years_70:poor_healthTRUE                          .98(.96,1)                            
pooled       age_in_years_70:poor_healthTRUE                          1(.99,1.01)                           
alsa         age_in_years_70:sedentaryTRUE                            1.01(.96,1.07)                        
lbsl         age_in_years_70:sedentaryTRUE                            1.04(.97,1.12)                        
satsa        age_in_years_70:sedentaryTRUE                            1(.96,1.03)        .99(.98,1)**       
share        age_in_years_70:sedentaryTRUE                            1(.97,1.04)                           
tilda        age_in_years_70:sedentaryTRUE                            1.01(.99,1.04)                        
pooled       age_in_years_70:sedentaryTRUE                            1(.98,1.01)                           
alsa         age_in_years_70:current_work_2TRUE                       .75(.47,1.02)                         
lbsl         age_in_years_70:current_work_2TRUE                       1.05(.99,1.11).    1.02(1.01,1.03)*** 
satsa        age_in_years_70:current_work_2TRUE                       .99(.96,1.03)                         
share        age_in_years_70:current_work_2TRUE                       1.01(.97,1.05)                        
tilda        age_in_years_70:current_work_2TRUE                       1(.98,1.03)                           
pooled       age_in_years_70:current_work_2TRUE                       1.01(.99,1.02)                        
alsa         age_in_years_70:current_drinkTRUE                        1.05(.99,1.12).    .98(.98,.99)***    
lbsl         age_in_years_70:current_drinkTRUE                        1.04(.98,1.1)      .98(.97,.99)***    
satsa        age_in_years_70:current_drinkTRUE                        1.04(.99,1.08)                        
share        age_in_years_70:current_drinkTRUE                        1.01(.98,1.04)     1(.98,1.01)        
tilda        age_in_years_70:current_drinkTRUE                        .99(.97,1.01)                         
pooled       age_in_years_70:current_drinkTRUE                        .99(.98,1).                           


## femaleTRUE

 Main Effects across contexts 


study_name   coef_name    A                 B                 AA              BB               best            
-----------  -----------  ----------------  ----------------  --------------  ---------------  ----------------
alsa         femaleTRUE   .57(.42,.76)***   .6(.44,.81)***    .96(.53,1.71)   .65(.28,1.56)                    
lbsl         femaleTRUE   1.45(.84,2.53)    1.35(.78,2.39)    .86(.25,2.98)   .31(.04,2.11)                    
satsa        femaleTRUE   .44(.34,.57)***   .48(.37,.63)***   .66(.22,1.98)   .7(.15,3.2)      .74(.66,.84)*** 
share        femaleTRUE   1.11(.89,1.39)    1.09(.87,1.37)    1.07(.7,1.65)   .71(.4,1.26)     .64(.56,.74)*** 
tilda        femaleTRUE   .93(.81,1.07)     .91(.79,1.05)     .65(.47,.9)*    .78(.49,1.24)    .74(.61,.89)**  
pooled       femaleTRUE   .81(.73,.89)***   .81(.73,.9)***    .77(.62,.94)*   .78(.59,1.03).   .67(.49,.92)*   


 Interactions across contexts 


study_name   coef_name                       AA                BB                  best             
-----------  ------------------------------  ----------------  ------------------  -----------------
alsa         age_in_years_70:femaleTRUE      .92(.87,.98)**    .92(.87,.98)**      .99(.99,1).      
lbsl         age_in_years_70:femaleTRUE      1.03(.99,1.08)    1.02(.97,1.08)      .99(.99,1)       
satsa        age_in_years_70:femaleTRUE      .96(.93,.98)***   .98(.95,1.02)                        
share        age_in_years_70:femaleTRUE      1(.97,1.02)       1(.97,1.03)                          
tilda        age_in_years_70:femaleTRUE      .98(.96,1)*       .98(.96,1)*                          
pooled       age_in_years_70:femaleTRUE      .98(.97,.99)***   .99(.98,1)*         .98(.97,.99)***  
alsa         femaleTRUE:educ3_f( < HS )      .45(.16,1.18)     .31(.1,.89)*                         
lbsl         femaleTRUE:educ3_f( < HS )      2.06(.28,16.57)   1.17(.1,14.18)                       
satsa        femaleTRUE:educ3_f( < HS )      .4(.13,1.19).     .44(.12,1.62)                        
share        femaleTRUE:educ3_f( < HS )      .93(.55,1.57)     .91(.52,1.59)                        
tilda        femaleTRUE:educ3_f( < HS )      1.49(1.1,2.03)*   1.3(.94,1.79)       1.17(.95,1.45)   
pooled       femaleTRUE:educ3_f( < HS )      .96(.77,1.21)     .98(.78,1.24)                        
alsa         femaleTRUE:educ3_f( HS < )      .78(.39,1.53)     .72(.35,1.47)                        
lbsl         femaleTRUE:educ3_f( HS < )      1.71(.43,6.72)    1.89(.37,10.14)                      
satsa        femaleTRUE:educ3_f( HS < )      .69(.16,2.95)     .6(.11,3.15)                         
share        femaleTRUE:educ3_f( HS < )      1.24(.69,2.22)    1.22(.68,2.22)                       
tilda        femaleTRUE:educ3_f( HS < )      .94(.36,2.38)     .95(.36,2.47)       .85(.63,1.14)    
pooled       femaleTRUE:educ3_f( HS < )      1.2(.87,1.65)     1.18(.85,1.63)                       
alsa         femaleTRUE:singleTRUE           1.7(.84,3.54)     2.1(1,4.55).                         
lbsl         femaleTRUE:singleTRUE           2.37(.71,8.72)    5.13(1.23,25.99)*   .82(.71,.95)*    
satsa        femaleTRUE:singleTRUE           .76(.42,1.36)     .78(.42,1.45)                        
share        femaleTRUE:singleTRUE           .99(.54,1.89)     .95(.5,1.84)                         
tilda        femaleTRUE:singleTRUE           .81(.59,1.1)      .86(.62,1.19)                        
pooled       femaleTRUE:singleTRUE           .85(.68,1.06)     .9(.72,1.13)                         
alsa         femaleTRUE:poor_healthTRUE                        1.36(.66,2.79)                       
lbsl         femaleTRUE:poor_healthTRUE                        1.73(.43,7.25)                       
satsa        femaleTRUE:poor_healthTRUE                        .73(.4,1.33)                         
share        femaleTRUE:poor_healthTRUE                        1.31(.79,2.21)                       
tilda        femaleTRUE:poor_healthTRUE                        1.01(.71,1.43)                       
pooled       femaleTRUE:poor_healthTRUE                        1.06(.85,1.33)                       
alsa         femaleTRUE:sedentaryTRUE                          1.35(.67,2.76)                       
lbsl         femaleTRUE:sedentaryTRUE                          .98(.18,5.75)                        
satsa        femaleTRUE:sedentaryTRUE                          1.1(.6,2.05)                         
share        femaleTRUE:sedentaryTRUE                          1.16(.66,2.04)                       
tilda        femaleTRUE:sedentaryTRUE                          .94(.65,1.36)                        
pooled       femaleTRUE:sedentaryTRUE                          .84(.67,1.05)                        
alsa         femaleTRUE:current_work_2TRUE                     .14(0,4)                             
lbsl         femaleTRUE:current_work_2TRUE                     .81(.17,3.82)                        
satsa        femaleTRUE:current_work_2TRUE                     2.04(.91,4.59).     1.36(1.1,1.67)** 
share        femaleTRUE:current_work_2TRUE                     1.46(.81,2.62)                       
tilda        femaleTRUE:current_work_2TRUE                     1.01(.71,1.44)                       
pooled       femaleTRUE:current_work_2TRUE                     1.19(.91,1.54)                       
alsa         femaleTRUE:current_drinkTRUE                      1.39(.66,2.92)                       
lbsl         femaleTRUE:current_drinkTRUE                      2.01(.44,9.83)                       
satsa        femaleTRUE:current_drinkTRUE                      .99(.46,2.11)                        
share        femaleTRUE:current_drinkTRUE                      1.43(.87,2.36)      1.4(1.2,1.64)*** 
tilda        femaleTRUE:current_drinkTRUE                      .79(.55,1.12)                        
pooled       femaleTRUE:current_drinkTRUE                      .95(.76,1.18)                        


## educ3_f( < HS )

 Main Effects across contexts 


study_name   coef_name         A                    B                   AA                 BB                best           
-----------  ----------------  -------------------  ------------------  -----------------  ----------------  ---------------
alsa         educ3_f( < HS )   1.23(.81,1.84)       1.22(.8,1.82)       1.43(.64,3.1)      1.44(.41,4.83)                   
lbsl         educ3_f( < HS )   1.58(.67,3.59)       1.62(.67,3.77)      1.45(.25,6.78)     5.35(.33,70.89)                  
satsa        educ3_f( < HS )   1.17(.72,1.98)       1.27(.77,2.17)      2.93(1.13,9.05)*   4.14(.47,73.97)                  
share        educ3_f( < HS )   1(.78,1.29)          1.03(.8,1.32)       1.09(.71,1.67)     .58(.32,1.07).    1.08(.94,1.24) 
tilda        educ3_f( < HS )   1.27(1.09,1.47)**    1.18(1.01,1.38)*    .88(.65,1.2)       1.26(.79,2.05)                   
pooled       educ3_f( < HS )   1.22(1.08,1.37)***   1.18(1.05,1.32)**   1.14(.94,1.38)     .97(.72,1.31)     1.28(.8,2.03)  


 Interactions across contexts 


study_name   coef_name                       AA                BB                  best             
-----------  ------------------------------  ----------------  ------------------  -----------------
alsa         age_in_years_70:femaleTRUE      .92(.87,.98)**    .92(.87,.98)**      .99(.99,1).      
lbsl         age_in_years_70:femaleTRUE      1.03(.99,1.08)    1.02(.97,1.08)      .99(.99,1)       
satsa        age_in_years_70:femaleTRUE      .96(.93,.98)***   .98(.95,1.02)                        
share        age_in_years_70:femaleTRUE      1(.97,1.02)       1(.97,1.03)                          
tilda        age_in_years_70:femaleTRUE      .98(.96,1)*       .98(.96,1)*                          
pooled       age_in_years_70:femaleTRUE      .98(.97,.99)***   .99(.98,1)*         .98(.97,.99)***  
alsa         femaleTRUE:educ3_f( < HS )      .45(.16,1.18)     .31(.1,.89)*                         
lbsl         femaleTRUE:educ3_f( < HS )      2.06(.28,16.57)   1.17(.1,14.18)                       
satsa        femaleTRUE:educ3_f( < HS )      .4(.13,1.19).     .44(.12,1.62)                        
share        femaleTRUE:educ3_f( < HS )      .93(.55,1.57)     .91(.52,1.59)                        
tilda        femaleTRUE:educ3_f( < HS )      1.49(1.1,2.03)*   1.3(.94,1.79)       1.17(.95,1.45)   
pooled       femaleTRUE:educ3_f( < HS )      .96(.77,1.21)     .98(.78,1.24)                        
alsa         femaleTRUE:educ3_f( HS < )      .78(.39,1.53)     .72(.35,1.47)                        
lbsl         femaleTRUE:educ3_f( HS < )      1.71(.43,6.72)    1.89(.37,10.14)                      
satsa        femaleTRUE:educ3_f( HS < )      .69(.16,2.95)     .6(.11,3.15)                         
share        femaleTRUE:educ3_f( HS < )      1.24(.69,2.22)    1.22(.68,2.22)                       
tilda        femaleTRUE:educ3_f( HS < )      .94(.36,2.38)     .95(.36,2.47)       .85(.63,1.14)    
pooled       femaleTRUE:educ3_f( HS < )      1.2(.87,1.65)     1.18(.85,1.63)                       
alsa         femaleTRUE:singleTRUE           1.7(.84,3.54)     2.1(1,4.55).                         
lbsl         femaleTRUE:singleTRUE           2.37(.71,8.72)    5.13(1.23,25.99)*   .82(.71,.95)*    
satsa        femaleTRUE:singleTRUE           .76(.42,1.36)     .78(.42,1.45)                        
share        femaleTRUE:singleTRUE           .99(.54,1.89)     .95(.5,1.84)                         
tilda        femaleTRUE:singleTRUE           .81(.59,1.1)      .86(.62,1.19)                        
pooled       femaleTRUE:singleTRUE           .85(.68,1.06)     .9(.72,1.13)                         
alsa         femaleTRUE:poor_healthTRUE                        1.36(.66,2.79)                       
lbsl         femaleTRUE:poor_healthTRUE                        1.73(.43,7.25)                       
satsa        femaleTRUE:poor_healthTRUE                        .73(.4,1.33)                         
share        femaleTRUE:poor_healthTRUE                        1.31(.79,2.21)                       
tilda        femaleTRUE:poor_healthTRUE                        1.01(.71,1.43)                       
pooled       femaleTRUE:poor_healthTRUE                        1.06(.85,1.33)                       
alsa         femaleTRUE:sedentaryTRUE                          1.35(.67,2.76)                       
lbsl         femaleTRUE:sedentaryTRUE                          .98(.18,5.75)                        
satsa        femaleTRUE:sedentaryTRUE                          1.1(.6,2.05)                         
share        femaleTRUE:sedentaryTRUE                          1.16(.66,2.04)                       
tilda        femaleTRUE:sedentaryTRUE                          .94(.65,1.36)                        
pooled       femaleTRUE:sedentaryTRUE                          .84(.67,1.05)                        
alsa         femaleTRUE:current_work_2TRUE                     .14(0,4)                             
lbsl         femaleTRUE:current_work_2TRUE                     .81(.17,3.82)                        
satsa        femaleTRUE:current_work_2TRUE                     2.04(.91,4.59).     1.36(1.1,1.67)** 
share        femaleTRUE:current_work_2TRUE                     1.46(.81,2.62)                       
tilda        femaleTRUE:current_work_2TRUE                     1.01(.71,1.44)                       
pooled       femaleTRUE:current_work_2TRUE                     1.19(.91,1.54)                       
alsa         femaleTRUE:current_drinkTRUE                      1.39(.66,2.92)                       
lbsl         femaleTRUE:current_drinkTRUE                      2.01(.44,9.83)                       
satsa        femaleTRUE:current_drinkTRUE                      .99(.46,2.11)                        
share        femaleTRUE:current_drinkTRUE                      1.43(.87,2.36)      1.4(1.2,1.64)*** 
tilda        femaleTRUE:current_drinkTRUE                      .79(.55,1.12)                        
pooled       femaleTRUE:current_drinkTRUE                      .95(.76,1.18)                        


## educ3_f( HS < )

 Main Effects across contexts 


study_name   coef_name         A                 B                 AA               BB                best          
-----------  ----------------  ----------------  ----------------  ---------------  ----------------  --------------
alsa         educ3_f( HS < )   1.06(.77,1.45)    1.05(.76,1.44)    1.16(.64,2.11)   1.01(.42,2.43)                  
lbsl         educ3_f( HS < )   .84(.46,1.57)     .95(.51,1.8)      1.02(.37,3.14)   2.01(.35,13.01)                 
satsa        educ3_f( HS < )   1.03(.51,2.06)    1.13(.56,2.28)    1.39(.36,5.56)   3.51(.24,85.22)                 
share        educ3_f( HS < )   .84(.64,1.11)     .85(.64,1.12)     .8(.5,1.29)      .78(.4,1.52)      .83(.69,1).   
tilda        educ3_f( HS < )   .39(.25,.58)***   .42(.27,.63)***   .47(.22,.91)*    .16(.02,.75)*                   
pooled       educ3_f( HS < )   .77(.66,.91)**    .8(.68,.93)**     .77(.6,.99)*     .87(.59,1.28)     .94(.61,1.46) 


 Interactions across contexts 


study_name   coef_name                       AA                BB                  best             
-----------  ------------------------------  ----------------  ------------------  -----------------
alsa         age_in_years_70:femaleTRUE      .92(.87,.98)**    .92(.87,.98)**      .99(.99,1).      
lbsl         age_in_years_70:femaleTRUE      1.03(.99,1.08)    1.02(.97,1.08)      .99(.99,1)       
satsa        age_in_years_70:femaleTRUE      .96(.93,.98)***   .98(.95,1.02)                        
share        age_in_years_70:femaleTRUE      1(.97,1.02)       1(.97,1.03)                          
tilda        age_in_years_70:femaleTRUE      .98(.96,1)*       .98(.96,1)*                          
pooled       age_in_years_70:femaleTRUE      .98(.97,.99)***   .99(.98,1)*         .98(.97,.99)***  
alsa         femaleTRUE:educ3_f( < HS )      .45(.16,1.18)     .31(.1,.89)*                         
lbsl         femaleTRUE:educ3_f( < HS )      2.06(.28,16.57)   1.17(.1,14.18)                       
satsa        femaleTRUE:educ3_f( < HS )      .4(.13,1.19).     .44(.12,1.62)                        
share        femaleTRUE:educ3_f( < HS )      .93(.55,1.57)     .91(.52,1.59)                        
tilda        femaleTRUE:educ3_f( < HS )      1.49(1.1,2.03)*   1.3(.94,1.79)       1.17(.95,1.45)   
pooled       femaleTRUE:educ3_f( < HS )      .96(.77,1.21)     .98(.78,1.24)                        
alsa         femaleTRUE:educ3_f( HS < )      .78(.39,1.53)     .72(.35,1.47)                        
lbsl         femaleTRUE:educ3_f( HS < )      1.71(.43,6.72)    1.89(.37,10.14)                      
satsa        femaleTRUE:educ3_f( HS < )      .69(.16,2.95)     .6(.11,3.15)                         
share        femaleTRUE:educ3_f( HS < )      1.24(.69,2.22)    1.22(.68,2.22)                       
tilda        femaleTRUE:educ3_f( HS < )      .94(.36,2.38)     .95(.36,2.47)       .85(.63,1.14)    
pooled       femaleTRUE:educ3_f( HS < )      1.2(.87,1.65)     1.18(.85,1.63)                       
alsa         femaleTRUE:singleTRUE           1.7(.84,3.54)     2.1(1,4.55).                         
lbsl         femaleTRUE:singleTRUE           2.37(.71,8.72)    5.13(1.23,25.99)*   .82(.71,.95)*    
satsa        femaleTRUE:singleTRUE           .76(.42,1.36)     .78(.42,1.45)                        
share        femaleTRUE:singleTRUE           .99(.54,1.89)     .95(.5,1.84)                         
tilda        femaleTRUE:singleTRUE           .81(.59,1.1)      .86(.62,1.19)                        
pooled       femaleTRUE:singleTRUE           .85(.68,1.06)     .9(.72,1.13)                         
alsa         femaleTRUE:poor_healthTRUE                        1.36(.66,2.79)                       
lbsl         femaleTRUE:poor_healthTRUE                        1.73(.43,7.25)                       
satsa        femaleTRUE:poor_healthTRUE                        .73(.4,1.33)                         
share        femaleTRUE:poor_healthTRUE                        1.31(.79,2.21)                       
tilda        femaleTRUE:poor_healthTRUE                        1.01(.71,1.43)                       
pooled       femaleTRUE:poor_healthTRUE                        1.06(.85,1.33)                       
alsa         femaleTRUE:sedentaryTRUE                          1.35(.67,2.76)                       
lbsl         femaleTRUE:sedentaryTRUE                          .98(.18,5.75)                        
satsa        femaleTRUE:sedentaryTRUE                          1.1(.6,2.05)                         
share        femaleTRUE:sedentaryTRUE                          1.16(.66,2.04)                       
tilda        femaleTRUE:sedentaryTRUE                          .94(.65,1.36)                        
pooled       femaleTRUE:sedentaryTRUE                          .84(.67,1.05)                        
alsa         femaleTRUE:current_work_2TRUE                     .14(0,4)                             
lbsl         femaleTRUE:current_work_2TRUE                     .81(.17,3.82)                        
satsa        femaleTRUE:current_work_2TRUE                     2.04(.91,4.59).     1.36(1.1,1.67)** 
share        femaleTRUE:current_work_2TRUE                     1.46(.81,2.62)                       
tilda        femaleTRUE:current_work_2TRUE                     1.01(.71,1.44)                       
pooled       femaleTRUE:current_work_2TRUE                     1.19(.91,1.54)                       
alsa         femaleTRUE:current_drinkTRUE                      1.39(.66,2.92)                       
lbsl         femaleTRUE:current_drinkTRUE                      2.01(.44,9.83)                       
satsa        femaleTRUE:current_drinkTRUE                      .99(.46,2.11)                        
share        femaleTRUE:current_drinkTRUE                      1.43(.87,2.36)      1.4(1.2,1.64)*** 
tilda        femaleTRUE:current_drinkTRUE                      .79(.55,1.12)                        
pooled       femaleTRUE:current_drinkTRUE                      .95(.76,1.18)                        


## poor_healthTRUE

 Main Effects across contexts 


study_name   coef_name         A    B                    AA   BB                 best               
-----------  ----------------  ---  -------------------  ---  -----------------  -------------------
alsa         poor_healthTRUE        1.12(.82,1.53)            1.17(.48,2.83)                        
lbsl         poor_healthTRUE        .73(.42,1.27)             .66(.11,3.76)                         
satsa        poor_healthTRUE        1.19(.9,1.57)             1.68(.34,7.77)     1.39(1.22,1.58)*** 
share        poor_healthTRUE        .88(.7,1.11)              .86(.48,1.54)      1.31(1.04,1.65)*   
tilda        poor_healthTRUE        1.59(1.35,1.87)***        1.85(1.07,3.18)*   1.35(1.19,1.53)*** 
pooled       poor_healthTRUE        1.26(1.13,1.4)***         1.29(.95,1.74).    1.35(.92,1.96)     


 Interactions across contexts 


study_name   coef_name                       AA                BB                  best             
-----------  ------------------------------  ----------------  ------------------  -----------------
alsa         age_in_years_70:femaleTRUE      .92(.87,.98)**    .92(.87,.98)**      .99(.99,1).      
lbsl         age_in_years_70:femaleTRUE      1.03(.99,1.08)    1.02(.97,1.08)      .99(.99,1)       
satsa        age_in_years_70:femaleTRUE      .96(.93,.98)***   .98(.95,1.02)                        
share        age_in_years_70:femaleTRUE      1(.97,1.02)       1(.97,1.03)                          
tilda        age_in_years_70:femaleTRUE      .98(.96,1)*       .98(.96,1)*                          
pooled       age_in_years_70:femaleTRUE      .98(.97,.99)***   .99(.98,1)*         .98(.97,.99)***  
alsa         femaleTRUE:educ3_f( < HS )      .45(.16,1.18)     .31(.1,.89)*                         
lbsl         femaleTRUE:educ3_f( < HS )      2.06(.28,16.57)   1.17(.1,14.18)                       
satsa        femaleTRUE:educ3_f( < HS )      .4(.13,1.19).     .44(.12,1.62)                        
share        femaleTRUE:educ3_f( < HS )      .93(.55,1.57)     .91(.52,1.59)                        
tilda        femaleTRUE:educ3_f( < HS )      1.49(1.1,2.03)*   1.3(.94,1.79)       1.17(.95,1.45)   
pooled       femaleTRUE:educ3_f( < HS )      .96(.77,1.21)     .98(.78,1.24)                        
alsa         femaleTRUE:educ3_f( HS < )      .78(.39,1.53)     .72(.35,1.47)                        
lbsl         femaleTRUE:educ3_f( HS < )      1.71(.43,6.72)    1.89(.37,10.14)                      
satsa        femaleTRUE:educ3_f( HS < )      .69(.16,2.95)     .6(.11,3.15)                         
share        femaleTRUE:educ3_f( HS < )      1.24(.69,2.22)    1.22(.68,2.22)                       
tilda        femaleTRUE:educ3_f( HS < )      .94(.36,2.38)     .95(.36,2.47)       .85(.63,1.14)    
pooled       femaleTRUE:educ3_f( HS < )      1.2(.87,1.65)     1.18(.85,1.63)                       
alsa         femaleTRUE:singleTRUE           1.7(.84,3.54)     2.1(1,4.55).                         
lbsl         femaleTRUE:singleTRUE           2.37(.71,8.72)    5.13(1.23,25.99)*   .82(.71,.95)*    
satsa        femaleTRUE:singleTRUE           .76(.42,1.36)     .78(.42,1.45)                        
share        femaleTRUE:singleTRUE           .99(.54,1.89)     .95(.5,1.84)                         
tilda        femaleTRUE:singleTRUE           .81(.59,1.1)      .86(.62,1.19)                        
pooled       femaleTRUE:singleTRUE           .85(.68,1.06)     .9(.72,1.13)                         
alsa         femaleTRUE:poor_healthTRUE                        1.36(.66,2.79)                       
lbsl         femaleTRUE:poor_healthTRUE                        1.73(.43,7.25)                       
satsa        femaleTRUE:poor_healthTRUE                        .73(.4,1.33)                         
share        femaleTRUE:poor_healthTRUE                        1.31(.79,2.21)                       
tilda        femaleTRUE:poor_healthTRUE                        1.01(.71,1.43)                       
pooled       femaleTRUE:poor_healthTRUE                        1.06(.85,1.33)                       
alsa         femaleTRUE:sedentaryTRUE                          1.35(.67,2.76)                       
lbsl         femaleTRUE:sedentaryTRUE                          .98(.18,5.75)                        
satsa        femaleTRUE:sedentaryTRUE                          1.1(.6,2.05)                         
share        femaleTRUE:sedentaryTRUE                          1.16(.66,2.04)                       
tilda        femaleTRUE:sedentaryTRUE                          .94(.65,1.36)                        
pooled       femaleTRUE:sedentaryTRUE                          .84(.67,1.05)                        
alsa         femaleTRUE:current_work_2TRUE                     .14(0,4)                             
lbsl         femaleTRUE:current_work_2TRUE                     .81(.17,3.82)                        
satsa        femaleTRUE:current_work_2TRUE                     2.04(.91,4.59).     1.36(1.1,1.67)** 
share        femaleTRUE:current_work_2TRUE                     1.46(.81,2.62)                       
tilda        femaleTRUE:current_work_2TRUE                     1.01(.71,1.44)                       
pooled       femaleTRUE:current_work_2TRUE                     1.19(.91,1.54)                       
alsa         femaleTRUE:current_drinkTRUE                      1.39(.66,2.92)                       
lbsl         femaleTRUE:current_drinkTRUE                      2.01(.44,9.83)                       
satsa        femaleTRUE:current_drinkTRUE                      .99(.46,2.11)                        
share        femaleTRUE:current_drinkTRUE                      1.43(.87,2.36)      1.4(1.2,1.64)*** 
tilda        femaleTRUE:current_drinkTRUE                      .79(.55,1.12)                        
pooled       femaleTRUE:current_drinkTRUE                      .95(.76,1.18)                        


## sedentaryTRUE

 Main Effects across contexts 


study_name   coef_name       A    B                    AA   BB                   best              
-----------  --------------  ---  -------------------  ---  -------------------  ------------------
alsa         sedentaryTRUE        1.16(.85,1.56)            .96(.38,2.35)                          
lbsl         sedentaryTRUE        2.97(1.56,5.55)***        10.07(1.43,71.57)*   1.6(1.43,1.77)*** 
satsa        sedentaryTRUE        1.58(1.19,2.12)**         .64(.14,3.08)                          
share        sedentaryTRUE        1.23(.94,1.58)            1.02(.49,2.07)                         
tilda        sedentaryTRUE        1.54(1.29,1.83)***        2.3(1.28,4.09)**     1.53(1.37,1.7)*** 
pooled       sedentaryTRUE        1.45(1.29,1.62)***        1.4(1.02,1.92)*      1.28(.94,1.75)    


 Interactions across contexts 


study_name   coef_name                       AA                BB                  best             
-----------  ------------------------------  ----------------  ------------------  -----------------
alsa         age_in_years_70:femaleTRUE      .92(.87,.98)**    .92(.87,.98)**      .99(.99,1).      
lbsl         age_in_years_70:femaleTRUE      1.03(.99,1.08)    1.02(.97,1.08)      .99(.99,1)       
satsa        age_in_years_70:femaleTRUE      .96(.93,.98)***   .98(.95,1.02)                        
share        age_in_years_70:femaleTRUE      1(.97,1.02)       1(.97,1.03)                          
tilda        age_in_years_70:femaleTRUE      .98(.96,1)*       .98(.96,1)*                          
pooled       age_in_years_70:femaleTRUE      .98(.97,.99)***   .99(.98,1)*         .98(.97,.99)***  
alsa         femaleTRUE:educ3_f( < HS )      .45(.16,1.18)     .31(.1,.89)*                         
lbsl         femaleTRUE:educ3_f( < HS )      2.06(.28,16.57)   1.17(.1,14.18)                       
satsa        femaleTRUE:educ3_f( < HS )      .4(.13,1.19).     .44(.12,1.62)                        
share        femaleTRUE:educ3_f( < HS )      .93(.55,1.57)     .91(.52,1.59)                        
tilda        femaleTRUE:educ3_f( < HS )      1.49(1.1,2.03)*   1.3(.94,1.79)       1.17(.95,1.45)   
pooled       femaleTRUE:educ3_f( < HS )      .96(.77,1.21)     .98(.78,1.24)                        
alsa         femaleTRUE:educ3_f( HS < )      .78(.39,1.53)     .72(.35,1.47)                        
lbsl         femaleTRUE:educ3_f( HS < )      1.71(.43,6.72)    1.89(.37,10.14)                      
satsa        femaleTRUE:educ3_f( HS < )      .69(.16,2.95)     .6(.11,3.15)                         
share        femaleTRUE:educ3_f( HS < )      1.24(.69,2.22)    1.22(.68,2.22)                       
tilda        femaleTRUE:educ3_f( HS < )      .94(.36,2.38)     .95(.36,2.47)       .85(.63,1.14)    
pooled       femaleTRUE:educ3_f( HS < )      1.2(.87,1.65)     1.18(.85,1.63)                       
alsa         femaleTRUE:singleTRUE           1.7(.84,3.54)     2.1(1,4.55).                         
lbsl         femaleTRUE:singleTRUE           2.37(.71,8.72)    5.13(1.23,25.99)*   .82(.71,.95)*    
satsa        femaleTRUE:singleTRUE           .76(.42,1.36)     .78(.42,1.45)                        
share        femaleTRUE:singleTRUE           .99(.54,1.89)     .95(.5,1.84)                         
tilda        femaleTRUE:singleTRUE           .81(.59,1.1)      .86(.62,1.19)                        
pooled       femaleTRUE:singleTRUE           .85(.68,1.06)     .9(.72,1.13)                         
alsa         femaleTRUE:poor_healthTRUE                        1.36(.66,2.79)                       
lbsl         femaleTRUE:poor_healthTRUE                        1.73(.43,7.25)                       
satsa        femaleTRUE:poor_healthTRUE                        .73(.4,1.33)                         
share        femaleTRUE:poor_healthTRUE                        1.31(.79,2.21)                       
tilda        femaleTRUE:poor_healthTRUE                        1.01(.71,1.43)                       
pooled       femaleTRUE:poor_healthTRUE                        1.06(.85,1.33)                       
alsa         femaleTRUE:sedentaryTRUE                          1.35(.67,2.76)                       
lbsl         femaleTRUE:sedentaryTRUE                          .98(.18,5.75)                        
satsa        femaleTRUE:sedentaryTRUE                          1.1(.6,2.05)                         
share        femaleTRUE:sedentaryTRUE                          1.16(.66,2.04)                       
tilda        femaleTRUE:sedentaryTRUE                          .94(.65,1.36)                        
pooled       femaleTRUE:sedentaryTRUE                          .84(.67,1.05)                        
alsa         femaleTRUE:current_work_2TRUE                     .14(0,4)                             
lbsl         femaleTRUE:current_work_2TRUE                     .81(.17,3.82)                        
satsa        femaleTRUE:current_work_2TRUE                     2.04(.91,4.59).     1.36(1.1,1.67)** 
share        femaleTRUE:current_work_2TRUE                     1.46(.81,2.62)                       
tilda        femaleTRUE:current_work_2TRUE                     1.01(.71,1.44)                       
pooled       femaleTRUE:current_work_2TRUE                     1.19(.91,1.54)                       
alsa         femaleTRUE:current_drinkTRUE                      1.39(.66,2.92)                       
lbsl         femaleTRUE:current_drinkTRUE                      2.01(.44,9.83)                       
satsa        femaleTRUE:current_drinkTRUE                      .99(.46,2.11)                        
share        femaleTRUE:current_drinkTRUE                      1.43(.87,2.36)      1.4(1.2,1.64)*** 
tilda        femaleTRUE:current_drinkTRUE                      .79(.55,1.12)                        
pooled       femaleTRUE:current_drinkTRUE                      .95(.76,1.18)                        


## current_work_2TRUE

 Main Effects across contexts 


study_name   coef_name            A    B                 AA   BB                    best            
-----------  -------------------  ---  ----------------  ---  --------------------  ----------------
alsa         current_work_2TRUE        1.75(.64,4.1)          61.72(.52,19638.03)                   
lbsl         current_work_2TRUE        .9(.45,1.78)           1.53(.16,11.94)                       
satsa        current_work_2TRUE        .67(.46,.97)*          .01(0,.1)***          .64(.5,.8)***   
share        current_work_2TRUE        .94(.72,1.23)          .82(.4,1.64)          .63(.51,.77)*** 
tilda        current_work_2TRUE        .64(.54,.76)***        .88(.49,1.59)         .77(.67,.9)***  
pooled       current_work_2TRUE        .71(.63,.81)***        .82(.56,1.2)          2.25(.8,5.41).  


 Interactions across contexts 


study_name   coef_name                       AA                BB                  best             
-----------  ------------------------------  ----------------  ------------------  -----------------
alsa         age_in_years_70:femaleTRUE      .92(.87,.98)**    .92(.87,.98)**      .99(.99,1).      
lbsl         age_in_years_70:femaleTRUE      1.03(.99,1.08)    1.02(.97,1.08)      .99(.99,1)       
satsa        age_in_years_70:femaleTRUE      .96(.93,.98)***   .98(.95,1.02)                        
share        age_in_years_70:femaleTRUE      1(.97,1.02)       1(.97,1.03)                          
tilda        age_in_years_70:femaleTRUE      .98(.96,1)*       .98(.96,1)*                          
pooled       age_in_years_70:femaleTRUE      .98(.97,.99)***   .99(.98,1)*         .98(.97,.99)***  
alsa         femaleTRUE:educ3_f( < HS )      .45(.16,1.18)     .31(.1,.89)*                         
lbsl         femaleTRUE:educ3_f( < HS )      2.06(.28,16.57)   1.17(.1,14.18)                       
satsa        femaleTRUE:educ3_f( < HS )      .4(.13,1.19).     .44(.12,1.62)                        
share        femaleTRUE:educ3_f( < HS )      .93(.55,1.57)     .91(.52,1.59)                        
tilda        femaleTRUE:educ3_f( < HS )      1.49(1.1,2.03)*   1.3(.94,1.79)       1.17(.95,1.45)   
pooled       femaleTRUE:educ3_f( < HS )      .96(.77,1.21)     .98(.78,1.24)                        
alsa         femaleTRUE:educ3_f( HS < )      .78(.39,1.53)     .72(.35,1.47)                        
lbsl         femaleTRUE:educ3_f( HS < )      1.71(.43,6.72)    1.89(.37,10.14)                      
satsa        femaleTRUE:educ3_f( HS < )      .69(.16,2.95)     .6(.11,3.15)                         
share        femaleTRUE:educ3_f( HS < )      1.24(.69,2.22)    1.22(.68,2.22)                       
tilda        femaleTRUE:educ3_f( HS < )      .94(.36,2.38)     .95(.36,2.47)       .85(.63,1.14)    
pooled       femaleTRUE:educ3_f( HS < )      1.2(.87,1.65)     1.18(.85,1.63)                       
alsa         femaleTRUE:singleTRUE           1.7(.84,3.54)     2.1(1,4.55).                         
lbsl         femaleTRUE:singleTRUE           2.37(.71,8.72)    5.13(1.23,25.99)*   .82(.71,.95)*    
satsa        femaleTRUE:singleTRUE           .76(.42,1.36)     .78(.42,1.45)                        
share        femaleTRUE:singleTRUE           .99(.54,1.89)     .95(.5,1.84)                         
tilda        femaleTRUE:singleTRUE           .81(.59,1.1)      .86(.62,1.19)                        
pooled       femaleTRUE:singleTRUE           .85(.68,1.06)     .9(.72,1.13)                         
alsa         femaleTRUE:poor_healthTRUE                        1.36(.66,2.79)                       
lbsl         femaleTRUE:poor_healthTRUE                        1.73(.43,7.25)                       
satsa        femaleTRUE:poor_healthTRUE                        .73(.4,1.33)                         
share        femaleTRUE:poor_healthTRUE                        1.31(.79,2.21)                       
tilda        femaleTRUE:poor_healthTRUE                        1.01(.71,1.43)                       
pooled       femaleTRUE:poor_healthTRUE                        1.06(.85,1.33)                       
alsa         femaleTRUE:sedentaryTRUE                          1.35(.67,2.76)                       
lbsl         femaleTRUE:sedentaryTRUE                          .98(.18,5.75)                        
satsa        femaleTRUE:sedentaryTRUE                          1.1(.6,2.05)                         
share        femaleTRUE:sedentaryTRUE                          1.16(.66,2.04)                       
tilda        femaleTRUE:sedentaryTRUE                          .94(.65,1.36)                        
pooled       femaleTRUE:sedentaryTRUE                          .84(.67,1.05)                        
alsa         femaleTRUE:current_work_2TRUE                     .14(0,4)                             
lbsl         femaleTRUE:current_work_2TRUE                     .81(.17,3.82)                        
satsa        femaleTRUE:current_work_2TRUE                     2.04(.91,4.59).     1.36(1.1,1.67)** 
share        femaleTRUE:current_work_2TRUE                     1.46(.81,2.62)                       
tilda        femaleTRUE:current_work_2TRUE                     1.01(.71,1.44)                       
pooled       femaleTRUE:current_work_2TRUE                     1.19(.91,1.54)                       
alsa         femaleTRUE:current_drinkTRUE                      1.39(.66,2.92)                       
lbsl         femaleTRUE:current_drinkTRUE                      2.01(.44,9.83)                       
satsa        femaleTRUE:current_drinkTRUE                      .99(.46,2.11)                        
share        femaleTRUE:current_drinkTRUE                      1.43(.87,2.36)      1.4(1.2,1.64)*** 
tilda        femaleTRUE:current_drinkTRUE                      .79(.55,1.12)                        
pooled       femaleTRUE:current_drinkTRUE                      .95(.76,1.18)                        


## current_drinkTRUE

 Main Effects across contexts 


study_name   coef_name           A    B                    AA   BB                  best               
-----------  ------------------  ---  -------------------  ---  ------------------  -------------------
alsa         current_drinkTRUE        1.38(1.01,1.92)*          .7(.31,1.64)                           
lbsl         current_drinkTRUE        .64(.37,1.11)             1(.16,6.62)                            
satsa        current_drinkTRUE        2.87(2.03,4.12)***        9.1(1.32,119.98)*   1.25(1.12,1.4)***  
share        current_drinkTRUE        1.45(1.15,1.83)**         .75(.39,1.43)                          
tilda        current_drinkTRUE        1.36(1.16,1.61)***        2.09(1.29,3.46)**   1.46(1.21,1.77)*** 
pooled       current_drinkTRUE        1.53(1.36,1.71)***        1.26(.96,1.67).     1.35(.94,1.96)     


 Interactions across contexts 


study_name   coef_name                       AA                BB                  best             
-----------  ------------------------------  ----------------  ------------------  -----------------
alsa         age_in_years_70:femaleTRUE      .92(.87,.98)**    .92(.87,.98)**      .99(.99,1).      
lbsl         age_in_years_70:femaleTRUE      1.03(.99,1.08)    1.02(.97,1.08)      .99(.99,1)       
satsa        age_in_years_70:femaleTRUE      .96(.93,.98)***   .98(.95,1.02)                        
share        age_in_years_70:femaleTRUE      1(.97,1.02)       1(.97,1.03)                          
tilda        age_in_years_70:femaleTRUE      .98(.96,1)*       .98(.96,1)*                          
pooled       age_in_years_70:femaleTRUE      .98(.97,.99)***   .99(.98,1)*         .98(.97,.99)***  
alsa         femaleTRUE:educ3_f( < HS )      .45(.16,1.18)     .31(.1,.89)*                         
lbsl         femaleTRUE:educ3_f( < HS )      2.06(.28,16.57)   1.17(.1,14.18)                       
satsa        femaleTRUE:educ3_f( < HS )      .4(.13,1.19).     .44(.12,1.62)                        
share        femaleTRUE:educ3_f( < HS )      .93(.55,1.57)     .91(.52,1.59)                        
tilda        femaleTRUE:educ3_f( < HS )      1.49(1.1,2.03)*   1.3(.94,1.79)       1.17(.95,1.45)   
pooled       femaleTRUE:educ3_f( < HS )      .96(.77,1.21)     .98(.78,1.24)                        
alsa         femaleTRUE:educ3_f( HS < )      .78(.39,1.53)     .72(.35,1.47)                        
lbsl         femaleTRUE:educ3_f( HS < )      1.71(.43,6.72)    1.89(.37,10.14)                      
satsa        femaleTRUE:educ3_f( HS < )      .69(.16,2.95)     .6(.11,3.15)                         
share        femaleTRUE:educ3_f( HS < )      1.24(.69,2.22)    1.22(.68,2.22)                       
tilda        femaleTRUE:educ3_f( HS < )      .94(.36,2.38)     .95(.36,2.47)       .85(.63,1.14)    
pooled       femaleTRUE:educ3_f( HS < )      1.2(.87,1.65)     1.18(.85,1.63)                       
alsa         femaleTRUE:singleTRUE           1.7(.84,3.54)     2.1(1,4.55).                         
lbsl         femaleTRUE:singleTRUE           2.37(.71,8.72)    5.13(1.23,25.99)*   .82(.71,.95)*    
satsa        femaleTRUE:singleTRUE           .76(.42,1.36)     .78(.42,1.45)                        
share        femaleTRUE:singleTRUE           .99(.54,1.89)     .95(.5,1.84)                         
tilda        femaleTRUE:singleTRUE           .81(.59,1.1)      .86(.62,1.19)                        
pooled       femaleTRUE:singleTRUE           .85(.68,1.06)     .9(.72,1.13)                         
alsa         femaleTRUE:poor_healthTRUE                        1.36(.66,2.79)                       
lbsl         femaleTRUE:poor_healthTRUE                        1.73(.43,7.25)                       
satsa        femaleTRUE:poor_healthTRUE                        .73(.4,1.33)                         
share        femaleTRUE:poor_healthTRUE                        1.31(.79,2.21)                       
tilda        femaleTRUE:poor_healthTRUE                        1.01(.71,1.43)                       
pooled       femaleTRUE:poor_healthTRUE                        1.06(.85,1.33)                       
alsa         femaleTRUE:sedentaryTRUE                          1.35(.67,2.76)                       
lbsl         femaleTRUE:sedentaryTRUE                          .98(.18,5.75)                        
satsa        femaleTRUE:sedentaryTRUE                          1.1(.6,2.05)                         
share        femaleTRUE:sedentaryTRUE                          1.16(.66,2.04)                       
tilda        femaleTRUE:sedentaryTRUE                          .94(.65,1.36)                        
pooled       femaleTRUE:sedentaryTRUE                          .84(.67,1.05)                        
alsa         femaleTRUE:current_work_2TRUE                     .14(0,4)                             
lbsl         femaleTRUE:current_work_2TRUE                     .81(.17,3.82)                        
satsa        femaleTRUE:current_work_2TRUE                     2.04(.91,4.59).     1.36(1.1,1.67)** 
share        femaleTRUE:current_work_2TRUE                     1.46(.81,2.62)                       
tilda        femaleTRUE:current_work_2TRUE                     1.01(.71,1.44)                       
pooled       femaleTRUE:current_work_2TRUE                     1.19(.91,1.54)                       
alsa         femaleTRUE:current_drinkTRUE                      1.39(.66,2.92)                       
lbsl         femaleTRUE:current_drinkTRUE                      2.01(.44,9.83)                       
satsa        femaleTRUE:current_drinkTRUE                      .99(.46,2.11)                        
share        femaleTRUE:current_drinkTRUE                      1.43(.87,2.36)      1.4(1.2,1.64)*** 
tilda        femaleTRUE:current_drinkTRUE                      .79(.55,1.12)                        
pooled       femaleTRUE:current_drinkTRUE                      .95(.76,1.18)                        


# session

```r
sessionInfo()
```

```
R version 3.2.5 (2016-04-14)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252
[4] LC_NUMERIC=C                           LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] knitr_1.12.3  MASS_7.3-45   glmulti_1.0.7 rJava_0.9-8   ggplot2_2.1.0 magrittr_1.5 

loaded via a namespace (and not attached):
 [1] Rcpp_0.12.5        RColorBrewer_1.1-2 formatR_1.3        plyr_1.8.3         highr_0.5.1        tools_3.2.5       
 [7] extrafont_0.17     digest_0.6.9       jsonlite_0.9.20    evaluate_0.9       gtable_0.2.0       DBI_0.4-1         
[13] yaml_2.1.13        parallel_3.2.5     Rttf2pt1_1.3.3     dplyr_0.4.3        stringr_1.0.0      htmlwidgets_0.6   
[19] grid_3.2.5         DT_0.1.40          R6_2.1.2           rmarkdown_0.9.6    tidyr_0.4.1        extrafontdb_1.0   
[25] scales_0.4.0       htmltools_0.3.5    rsconnect_0.4.2.1  assertthat_0.1     dichromat_2.0-0    testit_0.5        
[31] colorspace_1.2-6   stringi_1.0-1      lazyeval_0.1.10    munsell_0.4.3     
```




