loadNamespace("readr")

# Ellis Island
knitr::stitch_rmd(
  script="./manipulation/0-ellis-island.R", 
  output="./manipulation/stitched-output/0-ellis-island.md"
)

# ----- define-reports-to-build ----------------------
pathsDescribe <- c(
   # "meta"      = "./reports/view-meta-data/view-meta-data.Rmd" 
  # "smoking"   = "./reports/harmonize-smoking/describe-smoking.Rmd"
   # "age"       = "./reports/harmonize-age/describe-age.Rmd"
   # "sex"       = "./reports/harmonize-sex/describe-sex.Rmd"
   # "marital"   = "./reports/harmonize-marital/describe-marital.Rmd"
   # "education" = "./reports/harmonize-education/describe-education.Rmd"
   # "work"      = "./reports/harmonize-work/describe-work.Rmd"
   # "alcohol"   = "./reports/harmonize-alcohol/describe-alcohol.Rmd"
   # "physact"   = "./reports/harmonize-physact/describe-physact.Rmd"
   # "health"    = "./reports/harmonize-health/describe-health.Rmd"
   # "physique"  = "./reports/harmonize-physique/describe-physique.Rmd"
)

----- build-reports -------------------------------------------------------
for( pathRmd in pathsDescribe ) {
  rmarkdown::render(
    input = pathRmd,
    output_format = "html_document",
    clean = TRUE)
}


# WARNING: recreate H-reports ONLY after re-creating the dto by Ellis Island
pathsHarmonize <- c(
    "smoking"   = "./reports/harmonize-smoking/harmonize-smoking.Rmd" 
   ,  "age"       = "./reports/harmonize-age/harmonize-age.Rmd"
   ,  "sex"       = "./reports/harmonize-sex/harmonize-sex.Rmd"
   ,  "marital"   = "./reports/harmonize-marital/harmonize-marital.Rmd"
   ,  "education" = "./reports/harmonize-education/harmonize-education.Rmd"
   ,  "work"      = "./reports/harmonize-work/harmonize-work.Rmd"
   ,  "alcohol"   = "./reports/harmonize-alcohol/harmonize-alcohol.Rmd"
   ,  "physact"   = "./reports/harmonize-physact/harmonize-physact.Rmd"
   ,  "health"    = "./reports/harmonize-health/harmonize-health.Rmd"
   ,  "physique"  = "./reports/harmonize-physique/harmonize-physique.Rmd"
   , "harmonized"= "./reports/harmonized-data/harmonized-data.Rmd"
)
# once the file is created, it is manually renamed into dto_h.rds  



# Build the reports -------------------------------------------------------
for( pathRmd in pathsHarmonize ) { 
   rmarkdown::render( 
     input = pathRmd,
     output_format = "html_document",
     clean = TRUE) 
} 

# save a copy of the harmonized dataset  
temp <- readRDS("./data/unshared/derived/dto.rds")
saveRDS(temp, "./data/unshared/derived/dto_h.rds")

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
  "compare N" = "./sandbox/2016-05-12/compare-N-across-teams.Rmd"
)


# Build the reports -------------------------------------------------------
for( pathRmd in pathModels ) { 
  rmarkdown::render( 
    input = pathRmd,
    output_format = "html_document",
    clean = TRUE) 
} 

# Compile Models
knitr::stitch_rmd(
  script="./models/exercise-report-2/compile-models.R", 
  output="./models/exercise-report-2/stitched-output/compile-models.md"
)




