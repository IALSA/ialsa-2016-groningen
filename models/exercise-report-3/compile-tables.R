# This report conducts harmonization procedure 
# knitr::stitch_rmd(script="./___/___.R", output="./___/___/___.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
source("./scripts/common-functions.R") # used in multiple reports
# source("./scripts/graph-presets.R") # fonts, colors, themes 
# source("./scripts/graph-logistic.R")

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

# ---- declare-globals ---------------------------------------------------------

# ---- load-data ---------------------------------------------------------------
dto <- readRDS("./data/unshared/derived/dto_h.rds")

models_pooled <- readRDS("./data/shared/derived/models/models_pooled.rds")# list with elements as glm objects
subset_pooled <- readRDS("./data/shared/derived/models/pooled_subset.rds")# list with elements as glmulti objects

models_local <- readRDS("./data/shared/derived/models/models_local.rds")
subset_local <- readRDS("./data/shared/derived/models/local_subset.rds")

# Load best subset solutions separately, due to large size
# pooled_A_bs  <- readRDS("./data/shared/derived/models/pooled_A_bs.rds")
# pooled_AA_bs  <- readRDS("./data/shared/derived/models/pooled_AA_bs.rds")
# pooled_B_bs  <- readRDS("./data/shared/derived/models/pooled_B_bs.rds")
# pooled_BB_bs  <- readRDS("./data/shared/derived/models/pooled_BB_bs.rds")

# local_A_bs  <- readRDS("./data/shared/derived/models/local_A_bs.rds")
# local_AA_bs  <- readRDS("./data/shared/derived/models/local_AA_bs.rds")
# local_B_bs  <- readRDS("./data/shared/derived/models/local_B_bs.rds")
# local_BB_bs  <- readRDS("./data/shared/derived/models/local_BB_bs.rds")

# remind yourself the structure of the objects:

# ---- inspect-data -------------------------------------
# custom models (A, B, AA, BB) over (pooled) studies
class(models_pooled) # list
names(models_pooled) # element = model type
class(models_pooled[["BB"]]) # glm : model solution
names(models_pooled[["BB"]]) # model information components
print(models_pooled[["BB"]]$formula, showEnv = F) # model specification
# summary(models_pooled[["BB"]]);  # model solution
# broom::glance(models_pooled[["BB"]]); basic_model_info(models_pooled$BB)

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



# ---- dummy ------------------------------------
###################################################
##########   WITHIN   model   tables   ########
###################################################



# ---- compute-within-model-tables --------------------------
model_object <- models_pooled$A
# model_object <- models_pooled[["best"]]



basic_model_info(model_object, T) # alternative: broom::glance()
make_result_table(model_object) # prints custom designed table of coefficients
model_ = "A"


# tables_pooled <- list(); 
# for(model_ in c("A","B","AA","BB","best")){
#   m <- models_pooled[[model_]]
#   tables_pooled[[model_]] <- make_result_table(m)
# }
# saveRDS(tables_pooled, "./data/shared/derived/tables/tables_pooled.rds")
tables_pooled <- readRDS("./data/shared/derived/tables/tables_pooled.rds")


# tables_local <- list()
# for(model_ in c("A","B","AA","BB","best")){
#   for(study_name_ in dto[["studyName"]]){
#     m <- models_local[[model_]][[study_name_]]
#     tables_local[[model_]][[study_name_]] <- make_result_table(m)  
#   }
# }
# saveRDS(tables_local,   "./data/shared/derived/tables/tables_local.rds")
tables_local <- readRDS("./data/shared/derived/tables/tables_local.rds")


# ---- dummy ------------------------------------
###################################################
##########   BETWEEN   model   tables   ########
###################################################


# ---- compute-between-model-tables --------------------------
# disable BELOW when computed one to speed up report production
# lapply(models_pooled, names)
# tables_bw_pooled <- make_display_table(models_pooled)
# saveRDS(tables_bw_pooled, "./data/shared/derived/tables/tables_bw_pooled.rds")
# disable ABOVE when computed one to speed up report production

tables_bw_pooled <- readRDS("./data/shared/derived/tables/tables_bw_pooled.rds")
# ---- pooled-results-table-2 ------------------------------
knitr::kable(tables_bw_pooled)


# ----- compare-custom-and-subset-pooled ----------------
# Review models
model_object= models_pooled$BB
subset_object = subset_pooled[["BB"]]

