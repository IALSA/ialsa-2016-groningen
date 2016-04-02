knitr::stitch_rmd(
  script="./manipulation/0-ellis-island.R", 
  output="./manipulation/stitched-output/0-ellis-island.md"
)

rmarkdown::render(
  input = "./reports/harmonization-smoking/harmonization-smoking.Rmd" ,
  output_format="html_document", clean=TRUE
)


rmarkdown::render(
  input = "./reports/harmonization-smoking/harmonization-smoking-basic-graphs.Rmd" ,
  output_format="html_document", clean=TRUE
)

rmarkdown::render(
  input = "./reports/harmonization-age/harmonization-age-basic-graphs.Rmd" ,
  output_format="html_document", clean=TRUE
)




