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
dto[["metaData"]] %>% dplyr::select(study_name, name, item, construct, type, categories, label_short, label) %>%
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
dmls <- list() # dummy list
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]] # get study data from dto
  (varnames <- names(ds)) # see what variables there are
  (get_these_variables <- c("id",
                            "year_of_wave","age_in_years","year_born",
                            "female",
                            "marital",
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

# ---- save-for-Mplus ---------------------------

# write.table(ds,"./data/unshared/derived/combined-harmonized-data-set.dat", row.names=F, col.names=F)
# write(names(ds), "./data/unshared/derived/variable-names.txt", sep=" ")


# ---- basic-info -------------------------

# age summary across studies
ds %>%  
  dplyr::group_by(study_name) %>%
  na.omit() %>% 
  dplyr::summarize(mean_age = round(mean(age_in_years),1),
                   sd_age = round(sd(age_in_years),2),
                   observed = n(),
                   min_born = min(year_born),
                   med_born = median(year_born),
                   max_born = max(year_born)) 
                   
# see counts across age groups and studies 
t <- table(
  cut(ds$age_in_years,breaks = c(-Inf,seq(from=40,to=100,by=5), Inf)),
  ds$study_name, 
  useNA = "always"
); t[t==0] <- "."; t

# basic counts
table(ds$study_name, ds$smoke_now, useNA = "always")
table(ds$study_name, ds$smoked_ever, useNA = "always")
table(ds$study_name, ds$female, useNA = "always")
table(ds$study_name, ds$marital, useNA = "always")
table(ds$study_name, ds$educ3, useNA = "always")


# ----- basic-model ------------------





# ---- fit-model-with-study-as-factor ----------------------------------------
d <- ds %>% 
  dplyr::select_("id", "study_name", "smoke_now", 
                 "age_in_years", "female", "marital", "educ3","poor_health") %>% 
  na.omit()
mdl <- glm(
  formula = smoke_now ~ -1 + study_name + age_in_years + female + marital + educ3 + poor_health,
  data = d, family = "binomial"
);summary(mdl)
d$smoke_now_p <- predict(mdl)

# ---- graph-points-study-as-factor ----------------------

graph_logistic_point_complex_4(
  ds = d, 
  x_name = "age_in_years", 
  y_name = "smoke_now_p", 
  covar_order = c("female","marital","educ3","poor_health"),
  alpha_level = .3) 

# ---- graph-curves-study-as-factor ----------------------
graph_logitstic_curve_complex_4(
  ds = d, 
  x_name = "age_in_years", 
  y_name = "smoke_now", 
  covar_order = c("female","marital","educ3","poor_health"),
  alpha_level = .3) 


# ---- fit-model-with-study-as-cluster ----------------------------------------

model_outcome <- "smoke_now"
model_predictors <- c("age_in_years", "female", "marital", "educ3","poor_health")

ml <- list() # create a model list object to contain model estimation and modeled data
for(s in dto[["studyName"]]){
  d <- dto[['unitData']][[s]] %>% 
    dplyr::select_(.dots=c("id",model_outcome, model_predictors)) %>% 
    na.omit()
  mdl <- stats::glm( # fit model
    formula = smoke_now ~ age_in_years +female + marital + educ3 + poor_health ,
    data = d, family="binomial"
  ); summary(mdl); 
  modeled_response_name <- paste0(model_outcome,"_p")
  d[,modeled_response_name] <- predict(mdl)
  ml[["data"]][[s]] <- d
  ml[["model"]][[s]] <- mdl
}
# names(ml[["data"]])
# names(ml[["model"]])

d <- plyr::ldply(ml[["data"]],data.frame,.id = "study_name")
d$id <- 1:nrow(d) # some ids values might be identical, replace
head(d)

# ---- graph-points-study-as-cluster ----------------------

graph_logistic_point_complex_4(
  ds = d, 
  x_name = "age_in_years", 
  y_name = "smoke_now_p", 
  covar_order = c("female","marital","educ3","poor_health"),
  alpha_level = .3) 


# ---- graph-curves-study-as-cluster ----------------------
graph_logitstic_curve_complex_4(
  ds = d, 
  x_name = "age_in_years", 
  y_name = "smoke_now", 
  covar_order = c("female","marital","educ3","poor_health"),
  alpha_level = .3) 





# ----- dummy ---------------------------
ld <- d %>%  dplyr::select(id, study_name, age_in_years,female, marital, educ3, smoke_now_p)


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


















