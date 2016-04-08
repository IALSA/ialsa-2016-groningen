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
seeitems <- dto[["metaData"]] %>%
  dplyr::filter(construct %in% c('health')) %>% 
  dplyr::select(-item, -url, -label, -notes, -construct, -type, -categories) %>%
  dplyr::arrange(study_name, name) %>%
  base::print()  
seeitems #%>% dplyr::select(-label_short)

# ----- alsa-BTSM12MN ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="alsa", name=="BTSM12MN")%>%dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>%histogram_discrete("BTSM12MN")
dto[["unitData"]][["alsa"]]%>%dplyr::group_by_("BTSM12MN")%>%dplyr::summarize(n=n())

# ----- alsa-HLTHBTSM ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="HLTHBTSM") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>% histogram_discrete("HLTHBTSM")
dto[["unitData"]][["alsa"]]%>% dplyr::group_by_("HLTHBTSM") %>% dplyr::summarize(n=n())

# ----- alsa-HLTHLIFE ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="HLTHLIFE") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>% histogram_discrete("HLTHLIFE")
dto[["unitData"]][["alsa"]]%>% dplyr::group_by_("HLTHLIFE") %>% dplyr::summarize(n=n())




# ----- lbsl-SRHEALTH ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="lbsl", name=="SRHEALTH")%>%dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>%histogram_discrete("SRHEALTH")
dto[["unitData"]][["lbsl"]]%>%dplyr::group_by_("SRHEALTH")%>%dplyr::summarize(n=n())




# ----- satsa-GGENHLTH ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="satsa", name=="GGENHLTH")%>%dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>%histogram_discrete("GGENHLTH")
dto[["unitData"]][["satsa"]]%>%dplyr::group_by_("GGENHLTH")%>%dplyr::summarize(n=n())

# ----- satsa-GHLTHOTH ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="satsa", name=="GHLTHOTH")%>%dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>%histogram_discrete("GHLTHOTH")
dto[["unitData"]][["satsa"]]%>%dplyr::group_by_("GHLTHOTH")%>%dplyr::summarize(n=n())




# ----- share-PH0020 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="share", name=="PH0020")%>%dplyr::select(name,label)
dto[["unitData"]][["share"]]%>%histogram_discrete("PH0020")
dto[["unitData"]][["share"]]%>%dplyr::group_by_("PH0020")%>%dplyr::summarize(n=n())

# ----- share-PH0030 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="share", name=="PH0030")%>%dplyr::select(name,label)
dto[["unitData"]][["share"]]%>%histogram_discrete("PH0030")
dto[["unitData"]][["share"]]%>%dplyr::group_by_("PH0030")%>%dplyr::summarize(n=n())

# ----- share-PH0520 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="share", name=="PH0520")%>%dplyr::select(name,label)
dto[["unitData"]][["share"]]%>%histogram_discrete("PH0520")
dto[["unitData"]][["share"]]%>%dplyr::group_by_("PH0520")%>%dplyr::summarize(n=n())

# ----- share-PH0530 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="share", name=="PH0530")%>%dplyr::select(name,label)
dto[["unitData"]][["share"]]%>%histogram_discrete("PH0530")
dto[["unitData"]][["share"]]%>%dplyr::group_by_("PH0530")%>%dplyr::summarize(n=n())





# ----- tilda-PH001 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="PH001")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%histogram_discrete("PH001")
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("PH001")%>%dplyr::summarize(n=n())


# ----- tilda-PH009 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="PH009")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]] %>%histogram_discrete("PH009")
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("PH009")%>%dplyr::summarize(n=n())


# ---- reproduce ---------------------------------------
rmarkdown::render(
          input = "./reports/harmonize-health/describe-health.Rmd",
  output_format = "html_document", 
          clean = TRUE
)


























