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
dto <- main_list
# ---- tweak-data --------------------------------------------------------------

# ---- basic-table --------------------------------------------------------------

# ---- basic-graph --------------------------------------------------------------


# ----- view-metadata ---------------------------------------------
# function to pull out the name meta data before graph


# view metadata for the construct of smoking
mds_sub <- mds %>%
  dplyr::filter(construct %in% c('smoking')) %>% 
  dplyr::select(-url, -label, -notes, - X) %>%
  dplyr::arrange(study_name, item)
base::print(mds_sub,nrow(mds_sub))  





# ----- alsa-SMOKER ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="SMOKER") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]] %>% histogram_discrete("SMOKER")


# ----- alsa-PIPCIGAR ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="PIPCIGAR") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]] %>% histogram_discrete("PIPCIGAR")

# ----- lbsl-SMK94 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="SMK94") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]] %>% histogram_discrete("SMK94")
# ----- lbsl-SMOKE ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="SMOKE") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]] %>% histogram_discrete("SMOKE")


# ----- satsa-GSMOKNOW ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GSMOKNOW") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]] %>% histogram_discrete("GSMOKNOW")
# ----- satsa-GEVRSMK ---------------------------------

dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GEVRSMK") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]] %>% histogram_discrete("GEVRSMK")
# ----- satsa-GEVRSNS ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GEVRSNS") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]] %>% histogram_discrete("GEVRSNS")


# ----- share-BR0010 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0010") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]] %>% histogram_discrete("BR0010")

# ----- share-BR0020 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0020") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]] %>% histogram_discrete("BR0020")

# ----- share-BR0030 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0030") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]] %>% dplyr::filter(!BR0030 == 9999) %>% histogram_continuous("BR0030", bin_width = 5)


# ----- tilda-BH001 ---------------------------------
ds %>% dplyr::filter(study_name == "tilda") %>% histogram_discrete("BH001")
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="BH001") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]] %>% histogram_discrete("BH001")
# ----- tilda-BH002 ---------------------------------
ds %>% dplyr::filter(study_name == "tilda") %>% histogram_discrete("BH002")
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="BH002") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]] %>% histogram_discrete("BH002")
# ----- tilda-BH003 ---------------------------------
ds %>% dplyr::filter(study_name == "tilda", !BH003 == -1) %>% histogram_continuous("BH003", bin_width = 1)
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="BH003") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]] %>% dplyr::filter(!BH003==-1) %>% histogram_continuous("BH003")
# ----- tilda-BEHSMOKER ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="BEHSMOKER") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]] %>% histogram_discrete("BEHSMOKER")



# ---- reproduce ---------------------------------------
rmarkdown::render(input = "./sandbox/harmonization-smoking/harmonization-smoking-basic-graphs.Rmd" ,
                  output_format="html_document", clean=TRUE)


























