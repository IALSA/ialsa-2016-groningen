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
(studyNames <- dto[["studyName"]])
# 2nd element - file paths of the data files for each study as character vector
dto[["filePath"]]
# 3rd element - list objects with the following elements
names(dto[["unitData"]])
# each of these elements is a raw data set of a corresponding study, for example
dplyr::tbl_df(dto[["unitData"]][["alsa"]]) 
# 4th element - a dataset names and labels of raw variables + added metadata for all studies
mds <- dto[["metaData"]]; dplyr::tbl_df(mds)

# ---- tweak-data --------------------------------------------------------------

# ---- basic-table --------------------------------------------------------------

# ---- basic-graph --------------------------------------------------------------
# this is how we can interact with the `dto` to call and graph data and metadata
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0030") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]] %>% dplyr::filter(!BR0030==9999) %>% histogram_continuous("BR0030", bin_width=5)


# ----- view-metadata ---------------------------------------------
# function to pull out the name meta data before graph


# view metadata for the construct of smoking
mds_sub <- mds %>%
  dplyr::filter(construct %in% c('smoking')) %>% 
  dplyr::select(-url, -label, -notes, - X) %>%
  dplyr::arrange(study_name, item)
base::print(mds_sub,nrow(mds_sub))  

# now, let's focus on the variables we suspect will be included into data schema for smoking
mds_sub <- mds %>%
  dplyr::filter(construct %in% c('smoking')) %>% 
  # dplyr::filter(     item %in% c("smoke_now")) %>%
  dplyr::select(study_name, name, item, label_short, -categories) %>%
  dplyr::arrange(item, study_name)
base::print(mds_sub,nrow(mds_sub))

# ---- recode-smoke_now ----------------------------


# ---- get-schema-variables ---------------------------------------------
# pull out the variables from the subsetted metadata
# source("./scripts/common-functions.r")
ds <- load_data_schema(dto=dto,
                       varname_new="item",
                       construct_name = "smoking")
names(ds)               



dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0030") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]] %>% dplyr::filter(!BR0030==9999) %>% histogram_continuous("BR0030", bin_width=5)




# ---- reproduce ---------------------------------------
rmarkdown::render(input = "./sandbox/harmonization-smoking/harmonization-smoking.Rmd" ,
                  output_format="html_document", clean=TRUE)


























