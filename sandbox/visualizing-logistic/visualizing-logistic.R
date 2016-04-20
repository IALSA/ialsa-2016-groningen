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
    "poor_health",
    "bmi"
  )
  variables_present <- colnames(ds) %in% get_these_variables # variables on the list
  dmls[[s]] <- ds[, variables_present] # keep only them
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

# basic counts
table(ds$study_name, ds$smoke_now,     useNA = "always")
table(ds$study_name, ds$smoked_ever,   useNA = "always")
table(ds$study_name, ds$female,        useNA = "always")
table(ds$study_name, ds$marital,       useNA = "always")
table(ds$study_name, ds$educ3,         useNA = "always")

# ----- basic-model ------------------


# ---- declare-variables  ----------------------------------------
dv_name <- "smoke_now"
dv_label <- "P(Smoke Now)"
dv_label_odds <- "Odds(Smoke Now)"

ds2 <- ds %>% 
  dplyr::select_("id", "study_name", "smoke_now", "age_in_years", "female", "marital", "educ3","poor_health") %>%
  # dplyr::select_(.dots = selected_variables) %>%
  na.omit() %>% 
  dplyr::mutate(
    marital_f         = as.factor(marital),
    educ3_f           = as.factor(educ3)
  ) %>% 
  dplyr::rename_(
    "dv" = dv_name
  ) 
 
time_scale <- "age_in_years"
control_covar <- c("female + educ3_f + marital_f")
focal_covar <- "poor_health"

# ---- model-specification -------------------------
# eq <- as.formula(paste0("dv ~ -1 + age_in_years + female + educ3_f + poor_health + marital_f"))
eq <- as.formula(paste0("dv ~ -1 + ",time_scale, " + ", control_covar, " + ", focal_covar))
model_global <- glm(eq, data = ds2, family = binomial(link="logit")) 
summary(model_global)

# ---- compute-predicted-global ------------------------------
ds2$dv_p <- predict(model_global)

ds_predicted_global <- expand.grid(
  study_name       = sort(unique(ds2$study_name)), #For the sake of repeating the same global line in all studies/panels in the facetted graphs
  age_in_years     = seq.int(40, 100, 10),
  female           = sort(unique(ds2$female)),
  educ3_f          = sort(unique(ds2$educ3_f)),
  marital_f        = sort(unique(ds2$marital_f)),
  poor_health      = sort(unique(ds2$poor_health)),
  stringsAsFactors = FALSE
) 

predicted_global                  <- predict(model_global, newdata=ds_predicted_global, se.fit=TRUE) 
ds_predicted_global$dv_hat        <- predicted_global$fit #logged-odds of probability (ie, linear)
ds_predicted_global$dv_upper      <- predicted_global$fit + 1.96*predicted_global$se.fit
ds_predicted_global$dv_lower      <- predicted_global$fit - 1.96*predicted_global$se.fit 
ds_predicted_global$dv_hat_p      <- plogis(ds_predicted_global$dv_hat) 
ds_predicted_global$dv_upper_p    <- plogis(ds_predicted_global$dv_upper) 
ds_predicted_global$dv_lower_p    <- plogis(ds_predicted_global$dv_lower) 

