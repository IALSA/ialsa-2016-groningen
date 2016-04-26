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
  dplyr::mutate(
    marital_f         = as.factor(marital),
    educ3_f           = as.factor(educ3)
  ) %>% 
  dplyr::rename_(
    "dv" = dv_name
  ) 
 

# ---- model-specification -------------------------
local_stem <- "dv ~ 1 + "
pooled_stem <- paste0(local_stem, "study_name + ") 
predictors_A <- "age_in_years + female + educ3_f + marital_f" 
predictors_B <- "age_in_years + female + educ3_f + marital_f + poor_health + sedentary + current_work_2 + current_drink"
predictors_AA <-  "age_in_years + female + educ3_f + marital_f + age_in_years*female + age_in_years*educ3_f + age_in_years*marital_f + female*educ3_f + female*marital_f + educ3_f*marital_f"
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

estimate_pooled_model <- function(data, predictors){
  eq_formula <- as.formula(paste0(pooled_stem, predictors))
  models <- glm(eq_formula, data = data, family = binomial(link="logit")) 
  return(models)
}

estimate_pooled_model_best_subset <- function(data, predictors, level=1){
  eq_formula <- as.formula(paste0(pooled_stem, predictors))
  print(eq_formula)
  models <- glmulti::glmulti(
    eq_formula,
    data = data,
    level = level,           # 1 = No interaction considered
    method = "h",            # Exhaustive approach
    crit = "aic",            # AIC as criteria
    confsetsize = 5,         # Keep 5 best models
    plotty = F, report = F,  # No plot or interim reports
    fitfunction = "glm",     # glm function
    family = binomial)       # binomial family for logistic regression family=binomial(link="logit")
  return(models)
  
}

estimate_local_models <- function(data, predictors){
  eq_formula <- as.formula(paste0(local_stem, predictors))
  model_study_list <- list()
  for(study_name_ in dto[["studyName"]]){
    d_study <- data[data$study_name==study_name_, ]
    model_study <- glm(eq_formula, data=d_study,  family=binomial(link="logit")) 
    model_study_list[[study_name_]] <- model_study
  }
  return(model_study_list)
}

estimate_local_models_best_subset <- function(data, predictors, level=1){
  eq_formula <- as.formula(paste0(local_stem, predictors))
  model_study_list <- list()
  # study_name_ = "alsa"
  # d_study <- data[data$study_name==study_name_, ]
  for(study_name_ in dto[["studyName"]]){
  # for(study_name_ in c("alsa")){
    # browser()
    d_study <- data[data$study_name==study_name_, ]
    models_study <- glmulti::glmulti(
      eq_formula,
      data = d_study,
      level = level,           # 1 = No interaction considered
      method = "h",            # Exhaustive approach
      crit = "aic",            # AIC as criteria
      confsetsize = 5,         # Keep 5 best models
      plotty = F, report = F,  # No plot or interim reports
      fitfunction = "glm",     # glm function
      family = binomial)       # binomial family for logistic regression family=binomial(link="logit")
    model_study_list[[study_name_]] <- models_study
    # model_study_list[[study_name_]] <- d_study
  }
  # return(model_study_list)
  return(model_study_list)
}

