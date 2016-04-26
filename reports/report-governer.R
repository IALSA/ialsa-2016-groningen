# Ellis Island
knitr::stitch_rmd(
  script="./manipulation/0-ellis-island.R", 
  output="./manipulation/stitched-output/0-ellis-island.md"
)


pathsDescribe <- c(
    "meta"      = "./reports/view-meta-data/view-meta-data.Rmd" 
  , "smoking"   = "./reports/harmonize-smoking/harmonize-smoking.Rmd"
  , "age"       = "./reports/harmonize-age/harmonize-age.Rmd"
  , "sex"       = "./reports/harmonize-sex/harmonize-sex.Rmd"
  , "marital"   = "./reports/harmonize-marita/harmonize-marital.Rmd"
  , "education" = "./reports/harmonize-education/harmonize-education.Rmd"
  , "work"      = "./reports/harmonize-work/harmonize-work.Rmd"
  , "alcohol"   = "./reports/harmonize-alcohol/harmonize-alcohol.Rmd"
  , "physact"   = "./reports/harmonize-physact/harmonize-physact.Rmd"
  , "health"    = "./reports/harmonize-health/harmonize-health.Rmd"
  , "physique"  = "./reports/harmonize-physique/harmonize-physique.Rmd"
)

# Build the reports -------------------------------------------------------
# for( pathRmd in pathsDescribe ) { 
#   rmarkdown::render( 
#     input = pathRmd,
#     output_format = "html_document",
#     clean = TRUE) 
# } 



pathsHarmonize <- c(
    "harmonized"= "./reports/harmonized-data/harmonized-data.Rmd"
  , "smoking"   = "./reports/harmonize-smoking/harmonize-smoking.Rmd"
  , "age"       = "./reports/harmonize-age/harmonize-age.Rmd"
  , "sex"       = "./reports/harmonize-sex/harmonize-sex.Rmd"
  , "marital"   = "./reports/harmonize-marital/harmonize-marital.Rmd"
  , "education" = "./reports/harmonize-education/harmonize-education.Rmd"
  , "work"      = "./reports/harmonize-work/harmonize-work.Rmd"
  , "alcohol"   = "./reports/harmonize-alcohol/harmonize-alcohol.Rmd"
  , "physact"   = "./reports/harmonize-physact/harmonize-physact.Rmd"
  , "health"    = "./reports/harmonize-health/harmonize-health.Rmd"
  , "physique"  = "./reports/harmonize-physique/harmonize-physique.Rmd"
 
)
  

# Build the reports -------------------------------------------------------
for( pathRmd in pathsHarmonize ) { 
   rmarkdown::render( 
     input = pathRmd,
     output_format = "html_document",
     clean = TRUE) 
} 


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
  "exercise report" = "./models/exercise-report/exercise-report.Rmd"
)


# Build the reports -------------------------------------------------------
for( pathRmd in pathModels ) { 
  rmarkdown::render( 
    input = pathRmd,
    output_format = "html_document",
    clean = TRUE) 
} 




