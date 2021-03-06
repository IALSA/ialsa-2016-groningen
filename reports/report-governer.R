# Reporduction note: always start with nothing but raw files

# Ellis Island
knitr::stitch_rmd(
  script="./manipulation/0-ellis-island.R", 
  output="./manipulation/stitched-output/0-ellis-island.md"
)

# the following reports will create descriptive statistics and graphs for all variables over studies
# no real need reproducing them all the time, won't change unless the raw data objects change
# however, if you need to add exprlorative displays to a variable then re-run 
# ----- define-reports-to-build ----------------------
pathsDescribe <- c(
   # "meta"      = "./reports/view-meta-data/view-meta-data.Rmd" 
   #,"smoking"   = "./reports/harmonize-smoking/describe-smoking.Rmd"
   #,"age"       = "./reports/harmonize-age/describe-age.Rmd"
   #,"sex"       = "./reports/harmonize-sex/describe-sex.Rmd"
   #,"marital"   = "./reports/harmonize-marital/describe-marital.Rmd"
   #,"education" = "./reports/harmonize-education/describe-education.Rmd"
   #,"work"      = "./reports/harmonize-work/describe-work.Rmd"
   #,"alcohol"   = "./reports/harmonize-alcohol/describe-alcohol.Rmd"
   #,"physact"   = "./reports/harmonize-physact/describe-physact.Rmd"
   #,"health"    = "./reports/harmonize-health/describe-health.Rmd"
   #,"physique"  = "./reports/harmonize-physique/describe-physique.Rmd"
)

----- build-reports -------------------------------------------------------
for( pathRmd in pathsDescribe ) {
  rmarkdown::render(
    input = pathRmd,
    output_format = "html_document",
    clean = TRUE)
}

# the following reports will take original datasets and combine them into a harmonized data object
# The reports merely describe the transformations that underlying script accomplish with datasets
# You need to execute them, in order to produce harmonized dataset to be used for modelling
# WARNING: recreate H-reports ONLY after re-creating the dto by Ellis Island, otherwise breaks
pathsHarmonize <- c(
     "smoking"   = "./reports/harmonize-smoking/harmonize-smoking.Rmd" 
   , "age"       = "./reports/harmonize-age/harmonize-age.Rmd"
   , "sex"       = "./reports/harmonize-sex/harmonize-sex.Rmd"
   , "marital"   = "./reports/harmonize-marital/harmonize-marital.Rmd"
   , "education" = "./reports/harmonize-education/harmonize-education.Rmd"
   , "work"      = "./reports/harmonize-work/harmonize-work.Rmd"
   , "alcohol"   = "./reports/harmonize-alcohol/harmonize-alcohol.Rmd"
   , "physact"   = "./reports/harmonize-physact/harmonize-physact.Rmd"
   , "health"    = "./reports/harmonize-health/harmonize-health.Rmd"
   , "physique"  = "./reports/harmonize-physique/harmonize-physique.Rmd"
   , "harmonized"= "./reports/harmonized-data/harmonized-data.Rmd"
)

# Build the reports -------------------------------------------------------
for( pathRmd in pathsHarmonize ) { 
   rmarkdown::render( 
     input = pathRmd,
     output_format = "html_document",
     clean = TRUE) 
} 

# save a copy of the harmonized dataset  
temp <- readRDS("./data/unshared/derived/dto.rds") # dynamic object, built in stages
saveRDS(temp, "./data/unshared/derived/dto_h.rds") # static object, needed stages

### This marks the check-point: harmonized dataset  has been created

pathModels <- c(
  # "starter"   = "./sandbox/visualizing-logistic/visualizing-logistic.Rmd"
  # "easy"   = "./sandbox/visualizing-logistic/visualizing-logistic-easy.Rmd",

  # "poor_health_smoke_now_points" = "./models/poor_health/smoke_now-points.Rmd",
  # "poor_health_smoke_now_curves" = "./models/poor_health/smoke_now-curves.Rmd",
  # "poor_health_smoked_ever_points" = "./models/poor_health/smoked_ever-points.Rmd",
  # "poor_health_smoked_ever_curves" = "./models/poor_health/smoked_ever-curves.Rmd"
  # 
  # "poor_health_smoke_now_points-cb" = "./models/poor_health/smoke_now-points-coloring-book.Rmd"
  # "model overivew" = "./models/summaries/model-summaries.Rmd"
  # "exercise report" = "./models/exercise-report/exercise-report.Rmd"
  # "best subset" = "./models/best-subset/best-subset.Rmd"
  # "detailed models" = "./models/exercise-report-2/detailed-model-report.Rmd"
  # "exercise report" = "./models/exercise-report-2/exercise-report.Rmd"
  # "compare N" = "./sandbox/2016-05-12/compare-N-across-teams.Rmd"
  "exercise report" = "./models/exercise-report-3/exercise-report.Rmd"
)


# Build the reports -------------------------------------------------------
for( pathRmd in pathModels ) { 
  rmarkdown::render( 
    input = pathRmd,
    output_format = "html_document",
    clean = TRUE) 
} 



# ----- published-reports -----------------------
pathPublish <- c(
  "focus-predictors" = "./models/exercise-report-3/predictors-in-focus.Rmd"
)
publishFormats <- c(
   "html_document"
  , "word_document" 
  ,"pdf_document"
  )
for( pathRmd in pathPublish ) { 
  for(pub_format in publishFormats){
    rmarkdown::render( 
      input = pathRmd,
      output_format = pub_format,
      clean = TRUE)   
  }
  
} 




