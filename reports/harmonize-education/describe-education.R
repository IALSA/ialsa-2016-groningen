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
  dplyr::filter(construct %in% c('education')) %>% 
  dplyr::select(-url, -label, -notes) %>%
  dplyr::arrange(study_name, item) %>%
  base::print()  

# ----- alsa-SCHOOL ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="SCHOOL") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>% histogram_discrete("SCHOOL")
dto[["unitData"]][["alsa"]]%>% dplyr::group_by_("SCHOOL") %>% dplyr::summarize(n=n())

# ----- alsa-TYPQUAL ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="TYPQUAL") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>% histogram_discrete("TYPQUAL")
dto[["unitData"]][["alsa"]]%>% dplyr::group_by_("TYPQUAL") %>% dplyr::summarize(n=n())


# ----- lbsl-EDUC94 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="EDUC94") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>% histogram_discrete("EDUC94")
dto[["unitData"]][["lbsl"]]%>% dplyr::group_by_("EDUC94") %>% dplyr::summarize(n=n())

# ----- satsa-EDUC ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="EDUC") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("EDUC")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("EDUC") %>% dplyr::summarize(n=n())



# ----- share-DN012D01 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN012D01") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("DN012D01")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("DN012D01") %>% dplyr::summarize(n=n())

# ----- share-DN012D02 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN012D02") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("DN012D02")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("DN012D02") %>% dplyr::summarize(n=n())

# ----- share-DN012D03 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN012D03") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("DN012D03")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("DN012D03") %>% dplyr::summarize(n=n())

# ----- share-DN012D04 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN012D04") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("DN012D04")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("DN012D04") %>% dplyr::summarize(n=n())

# ----- share-DN012D05 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN012D05") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("DN012D05")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("DN012D05") %>% dplyr::summarize(n=n())

# ----- share-DN012D09 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN012D09") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("DN012D09")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("DN012D09") %>% dplyr::summarize(n=n())

# ----- share-DN012DNO ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN012DNO") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("DN012DNO")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("DN012DNO") %>% dplyr::summarize(n=n())

# ----- share-DN012DOT ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN012DOT") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("DN012DOT")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("DN012DOT") %>% dplyr::summarize(n=n())

# ----- share-DN012DRF ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN012DRF") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("DN012DRF")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("DN012DRF") %>% dplyr::summarize(n=n())

# ----- share-DN012DDK ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN012DDK") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("DN012DDK")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("DN012DDK") %>% dplyr::summarize(n=n())

# ----- share-DN0100 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="DN0100") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("DN0100")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("DN0100") %>% dplyr::summarize(n=n())

# ----- tilda-DM001 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="DM001") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% histogram_discrete("DM001")
dto[["unitData"]][["tilda"]]%>% dplyr::group_by_("DM001") %>% dplyr::summarize(n=n())


# ---- reproduce ---------------------------------------
rmarkdown::render(
          input = "./reports/harmonize-education/describe-education.Rmd",
  output_format = "html_document", 
          clean = TRUE
)


