best <- model_object[["best"]]
print(subset_object) # results of the best subset search
plot(subset_object) # red line: models whose AICc is more than 2 units away from "best" 
tmp <- weightable(subset_object)
tmp <- tmp[tmp$aicc <= min(tmp$aicc) + 2,][1:10,]
tmp$model_rank <- c(1:length(tmp$aicc))
tmp$model <- NULL
akaike_weights <- tmp %>% dplyr::select(model_rank, aicc, weights)
print(knitr::kable(akaike_weights)) # weight could be thought of as the probability that model is the "best"
print(plot(subset_object, type="s")) # average importance of terms 
# print(model_report(model_object, subset_object)) # would not work if includeobjects = F



# ---- local-results-tables -------------------

# disable BELOW when computed one to speed up report production
# alsa_table <- make_study_table(models_local, study_name_= "alsa")
# lbsl_table <- make_study_table(models_local, "lbsl")
# satsa_table <- make_study_table(models_local, "satsa")
# share_table <- make_study_table(models_local, "share")
# tilda_table <- make_study_table(models_local, "tilda")
# tables_bw_local <- list("alsa"= alsa_table,"lbsl"= lbsl_table,"satsa" = satsa_table,"share"= share_table,"tilda"= tilda_table)
# saveRDS(tables_bw_local, "./data/shared/derived/tables/tables_bw_local.rds")
# disable ABOVE when computed one to speed up report production
tables_bw_local <- readRDS("./data/shared/derived/tables/tables_bw_local.rds")

alsa_table <- tables_bw_local[["alsa"]]
lbsl_table <- tables_bw_local[["lbsl"]]
satsa_table <- tables_bw_local[["satsa"]]
share_table <- tables_bw_local[["share"]]
tilda_table <- tables_bw_local[["tilda"]]

# ---- summarize-existing-objects ------------------------
# at this point, the following objects have been created:

# (1a) WITHIN model tables for POOLED results
names(tables_pooled) # element =  model =  table
tables_pooled$A
# (1b) BETWEEN model tables for POOOLED results
tables_bw_pooled # table


# (2a) WITHIN model tables for LOCAL results (for each study)
names(tables_local) # element = model_type
names(tables_local$A) # element = study = table
tables_local$A$alsa
# (2b) WITHIN model tables for LOCAL results (for each study)
names(tables_bw_local) # element = study = table
tables_bw_local$alsa

# ----- create-within-tables-for-DT -----------------

dlist_within = list(
  pooled = "", 
  alsa = "", 
  lbsl = "", 
  satsa = "", 
  share = "", 
  tilda ="" 
)

names(tables_pooled)
d <- plyr::ldply(tables_pooled, .id = "model_type")
head(d)
dlist_within[["pooled"]] <- d

# names(table_object)

# table_object = tables_local; study_name_="alsa"
get_local_pooled <- function(table_object, study_name_){  
  dlist <- list()
  for(model_type_ in c("A","B","AA","BB", "best")){
    dlist[[model_type_]] <- table_object[[model_type_]][[study_name_]]
  }
  names(dlist)
  d <- plyr::ldply(dlist, .id = "model_type")
  head(d)
  return(d) 
}  

for(study_name_ in dto[["studyName"]]){
dlist_within[[study_name_]] <- get_local_pooled(tables_local, study_name_)
}

names(dlist_within)
ds_within <- plyr::ldply(dlist_within, .id = "study_name")
head(ds_within)
table(ds_within$study_name, ds_within$model_type)
# saveRDS(ds_within, "./data/shared/derived/tables/ds_within.rds")
ds_within <- readRDS("./data/shared/derived/tables/ds_within.rds")

# ----- create-between-tables-for-DT -----------------
tables_bw_pooled # table
names(tables_bw_local) # list

dummylist <- list()


dlist_between = tables_bw_local 
dlist_between[["pooled"]] <- tables_bw_pooled
names(dlist_between)

ds_between <- plyr::ldply(dlist_between, .id = "study_name")

head(ds_between)
table(d$model_type)
# saveRDS(ds_between,"./data/shared/derived/tables/ds_between.rds")
ds_between <- readRDS("./data/shared/derived/tables/ds_between.rds")

# ----- report-results-within-models -------------------------
 ds_within %>%
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "Individual model solution || identifiable by : study_name and model_type",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )


# ----- report-results-within-models -------------------------
ds_between %>%
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "Comparison across models || identifiable by : study_name",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )




