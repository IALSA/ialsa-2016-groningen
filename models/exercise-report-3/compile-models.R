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

# ---- meta-table --------------------------------------------------------
# 4th element - a dataset names and labels of raw variables + added metadata for all studies
# dto[["metaData"]] %>% 
#   dplyr::select(study_name, name, item, construct, type, categories, label_short, label) %>%
#   DT::datatable(
#     class   = 'cell-border stripe',
#     caption = "This is the primary metadata file. Edit at `./data/shared/meta-data-map.csv",
#     filter  = "top",
#     options = list(pageLength = 6, autoWidth = TRUE)
#   )

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


# ---- save-for-Mplus ---------------------------

# write.table(ds,"./data/unshared/derived/combined-harmonized-data-set.dat", row.names=F, col.names=F)
# write(names(ds), "./data/unshared/derived/variable-names.txt", sep=" ")


# ---- basic-info -------------------------

# ---- age-frequencies ----------------    
lsh_age <- assemble_dto(dto, c("id","year_of_wave","age_in_years","year_born"))
lapply(lsh_age, head) # view the contents of the list object
rm(lsh_age)

# age summary across studies
ds %>%  
  dplyr::group_by(study_name) %>%
  na.omit() %>% 
  dplyr::summarize(
    mean_age     = round(mean(age_in_years),1),
    sd_age       = round(sd(age_in_years),2),
    observed     = n(),
    min_born     = min(year_born),
    med_born     = median(year_born),
    max_born     = max(year_born)
  ) %>% 
  dplyr::ungroup()

# see counts across age groups and studies 
t <- table(
  cut(ds$age_in_years,breaks = c(-Inf,seq(from=40,to=100,by=5), Inf)),
  ds$study_name, 
  useNA = "always"
); t[t==0] <- "."; t
# Center at 70
ds$age_in_years_70 <- ds$age_in_years - 70
t <- table(
  cut(ds$age_in_years_70,breaks = c(-Inf,seq(from=-40,to=30,by=5), Inf)),
  ds$study_name, 
  useNA = "always"
); t[t==0] <- "."; t
# Center at 75
ds$age_in_years_75 <- ds$age_in_years - 75
t <- table(
  cut(ds$age_in_years_75,breaks = c(-Inf,seq(from=-45,to=25,by=5), Inf)),
  ds$study_name, 
  useNA = "always"
); t[t==0] <- "."; t
# Center at 80
ds$age_in_years_80 <- ds$age_in_years - 80
t <- table(
  cut(ds$age_in_years_80,breaks = c(-Inf,seq(from=-50,to=20,by=5), Inf)),
  ds$study_name, 
  useNA = "always"
); t[t==0] <- "."; t

# ----- basic-frequencies-criteria-1 -------------------
t <- table(ds$smoke_now, ds$study_name,    useNA = "always"); t[t==0] <- "."; t
# ----- basic-frequencies-criteria-2 -------------------
t <- table( ds$smoked_ever,ds$study_name,   useNA = "always"); t[t==0] <- "."; t
# ----- basic-frequencies-predictors-1 -------------------
t <- table( ds$female, ds$study_name,       useNA = "always"); t[t==0] <- "."; t
# ----- basic-frequencies-predictors-2 -------------------
t <- table( ds$single,ds$study_name,       useNA = "always"); t[t==0] <- "."; t
t <- table( ds$single,ds$marital, ds$study_name,       useNA = "always"); t[t==0] <- "."; t

# ----- basic-frequencies-predictors-3 -------------------
t <- table( ds$educ3,ds$study_name,         useNA = "always"); t[t==0] <- "."; t

# ----- basic-frequencies-predictors-4 -------------------
t <- table( ds$current_work_2,ds$study_name,useNA = "always"); t[t==0] <- "."; t
# ----- basic-frequencies-predictors-5 -------------------
t <- table( ds$current_drink,ds$study_name, useNA = "always"); t[t==0] <- "."; t
# ----- basic-frequencies-predictors-6 -------------------
t <- table( ds$sedentary,  ds$study_name,   useNA = "always"); t[t==0] <- "."; t
t <- table( ds$sedentary,  ds$study_name,   useNA = "always"); t[t==0] <- "."; t