# ---- compute-predicted-study ------------------------
ds_predicted_study_list <- list()
model_study_list <- list()
for( study_name_ in dto[["studyName"]] ) {
  d_study <- ds2[ds2$study_name==study_name_, ]
  model_study <- glm(eq, data=d_study,  family=binomial(link="logit")) 
  model_study_list[[study_name_]] <- model_study
  
  d_predicted <- expand.grid(
    age_in_years     = seq.int(40, 100, 10),
    female           = sort(unique(ds2$female)),
    educ3_f          = sort(unique(ds2$educ3_f)),
    marital_f        = sort(unique(ds2$marital_f)),
    poor_health      = sort(unique(ds2$poor_health)),
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

ds_replicated_observed_list <- list(
  female        = ds2,
  educ3_f       = ds2,
  marital_f     = ds2,
  poor_health   = ds2
)
ds_replicated_predicted_list <- list(
  female        = ds_predicted_study,
  educ3_f       = ds_predicted_study,
  marital_f     = ds_predicted_study,
  poor_health   = ds_predicted_study
)
ds_replicated_predicted_global_list <- list( 
  female        = ds_predicted_global,
  educ3_f       = ds_predicted_global, 
  marital_f     = ds_predicted_global, 
  poor_health   = ds_predicted_global
)

# ---- define-coloring-function ----------------
assign_color <- function( d, facet_line ) {
  reference_color <- "#4daf4a" ##7e1a02 # 91777e
  testit::assert("Only one `facet_line` value should be passed.", dplyr::n_distinct(facet_line)==1L)
  variable <- facet_line[1]
  
  # color logic:
  
  # e41a1c - red
  # 377eb8 - blue
  # 4daf4a - green
  # 984ea3 - purplse
  # ff7f00 - organge
  
  increased_risk_2 <- "#e41a1c"  # red - further increased risk factor
  increased_risk_1 <- "#ff7f00"  # organge - increased risk factor
  reference_color <- "#4daf4a"   # green  - REFERENCE  category
  descreased_risk_1 <-"#377eb8"  # blue - descreased risk factor
  descreased_risk_2 <- "#984ea3" # purple - further descrease in risk factor
  
  
  if( variable == "female") {
    # http://colrd.com/image-dna/25114/
    palette_row <- c("TRUE"=reference_color, "FALSE"=increased_risk_1) # 98aab9
  } else if( variable %in% c("educ3", "educ3_f") ) { 
    # http://colrd.com/image-dna/24382/
    palette_row <- c("high school"=reference_color, "less than high school"=increased_risk_1, "more than high school"=descreased_risk_1) # 54a992, e8c571
  } else if( variable %in% c("marital_f") ) {
    # http://colrd.com/image-dna/23318/
    palette_row <- c("mar_cohab"=descreased_risk_1, "sep_divorced"= increased_risk_2, "single"=reference_color, "widowed"=increased_risk_1)
  } else if( variable %in% c("poor_health") ) {
    # http://colrd.com/palette/18841/
    palette_row <- c("FALSE"=reference_color, "TRUE"=descreased_risk_2)
  } else {
    stop("The palette for this variable is not defined.")
  }
  
  d3 <- d[d$facet_line==facet_line, ] %>% 
    dplyr::rename_("iv" = variable)
  
  palette_row[as.character(d3$iv)]
}

assign_prediction <- function( d, study_name ) {
  testit::assert("Only one `study_name` value should be passed.", dplyr::n_distinct(study_name)==1L)
  study_name <- study_name[1]
  
  m <- model_study_list[[study_name]]
  d$dv_hat <- as.numeric(predict(m, newdata=d)) #logged-odds of probability (ie, linear)
  d$dv_hat[d$study_name==study_name]
}

# - generated-replicated-dataset --------------------
ds_replicated <- ds_replicated_observed_list %>% 
  dplyr::bind_rows(.id="facet_line") %>%
  # dplyr::select(facet_line, female, educ3_f, poor_health) %>% # was turned off
  dplyr::group_by(facet_line) %>% 
  dplyr::mutate(
    color_stroke = assign_color(., facet_line)
  ) %>% 
  dplyr::ungroup()
rm(ds_replicated_observed_list)

ds_replicated_predicted <- ds_replicated_predicted_list %>%
  dplyr::bind_rows(.id="facet_line") %>%
  dplyr::select(study_name, facet_line, age_in_years, female, educ3_f, marital_f, poor_health) %>%
  dplyr::group_by(facet_line) %>%
  dplyr::mutate(
    color_stroke     = assign_color(., facet_line)
  ) %>%
  dplyr::ungroup() %>%
  dplyr::group_by(study_name) %>%
  dplyr::mutate(
    dv_hat           = assign_prediction(., study_name)
  ) %>%
  dplyr::ungroup() %>% 
  dplyr::mutate(
    dv_hat_p         = plogis(dv_hat),
    prediction_line  = paste(female, educ3_f, marital_f, poor_health, sep="-")
  )
rm(ds_replicated_predicted_list)

ds_replicated_predicted_global <- ds_replicated_predicted_global_list %>% #This block should be almost identical to the one above.
  dplyr::bind_rows(.id="facet_line") %>%
  # dplyr::select(study_name, facet_line, age_in_years, female, educ3_f, marital_f, poor_health) %>%
  dplyr::mutate(
    # dv_hat           = as.numeric(predict(model_global, newdata=.)), #logged-odds of probability (ie, linear)
    # dv_hat_p         = plogis(dv_hat),
    prediction_line  = paste(female, educ3_f, marital_f, poor_health, sep="-")
  )
rm(ds_replicated_predicted_global_list)

# ---- declare-reference-groups ------------------
reference_group <- c(
  "female"        = TRUE,
  "educ3_f"       = "high school",
  "marital_f"     = "single",
  "poor_health"   = FALSE
)

# ---- replicate-predicted-datasets --------------------
ds_replicated_predicted <- ds_replicated_predicted %>% 
  dplyr::arrange(prediction_line)
ds_replicated_predicted_global <- ds_replicated_predicted_global %>% 
  dplyr::arrange(prediction_line)

ds_replicated_predicted$keep <- NA
ds_replicated_predicted_global$keep <- NA
testit::assert("The two replicated predicted datasets should have the same number of rows.", nrow(ds_replicated_predicted)==nrow(ds_replicated_predicted_global))

for( i in seq_len(nrow(ds_replicated_predicted)) ) {
  if( ds_replicated_predicted$facet_line[i] == "female" ) {
    keep_study  <- #Add more conditions/predictors here
      (ds_replicated_predicted$educ3_f[i]      == reference_group["educ3_f"]) & 
      (ds_replicated_predicted$marital_f[i]    == reference_group["marital_f"]) & 
      (ds_replicated_predicted$poor_health[i]  == reference_group["poor_health"])
    keep_global <- keep_study & (ds_replicated_predicted$female[i]==reference_group["female"])
    
  } else if( ds_replicated_predicted$facet_line[i] == "educ3_f" ) {
    keep_study <- #Add more conditions/predictors here
      (ds_replicated_predicted$female[i]       == reference_group["female"]) & 
      (ds_replicated_predicted$marital_f[i]    == reference_group["marital_f"]) & 
      (ds_replicated_predicted$poor_health[i]  == reference_group["poor_health"])
    keep_global <- keep_study & (ds_replicated_predicted$educ3_f[i]==reference_group["educ3_f"])
      
  } else if( ds_replicated_predicted$facet_line[i] == "marital_f" ) {
    keep_study <- #Add more conditions/predictors here
      (ds_replicated_predicted$female[i]       == reference_group["female"]) & 
      (ds_replicated_predicted$educ3_f[i]      == reference_group["educ3_f"]) & 
      (ds_replicated_predicted$poor_health[i]  == reference_group["poor_health"])
    keep_global <- keep_study & (ds_replicated_predicted$marital_f[i]==reference_group["marital_f"])
  
  } else if( ds_replicated_predicted$facet_line[i] == "poor_health" ) {
    keep_study <- #Add more conditions/predictors here
      (ds_replicated_predicted$female[i]       == reference_group["female"]) & 
      (ds_replicated_predicted$marital_f[i]    == reference_group["marital_f"]) & 
      (ds_replicated_predicted$educ3_f[i]      == reference_group["educ3_f"])
    keep_global <- keep_study & (ds_replicated_predicted$poor_health[i]==reference_group["poor_health"])
    
  } else {
    stop("The facet_line value is not supported (yet).")
  }
  
  ds_replicated_predicted$keep[i] <- keep_study
  ds_replicated_predicted_global$keep[i] <- keep_global
}
ds_replicated_predicted2 <- ds_replicated_predicted[ds_replicated_predicted$keep, ]
ds_replicated_predicted_global2 <- ds_replicated_predicted_global[ds_replicated_predicted_global$keep, ]

# table(ds_replicated_predicted$prediction_line)
# ---- model-plot ------------------
ggplot(ds_replicated, aes(x=age_in_years, y=dv_hat_p, group=prediction_line, color=color_stroke)) +
  # geom_point(aes(y=as.integer(dv), group=NULL), shape=21, position=position_jitter(width=.3, height=.08), size=2, alpha=0.2, na.rm=T) +
  # geom_line(data=ds_replicated_predicted_global2, aes(group=NULL), color="gray60", size=4, alpha=.2, lineend="round") + #linetype="CC"
  geom_line(data=ds_replicated_predicted2, size=1.5, alpha=0.6) +
  # geom_ribbon(data=ds_replicated_predicted2, aes(ymax=dv_upper_p, ymin=dv_lower_p, group=NULL), color="gray80", alpha=.1) +
  geom_ribbon(data=ds_replicated_predicted_global2, aes(ymax=dv_upper_p, ymin=dv_lower_p, group=NULL), color="gray80", alpha=.1) +
  # geom_point(data=ds_replicated_predicted2) +
  scale_y_continuous(label=scales::percent, limits = c(0, .50)) +
  scale_color_identity() +
  facet_grid(facet_line ~ study_name) +
  theme_light() +
  theme(legend.position="none") +
  labs(x="Age", y=dv_label)



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
