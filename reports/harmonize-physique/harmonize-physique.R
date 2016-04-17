# This report conducts harmonization procedure 
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
# 3rd element - is a list object containing the following elements
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


# ----- view-metadata-1 ---------------------------------------------
meta_data <- dto[["metaData"]] %>%
  dplyr::filter(construct %in% c('physique')) %>% 
  dplyr::select(study_name, name, construct, label_short, categories, url) %>%
  dplyr::arrange(construct, study_name)
knitr::kable(meta_data)
 

# ---- II-A-1-schema-sets-1 -------------------------
schema_sets <- list(
  "alsa" = c("WEIGHT"),
  "lbsl" = c("HEIGHT94", "WEIGHT94","HHEIGHT","HWEIGHT"),
  "satsa" =  c("GHTCM","GWTKG","GPI"),
  "share" = c("PH0130","PH0120"), 
  "tilda" = c("HEIGHT","WEIGHT") 
)

# ---- II-A-1-schema-sets-2 --------------------


 
# ---- II-B-physique-alsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name=="alsa", construct %in% c("physique")) %>%
  dplyr::select(study_name, name, label,categories)
# ---- II-B-physique-alsa-2 -------------------------------------------------
dto[["unitData"]][["alsa"]] <- dto[["unitData"]][["alsa"]] %>% 
    dplyr::mutate(
      HIEGHT = NA,
      bmi = (WEIGHT)/ (HIEGHT^2))
# verify
dto[["unitData"]][["alsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "WEIGHT","HIEGHT", "bmi")


# ---- II-B-physique-lbsl-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "lbsl", construct == "physique") %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-physique-lbsl-2 -------------------------------------------------
dto[["unitData"]][["lbsl"]] <- dto[["unitData"]][["lbsl"]] %>% 
  dplyr::mutate(bmi = (WEIGHT94 * 703)/ (HEIGHT94^2))
# verify
dto[["unitData"]][["lbsl"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "WEIGHT94","HEIGHT94", "bmi")
# graph
histogram_continuous(dto[["unitData"]][["lbsl"]],"bmi")

# ---- II-B-physique-satsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "satsa", construct == "physique") %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-physique-satsa-2 -------------------------------------------------
dto[["unitData"]][["satsa"]] <- dto[["unitData"]][["satsa"]] %>% 
  dplyr::mutate(bmi = (GWTKG)/ ((GHTCM/100)^2))
# verify
dto[["unitData"]][["satsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "GWTKG","GHTCM","GPI", "bmi")
# graph
histogram_continuous(dto[["unitData"]][["satsa"]],"bmi")


# ---- II-B-physique-share-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "share", construct == "physique") %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-physique-share-2 -------------------------------------------------
# recode non-numeric flags
ds <- dto[["unitData"]][["share"]]
str(ds$PH0130); summary(ds$PH0130); table(ds$PH0130)
ds$PH0130 <- as.numeric(ds$PH0130)
ds$PH0130 <- car::recode(ds$PH0130, "
            c(9999998,9999999) = NA
            ")
str(ds$PH0120); summary(ds$PH0120); table(ds$PH0120)
ds$PH0120 <- car::recode(ds$PH0120, "
            c(0,10, 1000000) = NA
            ")
ds <- ds %>% 
  dplyr::mutate(bmi = (PH0120)/ ((PH0130/100)^2))
dto[["unitData"]][["share"]] <- ds
# verify
dto[["unitData"]][["share"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "PH0120" ,"PH0130", "bmi")
# graph
histogram_continuous(dto[["unitData"]][["share"]],"bmi")



# ---- II-B-physique-tilda-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "tilda", construct == "physique") %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-physique-tilda-2 -------------------------------------------------
ds <- dto[["unitData"]][["tilda"]]
ds <- ds %>% 
  dplyr::mutate(
    weight = ifelse(
    !is.na(WEIGHT), WEIGHT, ifelse(
      !is.na(SR.WEIGHT.KILOGRAMMES),SR.WEIGHT.KILOGRAMMES, NA)),
    height = ifelse(
      !is.na(HEIGHT), HEIGHT, ifelse(
        !is.na(SR.HEIGHT.CENTIMETRES),SR.HEIGHT.CENTIMETRES, NA))
  ) 
ds <- ds %>%
  dplyr::mutate(bmi = (weight)/ ((height/100)^2))
dto[["unitData"]][["tilda"]] <- ds
# verify
dto[["unitData"]][["tilda"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id","weight", "height", "bmi")
# graph
histogram_continuous(dto[["unitData"]][["tilda"]],"bmi")






# ---- III-A-assembly ---------------------------------------------
dumlist <- list()
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]]
  dumlist[[s]] <- ds[,c("id","bmi")]
}
ds <- plyr::ldply(dumlist,data.frame,.id = "study_name")
head(ds)
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
for(s in dto[["studyName"]]){
  print(s)
  print(summary(dto[["unitData"]][[s]]$bmi))
}

# ---- save-to-disk ------------------------------------------------------------
# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
saveRDS(dto, file="./data/unshared/derived/dto.rds", compress="xz")


# ---- reproduce ---------------------------------------
rmarkdown::render(
  input = "./reports/harmonize-bmi/harmonize-bmi.Rmd" ,
  output_format="html_document", clean=TRUE
)


















