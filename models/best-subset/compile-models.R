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


# ---- declare-variables  ----------------------------------------
dv_name <- "smoke_now"
dv_label <- "P(Smoke Now)"
dv_label_odds <- "Odds(Smoke Now)"


ds2 <- ds %>% 
  dplyr::select_("id", "study_name", "smoke_now", "age_in_years", 
                 "female", "marital", "educ3",
                 "current_work_2",
                 "current_drink",
                 "sedentary",
                 "poor_health") %>%
  # dplyr::select_(.dots = selected_variables) %>%
  na.omit() %>% 
  dplyr::rename_(
    "dv" = dv_name
  ) 

# Label factors
ds2 <- ds2 %>% 
  dplyr::mutate(
    marital_f         = factor(marital, levels = c("single","mar_cohab","widowed","sep_divorced"), labels =  c("(Single)","(Married/Cohab)", "(Widowed)", "(Sep/Divorced)")),
    educ3_f           = factor(educ3, levels = c("high school","less than high school", "more than high school"), labels = c("(HS)","(Less than HS)","(More than HS)")),
    study_name_f      = factor(study_name,
                               levels = c("alsa", "lbsl", "satsa", "share","tilda"),
                               labels = c("(ALSA)","(LBLS)", "(SATSA)", "(SHARE)", "(TILDA)"))
) 

table(ds2$educ3)
table(ds2$marital, ds2$marital_f)
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
age_in_years + female + educ3_f + marital_f
" 

# age_in_years + female + relevel(educ3_f,'(HS)') + marital_f
# " 

predictors_AA <-  "
age_in_years + female + educ3_f + marital_f + 
age_in_years*female + age_in_years*educ3_f + age_in_years*marital_f + 
female*educ3_f + female*marital_f + 
educ3_f*marital_f
"

predictors_B <- "
age_in_years + female + educ3_f + marital_f + 
poor_health + sedentary + current_work_2 + current_drink
"

predictors_BB <-  "
age_in_years + female + educ3_f + marital_f + poor_health + sedentary + current_work_2 + current_drink +
age_in_years*female + age_in_years*educ3_f + age_in_years*marital_f + age_in_years*poor_health + age_in_years*sedentary + age_in_years*current_work_2 + age_in_years*current_drink +
female*educ3_f + female*marital_f + female*poor_health + female*sedentary + female*current_work_2 + female*current_drink +
educ3_f*marital_f + educ3_f*poor_health + educ3_f*sedentary + educ3_f*current_work_2 + educ3_f*current_drink
marital_f*poor_health + marital_f*sedentary + marital_f*current_work_2 + marital_f*current_drink +
poor_health*sedentary + poor_health*current_work_2 + poor_health*current_drink + 
sedentary*current_work_2 + sedentary*current_drink +
current_work_2*current_drink
"
# ---- define-modeling-functions -------------------------
source("./scripts/modeling-functions.R")

# Available functions
# model_object= pooled_A # object containing one model
# best_subset = pooled_B_bs # object contianing subset of models from the search
# basic_model_info(model_object)   #  basic model information
# make_result_table(model_object)  #  solution table
# show_best_subset(best_subset)    #  top models from subset search
# model_report(model_object= model_object, best_subset = best_subset) # custom vs subset

# ---- models-on-pooled-data ------------------------------
pooled_A <- estimate_pooled_model(data=ds2, predictors=predictors_A)
# pooled_A_bs <- estimate_pooled_model_best_subset(data=ds2, predictors=predictors_A, level=1, method="g")

pooled_AA <- estimate_pooled_model(data=ds2, predictors=predictors_AA)
# pooled_AA_bs <- estimate_pooled_model_best_subset(data=ds2, predictors=predictors_A, level=2, method="g")

pooled_B <- estimate_pooled_model(data=ds2, predictors=predictors_B)
# pooled_B_bs <- estimate_pooled_model_best_subset(data=ds2, predictors=predictors_B, level=1, method="g")

pooled_BB <- estimate_pooled_model(data=ds2, predictors=predictors_BB)
# pooled_BB_bs <- estimate_pooled_model_best_subset(data=ds2, predictors=predictors_B, level=2, method="g")

# Review models
# model_object= pooled_B
# best_subset = pooled_B_bs

# basic_model_info(model_object)
# make_result_table(model_object)
# show_best_subset(best_subset)
# cat("\014")
# model_report(model_object= model_object, best_subset = best_subset)


pooled_custom <- list(
  "A"  = pooled_A  ,
  "AA" = pooled_AA ,
  "B"  = pooled_B  ,
  "BB" = pooled_BB 
)
saveRDS(pooled_custom, "./data/shared/derived/models_pooled_custom.rds")

# pooled_best <- list(
#  "A_best" = pooled_A_bs@objects[[1]], 
# "AA_best" = pooled_AA_bs@objects[[1]],
#  "B_best" = pooled_B_bs@objects[[1]]#, 
# "BB_best" = pooled_BB_bs@objects[[1]]
# ) 

# pooled <- list("custom"=pooled_custom, "best"=pooled_best)
# saveRDS(pooled, "./data/shared/derived/pooled_results.rds")


