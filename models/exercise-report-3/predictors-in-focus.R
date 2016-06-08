# This report conducts harmonization procedure 
# knitr::stitch_rmd(script="./___/___.R", output="./___/___/___.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
source("./scripts/common-functions.R") # used in multiple reports
source("./scripts/modeling-functions.R")
# ---- load-packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr) # enables piping : %>% 
library(ggplot2)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("ggplot2") # graphing
requireNamespace("tidyr") # data manipulation
requireNamespace("dplyr") # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("plyr")
requireNamespace("testit")# For asserting conditions meet expected patterns.

# ---- declare-globals ---------------------------------------------------------

# ---- load-data ---------------------------------------------------------------
# prepared by Ellis Island and ./reports/report-governor.R
dto <- readRDS("./data/unshared/derived/dto_h.rds")

# prepared by ../compile-tables.R
ds_within <- readRDS("./data/shared/derived/tables/ds_within.rds")
ds_between <- readRDS("./data/shared/derived/tables/ds_between.rds")

# ----- dynamic-between -----------------------
ds_between %>% # dplyr::mutate(
  #   coef_name = factor(coef_name)
  # ) %>% 
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "Comparison across models || identifiable by : study_name",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )

# ----- dynamic-within ------------------------
ds_within %>%
  # dplyr::mutate(
  #   coef_name = factor(coef_name)
  # ) %>% 
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "Individual model solution || identifiable by : study_name and model_type",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )

# ---- define-main-fx-name-objects -------------------------
intercept <- "(Intercept)"   

confounders_main_fx <- c( # group A
   "age_in_years_70" 
  ,"femaleTRUE" 
  ,"educ3_f( < HS )"  
  ,"educ3_f( HS < )" 
  ,"singleTRUE" 
)

exposures_main_fx <- c( # group B
 "poor_healthTRUE"
,"sedentaryTRUE"                       
,"current_work_2TRUE"
,"current_drinkTRUE" 
)

# ---- define-interaction-name-objects ------------------
age_interactions <- c(
     "age_in_years_70:femaleTRUE"
    ,"age_in_years_70:educ3_f( < HS )"     
    ,"age_in_years_70:educ3_f( HS < )"     
    ,"age_in_years_70:singleTRUE"          
    ,"age_in_years_70:poor_healthTRUE"     
    ,"age_in_years_70:sedentaryTRUE"       
    ,"age_in_years_70:current_work_2TRUE"  
    ,"age_in_years_70:current_drinkTRUE"   
);length(age_interactions)

female_interactions <- c( 
     "age_in_years_70:femaleTRUE"  
                    ,"femaleTRUE:educ3_f( < HS )"           
                    ,"femaleTRUE:educ3_f( HS < )"          
                    ,"femaleTRUE:singleTRUE"                
                    ,"femaleTRUE:poor_healthTRUE"          
                    ,"femaleTRUE:sedentaryTRUE"             
                    ,"femaleTRUE:current_work_2TRUE"       
                    ,"femaleTRUE:current_drinkTRUE"      
);length(female_interactions)

education_interactions <- c(
     "age_in_years_70:educ3_f( < HS )" 
         ,"femaleTRUE:educ3_f( < HS )"  
                    ,"educ3_f( < HS ):singleTRUE"          
                    ,"educ3_f( < HS ):poor_healthTRUE"     
                    ,"educ3_f( < HS ):sedentaryTRUE"       
                    ,"educ3_f( < HS ):current_work_2TRUE"  
                    ,"educ3_f( < HS ):current_drinkTRUE"   
      
    ,"age_in_years_70:educ3_f( HS < )"
         ,"femaleTRUE:educ3_f( HS < )"   
                    ,"educ3_f( HS < ):singleTRUE"           
                    ,"educ3_f( HS < ):poor_healthTRUE"      
                    ,"educ3_f( HS < ):sedentaryTRUE"        
                    ,"educ3_f( HS < ):current_work_2TRUE"  
                    ,"educ3_f( HS < ):current_drinkTRUE"   
);length(education_interactions)

marital_interactions <- c(
     "age_in_years_70:singleTRUE"     
         ,"femaleTRUE:singleTRUE"   
    ,"educ3_f( < HS ):singleTRUE"  
    ,"educ3_f( HS < ):singleTRUE"  
                    ,"singleTRUE:poor_healthTRUE"          
                    ,"singleTRUE:sedentaryTRUE"            
                    ,"singleTRUE:current_work_2TRUE"       
                    ,"singleTRUE:current_drinkTRUE"     
); length(marital_interactions)

