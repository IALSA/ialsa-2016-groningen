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
  dplyr::filter(construct %in% c('smoking')) %>% 
  dplyr::select(study_name, name, construct, label_short, categories, url) %>%
  dplyr::arrange(construct, study_name)
knitr::kable(meta_data)


# ---- II-A-categorization-1 ----------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0030") %>% dplyr::select(name,label)
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="BH003") %>% dplyr::select(name,label)





# ---- II-A-2-schema-sets-1 -------------------------
schema_sets <- list(
  "alsa" = c("SMOKER", "PIPCIGAR"),
  "lbsl" = c("SMK94","SMOKE"),
  "satsa" = c("GSMOKNOW", "GEVRSMK","GEVRSNS"),
  "share" = c("BR0010","BR0020"), # "BR0030" is continuous
  "tilda" = c("BH001","BH002", "BEHSMOKER") # "BH003" is continuous
)

# ---- II-A-2-schema-sets-2 --------------------
# view the joint profile of responses
dto[["unitData"]][["alsa"]] %>% 
  dplyr::group_by(SMOKER, PIPCIGAR) %>% 
  dplyr::summarize(count = n()) 


# ---- II-A-2-schema-sets-3 --------------------
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
                   h_target = 'smoking',
                   varnames_values = schema_sets[[s]]
                   )
}
 


# ---- II-B-smoke_now-alsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(name %in% c("SMOKER", "PIPCIGAR")) %>%
  dplyr::select(study_name, name, label,categories)
# ---- II-B-smoke_now-alsa-2 -------------------------------------------------
study_name <- "alsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-smoking-alsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("SMOKER", "PIPCIGAR"), 
  harmony_name = "smoke_now"
)
# verify
dto[["unitData"]][["alsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "SMOKER", "PIPCIGAR", "smoke_now")



# ---- II-B-smoke_now-lbsl-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "lbsl", construct == "smoking") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-smoke_now-lbsl-2 -------------------------------------------------
study_name <- "lbsl"
path_to_hrule <- "./data/meta/h-rules/h-rules-smoking-lbsl.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("SMK94", "SMOKE"), 
  harmony_name = "smoke_now"
)
# verify
dto[["unitData"]][["lbsl"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "SMK94", "SMOKE", "smoke_now")



# ---- II-B-smoke_now-satsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "satsa", construct == "smoking") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-smoke_now-satsa-2 -------------------------------------------------
study_name <- "satsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-smoking-satsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("GEVRSMK", "GEVRSNS","GSMOKNOW"), 
  harmony_name = "smoke_now"
)
# verify
dto[["unitData"]][["satsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "GEVRSMK", "GEVRSNS","GSMOKNOW", "smoke_now")



# ---- II-B-smoke_now-share-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "share", construct == "smoking") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-B-smoke_now-share-2 -------------------------------------------------
study_name <- "share"
path_to_hrule <- "./data/meta/h-rules/h-rules-smoking-share.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("BR0010", "BR0020"), 
  harmony_name = "smoke_now"
)
# verify
dto[["unitData"]][["share"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "BR0010", "BR0020", "smoke_now")



# ---- II-B-smoke_now-tilda-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "tilda", construct == "smoking") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short, categories)
# ---- II-B-smoke_now-tilda-2 -------------------------------------------------
study_name <- "tilda"
path_to_hrule <- "./data/meta/h-rules/h-rules-smoking-tilda.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("BH001", "BH002","BEHSMOKER" ), 
  harmony_name = "smoke_now"
)
# verify
dto[["unitData"]][["tilda"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "BH001", "BH002","BEHSMOKER", "smoke_now")





# ---- II-C-smoked_ever-alsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(name %in% c("SMOKER", "PIPCIGAR")) %>%
  dplyr::select(study_name, name, label,categories)
# ---- II-C-smoked_ever-alsa-2 -------------------------------------------------
study_name <- "alsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-smoking-alsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("SMOKER", "PIPCIGAR"), 
  harmony_name = "smoked_ever"
)
# verify
dto[["unitData"]][["alsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "SMOKER", "PIPCIGAR", "smoked_ever")



# ---- II-C-smoked_ever-lbsl-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "lbsl", construct == "smoking") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-C-smoked_ever-lbsl-2 -------------------------------------------------
study_name <- "lbsl"
path_to_hrule <- "./data/meta/h-rules/h-rules-smoking-lbsl.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("SMK94", "SMOKE"), 
  harmony_name = "smoked_ever"
)
# verify
dto[["unitData"]][["lbsl"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "SMK94", "SMOKE", "smoked_ever")




# ---- II-C-smoked_ever-satsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "satsa", construct == "smoking") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-C-smoked_ever-satsa-2 -------------------------------------------------
study_name <- "satsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-smoking-satsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("GEVRSMK", "GEVRSNS","GSMOKNOW"), 
  harmony_name = "smoked_ever"
)
# verify
dto[["unitData"]][["satsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "GEVRSMK", "GEVRSNS","GSMOKNOW", "smoked_ever")



# ---- II-C-smoked_ever-share-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "share", construct == "smoking") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-C-smoked_ever-share-2 -------------------------------------------------
study_name <- "share"
path_to_hrule <- "./data/meta/h-rules/h-rules-smoking-share.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("BR0010", "BR0020"), 
  harmony_name = "smoked_ever"
)
# verify
dto[["unitData"]][["share"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "BR0010", "BR0020", "smoked_ever")



# ---- II-C-smoked_ever-tilda-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "tilda", construct == "smoking") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-C-smoked_ever-tilda-2 -------------------------------------------------
study_name <- "tilda"
path_to_hrule <- "./data/meta/h-rules/h-rules-smoking-tilda.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("BH001", "BH002","BEHSMOKER" ), 
  harmony_name = "smoked_ever"
)
# verify
dto[["unitData"]][["tilda"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "BH001", "BH002","BEHSMOKER", "smoked_ever")



# ---- III-A-assembly ---------------------------------------------
dumlist <- list()
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]]
  dumlist[[s]] <- ds[,c("id","smoke_now","smoked_ever")]
}
ds <- plyr::ldply(dumlist,data.frame,.id = "study_name")
head(ds)
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
table( ds$smoke_now, ds$study_name, useNA = "always")
table( ds$smoked_ever, ds$study_name, useNA = "always")


# ---- save-to-disk ------------------------------------------------------------
# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
saveRDS(dto, file="./data/unshared/derived/dto.rds", compress="xz")



# ---- reproduce ---------------------------------------
rmarkdown::render(input = "./reports/harmonize-smoking/harmonize-smoking.Rmd" , 
                  output_format="html_document", clean=TRUE)


















