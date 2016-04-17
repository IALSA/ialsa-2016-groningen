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
  dplyr::filter(construct %in% c('physact')) %>% 
  dplyr::select(study_name, name, construct, label_short, categories, url) %>%
  dplyr::arrange(construct, study_name)
knitr::kable(meta_data)
 

# ---- II-A-1-schema-sets-1 -------------------------
schema_sets <- list(
  "alsa" = c("WALK2WKS","LSVIGEXC","VIGEXCS","EXRTHOUS"),
  "lbsl" = c("WALK94", "EXCERTOT"),
  "satsa" =  c("GEXERCIS"),
  "share" = c("BR0160","BR0150"), 
  "tilda" = c("BH105","BH106","BH101","BH103") 
)

# ---- II-A-1-schema-sets-2 --------------------
# view the profile of responses
dto[["unitData"]][["alsa"]] %>% 
  dplyr::group_by_("WALK2WKS","LSVIGEXC","VIGEXCS","EXRTHOUS") %>% 
  dplyr::summarize(count = n()) 


# ---- II-A-1-schema-sets-3 --------------------
# define function to extract profiles
response_profile <- function(dto, h_target, study, varnames_values){
  ds <- dto[["unitData"]][[study]]
  varnames_values <- lapply(varnames_values, as.symbol)   # Convert character vector to list of symbols
  d <- ds %>% 
    dplyr::group_by_(.dots=varnames_values) %>% 
    dplyr::summarize(count = n()) 
  write.csv(d,paste0("./data/meta/response-profiles-live/",h_target,"-",study,".csv"))
}
# extract response profile for data schema set from each study
for(s in names(schema_sets)){
  response_profile(dto,
                   study = s,
                   h_target = 'physact',
                   varnames_values = schema_sets[[s]]
                   )
}
 
# ---- II-B-physact-alsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name=="alsa", construct %in% c("physact")) %>%
  dplyr::select(study_name, name, label,categories)
# ---- II-B-physact-alsa-2 -------------------------------------------------
study_name <- "alsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-physact-alsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("WALK2WKS", "LSVIGEXC", "VIGEXCS", "EXRTHOUS"), 
  harmony_name = "sedentary"
)
# verify
dto[["unitData"]][["alsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "WALK2WKS", "LSVIGEXC", "VIGEXCS", "EXRTHOUS", "sedentary")


# ---- II-B-physact-lbsl-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "lbsl", construct == "physact") %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-physact-lbsl-2 -------------------------------------------------
study_name <- "lbsl"
path_to_hrule <- "./data/meta/h-rules/h-rules-physact-lbsl.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("WALK94","EXCERTOT"), 
  harmony_name = "sedentary"
)
# verify
dto[["unitData"]][["lbsl"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "WALK94","EXCERTOT", "sedentary")



# ---- II-B-physact-satsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "satsa", construct == "physact") %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-physact-satsa-2 -------------------------------------------------
study_name <- "satsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-physact-satsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("GEXERCIS"), 
  harmony_name = "sedentary"
)
# verify
dto[["unitData"]][["satsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "GEXERCIS", "sedentary")



# ---- II-B-physact-share-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "share", construct == "physact") %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-physact-share-2 -------------------------------------------------
study_name <- "share"
path_to_hrule <- "./data/meta/h-rules/h-rules-physact-share.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("BR0160" ,"BR0150"), 
  harmony_name = "sedentary"
)
# verify
knitr::kable(dto[["unitData"]][["share"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "BR0160" ,"BR0150", "sedentary"))



# ---- II-B-physact-tilda-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "tilda", construct == "physact") %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-physact-tilda-2 -------------------------------------------------
study_name <- "tilda"
path_to_hrule <- "./data/meta/h-rules/h-rules-physact-tilda.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("BH105", "BH106", "BH101" ,"BH103"), 
  harmony_name = "sedentary"
)
# verify
dto[["unitData"]][["tilda"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id","BH105", "BH106", "BH101" ,"BH103","sedentary")





# ---- III-A-assembly ---------------------------------------------
dumlist <- list()
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]]
  dumlist[[s]] <- ds[,c("id","sedentary")]
}
ds <- plyr::ldply(dumlist,data.frame,.id = "study_name")
head(ds)
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
table( ds$sedentary, ds$study_name, useNA="always")



# ---- reproduce ---------------------------------------
rmarkdown::render(
  input = "./reports/harmonize-physact/harmonize-physact.Rmd" ,
  output_format="html_document", clean=TRUE
)


