# ##### ATTENTION ####
# Model estimation begins. The above is the script to help review the data object and do last-minute shaping
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
    educ3_f           = factor(educ3, levels = c("high school","less than high school", "more than high school"), labels = c("( HS )","( < HS )","( HS < )")),
    study_name_f      = factor(study_name,
                               levels = c("alsa", "lbsl", "satsa", "share","tilda"),
                               labels = c("(ALSA)","(LBLS)", "(SATSA)", "(SHARE)", "(TILDA)"))
  ) %>% 
  dplyr::rename_(
    "dv" = dv_name
  ) 

table(ds2$educ3)
table(ds2$educ3, ds2$educ3_f)

# # Recode
# ds2$marital <- car::recode(ds2$marital, "
# 'mar_cohab' = -1;
# 'single' = 0;
# 'widowed' = 1;
# 'sep_divorced' = 2;
# ")
# ds2$educ3 <- car::recode(ds2$educ3, "
# 'less than high school' = -1;
# 'high school' = 0;
# 'more than high school' = 1;
# ")
# ds2$marital_f <- ordered(
#   ds2$marital, 
#   levels = c(-1,0,1,2),
#   labels = c("Married/Cohab","Single", "Widowed", "Sep/Divorced")
# )
# 
# ds2$educ3_f <- ordered(
#   ds2$educ3, 
#   levels = c(-1,0,1),
#   labels = c("less than high school","high school", "more than high school")
# )


# ---- model-specification -------------------------
local_stem <- "dv ~ 1 + "
pooled_stem <- paste0(local_stem, "study_name_f + ") 

predictors_A <- "
age_in_years_70 + 
female + 
educ3_f + 
single
" 

predictors_AA <-  "
age_in_years_70 + 
female + 
educ3_f + 
single + 

age_in_years_70*female + 
age_in_years_70*educ3_f + 
age_in_years_70*single + 

female*educ3_f + 
female*single + 

educ3_f*single
"

predictors_B <- "
age_in_years_70 + 
female + 
educ3_f + 
single + 
poor_health + 
sedentary + 
current_work_2 + 
current_drink
"

predictors_BB <-  "

age_in_years_70 + 
female + 
educ3_f + 
single +
poor_health + 
sedentary + 
current_work_2 + 
current_drink + 

age_in_years_70*female + 
age_in_years_70*educ3_f + 
age_in_years_70*single + 
age_in_years_70*poor_health + 
age_in_years_70*sedentary + 
age_in_years_70*current_work_2 + 
age_in_years_70*current_drink + 

female*educ3_f + 
female*single + 
female*poor_health + 
female*sedentary + 
female*current_work_2 + 
female*current_drink + 

educ3_f*single + 
educ3_f*poor_health + 
educ3_f*sedentary + 
educ3_f*current_work_2 + 
educ3_f*current_drink + 

single*poor_health + 
single*sedentary + 
single*current_work_2 + 
single*current_drink + 

poor_health*sedentary + 
poor_health*current_work_2 + 
poor_health*current_drink + 

sedentary*current_work_2 + 
sedentary*current_drink + 

current_work_2*current_drink
" 
# ---- define-modeling-functions -------------------------
source("./scripts/modeling-functions.R")

# Available functions
#  model_object = object of class glm
# subset_object = object of class glmulti

# model_object = pooled_A # object containing one model
# subset_object = pooled_B_bs # object contianing subset of models from the search
# basic_model_info(model_object)   #  basic model information
# make_result_table(model_object)  #  solution table
# show_best_subset(subset_object)    #  top models from subset search
# model_report(model_object= model_object, subset_object = subset_object) # custom vs subset

# ---- estimate-pooled-models  ------------------------------

# A
pooled_A <- estimate_pooled_model(data=ds2, predictors=predictors_A)
# pooled_A_bs <- estimate_pooled_model_best_subset(
#   data=ds2, predictors=predictors_A, level=1, method="h", plotty=T, includeobjects=F )
# saveRDS(pooled_A_bs, "./data/shared/derived/models/pooled_A_bs.rds")
pooled_A_bs <- readRDS("./data/shared/derived/models/pooled_A_bs.rds")
# rm(pooled_A_bs)


# B
pooled_B <- estimate_pooled_model(data=ds2, predictors=predictors_B)
# pooled_B_bs <- estimate_pooled_model_best_subset(
#   data=ds2, predictors=predictors_B, level=1, method="h", plotty=T,includeobjects=F )
# saveRDS(pooled_B_bs, "./data/shared/derived/models/pooled_B_bs.rds")
pooled_B_bs <- readRDS("./data/shared/derived/models/pooled_B_bs.rds")
# rm(pooled_B_bs)



# AA
pooled_AA <- estimate_pooled_model(data=ds2, predictors=predictors_AA)
# I see no need in estimating this model, rather than thoroughness. 
# pooled_AA_bs <- estimate_pooled_model_best_subset(
# data=ds2, predictors=predictors_A, level=2, method="g", plotty=T,includeobjects=F )
# saveRDS(pooled_AA_bs, "./data/shared/derived/models/pooled_AA_bs.rds")
pooled_AA_bs <- readRDS("./data/shared/derived/models/pooled_AA_bs.rds")
# rm(pooled_AA_bs)

# BB
pooled_BB <- estimate_pooled_model(data=ds2, predictors=predictors_BB)
# pooled_BB_bs <- estimate_pooled_model_best_subset(
#   data=ds2, predictors=predictors_B, level=2, method="g", plotty=T,includeobjects=F )
# saveRDS(pooled_BB_bs, "./data/shared/derived/models/pooled_BB_bs.rds")
pooled_BB_bs <- readRDS("./data/shared/derived/models/pooled_BB_bs.rds")
# rm(pooled_BB_bs)

# ---- inspect-pooled-models-results -----------------

model_object <- pooled_A
best_subset  <- pooled_A_bs
# # Review models
basic_model_info(model_object)
# make_result_table(model_object)
# show_best_subset(best_subset) # will produce error if includeobjects=F 
cat("\014")
# model_report(model_object, best_subset)
print(best_subset)
plot(best_subset)
tmp <- weightable(best_subset)
tmp <- tmp[tmp$aicc <= min(tmp$aicc) + 2,]
tmp
plot(best_subset, type="s")

# ---- assemble-pooled-models-results ----------------------------
subset_pooled <-list(
 "A"  = pooled_A_bs  ,
 "AA" = pooled_AA_bs ,
 "B"  = pooled_B_bs  ,
 "BB" = pooled_BB_bs 
) 
saveRDS(subset_pooled, "./data/shared/derived/models/subset_pooled.rds")

models_pooled <- list(
  "A"  = pooled_A  ,
  "AA" = pooled_AA ,
  "B"  = pooled_B  ,
  "BB" = pooled_BB 
)
# augment the existing results with the best subset solution
(eq <- subset_pooled[["BB"]]@formulas[[1]]) # 1 for the top model
(eq_formula <- as.formula(paste("dv ~ ", as.character(eq)[3])))
models_pooled[["best"]] <- glm(eq_formula,ds2, family = binomial(link="logit")) # object of class glm
saveRDS(models_pooled, "./data/shared/derived/models/models_pooled.rds")
models_pooled <- readRDS("./data/shared/derived/models/models_pooled.rds")
# at this point, object
#                      models_pooled
# contains glm objects (A , B , AA, BB, best)
names(models_pooled)
names(models_pooled$A)
summary(models_pooled$A)
broom::glance(models_pooled$A)

# ---- estimate-local-models -------------------------
local_A <- estimate_local_models(data=ds2, predictors=predictors_A)
# local_A_bs <- estimate_local_models_best_subset(
#   data=ds2, predictors=predictors_A, level=1, method="h", plotty=T,includeobjects=F )
# saveRDS(local_A_bs, "./data/shared/derived/models/local_A_bs.rds")
local_A_bs <- readRDS("./data/shared/derived/models/local_A_bs.rds")
# rm(local_A_bs)

local_B <- estimate_local_models(data=ds2, predictors=predictors_B)
# local_B_bs <- estimate_local_models_best_subset(
#   data=ds2, predictors=predictors_B, level=1, method="h", plotty=T,includeobjects=F )
# saveRDS(local_B_bs, "./data/shared/derived/models/local_B_bs.rds")
local_B_bs <- readRDS("./data/shared/derived/models/local_B_bs.rds")
# rm(local_B_bs)



local_AA <- estimate_local_models(data=ds2, predictors=predictors_AA)
# I see no need in estimating this model, rather than thoroughness. 
# local_AA_bs <- estimate_local_models_best_subset(
#   data=ds2, predictors=predictors_A, level=2, method="g", plotty=T,includeobjects=F )
# saveRDS(local_AA_bs, "./data/shared/derived/models/local_AA_bs.rds")
local_AA_bs <- readRDS("./data/shared/derived/models/local_AA_bs.rds")
# rm(local_AA_bs)

local_BB <- estimate_local_models(data=ds2, predictors=predictors_BB)
# local_BB_bs <- estimate_local_models_best_subset(
#   data=ds2, predictors=predictors_B, level=2, method="g", plotty=T,includeobjects=F )
# saveRDS(local_BB_bs, "./data/shared/derived/models/local_BB_bs.rds")
local_BB_bs <- readRDS("./data/shared/derived/models/local_BB_bs.rds")
# rm(local_BB_bs)

# ---- inspect-local-models-results  ------------------------

# Review models
model_object= local_A[["alsa"]]
subset_object = local_A_bs[["alsa"]]
basic_model_info(model_object)
make_result_table(model_object)
# show_best_subset(subset_object)
cat("\014")
# model_report(model_object= model_object, subset_object = best_subset)
print(subset_object)
plot(subset_object)
tmp <- weightable(subset_object)
tmp <- tmp[tmp$aicc <= min(tmp$aicc) + 2,]
tmp
plot(subset_object, type="s")


# ---- assemble-local-models-results ----------------------------
subset_local <- list(
  "A"  = local_A_bs  ,
  "AA" = local_AA_bs ,
  "B"  = local_B_bs  ,
  "BB" = local_BB_bs 
)
saveRDS(subset_local, "./data/shared/derived/models/subset_local.rds")


# save modeling results in separate object to help looping later
models_local <- list(
  "A"  = local_A  ,
  "AA" = local_AA ,
  "B"  = local_B  ,
  "BB" = local_BB 
)

for(study_name_ in as.character(sort(unique(ds2$study_name))) ){
  (eq <- subset_local[["BB"]][[study_name_]]@formulas[[1]])
  (eq_formula <- as.formula(paste("dv ~ ", as.character(eq)[3])))
  local_subset_best <- glm(eq_formula,ds2, family = binomial(link="logit")) 
  models_local[["best"]][[study_name_]] <- local_subset_best
}
names(models_local)
names(models_local$best)
class(models_local$best$alsa)

saveRDS(models_local, "./data/shared/derived/models/models_local.rds")
models_local <- readRDS("./data/shared/derived/models/models_local.rds")

# ---- inspect-created-objects -------------------------
# pooled models
names(models_pooled)
broom::glance(models_pooled$A)
make_result_table(models_pooled$A)
broom::tidy(models_pooled$A)

# local models
names(models_local)
names(models_local$best)
basic_model_info(models_local$A$alsa)
make_result_table(models_local$A$alsa)
broom::tidy(models_local$A$alsa)

