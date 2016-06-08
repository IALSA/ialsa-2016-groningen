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

# prepared by ../compile-models.R
models_pooled <- readRDS("./data/shared/derived/models/models_pooled.rds")#  glm objects
subset_pooled <- readRDS("./data/shared/derived/models/subset_pooled.rds")#  glmulti objects

models_local <- readRDS("./data/shared/derived/models/models_local.rds")
subset_local <- readRDS("./data/shared/derived/models/subset_local.rds")

# prepared by ../compile-tables.R
ds_within <- readRDS("./data/shared/derived/tables/ds_within.rds")
ds_between <- readRDS("./data/shared/derived/tables/ds_between.rds")

# ----- dynamic-between -----------------------
ds_between %>%
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "Comparison across models || identifiable by : study_name",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )

# ----- dynamic-within ------------------------
ds_within %>%
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "Individual model solution || identifiable by : study_name and model_type",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )




cfn <- unique(alsa_table$coef_name)
length(cfn)

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

# ---- view-between-models-data-prep ---------------------------
#create a single list object
results_table_list <- studies_table
results_table_list[["pooled"]] <- pooled_table 
names(results_table_list)
lapply(results_table_list,names) # verify parallel structure

d <- plyr::ldply(results_table_list, data.frame, .id = "model_type")
head(d)
library(magrittr)
# ---- view-between-models -----------------------
d %>%
  # dplyr::mutate(
  #   coef_name = factor(coef_name)
  # ) %>% 
  DT::datatable(
    class   = 'cell-border stripe',
    caption = " Title ",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )

# ---- view-within-models-data-prep ---------------------------

# ---- view-within-models -----------------------







