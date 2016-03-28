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


# ----- view-metadata-1 ---------------------------------------------
meta_data <- dto[["metaData"]] %>%
  dplyr::filter(construct %in% c('smoking')) %>% 
  dplyr::select(study_name, name, construct, label_short, categories, url) %>%
  dplyr::arrange(construct, study_name)
knitr::kable(meta_data)


# ---- II-A-categorization-1 ----------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0030") %>% dplyr::select(name,label)
dto[["unitData"]][["share"]] %>% dplyr::filter(!BR0030==9999) %>% histogram_continuous("BR0030", bin_width=1)

dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="BH003") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]] %>% dplyr::filter(!BH003==-1) %>% histogram_continuous("BH003", bin_width=1)


# ---- II-A-categorization-2 ----------------------
# categorize continuous variable BR0030 of SHARE
ds <- dto[["unitData"]][["share"]]

ds$BR0030_F[ds$BR0030 == 0]                      <- "less than 1"
ds$BR0030_F[ds$BR0030 > 1  & ds$BR0030 <= 10   ] <- "1-10 years"
ds$BR0030_F[ds$BR0030 > 11 & ds$BR0030 <= 20  ] <- "11-20 years"
ds$BR0030_F[ds$BR0030 > 21 & ds$BR0030 <= 30  ] <- "21-30 years"
ds$BR0030_F[ds$BR0030 > 31 & ds$BR0030 <= 40  ] <- "31-40 years"
ds$BR0030_F[ds$BR0030 > 41 & ds$BR0030 <= 50  ] <- "41-50 years"
ds$BR0030_F[ds$BR0030 > 51                    ] <- "51+ years"
ds$BR0030_F[ds$BR0030 == 9999                  ] <- NA
# convert to an ordered factor
order_in_factor <- c("less than 1","1-10 years","11-20 years","21-30 years","31-40 years","41-50 years","51+ years")
ds$BR0030_F <- ordered(ds$BR0030_F, labels = order_in_factor)
ds %>% dplyr::group_by(BR0030_F) %>% dplyr::summarize(count=n())
# attach modified dataset to dto, local to this report
dto[["unitData"]][["share"]] <- ds

# ---- II-A-categorization-3 ----------------------
# categorize continuous variable BH003 of TILDA
ds <- dto[["unitData"]][["tilda"]]
ds$BH003_F <- car::Recode(ds$BH003, " -1 = NA; lo:25 ='YOUNG'; 26:50 = 'ADULT'; 51:75 = 'MIDDLEAGED'; 75:hi = 'OLD'")
# convert to an ordered factor
order_in_factor <- c("YOUNG","ADULT","MIDDLEAGED","OLD")
ds$BH003_F <- ordered(ds$BH003_F, labels = order_in_factor)
ds %>% dplyr::group_by(BH003_F) %>% dplyr::summarize(count=n())
# attach modified dataset to dto, local to this report
dto[["unitData"]][["tilda"]] <- ds

# ---- II-A-2-schema-sets-1 -------------------------
schema_sets <- list(
  "alsa" = c("SMOKER", "PIPCIGAR"),
  "lbsl" = c("SMK94","SMOKE"),
  "satsa" = c("GSMOKNOW", "GEVRSMK","GEVRSNS"),
  "share" = c("BR0010","BR0020","BR0030_F" ), # "BR0030" is continuous
  "tilda" = c("BH001","BH002", "BEHSMOKER","BH003_F") # "BH003" is continuous
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
  write.csv(d,paste0("./data/shared/derived/response-profiles/",h_target,"-",study,".csv"))
}
# extract response profile for data schema set from each study
for(s in names(schema_sets)){
  response_profile(dto,
                   study = s,
                   h_target = 'smoking',
                   varnames_values = schema_sets[[s]]
                   )
}
 
# ---- target-1-alsa-1 -------------------------------------------------
# view the joint profile of responses
dto[["unitData"]][["alsa"]] %>% 
  dplyr::group_by(SMOKER, PIPCIGAR) %>% 
  dplyr::summarize(count = n()) 


# ---- target-1-alsa-2 -------------------------------------------------
path_to_hrule <- "./data/shared/raw/response-profiles/h-rule-smoking-alsa.csv"
(hrule <- read.csv(path_to_hrule, stringsAsFactors = F, na.strings = "NA"))

study = "alsa"
raw_vars = c("SMOKER", "PIPCIGAR")
h_var = "smoke_now"
recode_with_hrule <- function(dto, study, raw_vars, h_var){
  d <- dto[["unitData"]][["alsa"]]
  
  d <- dto[["unitData"]][["alsa"]] %>% 
  dplyr::group_by(SMOKER, PIPCIGAR) %>% 
  dplyr::summarize(count = n()) %>%
  dplyr::ungroup()
  
  
  old_va
  d[]
  
}


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


