# ---- models-on-separate-studies -------------------------
local_A <- estimate_local_models(data=ds2, predictors=predictors_A)
# local_A_bs <- estimate_local_models_best_subset(data=ds2, predictors=predictors_A, level=1, method="g")

local_AA <- estimate_local_models(data=ds2, predictors=predictors_AA)
# local_AA_bs <- estimate_local_models_best_subset(data=ds2, predictors=predictors_A, level=2, method="g")

local_B <- estimate_local_models(data=ds2, predictors=predictors_B)
# local_B_bs <- estimate_local_models_best_subset(data=ds2, predictors=predictors_B, level=1, method="g")

local_BB <- estimate_local_models(data=ds2, predictors=predictors_BB)
# local_BB_bs <- estimate_local_models_best_subset(data=ds2, predictors=predictors_B, level=2, method="g")

local_custom <- list(
  "A"  = local_A  ,
  "AA" = local_AA ,
  "B"  = local_B  ,
  "BB" = local_BB 
)
saveRDS(local_custom, "./data/shared/derived/models_local_custom.rds")

d <- ds2 %>% dplyr::filter(study_name == "share")
table(d$marital_f, d$educ3_f)


# local_best <- list(
#   "A_best" = pooled_A_bs@objects[[1]], 
#   "AA_best" = pooled_AA_bs@objects[[1]],
#   "B_best" = pooled_B_bs@objects[[1]]#, 
  # "BB_best" = pooled_BB_bs@objects[[1]]
#)

# local <- list("custom"=local_custom, "best"=local_best)



# ---- make-big-table ------------------
dum <- list()
dum[["A"]] <- make_result_table(pooled_A)
dum[["AA"]] <- make_result_table(pooled_AA)
dum[["B"]] <- make_result_table(pooled_B)
dum[["BB"]] <- make_result_table(pooled_BB)
# a <- make_result_table(pooled_A)
# aa <- make_result_table(pooled_AA)
# b <- make_result_table(pooled_B)
# bb <- make_result_table(pooled_BB)

# d <- plyr::ldply(dum, data.frame, .id = "model_type")

# model_object = pooled_A

display_odds_prepare <- function(model_object, model_label){
  x <- make_result_table(model_object)
  x$display_odds <- paste0(x$odds," ",x$sign , "\n",  x$odds_ci)  
  x <- x[, c("coef_name", "display_odds")]
  x <- plyr::rename(x, replace = c("display_odds" = model_label))
  return(x)
}
(a <- display_odds_prepare(pooled_A, "A"))
(aa <- display_odds_prepare(pooled_AA, "AA"))
(b <- display_odds_prepare(pooled_B, "B"))
(bb <- display_odds_prepare(pooled_BB,"BB"))

d1 <- bb %>% dplyr::left_join(aa, by = "coef_name")
d2 <- d1 %>% dplyr::left_join(b, by = "coef_name")
d3 <- d2 %>% dplyr::left_join(a)
d_results <- d3 %>% dplyr::select_("coef_name","A","B","AA", "BB")
knitr::kable(d_results)

# list_object <- list(a,aa, b, bb)
# merge_files <- function(list){
#   Reduce(function( d_1, d_2 ) merge(d_1, d_2, by="coef_name"), list)
# }
# 
# dd <- merge_files(list_object)


for(study_name_ in as.character(sort(unique(ds2$study_name))) ){
  cat("Study : ", study_name_, "\n",sep="")
  model_object = local_AA[[study_name_]]
  # best_subset  = local_A_bs[[study_name_]]
  # model_report(model_object= model_object, best_subset = best_subset)
  print(model_object$formula, showEnv = F)
  print(knitr::kable(make_result_table(model_object)))
  cat("\n\n")
}

# Review models
model_object = local_A[["alsa"]]
best_subset  = local_A_bs[["alsa"]]
# model_object = local_A_bs[["alsa"]]@objects[[1]]

basic_model_info(model_object)
make_result_table(model_object)
show_best_subset(best_subset)
cat("\014")
model_report(model_object= model_object, best_subset = best_subset)



pooled <- list(
  "A"  = pooled_A,   "A_best" = pooled_A_bs@objects[[1]], 
  "AA" = pooled_AA, "AA_best" = pooled_AA_bs@objects[[1]],
  "B"  = pooled_B,   "B_best" = pooled_B_bs@objects[[1]], 
  "BB" = pooled_AA, "BB_best" = pooled_BB_bs@objects[[1]]
)

# local <- list(
#   "A"  = local_A,   "A_best" = local_A_bs@objects[[1]], 
#   "AA" = local_AA, "AA_best" = local_AA_bs@objects[[1]],
#   "B"  = local_B,   "B_best" = local_B_bs@objects[[1]], 
#   "BB" = local_AA, "BB_best" = local_BB_bs@objects[[1]]
# )
# saveRDS(local, "./data/unshared/derived/local_results.rds")


model_results <- list("pooled" = pooled, "local" = local)


model_object = 
# produces the tables of estimates and odds
make_result_table(model_object)
# produces the table of basic model information 
basic_model_info(model_object)
# show best five solutions
show_best_subset(best_subset)








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
