# This report conducts harmonization procedure 
# knitr::stitch_rmd(script="./___/___.R", output="./___/___/___.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
source("./scripts/common-functions.R") # used in multiple reports
source("./scripts/modeling-functions.R")
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
# prepared by Ellis Island and ./reports/report-governor.R
dto <- readRDS("./data/unshared/derived/dto_h.rds")

# prepared by ../compile-models.R
models_pooled <- readRDS("./data/shared/derived/models/models_pooled.rds")#  glm objects
subset_pooled <- readRDS("./data/shared/derived/models/subset_pooled.rds")#  glmulti objects

models_local <- readRDS("./data/shared/derived/models/models_local.rds")
subset_local <- readRDS("./data/shared/derived/models/subset_local.rds")

# prepared by ../compile-tables.R
tables_pooled <- readRDS("./data/shared/derived/tables/tables_pooled.rds")
tables_local <- readRDS("./data/shared/derived/tables/tables_local.rds")
tables_bw_pooled <- readRDS("./data/shared/derived/tables/tables_bw_pooled.rds")
tables_bw_local <- readRDS("./data/shared/derived/tables/tables_bw_local.rds")

ds_within <- readRDS("./data/shared/derived/tables/ds_within.rds")
ds_between <- readRDS("./data/shared/derived/tables/ds_between.rds")

# ----- dynamic-between -----------------------
ds_between %>%
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "Comparison across models || identifiable by : study_name",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )

# ----- dynamic-within ------------------------
ds_within %>%
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "Individual model solution || identifiable by : study_name and model_type",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )

# ----- static-pooled -----------------
cat("\n\n## pooled")
cat("\n\n### BETWEEN")
print(knitr::kable(tables_bw_pooled)) 

for(model_type_ in c("A","B","AA","BB", "best") ){ 
  table_to_print <- tables_pooled[[model_type_]]
  cat("\n\n### ", model_type_)
  cat("\n\n ", "solution of model **", model_type_, "** fit to combined and harmonized data from ** ALL ** studies", sep="")
  print(knitr::kable(basic_model_info(models_pooled[[model_type_]])))
  print(knitr::kable(table_to_print))
} 

# # ----- static-between -----------------
# 
# 
# for(study_name_ in dto$studyName ){
#  table_to_print <- tables_bw_local[[study_name_]]
#  cat("\n\n### ", study_name_)
#  cat("\n\n Comparing models fit to ", study_name_,"'s data")
#  print(knitr::kable(table_to_print))
# }
# print(knitr::kable(tables_bw_pooled))

# ----- static-local -----------------------
# names(tables_local)
# study_name_ = "alsa"
# model_type_ = "A"
for(study_name_ in dto$studyName ){
  cat("\n\n## ", study_name_)
  table_to_print <- tables_bw_local[[study_name_]]
  cat("\n\n### BETWEEN")
  for(model_type_ in c("A","B","AA","BB", "best") ){
  table_to_print <- tables_local[[model_type_]][[study_name_]]
  cat("\n\n### ", model_type_)
  cat("\n\n ", "solution of model **", model_type_, "** fit to data from **", study_name_,"** study", sep="")
  print(knitr::kable(basic_model_info(models_local[[model_type_]][[study_name_]])))
  print(knitr::kable(table_to_print))
  }
}


