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
  dplyr::filter(construct %in% c('physique')) %>% 
  dplyr::select(-item, -url, -label, -notes, -construct, -type, -categories) %>%
  dplyr::arrange(study_name, name) %>%
  base::print()  
seeitems #%>% dplyr::select(-label_short)

# ----- alsa-WEIGHT ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="alsa", name=="WEIGHT")%>%dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>%histogram_continuous("WEIGHT")



# ----- lbsl-HEIGHT94 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="HEIGHT94") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>% histogram_continuous("HEIGHT94")

# ----- lbsl-WEIGHT94 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="WEIGHT94") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>% histogram_continuous("WEIGHT94")

# ----- lbsl-HHEIGHT ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="HHEIGHT") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>% histogram_continuous("HHEIGHT")

# ----- lbsl-HWEIGHT ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="HWEIGHT") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>% histogram_continuous("HWEIGHT")





# ----- satsa-GHTCM ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GHTCM") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_continuous("GHTCM")

# ----- satsa-GWTKG ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GWTKG") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_continuous("GWTKG")

# ----- satsa-GPI ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GPI") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_continuous("GPI")



# ----- share-PH0130 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="share", name=="PH0130")%>%dplyr::select(name,label)
dto[["unitData"]][["share"]]%>%
  dplyr::filter(!PH0130 %in% c(9999999,9999998)) %>% 
  histogram_continuous("PH0130")

# ----- share-PH0120 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="share", name=="PH0120")%>%dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% 
  dplyr::filter(!PH0120 == 1000000) %>% histogram_continuous("PH0120")






# ----- tilda-HEIGHT ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="HEIGHT")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%histogram_continuous("HEIGHT")

# ----- tilda-WEIGHT ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="WEIGHT")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]] %>%histogram_continuous("WEIGHT")


# ----- tilda-SR.HEIGHT.CENTIMETRES  ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="SR.HEIGHT.CENTIMETRES")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]] %>%histogram_continuous("SR.HEIGHT.CENTIMETRES")

# ----- tilda-SR.WEIGHT.KILOGRAMMES ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="SR.WEIGHT.KILOGRAMMES")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%histogram_continuous("SR.WEIGHT.KILOGRAMMES")




# ---- reproduce ---------------------------------------
rmarkdown::render(
          input = "./reports/harmonize-physique/describe-physique.Rmd",
  output_format = "html_document", 
          clean = TRUE
)


























