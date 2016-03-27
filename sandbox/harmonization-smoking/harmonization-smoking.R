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
main_list <- readRDS("./data/unshared/derived/main_list.rds")

# ---- inspect-data -------------------------------------------------------------
# the list is composed of the following elements
names(main_list)
# 1st element - names of the studies as character vector
(studyNames <- main_list[["studyName"]])
# 2nd element - file paths of the data files for each study as character vector
main_list[["filePath"]]
# 3rd element - list objects with the following elements
names(main_list[["unitData"]])
# each of these elements is a raw data set of a corresponding study, for example
dplyr::tbl_df(main_list[["unitData"]][["alsa"]]) 
# 4th element - a dataset names and labels of raw variables + added metadata for all studies
mds <- main_list[["metaData"]]; dplyr::tbl_df(mds)

# ---- tweak-data --------------------------------------------------------------

# ---- basic-table --------------------------------------------------------------

# ---- basic-graph --------------------------------------------------------------


# ----- view-metadata ---------------------------------------------
# view metadata for the construct of smoking
mds_sub <- mds %>%
  dplyr::filter(construct %in% c('smoking')) %>% 
  dplyr::select(-url, -label, -notes, - X) %>%
  dplyr::arrange(study_name, item)
base::print(mds_sub,nrow(mds_sub))  



# ---- get-schema-variables ---------------------------------------------
# pull out the variables from the subsetted metadata
# source("./scripts/common-functions.r")
ds <- load_data_schema(dto=main_list,
                       varname_new="item",
                       construct_name = "smoking")
names(ds)                       

# ----- basic-graphs-alsa ---------------------------------
ds %>% dplyr::filter(study_name == "alsa") %>% histogram_discrete("SMOKER")
ds %>% dplyr::filter(study_name == "alsa") %>% histogram_discrete("PIPCIGAR")
# ----- basic-graphs-lbsl ---------------------------------
ds %>% dplyr::filter(study_name == "lbsl") %>% histogram_discrete("SMK94")
ds %>% dplyr::filter(study_name == "lbsl") %>% histogram_discrete("SMOKE")
# ----- basic-graphs-satsa ---------------------------------
ds %>% dplyr::filter(study_name == "satsa") %>% histogram_discrete("GSMOKNOW")
ds %>% dplyr::filter(study_name == "satsa") %>% histogram_discrete("GEVRSMK")
ds %>% dplyr::filter(study_name == "satsa") %>% histogram_discrete("GEVRSNS")
# ----- basic-graphs-share ---------------------------------
ds %>% dplyr::filter(study_name == "share") %>% histogram_discrete("BR0010")
ds %>% dplyr::filter(study_name == "share") %>% histogram_discrete("BR0020")
ds %>% dplyr::filter(study_name == "share", !BR0030 == 9999) %>% histogram_continuous("BR0030", bin_width = 5)
# ----- basic-graphs-tilda ---------------------------------
ds %>% dplyr::filter(study_name == "tilda") %>% histogram_discrete("BH001")
ds %>% dplyr::filter(study_name == "tilda") %>% histogram_discrete("BH002")
ds %>% dplyr::filter(study_name == "tilda", !BH003 == -1) %>% histogram_continuous("BH003", bin_width = 1)
ds %>% dplyr::filter(study_name == "tilda" ) %>% histogram_discrete("BEHSMOKER")



# ---- reproduce ---------------------------------------
rmarkdown::render(input = "./sandbox/harmonization-smoking/harmonization-smoking.Rmd" ,
                  output_format="html_document", clean=TRUE)


























