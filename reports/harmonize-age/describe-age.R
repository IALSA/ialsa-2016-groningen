# knitr::stitch_rmd(script="./___/___.R", output="./___/___/___.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console 

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
source("./scripts/common-functions.R") # used in multiple reports
source("./scripts/graph-presets.R") # fonts, colors, themes 

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
# 3rd element - list objects with the following elements
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


# ----- view-metadata ---------------------------------------------
# view metadata for the construct of age
dto[["metaData"]] %>%
  dplyr::filter(construct %in% c('age')) %>% 
  dplyr::select(-url, -label, -notes) %>%
  dplyr::arrange(study_name, item) %>%
  base::print()  

# ----- alsa-AGE ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="AGE") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]] %>% histogram_continuous("AGE", bin_width = 1)


# ----- lbsl-AGE94 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="AGE94") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]] %>% histogram_continuous("AGE94", bin_width = 1)

# ----- satsa-QAGE3 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="QAGE3") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]] %>% histogram_continuous("QAGE3", bin_width = 1)

# ----- satsa-YRBORN ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="YRBORN") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]] %>% histogram_continuous("YRBORN", bin_width = 1)


# ----- share-DN0030 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN0030") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]] %>% dplyr::filter(!DN0030==99999) %>% histogram_continuous("DN0030", bin_width=1)


# ----- tilda-AGE ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="AGE") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]] %>% histogram_continuous("AGE", bin_width = 1)



# ---- reproduce ---------------------------------------
rmarkdown::render(input = "./reports/harmonize-age/describe-age.Rmd" ,
                  output_format="html_document", clean=TRUE)


























