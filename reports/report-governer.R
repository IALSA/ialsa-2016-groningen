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









