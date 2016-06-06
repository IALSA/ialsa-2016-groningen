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
dto[["metaData"]] %>%
  dplyr::select(study_name, name, item, construct, type, categories, label_short, label) %>%
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "This is the primary metadata file. Edit at `./data/shared/meta-data-map.csv",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )

# ---- tweak-data --------------------------------------------------------------

# ---- basic-table --------------------------------------------------------------

# t <- table(ds$smoke_now, ds$study_name, useNA="always");t[t==0]<-".";t

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

# ---- assemble-2 ---------------------------------
# restrict analysis to respondents age 50+
ds <- ds %>% 
  dplyr::filter(age_in_years >= 50) 


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
  cut(ds$age_in_years,breaks = c(49,seq(from=45,to=100,by=5), Inf)),
  ds$study_name, 
  useNA="always"
);t[t==0]<-".";t

# now after centering
ds$age_in_years_70 <- ds$age_in_years - 70
t <- table(
  cut(ds$age_in_years_70,breaks = c(-Inf,seq(from=-25,to=30,by=5), Inf)),
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

# ----- report-results-between-models -------------------------
ds_between %>%
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "Comparison across models || fully identifiable by : study_name",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )


# ----- report-results-within-models -------------------------
ds_within %>%
  dplyr::mutate(coef_name = as.character(coef_name)) %>% 
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "Individual model solution || fully identifiable by : study_name and model_type",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )

# ---- dummy -----------



