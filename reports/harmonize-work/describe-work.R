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
  dplyr::filter(construct %in% c('work_status')) %>% 
  dplyr::select(-url, -label, -notes) %>%
  dplyr::arrange(study_name, item) %>%
  base::print()  

# ----- alsa-RETIRED ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="RETIRED") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>% histogram_discrete("RETIRED")
dto[["unitData"]][["alsa"]]%>% dplyr::group_by_("RETIRED") %>% dplyr::summarize(n=n())

# ----- alsa-CURRWORK ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="CURRWORK") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>% histogram_discrete("CURRWORK")
dto[["unitData"]][["alsa"]]%>% dplyr::group_by_("CURRWORK") %>% dplyr::summarize(n=n())


# ----- lbsl-NOWRK94 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="EDUC94") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>% histogram_discrete("EDUC94")
dto[["unitData"]][["lbsl"]]%>% dplyr::group_by_("EDUC94") %>% dplyr::summarize(n=n())

# ----- satsa-GAMTWORK ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GAMTWORK") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("GAMTWORK")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GAMTWORK") %>% dplyr::summarize(n=n())

# ----- share-EP0050 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="EP0050") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("EP0050")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("EP0050") %>% dplyr::summarize(n=n())


# ----- tilda-WE001 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="WE001") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% histogram_discrete("WE001")
dto[["unitData"]][["tilda"]]%>% dplyr::group_by_("WE001") %>% dplyr::summarize(n=n())

# ----- tilda-WE003 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="WE003") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% histogram_discrete("WE003")
dto[["unitData"]][["tilda"]]%>% dplyr::group_by_("WE003") %>% dplyr::summarize(n=n())


# ---- reproduce ---------------------------------------
rmarkdown::render(
          input = "./reports/harmonize-work/describe-work.Rmd",
  output_format = "html_document", 
          clean = TRUE
)


























