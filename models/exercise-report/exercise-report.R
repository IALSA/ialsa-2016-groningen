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
    "marital",
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


# ----- basic-frequencies-criteria-1 -------------------
t <- table(ds$smoke_now, ds$study_name,    useNA = "always"); t[t==0] <- "."; t
# ----- basic-frequencies-criteria-2 -------------------
t <- table( ds$smoked_ever,ds$study_name,   useNA = "always"); t[t==0] <- "."; t
# ----- basic-frequencies-predictors-1 -------------------
t <- table( ds$female, ds$study_name,       useNA = "always"); t[t==0] <- "."; t
# ----- basic-frequencies-predictors-2 -------------------
t <- table( ds$marital,ds$study_name,       useNA = "always"); t[t==0] <- "."; t
# ----- basic-frequencies-predictors-3 -------------------
t <- table( ds$educ3,ds$study_name,         useNA = "always"); t[t==0] <- "."; t

# ----- basic-frequencies-predictors-4 -------------------
t <- table( ds$current_work_2,ds$study_name,useNA = "always"); t[t==0] <- "."; t
# ----- basic-frequencies-predictors-5 -------------------
t <- table( ds$current_drink,ds$study_name, useNA = "always"); t[t==0] <- "."; t
# ----- basic-frequencies-predictors-6 -------------------
t <- table( ds$sedentary,  ds$study_name,   useNA = "always"); t[t==0] <- "."; t






# ---- define-modeling-functions ---------------------
source("./scripts/modeling-functions.R")

# ---- load-estimated-models ----------------------
pooled_custom <- readRDS("./data/shared/derived/models_pooled_custom.rds") 
local_custom <- readRDS("./data/shared/derived/models_local_custom.rds") 

# ---- functions-to-make-results-table ------------------
display_odds_prepare <- function(model_object, model_label){
  x <- make_result_table(model_object)
  x$display_odds <- paste0(x$odds,x$odds_ci,x$sign)
  # x$display_odds <- paste0(x$sign,x$odds,x$odds_ci)
  # x$display_odds <- paste0(x$odds,x$sign ,x$odds_ci)
  # x$display_odds <- paste0(x$odds," ",x$sign)  
  x <- x[, c("coef_name", "display_odds")]
  x <- plyr::rename(x, replace = c("display_odds" = model_label))
  return(x)
}

# list_object = pooled_custom # each element is a model summary
make_display_table <- function(list_object, model_type, model_label){
  (a <- display_odds_prepare(list_object[["A"]], "A"))
  (aa <- display_odds_prepare(list_object[["AA"]], "AA"))
  (b <- display_odds_prepare(list_object[["B"]], "B"))
  (bb <- display_odds_prepare(list_object[["BB"]],"BB"))
  
  d1 <- bb %>% dplyr::left_join(aa, by = "coef_name")
  d2 <- d1 %>% dplyr::left_join(b, by = "coef_name")
  d3 <- d2 %>% dplyr::left_join(a)
  d_results <- d3 %>% dplyr::select_("coef_name","A","B","AA", "BB")
  d_results[is.na(d_results)] <- ""
  return(d_results)
}

# list_object = pooled_custom # each element is a model summary
list_object_study <- function(list_object, study_name_){
  a <- local_custom[["A"]][[study_name_]]
  aa <- local_custom[["AA"]][[study_name_]]
  b <- local_custom[["B"]][[study_name_]]
  bb <- local_custom[["BB"]][[study_name_]]
  list_object <- list ("A" = a,"AA" = aa,"B" = b, "BB" = bb)
  results_table <- make_display_table(list_object)
  return(results_table)
}
# make_display_table(list_object, "alsa")



# ---- pooled-results-table-1 ------------------------------
# disable BELOW when computed one to speed up report production
# results_table_pooled <- make_display_table(pooled_custom)
# saveRDS(results_table_pooled, "./data/shared/derived/results_table_pooled.rds")
# disable ABOVE when computed one to speed up report production
results_table_pooled <- readRDS("./data/shared/derived/results_table_pooled.rds")
# ---- pooled-results-table-2 ------------------------------
knitr::kable(results_table_pooled)


# ---- local-results ------------------------------------
# disable BELOW when computed one to speed up report production
# alsa_table <- list_object_study(list_object, "alsa")
# lbsl_table <- list_object_study(list_object, "lbsl")
# satsa_table <- list_object_study(list_object, "satsa")
# share_table <- list_object_study(list_object, "share")
# tilda_table <- list_object_study(list_object, "tilda")
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

# ---- local-results-lbsl ------------------------------------
knitr::kable(lbsl_table)

# ---- local-results-satsa ------------------------------------
knitr::kable(satsa_table)

# ---- local-results-share ------------------------------------
knitr::kable(share_table)

# ---- local-results-tilda ------------------------------------
knitr::kable(tilda_table)





  
# ---- glm-support --------------------------
# useful functions working with GLM model objects
summary(mdl) # model summary
coefficients(mdl) # point estimates of model parameters (aka "model solution")
knitr::kable(vcov(mdl)) # covariance matrix of model parameters (inspect for colliniarity)
knitr::kable(cov2cor(vcov(mdl))) # view the correlation matrix of model parameters
confint(mdl, level=0.95) # confidence intervals for the estimated parameters

# predict(mdl); fitted(mld) # generate prediction of the full model (all effects)
# residuals(mdl) # difference b/w observed and modeled values
anova(mdl) # put results into a familiary ANOVA table
# influence(mdl) # regression diagnostics


# create a model summary object to query 
(summod <- summary(mdl))
str(summod)



# ---- reproduce ---------------------------------------
rmarkdown::render(
  input = "./sandbox/visualizing-logistic/visualizing-logistic.Rmd" , 
  output_format="html_document", clean=TRUE
)
