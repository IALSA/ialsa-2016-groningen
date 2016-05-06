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

# ---- load-data ----------------------
dto <- readRDS("./data/unshared/derived/dto_h.rds")

pooled_custom <- readRDS("./data/shared/derived/models_pooled_custom.rds") 
local_custom <- readRDS("./data/shared/derived/models_local_custom.rds") 


# ---- make-results-table ----------------------------

# models_pooled <- list()
# models_pooled[["A"]] <- make_result_table(pooled_custom[["A"]])
# models_pooled[["AA"]] <- make_result_table(pooled_custom[["AA"]])
# models_pooled[["B"]] <- make_result_table(pooled_custom[["B"]])
# models_pooled[["BB"]] <- make_result_table(pooled_custom[["BB"]])
# d <- plyr::ldply(dum, data.frame, .id = "model_type")
# saveRDS(models_pooled, "./data/shared/derived/models_pooled_detailed.rds")
models_pooled <- readRDS("./data/shared/derived/models_pooled_detailed.rds")


# models_local <- list()
# for(s in dto[["studyName"]]){
#   models_local[[s]][["A"]] <- make_result_table(local_custom[["A"]][[s]])
#   models_local[[s]][["AA"]] <- make_result_table(local_custom[["AA"]][[s]])
#   models_local[[s]][["B"]] <- make_result_table(local_custom[["B"]][[s]])
#   models_local[[s]][["BB"]] <- make_result_table(local_custom[["BB"]][[s]])
# }
# saveRDS(models_local, "./data/shared/derived/models_local_detailed.rds")
models_local <- readRDS("./data/shared/derived/models_local_detailed.rds")


# ---- local-results ------------------------------------
for(study_name_ in dto[["studyName"]]){
  cat("\n\n## `", study_name_, "` \n\n", sep="")
  models <- models_local[[study_name_]]
  
  for(model_type in c("A","AA","B","BB")){
    cat("\n\n### `", model_type, "` \n\n", sep="")
    model <- models[[model_type]]
    # print(model$formula, showEnv=FALSE)
    # cat("\n\n")
    print(knitr::kable(basic_model_info(local_custom[[model_type]][[study_name_]])))
    print(knitr::kable(model))
  }
}


# ---- pooled-results ------------------------------
# basic_model_info(pooled_custom[["A"]])
# knitr::kable(models_pooled[["A"]])

for(model_type in c("A","AA","B","BB")){
  cat("\n\n## `", model_type, "` \n\n", sep="")
  model <- pooled_custom[[model_type]]
  # print(model$formula, showEnv=FALSE)
  # cat("\n\n")
  print(knitr::kable(basic_model_info(pooled_custom[[model_type]])))
  print(knitr::kable(models_pooled[[model_type]]))
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
