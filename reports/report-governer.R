# Ellis Island
knitr::stitch_rmd(
  script="./manipulation/0-ellis-island.R", 
  output="./manipulation/stitched-output/0-ellis-island.md"
)

# # Meta data dynamic tables
# rmarkdown::render(
#   input = "./reports/view-meta-data/view-meta-data.Rmd" ,
#   output_format="html_document", clean=TRUE
# )


# Smoking
# Describe (prelude)
# rmarkdown::render(
#   input = "./reports/harmonize-smoking/describe-smoking.Rmd" ,
#   output_format="html_document", clean=TRUE
# )
# Harmonize (sonata)
rmarkdown::render(
  input = "./reports/harmonize-smoking/harmonize-smoking.Rmd" ,
  output_format="html_document", clean=TRUE
)


# Age
# Describe (prelude)
# rmarkdown::render(
#   input = "./reports/harmonize-age/describe-age.Rmd" ,
#   output_format="html_document", clean=TRUE
# )
# Harmonize (sonata)
rmarkdown::render(
  input = "./reports/harmonize-age/harmonize-age.Rmd" ,
  output_format="html_document", clean=TRUE
)


# Sex
# Describe (prelude)
# rmarkdown::render(
#   input = "./reports/harmonize-sex/describe-sex.Rmd" ,
#   output_format="html_document", clean=TRUE
# )
# Harmonize (sonata)
rmarkdown::render(
  input = "./reports/harmonize-sex/harmonize-sex.Rmd" ,
  output_format="html_document", clean=TRUE
)


# Marital
# Describe (prelude) 
# rmarkdown::render(
#   input = "./reports/harmonize-marital/describe-marital.Rmd",
#   output_format = "html_document",
#   clean = TRUE
# )
# Harmonize (sonata)
rmarkdown::render(
  input = "./reports/harmonize-marital/harmonize-marital.Rmd",
  output_format = "html_document", 
  clean = TRUE
)



rmarkdown::render(
  input = "./reports/harmonized-data/harmonized-data.Rmd" , 
  output_format="html_document", clean=TRUE
)



##### unverified harmonizations below #####
# 
# # Education
# # Describe (prelude) 
# # ---- reproduce ---------------------------------------
# rmarkdown::render(
#   input = "./reports/harmonize-education/describe-education.Rmd" ,
#   output_format="html_document", clean=TRUE
# )
# # Harmonize (sonata)
# rmarkdown::render(
#   input = "./reports/harmonize-education/harmonize-education.Rmd" ,
#   output_format="html_document", clean=TRUE
# )
# 
# 
# # Work status
# # Describe (prelude) 
# rmarkdown::render( 
#   input = "./reports/harmonize-work/describe-work.Rmd",
#   output_format = "html_document", 
#   clean = TRUE
# )
# # # Harmonize (sonata)
# # rmarkdown::render(
# #   input = "./reports/harmonize-work/harmonize-work.Rmd",
# #   output_format = "html_document", 
# #   clean = TRUE
# # )
# 
# 
# 
# # Alcohol
# # Describe (prelude) 
# rmarkdown::render(
#   input = "./reports/harmonize-alcohol/describe-alcohol.Rmd",
#   output_format = "html_document", 
#   clean = TRUE
# )
# # Harmonize (sonata)
# # rmarkdown::render(
# #   input = "./reports/harmonize-alcohol/harmonize-alcohol.Rmd",
# #   output_format = "html_document", 
# #   clean = TRUE
# # )
# 
# 
# # Physical activity
# # Describe (prelude) 
# rmarkdown::render(
#   input = "./reports/harmonize-physact/describe-physact.Rmd",
#   output_format = "html_document", 
#   clean = TRUE
# )
# 
# 
# # Health
# # Describe (prelude) 
# rmarkdown::render(
#   input = "./reports/harmonize-health/describe-health.Rmd",
#   output_format = "html_document", 
#   clean = TRUE
# )
# 
# 
# # Physique
# # Describe (prelude) 
# rmarkdown::render(
#   input = "./reports/harmonize-physique/describe-physique.Rmd",
#   output_format = "html_document", 
#   clean = TRUE
# )
# 
# 




