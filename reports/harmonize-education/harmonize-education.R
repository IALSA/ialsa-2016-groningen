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
  dplyr::filter(construct %in% c('education')) %>% 
  dplyr::select(study_name, name, construct, label_short, categories, url) %>%
  dplyr::arrange(construct, study_name)
knitr::kable(meta_data)


# ---- II-A-1-schema-sets-1 -------------------------
schema_sets <- list(
  "alsa" = c("SCHOOL","TYPQUAL"),
  "lbsl" = c("EDUC94"),
  "satsa" =  c("EDUC"),
  "share" = c("DN0100","DN012D01","DN012D02","DN012D03",
              "DN012D04","DN012D05","DN012D09", "DN012DNO", "DN012DOT",
              "DN012DRF", "DN012DDK" ), 
  "tilda" = c("DM001") 
)

# ---- II-A-1-schema-sets-2 --------------------
# view the profile of responses
dto[["unitData"]][["tilda"]] %>% 
  dplyr::group_by(DM001) %>% 
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
                   h_target = 'education',
                   varnames_values = schema_sets[[s]]
                   )
}
 


# ---- II-B-education-alsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name=="alsa", construct %in% c("education")) %>%
  dplyr::select(study_name, name, label,categories)
# ---- II-B-education-alsa-2 -------------------------------------------------
study_name <- "alsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-education-alsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("SCHOOL","TYPQUAL"), 
  harmony_name = "educ3"
)
# verify
dto[["unitData"]][["alsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "SCHOOL","TYPQUAL","educ3")



# ---- II-B-education-lbsl-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "lbsl", construct == "education") %>%
  # dplyr::filter(name %in% c("EDUC94")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-education-lbsl-2 -------------------------------------------------
study_name <- "lbsl"
path_to_hrule <- "./data/meta/h-rules/h-rules-education-lbsl.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("EDUC94"), 
  harmony_name = "educ3"
)
# verify
dto[["unitData"]][["lbsl"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "EDUC94", "educ3")



# ---- II-B-education-satsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "satsa", construct == "education") %>%
  # dplyr::filter(name %in% c("EDUC")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-education-satsa-2 -------------------------------------------------
study_name <- "satsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-education-satsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("EDUC"), 
  harmony_name = "educ3"
)
# verify
dto[["unitData"]][["satsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "EDUC", "educ3")



# ---- II-B-education-share-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "share", construct == "education") %>%
  # dplyr::filter(name %in% c("DN0100")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-education-share-2 -------------------------------------------------
study_name <- "share"
path_to_hrule <- "./data/meta/h-rules/h-rules-education-share.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name,
  variable_names = c("DN0100","DN012D01","DN012D02","DN012D03",
                     "DN012D04","DN012D05","DN012D09", "DN012DNO", "DN012DOT",
                     "DN012DRF", "DN012DDK"),
  harmony_name = "educ3"
)
# verify
knitr::kable(dto[["unitData"]][["share"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "DN0100","DN012D01","DN012D02","DN012D03",
                 "DN012D04","DN012D05","DN012D09", "DN012DNO", "DN012DOT",
                 "DN012DRF", "DN012DDK", "educ3"))

dto[["unitData"]][["share"]] %>%
  dplyr::group_by(DN0100) %>%
  dplyr::summarize(count=n())
  

# ---- II-B-education-tilda-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "tilda", construct == "education") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-education-tilda-2 -------------------------------------------------
study_name <- "tilda"
path_to_hrule <- "./data/meta/h-rules/h-rules-education-tilda.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("DM001"), 
  harmony_name = "educ3"
)
# verify
dto[["unitData"]][["tilda"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "DM001", "educ3")





# ---- III-A-assembly ---------------------------------------------
dumlist <- list()
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]]
  dumlist[[s]] <- ds[,c("id","educ3")]
}
ds <- plyr::ldply(dumlist,data.frame,.id = "study_name")
head(ds)
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
ds$educ3 <- car::recode(ds$educ3,"
                         'less than high school'=0;
                         'high school' =1;
                         'more than high school'=2
                         ",as.factor.result=TRUE )
ds$educ3 <- factor(
  ds$educ3,
  levels = c("less than high school",
             "high school",
             "more than high school"),
  labels = c(0,1,2)
)
table( ds$educ3, ds$study_name, useNA = "always")

str(ds$educ3)
head(dto[["unitData"]][["alsa"]])
# ---- save-to-disk ------------------------------------------------------------
# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
saveRDS(dto, file="./data/unshared/derived/dto.rds", compress="xz")


# ---- reproduce ---------------------------------------
rmarkdown::render(
  input = "./reports/harmonize-education/harmonize-education.Rmd" ,
  output_format="html_document", clean=TRUE
)


