# ---- model-A-global-1 ------------------------------
pooled_A <- estimate_pooled_model(data=ds2, predictors=predictors_A)
print(pooled_A$formula, showEnv = FALSE)
summary(pooled_A)
# ---- model-A-global-2 ------------------------------
# model_object = pooled_A
make_result_table <- function(model_object){ 
  (cf <- summary(model_object)$coefficients)
  (ci <- exp(cbind(coef(model_object), confint(model_object))))
  ds_table <- cbind.data.frame(coef_name = rownames(cf), cf,ci) 
  row.names(ds_table) <- NULL
  ds_table <- plyr::rename(ds_table, replace = c(
  "Estimate" = "estimate",
  "Std. Error"="se",
  "z value" ="zvalue",
  "Pr(>|z|)"="pvalue",
  "V1"="odds",
  "2.5 %"  = "ci95_low",
  "97.5 %"  ="ci95_high"
  ))
  # ds_table <- ds_table %>% 
  #   dplyr::mutate(
  #     estimate = gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(estimate, 2))
  #     pvalue = round(pvalue,3)
  #     )
  # prepare for display
  ds_table$est <- gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$estimate, 2))
  ds_table$se <- gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$se, 2))
  ds_table$z <- gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$zvalue, 3))
  # ds_table$p <- gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$pvalue, 4))
  ds_table$p <- as.numeric(round(ds_table$pvalue, 4))
  ds_table$odds <- gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$odds, 2))
  ds_table$odds_ci <- paste0("(",
                               gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$ci95_low,2)), ",",
                               gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$ci95_high,2)), ")"
  )
  ds_table$odds_center <- paste0(ds_table$odds, "\n",  ds_table$odds_ci)
  
  ds_table$sign_ <- cut(
    x = ds_table$pvalue,
    breaks = c(-Inf, .001, .01, .05, .10, Inf),
    labels = c("<=.001", "<=.01", "<=.05", "<=.10", "> .10"), #These need to coordinate with the color specs.
    right = TRUE, ordered_result = TRUE
  )
  ds_table$sign <- cut(
    x = ds_table$pvalue,
    breaks = c(-Inf, .001, .01, .05, .10, Inf),
    labels = c("***", "**", "*", ".", " "), #These need to coordinate with the color specs.
    right = TRUE, ordered_result = TRUE
  )
  ds_table <- ds_table %>% 
    dplyr::select_(
       "sign",
       "coef_name",
       "odds",
       "odds_ci",
       "est",
       "se",
       "p",
       "sign_"
    )
  
  return(ds_table)
}
result_table <- make_result_table(model_object=pooled_A)
knitr::kable(result_table)
# ---- model-A-global-3 ------------------------------
best_subset <- estimate_pooled_model_best_subset(data=ds2, predictors=predictors_A)
best_subset@formulas
best_pooled_A <- best_subset@objects[[1]]
# best_pooled_A$formula
summary(best_pooled_A)
# ---- model-A-global-4 ------------------------------
result_table <- make_result_table(model_object=best_pooled_A)
knitr::kable(result_table)


# ---- model-A-local-1 ------------------------------
local_A <- estimate_local_models(data=ds2, predictors=predictors_A)
local_A_best_subset <- estimate_local_models_best_subset(data=ds2, predictors=predictors_A)

# ---- model-A-local-2 ------------------------------

for(study_name_ in dto[["studyName"]]){
  cat("\n\n### `", study_name_, "` \n", sep="")
  local_fixed <- local_A[[study_name_]]
  cat("Fitting model with fixed order of covariates  ||  ")
  cat("\n")
  print(local_fixed$formula, showEnv=FALSE)
  (logLik<-logLik(local_fixed))
  (dev<-deviance(local_fixed))
  (AIC <- AIC(local_fixed)) 
  (BIC <- BIC(local_fixed))
  (dfF <- round(local_fixed$df.residual,0))
  (dfR <- round(local_fixed$df.null,0))
  (dfD <-dfR - dfF) 
  cat("\n\n")
  (model_Info <-t(c("logLik"=logLik,"dev"=dev,"AIC"=AIC,"BIC"=BIC, "df_Full"=dfF,"df_Reduced"=dfR, "df_drop"=dfD)))
  model_Info <- as.data.frame(model_Info)
  print(knitr::kable(model_Info))
  result_table_fixed <- make_result_table(model_object = local_fixed)
  print(knitr::kable(result_table_fixed))
  
  cat("\n\n#### `", "best", "` \n", sep="")
  local_best_subset <- local_A_best_subset[[study_name_]]
  # cat("\n\n")
  # print("Fit the best subset model using the same group of covariates. Top 5 models by AIC: ")
  # print(local_best_subset@formulas, showEnv=FALSE)
  best_local_A <- local_best_subset@objects[[1]]
  result_table_best <- make_result_table(model_object = best_local_A)
  cat("\n\n")
  cat("Display the solution for the best (first) model from the subset  ||  ")
  cat("\n")
  print(best_local_A$formula, showEnv=FALSE)
  (logLik<-logLik(best_local_A))
  (dev<-deviance(best_local_A))
  (AIC <- AIC(best_local_A)) 
  (BIC <- BIC(best_local_A))
  (dfF <- round(best_local_A$df.residual,0))
  (dfR <- round(best_local_A$df.null,0))
  (dfD <-dfR - dfF) 
  cat("\n\n")
  (model_Info <-t(c("logLik"=logLik,"dev"=dev,"AIC"=AIC,"BIC"=BIC, "df_Full"=dfF,"df_Reduced"=dfR, "df_drop"=dfD)))
  model_Info <- as.data.frame(model_Info)
  print(knitr::kable(model_Info))
  cat("\n\n")
  print(knitr::kable(result_table_best))
}



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
