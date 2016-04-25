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
# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("ggplot2") # graphing
requireNamespace("tidyr") # data manipulation
requireNamespace("dplyr") # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("plyr")
requireNamespace("testit")# For asserting conditions meet expected patterns.

# ---- declare-globals ---------------------------------------------------------

# ---- load-data ---------------------------------------------------------------
# load the product of 0-ellis-island.R,  a list object containing data and metadata
dto <- readRDS("./data/unshared/derived/dto.rds")

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
dmls <- list() # dummy list
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]] # get study data from dto
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
  variables_present <- colnames(ds) %in% get_these_variables # variables on the list
  dmls[[s]] <- ds[, variables_present] # keep only them
}
lapply(dmls, names) # view the contents of the list object

ds <- plyr::ldply(dmls,data.frame, .id = "study_name")
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
# ds %>% dplyr::glimpse()
head(ds)

# ---- save-for-Mplus ---------------------------

# write.table(ds,"./data/unshared/derived/combined-harmonized-data-set.dat", row.names=F, col.names=F)
# write(names(ds), "./data/unshared/derived/variable-names.txt", sep=" ")


# ---- basic-info -------------------------
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

# ---- age-frequencies ----------------                   
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
  dplyr::mutate(
    marital_f         = as.factor(marital),
    educ3_f           = as.factor(educ3)
  ) %>% 
  dplyr::rename_(
    "dv" = dv_name
  ) 
 
# time_scale <- "age_in_years"
# control_covar <- c("female + educ3_f + marital_f")
# focal_covar <- "poor_health"
# 
# reference_group <- c(
#   "female"        = TRUE,
#   "educ3_f"       = "high school",
#   "marital_f"     = "single",
#   "poor_health"   = FALSE
# )

# ---- model-specification -------------------------
formula_full_global <- as.formula(paste0(
  "dv ~ -1 + study_name + age_in_years + female + educ3_f + marital_f +
   poor_health + sedentary + current_work_2 + current_drink "
))

fomula_full_local <- as.formula(paste0(
  "dv ~ -1 + age_in_years + female + educ3_f + marital_f +
  poor_health + sedentary + current_work_2 + current_drink "
))


eq_global <- formula_full_global
eq_local <- fomula_full_local 

# ---- estimate-global -------------------------------------
# eq <- as.formula(paste0("dv ~ -1 + age_in_years + female + educ3_f + poor_health + marital_f"))
# eq_string <- formula_full_global
# eq <- as.formula(eq_string)


# ---- compute-predicted-global ------------------------------
model_global <- glm(eq_global, data = ds2, family = binomial(link="logit")) 

ds2$dv_p <- predict(model_global)
ds_predicted_global <- expand.grid(
  study_name       = sort(unique(ds2$study_name)), #For the sake of repeating the same global line in all studies/panels in the facetted graphs
  age_in_years     = seq.int(40, 100, 1),
  female           = sort(unique(ds2$female)),
  educ3_f          = sort(unique(ds2$educ3_f)),
  marital_f        = sort(unique(ds2$marital_f)),
  poor_health      = sort(unique(ds2$poor_health)),
  sedentary        = sort(unique(ds2$sedentary)),
  current_work_2   = sort(unique(ds2$current_work_2)),
  current_drink    = sort(unique(ds2$current_drink)),
  # bmi              = seq.int(5,60, 10),
  stringsAsFactors = FALSE
)

predicted_global                  <- predict(model_global, newdata=ds_predicted_global, se.fit=TRUE)
ds_predicted_global$dv_hat        <- predicted_global$fit #logged-odds of probability (ie, linear)
ds_predicted_global$dv_upper      <- predicted_global$fit + 1.96*predicted_global$se.fit
ds_predicted_global$dv_lower      <- predicted_global$fit - 1.96*predicted_global$se.fit
ds_predicted_global$dv_hat_p      <- plogis(ds_predicted_global$dv_hat)
ds_predicted_global$dv_upper_p    <- plogis(ds_predicted_global$dv_upper)
ds_predicted_global$dv_lower_p    <- plogis(ds_predicted_global$dv_lower)

# ds_predicted_global %>% dplyr::glimpse()
# head(ds_predicted_global)

# ---- report-global --------------------------------------
eq_global
summary(model_global)

# ---- compute-predicted-local ------------------------
ds_predicted_study_list <- list()
model_study_list <- list()
for( study_name_ in dto[["studyName"]] ) {
  d_study <- ds2[ds2$study_name==study_name_, ]
  model_study <- glm(eq_local, data=d_study,  family=binomial(link="logit")) 
  model_study_list[[study_name_]] <- model_study
  
  d_predicted <- expand.grid(
    age_in_years     = seq.int(40, 100, 10),
    female           = sort(unique(ds2$female)),
    educ3_f          = sort(unique(ds2$educ3_f)),
    marital_f        = sort(unique(ds2$marital_f)),
    poor_health      = sort(unique(ds2$poor_health)),
    sedentary        = sort(unique(ds2$sedentary)),
    current_work_2   = sort(unique(ds2$current_work_2)),
    current_drink    = sort(unique(ds2$current_drink)),
    # bmi              = seq.int(5,60, 5),
    stringsAsFactors = FALSE
  ) 
  
  # d_predicted$dv_hat      <- as.numeric(predict(model_study, newdata=d_predicted)) #logged-odds of probability (ie, linear)
  # d_predicted$dv_hat_p    <- plogis(d_predicted$dv_hat)                            #probability (ie, s-curve)
  
  predicted_study           <- predict(model_study, newdata=d_predicted, se.fit=TRUE) 
  d_predicted$dv_hat        <- predicted_study$fit #logged-odds of probability (ie, linear)
  d_predicted$dv_upper      <- predicted_study$fit + 1.96*predicted_study$se.fit
  d_predicted$dv_lower      <- predicted_study$fit - 1.96*predicted_study$se.fit 
  d_predicted$dv_hat_p      <- plogis(d_predicted$dv_hat) 
  d_predicted$dv_upper_p    <- plogis(d_predicted$dv_upper) 
  d_predicted$dv_lower_p    <- plogis(d_predicted$dv_lower) 
  
  ds_predicted_study_list[[study_name_]] <- d_predicted
}

ds_predicted_study <- ds_predicted_study_list %>% 
  dplyr::bind_rows(.id="study_name")

# ds_predicted_study %>% dplyr::glimpse()
# head(ds_predicted_study)

# ---- report-local ----------------------------
eq_local
sapply(model_study_list, summary)

lapply(model_study_list, summary)

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
