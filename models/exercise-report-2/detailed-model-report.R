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

pooled_custom      <- readRDS("./data/shared/derived/models/pooled_custom.rds")
local_custom       <- readRDS("./data/shared/derived/models/local_custom.rds")

# Load best subset solutions separately, due to large size
# pooled_A_bs  <- readRDS("./data/shared/derived/models/pooled_A_bs.rds")
# local_A_bs  <- readRDS("./data/shared/derived/models/local_A_bs.rds")


# ---- make-results-table ----------------------------

# turn of below once composite is produced -----------
# pooled_custom_composite <- list()
# pooled_custom_composite[["A"]] <- make_result_table(pooled_custom[["A"]])
# pooled_custom_composite[["AA"]] <- make_result_table(pooled_custom[["AA"]])
# pooled_custom_composite[["B"]] <- make_result_table(pooled_custom[["B"]])
# pooled_custom_composite[["BB"]] <- make_result_table(pooled_custom[["BB"]])
# saveRDS(pooled_custom_composite, "./data/shared/derived/models_pooled_detailed.rds")
# # in case you need one long ds:
# d <- plyr::ldply(pooled_custom_composite, data.frame, .id = "model_type")
# turn of above once composite is produced -----------
pooled_custom_composite <- readRDS("./data/shared/derived/pooled_custom_composite.rds")

# turn of below once composite is produced -----------
# local_custom_composite <- list()
# for(s in dto[["studyName"]]){
#   local_custom_composite[[s]][["A"]] <- make_result_table(local_custom[["A"]][[s]])
#   local_custom_composite[[s]][["AA"]] <- make_result_table(local_custom[["AA"]][[s]])
#   local_custom_composite[[s]][["B"]] <- make_result_table(local_custom[["B"]][[s]])
#   local_custom_composite[[s]][["BB"]] <- make_result_table(local_custom[["BB"]][[s]])
# }
# saveRDS(local_custom_composite, "./data/shared/derived/local_custom_composite.rds")
# turn of above once composite is produced -----------
local_custom_composite <- readRDS("./data/shared/derived/local_custom_composite.rds")


# ---- print-custom-local-results ------------------------------------
for(study_name_ in dto[["studyName"]]){
  cat("\n\n## `", study_name_, "` \n\n", sep="")
  models <- local_custom_composite[[study_name_]]
  
  for(model_type in c("A","AA","B","BB")){
    cat("\n\n### `", model_type, "` \n\n", sep="")
    model <- models[[model_type]]
    # print(model$formula, showEnv=FALSE)
    # cat("\n\n")
    print(knitr::kable(basic_model_info(local_custom[[model_type]][[study_name_]])))
    print(knitr::kable(model))
  }
}


# ---- print-custom-pooled-results ------------------------------
# basic_model_info(pooled_custom[["A"]])
# knitr::kable(pooled_custom[["A"]])

for(model_type in c("A","AA","B","BB")){
  cat("\n\n## `", model_type, "` \n\n", sep="")
  model <- pooled_custom[[model_type]]
  # print(model$formula, showEnv=FALSE)
  # cat("\n\n")
  print(knitr::kable(basic_model_info(pooled_custom[[model_type]])))
  print(knitr::kable(pooled_custom_composite[[model_type]]))
}


# ---- session ----------------------------
sessionInfo()