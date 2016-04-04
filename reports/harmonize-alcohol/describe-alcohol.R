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
  dplyr::filter(construct %in% c('alcohol')) %>% 
  dplyr::select(-item, -url, -label, -notes, -construct, -type) %>%
  dplyr::arrange(study_name, name) %>%
  base::print()  

# ----- alsa-FR6ORMOR ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="FR6ORMOR") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>% histogram_discrete("FR6ORMOR")
dto[["unitData"]][["alsa"]]%>% dplyr::group_by_("FR6ORMOR") %>% dplyr::summarize(n=n())

# ----- alsa-FREQALCH ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="FREQALCH") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>% histogram_discrete("FREQALCH")
dto[["unitData"]][["alsa"]]%>% dplyr::group_by_("FREQALCH") %>% dplyr::summarize(n=n())

# ----- alsa-NOSTDRNK ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="NOSTDRNK") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>% histogram_discrete("NOSTDRNK")
dto[["unitData"]][["alsa"]]%>% dplyr::group_by_("NOSTDRNK") %>% dplyr::summarize(n=n())




# ----- lbsl-ALCOHOL ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="ALCOHOL") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>% histogram_discrete("ALCOHOL")
dto[["unitData"]][["lbsl"]]%>% dplyr::group_by_("ALCOHOL") %>% dplyr::summarize(n=n())

# ----- lbsl-BEER ---------------------------------
# requires categorization
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="BEER") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>% histogram_continuous("BEER")
dto[["unitData"]][["lbsl"]]%>% dplyr::group_by_("BEER") %>% dplyr::summarize(n=n())

# ----- lbsl-HARDLIQ ---------------------------------
# requires categorization
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="HARDLIQ") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>% histogram_continuous("HARDLIQ")
dto[["unitData"]][["lbsl"]]%>% dplyr::group_by_("HARDLIQ") %>% dplyr::summarize(n=n())

# ----- lbsl-WINE ---------------------------------
# requires categorization
dto[["metaData"]] %>% dplyr::filter(study_name=="lbsl", name=="WINE") %>% dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>% histogram_continuous("WINE")
dto[["unitData"]][["lbsl"]]%>% dplyr::group_by_("WINE") %>% dplyr::summarize(n=n())







# ----- satsa-GALCOHOL ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GALCOHOL") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("GALCOHOL")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GALCOHOL") %>% dplyr::summarize(n=n())

# ----- satsa-GBEERX ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GBEERX") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("GBEERX")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GBEERX") %>% dplyr::summarize(n=n())

# ----- satsa-GBOTVIN ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GBOTVIN") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("GBOTVIN")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GBOTVIN") %>% dplyr::summarize(n=n())

# ----- satsa-GDRLOTS ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GDRLOTS") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("GDRLOTS")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GDRLOTS") %>% dplyr::summarize(n=n())

# ----- satsa-GEVRALK ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GEVRALK") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("GEVRALK")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GEVRALK") %>% dplyr::summarize(n=n())

# ----- satsa-GFREQBER ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GFREQBER") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("GFREQBER")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GFREQBER") %>% dplyr::summarize(n=n())

# ----- satsa-GFREQLIQ ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GFREQLIQ") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("GFREQLIQ")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GFREQLIQ") %>% dplyr::summarize(n=n())

# ----- satsa-GFREQVIN ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GFREQVIN") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("GFREQVIN")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GFREQVIN") %>% dplyr::summarize(n=n())

# ----- satsa-GLIQX ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GLIQX") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("GLIQX")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GLIQX") %>% dplyr::summarize(n=n())

# ----- satsa-GSTOPALK ---------------------------------
# requires categorization? maybe, maybe not
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GSTOPALK") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_continuous("GSTOPALK")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GSTOPALK") %>% dplyr::summarize(n=n())

# ----- satsa-GVINX ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="satsa", name=="GVINX") %>% dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>% histogram_discrete("GVINX")
dto[["unitData"]][["satsa"]]%>% dplyr::group_by_("GVINX") %>% dplyr::summarize(n=n())






# ----- share-BR0100 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0100") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("BR0100")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("BR0100") %>% dplyr::summarize(n=n())

# ----- share-BR0110 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0110") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("BR0110")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("BR0110") %>% dplyr::summarize(n=n())

# ----- share-BR0120 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0120") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("BR0120")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("BR0120") %>% dplyr::summarize(n=n())

# ----- share-BR0130 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0130") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]]%>% histogram_discrete("BR0130")
dto[["unitData"]][["share"]]%>% dplyr::group_by_("BR0130") %>% dplyr::summarize(n=n())







# ----- tilda-BEHALC.DRINKSPERDAY ---------------------------------
# requires categorization
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="BEHALC.DRINKSPERDAY") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% histogram_continuous("BEHALC.DRINKSPERDAY")
dto[["unitData"]][["tilda"]]%>% dplyr::group_by_("BEHALC.DRINKSPERDAY") %>% dplyr::summarize(n=n())

# ----- tilda-BEHALC.DRINKSPERWEEK ---------------------------------
# requires categorization
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="BEHALC.DRINKSPERWEEK") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% histogram_continuous("BEHALC.DRINKSPERWEEK")
dto[["unitData"]][["tilda"]]%>% dplyr::group_by_("BEHALC.DRINKSPERWEEK") %>% dplyr::summarize(n=n())

# ----- tilda-BEHALC.FREQ.WEEK ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="BEHALC.FREQ.WEEK") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% histogram_discrete("BEHALC.FREQ.WEEK")
dto[["unitData"]][["tilda"]]%>% dplyr::group_by_("BEHALC.FREQ.WEEK") %>% dplyr::summarize(n=n())

# ----- tilda-SCQALCOFREQ ---------------------------------
# requires labelling factor levels
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="SCQALCOFREQ") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%
  dplyr::filter(!SCQALCOFREQ %in% c(-867,-856,-845,-823,-812)) %>% histogram_discrete("SCQALCOFREQ")
dto[["unitData"]][["tilda"]]%>% dplyr::group_by_("SCQALCOFREQ") %>% dplyr::summarize(n=n())

# ----- tilda-SCQALCOHOL ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="SCQALCOHOL") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% histogram_discrete("SCQALCOHOL")
dto[["unitData"]][["tilda"]]%>% dplyr::group_by_("SCQALCOHOL") %>% dplyr::summarize(n=n())

# ----- tilda-SCQALCONO1 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="SCQALCONO1") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% 
  dplyr::filter(!SCQALCONO1 %in% c(-867,-856,-845,-823,-812)) %>% histogram_discrete("SCQALCONO1")
dto[["unitData"]][["tilda"]]%>% dplyr::group_by_("SCQALCONO1") %>% dplyr::summarize(n=n())

# ----- tilda-SCQALCONO2 ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="SCQALCONO2") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% 
  dplyr::filter(!SCQALCONO2 %in% c(-99, -1 )) %>%  histogram_continuous("SCQALCONO2")
dto[["unitData"]][["tilda"]]%>% dplyr::group_by_("SCQALCONO2") %>% dplyr::summarize(n=n())



# ---- reproduce ---------------------------------------
rmarkdown::render(
          input = "./reports/harmonize-alcohol/describe-alcohol.Rmd",
  output_format = "html_document", 
          clean = TRUE
)


























