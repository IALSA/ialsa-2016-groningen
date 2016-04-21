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
possible_x <- seq.int(0, 150, 10)


# ---- load-data ---------------------------------------------------------------
# load the product of 0-ellis-island.R,  a list object containing data and metadata
dto <- readRDS("./data/unshared/derived/dto.rds")

# ---- tweak-data --------------------------------------------------------------

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

ds <- dplyr::bind_rows(dmls, .id = "study_name")
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
ds %>% dplyr::glimpse()


# ---- create-fake-data-for-miechv-proposal ------------------------------------
ds <- ds %>% 
  dplyr::filter(
    study_name != "share"
  ) %>% 
  dplyr::mutate(
    age_in_years     = pmax(0, age_in_years-60)*150/40   ,
    # study_name       = droplevels.factor(study_name, "share")
    study_name       = factor(study_name, labels=c("Clinic 1", "Clinic 2", "Clinic 3", "Clinic 4"))
  )

summary(ds$age_in_years)

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

reference_group <- c(
  "female"        = TRUE,
  "educ3_f"       = "high school",
  "marital_f"     = "single",
  "poor_health"   = FALSE
)


# ---- model-specification -------------------------
# eq <- as.formula(paste0("dv ~ -1 + age_in_years + female + educ3_f + poor_health + marital_f"))
eq_string <- paste0("dv ~ -1 + ",time_scale, " + ", control_covar, " + ", focal_covar)
eq <- as.formula(eq_string)
model_global <- glm(eq, data = ds2, family = binomial(link="logit")) 
summary(model_global)

# ---- compute-predicted-global ------------------------------
ds2$dv_p <- predict(model_global)

ds_predicted_global <- expand.grid(
  study_name       = sort(unique(ds2$study_name)), #For the sake of repeating the same global line in all studies/panels in the facetted graphs
  age_in_years     = possible_x,
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

ds_predicted_global %>% dplyr::glimpse()
head(ds_predicted_global)

# ---- compute-predicted-study ------------------------
ds_predicted_study_list <- list()
model_study_list <- list()
for( study_name_ in sort(unique(ds2$study_name)) ) {
  d_study <- ds2[ds2$study_name==study_name_, ]
  model_study <- glm(eq, data=d_study,  family=binomial(link="logit")) 
  model_study_list[[study_name_]] <- model_study
  
  d_predicted <- expand.grid(
    age_in_years     = possible_x,
    female           = sort(unique(ds2$female)),
    educ3_f          = sort(unique(ds2$educ3_f)),
    marital_f        = sort(unique(ds2$marital_f)),
    poor_health      = sort(unique(ds2$poor_health)),
    stringsAsFactors = FALSE
  ) 
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

ds_predicted_study %>% dplyr::glimpse()
head(ds_predicted_study)

# ---- define-replication-structure -----------------

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
  increased_risk_2 <- "#e41a1c"  # red - further increased risk factor
  increased_risk_1 <- "#ff7f00"  # organge - increased risk factor
  reference_color <- "#4daf4a"   # green  - REFERENCE  category
  descreased_risk_1 <-"#377eb8"  # blue - descreased risk factor
  descreased_risk_2 <- "#984ea3" # purple - further descrease in risk factor
  
  if( variable == "female") {
    palette_row <- c("TRUE"=reference_color, "FALSE"=increased_risk_1) # 98aab9
  } else if( variable %in% c("educ3", "educ3_f") ) { 
    palette_row <- c("high school"=reference_color, "less than high school"=increased_risk_1, "more than high school"=descreased_risk_1) # 54a992, e8c571
  } else if( variable %in% c("marital_f") ) {
    palette_row <- c("mar_cohab"=descreased_risk_1, "sep_divorced"= increased_risk_2, "single"=reference_color, "widowed"=increased_risk_1)
  } else if( variable %in% c("poor_health") ) {
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

# ---- replicated-predicted-global --------------------
ds_replicated <- ds_replicated_observed_list %>% 
  dplyr::bind_rows(.id="facet_line") %>%
  # dplyr::select(facet_line, female, educ3_f, poor_health) %>% # was turned off
  dplyr::group_by(facet_line) %>% 
  dplyr::mutate(
    color_stroke     = assign_color(., facet_line)
  ) %>% 
  dplyr::ungroup() %>% 
  dplyr::mutate(
    facet_line       = ordered(
      facet_line, 
      levels=c("female", "educ3_f", "marital_f", "poor_health")#, 
      # labels=c("female", "education", "marital", "poor health")
    )
  )
rm(ds_replicated_observed_list)

ds_replicated_predicted <- ds_replicated_predicted_list %>%
  dplyr::bind_rows(.id="facet_line") %>%
  dplyr::select(study_name, facet_line, age_in_years, female, educ3_f, marital_f, poor_health) %>%
  dplyr::group_by(facet_line) %>%
  dplyr::mutate(
    color_stroke     = assign_color(., facet_line)
  ) %>% 
  dplyr::ungroup() %>% 
  dplyr::mutate(
    facet_line       = ordered(
      facet_line, 
      levels=c("female", "educ3_f", "marital_f", "poor_health")#, 
      # labels=c("female", "education", "marital", "poor health")
    )
  ) %>% 
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

# ---- replicated-predicted-local --------------------
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

# ---- model-plot ------------------

ds_replicated$facet_line <- ordered(ds_replicated$facet_line, labels=c("Gender", "Education", "Marriage", "Health"))
ds_replicated_predicted2$facet_line <- ordered(ds_replicated_predicted2$facet_line, labels=c("Gender", "Education", "Marriage", "Health"))
ds_replicated_predicted_global2$facet_line <- ordered(ds_replicated_predicted_global2$facet_line, labels=c("Gender", "Education", "Marriage", "Health"))

graph_logistic_main <- function( ){
  # [sample(x=nrow(ds_replicated), size=1000), ]
 ggplot(ds_replicated, aes(x=age_in_years, y=dv_hat_p, group=prediction_line, color=color_stroke)) +
    # geom_point(aes(y=as.integer(dv), group=NULL), shape=21, position=position_jitter(width=.3, height=.08), size=2, alpha=0.2, na.rm=T) +
    # geom_line(data=ds_replicated_predicted_global2, aes(group=NULL), color="gray60", size=4, alpha=.2, lineend="round") + #linetype="CC"
    geom_line(data=ds_replicated_predicted2, size=1.5, alpha=0.6) +
    # geom_ribbon(data=ds_replicated_predicted2, aes(ymax=dv_upper_p, ymin=dv_lower_p, group=NULL), color="gray80", alpha=.1) +
    geom_ribbon(data=ds_replicated_predicted_global2, aes(ymax=dv_upper_p, ymin=dv_lower_p, group=NULL), color="gray80", alpha=.1) +
    # geom_point(data=ds_replicated_predicted2) +
    scale_y_continuous(label=scales::percent) +
    scale_color_identity() +
    coord_cartesian(xlim=c(0, 100), ylim = c(0, .25)) + 
    facet_grid(facet_line ~ study_name) +
    theme_light() +
    theme(legend.position="none") +
    labs(x="Duration (days)", y="P(Undesirable Outcome)", title="Risk by Clinic Location (columns) and by Subject Characteristics (rows)")
}
graph_logistic_main()
ggsave("miechv-example.png", width=7, height=7, units="in", dpi=400)