health_interactions <- c(
     "age_in_years_70:poor_healthTRUE"  
         ,"femaleTRUE:poor_healthTRUE"   
    ,"educ3_f( < HS ):poor_healthTRUE"   
    ,"educ3_f( HS < ):poor_healthTRUE"  
         ,"singleTRUE:poor_healthTRUE"  
                   , "poor_healthTRUE:sedentaryTRUE"       
                   , "poor_healthTRUE:current_work_2TRUE"   
                   , "poor_healthTRUE:current_drinkTRUE"   
); length(health_interactions)

physact_interactions <- c(
     "age_in_years_70:sedentaryTRUE"    
         ,"femaleTRUE:sedentaryTRUE"   
    ,"educ3_f( < HS ):sedentaryTRUE"  
    ,"educ3_f( HS < ):sedentaryTRUE" 
         ,"singleTRUE:sedentaryTRUE"   
    ,"poor_healthTRUE:sedentaryTRUE"   
                    ,"sedentaryTRUE:current_work_2TRUE"     
                    ,"sedentaryTRUE:current_drinkTRUE"     
);length(physact_interactions)

work_interactions <- c(
     "age_in_years_70:current_work_2TRUE"  
         ,"femaleTRUE:current_work_2TRUE"    
    ,"educ3_f( < HS ):current_work_2TRUE"  
    ,"educ3_f( HS < ):current_work_2TRUE"  
         ,"singleTRUE:current_work_2TRUE"  
    ,"poor_healthTRUE:current_work_2TRUE"  
      ,"sedentaryTRUE:current_work_2TRUE"   
                    ,"current_work_2TRUE:current_drinkTRUE"
);length(work_interactions)

alcohol_interactions <- c(
     "age_in_years_70:current_drinkTRUE" 
         ,"femaleTRUE:current_drinkTRUE"   
    ,"educ3_f( < HS ):current_drinkTRUE"  
    ,"educ3_f( HS < ):current_drinkTRUE"  
         ,"singleTRUE:current_drinkTRUE"     
    ,"poor_healthTRUE:current_drinkTRUE"   
      ,"sedentaryTRUE:current_drinkTRUE"     
 ,"current_work_2TRUE:current_drinkTRUE"
); length(alcohol_interactions)


# ---- define-lookup-function -------------------
focun_on_predictor <- function(ds_between, predictor, interactions){
  
  cat("\n\n##", predictor)
  cat("\n\n Main Effects across contexts \n")
  print(knitr::kable(
    ds_between %>% 
      dplyr::filter(coef_name %in%  predictor) %>% 
      dplyr::arrange(coef_name)
  ))
  cat("\n\n Interactions across contexts \n")
  print(knitr::kable(
  ds_between %>% 
    dplyr::filter(coef_name %in% interactions) %>% 
    dplyr::mutate(coef_name = factor(coef_name, levels = interactions)) %>% 
    dplyr::arrange(coef_name, study_name)  %>% 
    dplyr::select(-A,-B)
  )) 
} # Usage:
# focun_on_predictor(ds_between, "singleTRUE", marital_interactions)

# ---- 0-intercept -----------------------
knitr::kable(
ds_between %>% 
  dplyr::filter(coef_name %in% intercept)
) 
# values of the intercepts seem to be similar across the board.
# very similar values in best are reassuring that intercept means the same thing

# ---- 1-predictor-age ---------------------
focun_on_predictor(ds_between, "age_in_years_70", age_interactions)

# ---- 2-predictor-sex ---------------------
focun_on_predictor(ds_between, "femaleTRUE", female_interactions)

# ---- 3-predictor-education-1 ---------------------
focun_on_predictor(ds_between, "educ3_f( < HS )", female_interactions)

# ---- 3-predictor-education-2 ---------------------
focun_on_predictor(ds_between, "educ3_f( HS < )", female_interactions)

# ---- 4-predictor-marital ---------------------
focun_on_predictor(ds_between, "singleTRUE", female_interactions)

# ---- 5-predictor-health ---------------------
focun_on_predictor(ds_between, "poor_healthTRUE", female_interactions)

# ---- 6-predictor-physact ---------------------
focun_on_predictor(ds_between, "sedentaryTRUE", female_interactions)

# ---- 7-predictor-work ---------------------
focun_on_predictor(ds_between, "current_work_2TRUE", female_interactions)

# ---- 8-predictor-alcohol ---------------------
focun_on_predictor(ds_between, "current_drinkTRUE", female_interactions)




