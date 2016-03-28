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
# this is how we can interact with the `dto` to call and graph data and metadata
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0030") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]] %>% dplyr::filter(!BR0030==9999) %>% histogram_continuous("BR0030", bin_width=5)


# ----- view-metadata-1 ---------------------------------------------
meta_data <- dto[["metaData"]] %>%
  dplyr::filter(construct %in% c('smoking')) %>% 
  # dplyr::filter(     item %in% c("smoke_now")) %>%
  dplyr::select(study_name, name, construct, label_short, categories, url) %>%
  dplyr::arrange(construct, study_name)
knitr::kable(meta_data)

# ---- get-schema-candidates ---------------------------------------------
# pull out the variables from the subsetted metadata
# source("./scripts/common-functions.r")
ds <- load_data_schema(dto=dto,
                       varname_new="item", # column in metadata to provide new variable names
                       construct_name = "smoking") # variables in this construct will be selected


# ---- declare-schema-sets -------------------------
schema_sets <- list(
  "alsa" = c("SMOKER", "PIPCIGAR"),
  "lbsl" = c("SMK94","SMOKE"),
  "satsa" = c("GSMOKNOW", "GEVRSMK","GEVRSNS"),
  "share" = c("BR0010","BR0020","BR0030cat" ), # "BR0030" is continuous
  "tilda" = c("BH001","BH002", "BEHSMOKER","BH003cat") # "BH003" is continuous
)

# ---- export-response-profiles --------------------
# define function to extract profiles
response_profile <- function(dto, h_target, study, varnames_values){
  ds <- dto[["unitData"]][[study]]
  varnames_values <- lapply(varnames_values, as.symbol)   # Convert character vector to list of symbols
  d <- ds %>% 
    dplyr::group_by_(.dots=varnames_values) %>% 
    dplyr::summarize(count = n()) 
  write.csv(d,paste0("./data/shared/derived/response-profiles/",h_target,"-",study,".csv"))
}
# extract response profile for data schema set from each study
for(s in names(schema_sets))
  response_profile(dto,
                   study = s,
                   h_target = 'smoking',
                   varnames_values = schema_sets[[s]]
                   
)

# ---- target-1-alsa-1 -------------------------------------------------
# view data schema candidates 
dto[["metaData"]] %>% 
  dplyr::filter(study_name=="alsa", construct == "smoking") %>% 
  dplyr::select(name,label)

# ---- target-1-alsa-2 -------------------------------------------------
# view the joint profile of responses
ds %>% 
  dplyr::filter(study_name=="alsa") %>%
  dplyr::group_by(SMOKER, PIPCIGAR) %>% 
  dplyr::summarize(count = n()) 

# ---- target-1-alsa-3 -------------------------------------------------
ds$SMOKER <- as.character(ds$SMOKER) 
ds$PIPCIGAR <- as.character(ds$PIPCIGAR) 
# apply harmonization algorythm to generate values for `h_smoke_now`

ds$h_smoke_now[ds$SMOKER=="Yes" & ds$PIPCIGAR=="Yes" ] <- "YES"
ds$h_smoke_now[ds$SMOKER=="Yes" & ds$PIPCIGAR=="No" ] <- "YES"
ds$h_smoke_now[ds$SMOKER=="No" & ds$PIPCIGAR=="Yes" ] <- "YES"
ds$h_smoke_now[ds$SMOKER=="No" & is.na(ds$PIPCIGAR) ] <- "NO"
ds$h_smoke_now[is.na(ds$SMOKER) & is.na(ds$PIPCIGAR) ] <- NA

# verify  the logic of recoding
ds %>% 
  dplyr::filter(study_name=="alsa") %>%
  dplyr::group_by(SMOKER, PIPCIGAR, h_smoke_now) %>% 
  dplyr::summarize(count = n()) 




# ---- target-1-lbsl-1 -------------------------------------------------
# view data schema candidates 
dto[["metaData"]] %>% 
  dplyr::filter(study_name=="lbsl", construct == "smoking") %>% 
  dplyr::select(name,label)

# ---- target-1-lbsl-2 -------------------------------------------------
# view the joint profile of responses
ds %>% 
  dplyr::filter(study_name=="lbsl") %>%
  dplyr::group_by(SMK94, SMOKE) %>% 
  dplyr::summarize(count = n()) 

# ---- target-1-lbsl-3 -------------------------------------------------
ds$SMK94 <- as.character(ds$SMK94) 
ds$SMOKE <- as.character(ds$SMOKE) 
# apply harmonization algorythm to generate values for `h_smoke_now`

ds$h_smoke_now[ds$SMK94=="no" & ds$SMOKE=="smoke at present time" ] <- "YES"
ds$h_smoke_now[ds$SMK94=="no" & ds$SMOKE=="don't smoke at present but smoked in the past" ] <- "NO"
ds$h_smoke_now[ds$SMK94=="no " & ds$SMOKE=="never smoked" ] <- "NO"
ds$h_smoke_now[ds$SMK94=="no " & is.na(ds$SMOKE) ] <- "NO"
ds$h_smoke_now[ds$SMK94=="yes " & ds$SMOKE=="never smoked" ] <- "NO"
ds$h_smoke_now[ds$SMK94=="yes " & ds$SMOKE=="never smoked" ] <- "NO"
ds$h_smoke_now[is.na(ds$SMK94)  & ds$SMOKE=="never smoked" ] <- "NO"
ds$h_smoke_now[is.na(ds$SMK94)  & ds$SMOKE=="never smoked" ] <- "NO"
ds$h_smoke_now[is.na(ds$SMK94)  & is.na(ds$SMOKE) ] <- NA

ds$h_smoke_now[ds$SMK94=="No" & is.na(ds$SMOKE) ] <- "NO"
ds$h_smoke_now[is.na(ds$SMK94) & is.na(ds$SMOKE) ] <- NA

# verify  the logic of recoding
ds %>% 
  dplyr::filter(study_name=="alsa") %>%
  dplyr::group_by(SMOKER, PIPCIGAR, h_smoke_now) %>% 
  dplyr::summarize(count = n()) 




# ---- reproduce ---------------------------------------
rmarkdown::render(input = "./reports/harmonization-smoking/harmonization-smoking.Rmd" ,
                  output_format="html_document", clean=TRUE)


























