# This report conducts harmonization procedure 
# knitr::stitch_rmd(script="./___/___.R", output="./___/___/___.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console 

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
source("./scripts/common-functions.R") # used in multiple reports
source("./scripts/graph-presets.R") # fonts, colors, themes 

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
requireNamespace("car") # For it's `recode()` function.

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
# dto[["metaData"]] %>% dplyr::select(study_name, name, item, construct, type, categories, label_short, label) %>% 
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
  (varnames <- names(ds)) # see what variables there are
  (get_these_variables <- c("id",
                            "year_of_wave","age_in_years","year_born",
                            "female",
                            "marital", "single",
                            "educ3",
                            "smoke_now","smoked_ever",
                            "current_work_2",
                            "current_drink",
                            "sedentary",
                            "poor_health",
                            "bmi")) 
  (variables_present <- varnames %in% get_these_variables) # variables on the list
  dmls[[s]] <- ds[,variables_present] # keep only them
}
lapply(dmls, names) # view the contents of the list object

ds <- plyr::ldply(dmls,data.frame,.id = "study_name")
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
head(ds)
saveRDS(ds, "./data/unshared/derived/ds_harmonized.rds")


# ---- save-for-Mplus ---------------------------
convert_to_numeric <- c("smoke_now","smoked_ever")
for(v in convert_to_numeric){
  ds[,v] <- as.integer(ds[,v])
}

# ds$marital_n <- car::recode(ds$marital,"
#                          'single'      = 0;
#                          'mar_cohab'   = 1;
#                          'sep_divorced'= 2; 
#                          'widowed'     = 3
#                          ", as.numeric.result=TRUE )
# ds$educ3_n <- car::recode(ds$educ3,"
#                          'less than high school'= 0;
#                          'high school'          = 1;
#                          'more than high school'= 2
#                          
#                          ", as.numeric.result=TRUE )

str(ds)
# write.table(ds,"./data/unshared/derived/combined-harmonized-data-set.dat", row.names=F, col.names=F)
# write(names(ds), "./data/unshared/derived/variable-names.txt", sep=" ")

# ----- basic-model ------------------
# 
# 
# m1 <- glm(
#   formula = smoke_now ~ 1 + study_name + age_in_years + female + marital + educ3, 
#   data = ds, family = "binomial"
#   )
# m1
# 
# m2 <- glm(
#   formula = smoke_now ~ -1  + age_in_years + female + marital + educ3, 
#   data = ds_sub_share, family = "binomial"
# )
# m2

# # useful functions working with GLM model objects
# summary(m1) # model summary
# summary(m2)
# coefficients(mdl) # point estimates of model parameters (aka "model solution")
# knitr::kable(vcov(mdl)) # covariance matrix of model parameters (inspect for colliniarity)
# knitr::kable(cov2cor(vcov(mdl))) # view the correlation matrix of model parameters
# confint(mdl, level=0.95) # confidence intervals for the estimated parameters
# 
# # predict(mdl); fitted(mld) # generate prediction of the full model (all effects)
# # residuals(mdl) # difference b/w observed and modeled values
# anova(mdl) # put results into a familiary ANOVA table
# # influence(mdl) # regression diagnostics
# 
# 
# # create a model summary object to query 
# (summod <- summary(mdl))
# str(summod)
# 


# ---- reproduce ---------------------------------------
rmarkdown::render(
  input = "./reports/harmonized-data/harmonized-data.Rmd" , 
  output_format="html_document", clean=TRUE
)


















