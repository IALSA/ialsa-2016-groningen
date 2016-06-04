# This report conducts harmonization procedure 
# knitr::stitch_rmd(script="./___/___.R", output="./___/___/___.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console 

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
source("./scripts/common-functions.R") # used in multiple reports
source("./scripts/graph-presets.R") # fonts, colors, themes 
source("./scripts/graph-logistic.R")

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
    "educ3",
    "marital", "single", 
    "smoke_now","smoked_ever",
    "poor_health",
    "sedentary",
    "current_work_2",
    "current_drink"
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

# ---- basic-frequencies-predictors-1 ----------------    
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
  useNA="always"
);t[t==0]<-".";t

ds$age_in_years_70 <- ds$age_in_years - 70
t <- table(
  cut(ds$age_in_years_70,breaks = c(-Inf,seq(from=-40,to=30,by=5), Inf)),
  ds$study_name, 
  useNA = "always"
); t[t==0] <- "."; t


# ----- basic-frequencies-criteria-dv-1 -------------------
t <- table(ds$smoke_now, ds$study_name, useNA="always");t[t==0]<-".";t

# ----- basic-frequencies-criteria-dv-2 -------------------
t <- table( ds$smoked_ever,ds$study_name, useNA="always");t[t==0]<-".";t


# ----- basic-frequencies-predictors-2 -------------------
t <- table( ds$female, ds$study_name, useNA="always");t[t==0]<-".";t
# ----- basic-frequencies-predictors-3 -------------------
t <- table( ds$educ3,ds$study_name, useNA="always");t[t==0]<-".";t
# ----- basic-frequencies-predictors-4 -------------------
t <- table( ds$single,ds$study_name, useNA="always");t[t==0]<-".";t

# ----- basic-frequencies-predictors-5 -------------------
t <- table( ds$poor_health, ds$study_name, useNA="always");t[t==0]<-".";t
# ----- basic-frequencies-predictors-6 -------------------
t <- table( ds$sedentary, ds$study_name, useNA="always");t[t==0]<-".";t
# ----- basic-frequencies-predictors-7 -------------------
t <- table( ds$current_work_2,ds$study_name,useNA="always");t[t==0]<-".";t
# ----- basic-frequencies-predictors-8 -------------------
t <- table( ds$current_drink,ds$study_name, useNA="always");t[t==0]<-".";t

# ---- define-modeling-functions ---------------------
source("./scripts/modeling-functions.R")

# ---- load-estimated-models ----------------------
# models_pooled <- readRDS("./data/shared/derived/models/models_pooled.rds")# list with elements as glm objects
subset_pooled <- readRDS("./data/shared/derived/models/pooled_subset.rds")# list with elements as glmulti objects

# models_local <- readRDS("./data/shared/derived/models/models_local.rds")
subset_local <- readRDS("./data/shared/derived/models/local_subset.rds")

ds_within <- readRDS("./data/shared/derived/tables/ds_within.rds") # datasets with tabled results
ds_between <- readRDS("./data/shared/derived/tables/ds_between.rds")  # datasets with tabled results

# ---- inspect-objects-containing-model-estimations -------------------------------------
# custom models (A, B, AA, BB) over (pooled) studies
class(models_pooled) # list
names(models_pooled) # element = model type
class(models_pooled[["BB"]]) # glm : model solution
names(models_pooled[["BB"]]) # model information components
print(models_pooled[["BB"]]$formula, showEnv = F) # model specification
# summary(pooled_custom[["BB"]]) # model solution

# best subset solution for most complex specification
class(subset_pooled) # glmulity
names(subset_pooled)
print(subset_pooled[["B"]]) # summary of best subset search for a given model type (e.g. "BB")
print(subset_pooled[["B"]]@formulas[[1]], showEnv = F) # best model specification
# class(subset_pooled$B@objects[[1]]) # gml object available if estimation was with includeobjects = T
# summary(pooled_BB_bs@objects[[1]]) # would not work if includeobjects = F
# instead, this model is already estimated in 
summary(models_pooled[["best"]])

class(models_local) # list
names(models_local) # element = model type
names(models_local[["BB"]]) # element = study
class(models_local[["BB"]][["alsa"]]) # glm
names(models_local[["BB"]][["alsa"]]) # model information components
print(models_local[["BB"]][["alsa"]]$formula, showEnv = F) # model specification
# summary(models_local[["BB"]][["alsa"]]) # would not work if includeobjects = F
# instead, this model is already estimated in 
summary(models_local[["best"]][["alsa"]])

class(subset_local) # list
names(subset_local) # element = model type
names(subset_local[["BB"]])# element = study
best_local <- subset_local[["BB"]][["alsa"]] # chose model type to use as "best"
class(best_local) # gmulti
print(best_local) # summary of best subset search
print(best_local@formulas[[1]], showEnv = F) # best model specification
class(best_local@objects[[1]]) #gml object available if estimation was with includeobjects = T
# summary(local_BB_bs[["alsa"]]@objects[[1]])  # would not work if includeobjects = F
# instead, this model is already estimated in 
summary(models_local[["best"]][["alsa"]])



# ---- pooled-results-table-1  -------------------
results_table_pooled <- readRDS("./data/shared/derived/results_table_pooled.rds")
# ---- pooled-results-table-2 ------------------------------
knitr::kable(results_table_pooled)


# ----- compare-custom-and-subset-pooled ----------------
# Review models
model_object= pooled_custom$BB
subset_object = pooled_BB_bs

