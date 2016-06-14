# This report conducts harmonization procedure 
# knitr::stitch_rmd(script="./___/___.R", output="./___/___/___.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
# source("./scripts/common-functions.R") # used in multiple reports
# source("./scripts/graph-presets.R") # fonts, colors, themes 
# source("./scripts/graph-logistic.R")
source("./scripts/modeling-functions.R")

# ---- load-packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr) # enables piping : %>% 
library(ggplot2)
library(glmulti)
library(rJava)

require(MASS)

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("ggplot2") # graphing
requireNamespace("tidyr") # data manipulation
requireNamespace("dplyr") # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("plyr")
requireNamespace("testit")# For asserting conditions meet expected patterns.

# ---- declare-globals ---------------------------------------------------------

# ---- load-data ---------------------------------------------------------------
# load the product of 0-ellis-island.R,  a list object containing data and metadata
dto <- readRDS("./data/unshared/derived/dto_h.rds")

# ---- inspect-data -------------------------------------------------------------
# the list is composed of the following elements
names(dto)
# 1st element - names of the studies as character vector
dto[["studyName"]]
# 2nd element - file paths of the data files for each study as character vector
dto[["filePath"]]
# 3rd element - is a list object containing the following elements
names(dto[["unitData"]])
# each of these elements is a raw data set of a corresponding study, for example
dplyr::tbl_df(dto[["unitData"]][["lbsl"]]) 



# ---- tweak-data --------------------------------------------------------------

# ---- basic-table --------------------------------------------------------------

# ---- basic-graph --------------------------------------------------------------

# ---- assemble ------------------
assemble_dto <- function(dto, get_these_variables){
  
  lsh <- list() #  list object with harmonized data
  for(s in dto[["studyName"]]){
    ds <- dto[["unitData"]][[s]] # get study data from dto
    variables_present <- colnames(ds) %in% get_these_variables # variables on the list
    lsh[[s]] <- ds[, variables_present] # keep only them
  }
  return(lsh)
}
lsh <- assemble_dto(
  dto=dto,
  get_these_variables <- c(
    "id",
    "year_of_wave","age_in_years","year_born",
    "female",
    "marital", "single",
    "educ3",
    "smoke_now","smoked_ever",
    "current_work_2",
    "current_drink",
    "sedentary",
    "poor_health"
  )
)
lapply(lsh, names) # view the contents of the list object
ds <- plyr::ldply(lsh,data.frame, .id = "study_name")
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
ds %>% names()

# restrict sample to persons 50+ at baseline
ds <- ds %>% 
  dplyr::filter(age_in_years >= 50) 
# Center at 70
ds$age_in_years_70 <- ds$age_in_years - 70
# view age cagetories across studies
t <- table(
  cut(ds$age_in_years_70,breaks = c(-Inf,seq(from=-25,to=30,by=5), Inf)),
  ds$study_name, 
  useNA = "always"
); t[t==0] <- "."; t

ds %>% 
  dplyr::group_by(study_name) %>% 
  dplyr::summarize(count =n())

# ##### ATTENTION ####
# Model estimation begins. The above is the script to help review the data.
# ---- declare-variables  ----------------------------------------
dv_name <- "smoke_now"
dv_label <- "P(Smoke Now)"
dv_label_odds <- "Odds(Smoke Now)"

ds2 <- ds %>% 
  dplyr::select_("id", "study_name", "smoke_now", "age_in_years_70", 
                 "female", "single", "educ3",
                 "current_work_2",
                 "current_drink",
                 "sedentary",
                 "poor_health") %>%
  # dplyr::select_(.dots = selected_variables) %>%
  na.omit() %>% 
  dplyr::mutate(
    educ3_f           = factor(educ3, levels = c("less than high school", "high school", "more than high school"), labels = c("( < HS )","( HS )", "( HS + )" )),
    study_name_f      = factor(study_name,
                               levels = c("alsa", "lbsl", "satsa", "share","tilda"),
                               labels = c("(ALSA)","(LBLS)", "(SATSA)", "(SHARE)", "(TILDA)")),
    male              = !female,
    good_health       = !poor_health
  ) %>% 
  dplyr::rename_(
    "dv" = dv_name
  ) 
table(ds2$educ3, ds2$educ3_f)


# ---- model-specification -------------------------
local_stem <- "dv ~ 1 + "
pooled_stem <- paste0(local_stem, "study_name_f + ") 

predictors_B <- "
age_in_years_70 + 
male + 
educ3_f + 
single + 
good_health + 
sedentary + 
current_work_2 + 
current_drink
"
unique_predictors <- c(
  "study_name_f",
  "age_in_years_70", 
  "male", 
  "educ3_f", 
  "single", 
  "good_health", 
  "sedentary",  
  "current_work_2", 
  "current_drink"
)

estimate_pooled_model_unadj <- function(data, predictors){
  eq_formula <- as.formula(paste0(local_stem, predictors))
  models <- glm(eq_formula, data = data, family = binomial(link="logit")) 
  return(models)
}

# ---- unadjusted-models --------------
pooled_B_unadj <- list()
for(predictor_ in unique_predictors){   
  pooled_B_unadj[[predictor_]] <- estimate_pooled_model_unadj(data=ds2, predictors=predictor_)
  # print(broom::tidy(pooled_B_unadj[[predictor_]]))
  model_object <- pooled_B_unadj[[predictor_]]
  cat("\n\n##", predictor_)
  cat("\n\n")
  print(model_object$formula, showEnv = F)# equation
  print(knitr::kable(basic_model_info(model_object, F))) # alternative: broom::glance()
  print(knitr::kable(make_result_table(model_object))) # prints custom designed table of coefficients
}   

# ---- adjusted-model -----------------
pooled_B <- estimate_pooled_model(data=ds2, predictors=predictors_B)
model_object <- pooled_B
print(knitr::kable(basic_model_info(model_object, F))) # alternative: broom::glance()
print(knitr::kable(make_result_table(model_object))) # prints custom designed table of coefficients

