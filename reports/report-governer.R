knitr::stitch_rmd(
  script="./manipulation/0-ellis-island.R", 
  output="./manipulation/stitched-output/0-ellis-island.md"
)

# Meta data dynamic tables
rmarkdown::render(
  input = "./reports/view-meta-data/view-meta-data.Rmd" ,
  output_format="html_document", clean=TRUE
)

# Smoking
# Describe
rmarkdown::render(
  input = "./reports/harmonize-smoking/describe-smoking.Rmd" ,
  output_format="html_document", clean=TRUE
)
# Harmonize
rmarkdown::render(
  input = "./reports/harmonize-smoking/harmonize-smoking.Rmd" ,
  output_format="html_document", clean=TRUE
)



# Age
# Describe
rmarkdown::render(
  input = "./reports/harmonize-age/describe-age.Rmd" ,
  output_format="html_document", clean=TRUE
)
# Harmonize
rmarkdown::render(
  input = "./reports/harmonize-age/harmonize-age.Rmd" ,
  output_format="html_document", clean=TRUE
)


# Sex
# Describe
rmarkdown::render(
  input = "./reports/harmonize-sex/describe-sex.Rmd" ,
  output_format="html_document", clean=TRUE
)
# Harmonize
rmarkdown::render(
  input = "./reports/harmonize-sex/harmonize-sex.Rmd" ,
  output_format="html_document", clean=TRUE
)