best <- pooled_custom_plus[["best"]]
print(subset_object) # results of the best subset search
plot(subset_object) # red line: models whose AICc is more than 2 units away from "best" 
tmp <- weightable(subset_object)
tmp <- tmp[tmp$aicc <= min(tmp$aicc) + 2,][1:10,]
tmp$model_rank <- c(1:length(tmp$aicc))
tmp$model <- NULL
akaike_weights <- tmp %>% dplyr::select(model_rank, aicc, weights)
print(knitr::kable(akaike_weights)) # weight could be thought of as the probability that model is the "best"
print(plot(subset_object, type="s")) # average importance of terms 
print(model_report(model_object, subset_object)) # the custom model is compared to the top 5 from the best subset search


# ---- local-results -------------------------------------
class(local_BB_bs) # list
names(local_BB_bs) # element = study
class(local_BB_bs[["alsa"]]) # gmulti
print(local_BB_bs[["alsa"]]) # summary of best subset search
print(local_BB_bs[["alsa"]]@formulas[[1]], showEnv = F) # best model specification
class(local_BB_bs[["alsa"]]@objects[[1]]) # gml
summary(local_BB_bs[["alsa"]]@objects[[1]]) # best model solution







# ----- compare-custom-and-subset-local ----------------
# Review models

# local_custom_object = local_custom_plus
# local_subset_object = local_BB_bs
#   
compare_local_solutions <- function(
  local_custom_object, 
  baseline_model="BB", 
  local_subset_object, 
  study_name_){
  
  model_object <- local_custom_object[[baseline_model]][[study_name_]]
  subset_object <- local_subset_object[[study_name_]]
  
  print(subset_object) # results of the best subset search
  print(plot(subset_object)) # red line: models whose AICc is more than 2 units away from "best" 
  
  tmp <- weightable(subset_object)
  tmp <- tmp[tmp$aicc <= min(tmp$aicc) + 2,][1:10,]
  tmp$model_rank <- c(1:length(tmp$aicc))
  tmp$model <- NULL
  akaike_weights <- tmp %>% dplyr::select(model_rank, aicc, weights)
  print(knitr::kable(akaike_weights)) # weight could be thought of as the probability that model is the "best"
  print(plot(subset_object, type="s")) # average importance of terms 
  print(model_object$formula, showEnv = F)
  print(knitr::kable(basic_model_info(model_object)))
  # print(model_report(model_object, subset_object))
  cat("\n Best subset selection using the same predictors : ")
  (top_models <- basic_model_info(subset_object@objects[[1]]))
  for(i in 2:5){
    top_models <- rbind(top_models, basic_model_info(subset_object@objects[[i]]))
  }
  print(knitr::kable(top_models))
  cat("\n")
  for(i in 1:5){
    cat("Model",i," : ", sep="")
    print(subset_object@formulas[[i]], showEnv = F)
  }
}

# compare_local_solutions(
#   local_custom_object = local_custom_plus, 
#        baseline_model = "BB",
#   local_subset_object = local_BB_bs, 
#           study_name_ = "alsa"
# ) 

# compare_local_solutions(local_custom_plus,"BB",local_BB_bs, "alsa")


# ---- local-results-tables -------------------

# disable BELOW when computed one to speed up report production
# alsa_table <- make_study_table(list_object = local_custom_plus, study_name_= "alsa")
# lbsl_table <- make_study_table(local_custom_plus, "lbsl")
# satsa_table <- make_study_table(local_custom_plus, "satsa")
# share_table <- make_study_table(local_custom_plus, "share")
# tilda_table <- make_study_table(local_custom_plus, "tilda")
# results_table_local <- list("alsa"= alsa_table,"lbsl"= lbsl_table,"satsa" = satsa_table,"share"= share_table,"tilda"= tilda_table)
# saveRDS(results_table_local, "./data/shared/derived/results_table_local.rds")
# disable ABOVE when computed one to speed up report production

results_table_local <- readRDS("./data/shared/derived/results_table_local.rds")
alsa_table <- results_table_local[["alsa"]]
lbsl_table <- results_table_local[["lbsl"]]
satsa_table <- results_table_local[["satsa"]]
share_table <- results_table_local[["share"]]
tilda_table <- results_table_local[["tilda"]]



# ---- local-results-alsa ------------------------------------
knitr::kable(alsa_table)
# ---- local-results-alsa-2 ------------------------------------
compare_local_solutions(local_custom_plus,"B",local_BB_bs, "alsa") 
# ---- local-results-lbsl ------------------------------------
knitr::kable(lbsl_table)
# ---- local-results-lbsl-2 ------------------------------------
compare_local_solutions(local_custom_plus,"B",local_BB_bs,  "lbsl")
# ---- local-results-satsa ------------------------------------
knitr::kable(satsa_table)
# ---- local-results-satsa-2 ------------------------------------
compare_local_solutions(local_custom_plus,"B",local_BB_bs,  "satsa")
# ---- local-results-share ------------------------------------
knitr::kable(share_table)
# ---- local-results-share-2 ------------------------------------
compare_local_solutions(local_custom_plus,"B",local_BB_bs, "share")
# ---- local-results-tilda ------------------------------------
knitr::kable(tilda_table)
# ---- local-results-tilda-2 ------------------------------------
compare_local_solutions(local_custom_plus,"B",local_BB_bs, "tilda")


# ---- make-within-model-tables ------------------------------------

