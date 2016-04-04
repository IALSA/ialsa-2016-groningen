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
  dplyr::filter(construct %in% c('alcohol')) %>% 
  dplyr::select(study_name, name, construct, label_short, categories, url) %>%
  dplyr::arrange(construct, study_name)
knitr::kable(meta_data)
 
###### FROM HERE FROM ON IS THE COPIED TEMPLATES FROM SMOKING AND WORK
##### COME BACK WHEN READY TO DO CATEGORIZATION

# ---- II-A-categorization-1 ----------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="share", name=="BR0030") %>% dplyr::select(name,label)
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="BH003") %>% dplyr::select(name,label)


# ---- II-A-categorization-2 ----------------------
dto[["unitData"]][["share"]] %>% dplyr::filter(!BR0030==9999) %>% histogram_continuous("BR0030", bin_width=1)
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
dto[["unitData"]][["share"]] %>% histogram_discrete("BR0030_F")
# ---- II-A-categorization-3 ----------------------
dto[["unitData"]][["tilda"]] %>% dplyr::filter(!BH003==-1) %>% histogram_continuous("BH003", bin_width=1)
# categorize continuous variable BH003 of TILDA
ds <- dto[["unitData"]][["tilda"]]
ds$BH003_F <- car::Recode(ds$BH003, "  -1 = NA; 
                          lo:25 ='YOUNG'; 
                          26:50 = 'ADULT'; 
                          51:75 = 'MIDDLEAGED'; 
                          75:hi = 'OLD'")
# convert to an ordered factor
order_in_factor <- c("YOUNG","ADULT","MIDDLEAGED","OLD")
ds$BH003_F <- ordered(ds$BH003_F, labels = order_in_factor)
ds %>% dplyr::group_by(BH003_F) %>% dplyr::summarize(count=n())
# attach modified dataset to dto, local to this report
dto[["unitData"]][["tilda"]] <- ds
dto[["unitData"]][["tilda"]] %>% histogram_discrete("BH003_F")




# ---- II-B-1-schema-sets-1 -------------------------
schema_sets <- list(
  "alsa" = c("FR6ORMOR","FREQALCH","NOSTDRNK"),
  "lbsl" = c("ALCOHOL", "BEER ", "HARDLIQ", "WINE"),
  "satsa" =  c("GALCOHOL", "GBEERX", "GBOTVIN", "GDRLOTS", 
               "GEVRALK", "GFREQBER", "GFREQLIQ", "GFREQVIN", 
               "GLIQX", "GSTOPALK","GVINX"),
  "share" = c("BR0100", "BR0110","BR0120","BR0130"), 
  "tilda" = c("BEHALC.DRINKSPERDAY","BEHALC.DRINKSPERWEEK",
              "BEHALC.FREQ.WEEK ","SCQALCOFREQ","SCQALCOHOL",
              "SCQALCONO1","SCQALCONO2") 
)

# ---- II-B-1-schema-sets-2 --------------------
# view the profile of responses
dto[["unitData"]][["alsa"]] %>% 
  dplyr::group_by(RETIRED,CURRWORK) %>% 
  dplyr::summarize(count = n()) 


# ---- II-B-1-schema-sets-3 --------------------
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
                   h_target = 'work',
                   varnames_values = schema_sets[[s]]
                   )
}
 
#### THE REST IS A DUMMY FROM EDUCATION. 
#### COME BACK WHEN YOU HAVE HARMONIZATION RULES

# ---- II-B-work-alsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name=="alsa", construct %in% c("work_status")) %>%
  dplyr::select(study_name, name, label,categories)
# ---- II-C-education-alsa-2 -------------------------------------------------
study_name <- "alsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-education-alsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("SCHOOL","TYPQUAL"), 
  harmony_name = "educ4"
)
# verify
dto[["unitData"]][["alsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "SCHOOL","TYPQUAL","educ4")



# ---- II-C-education-lbsl-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "lbsl", construct == "education") %>%
  # dplyr::filter(name %in% c("EDUC94")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-C-education-lbsl-2 -------------------------------------------------
study_name <- "lbsl"
path_to_hrule <- "./data/meta/h-rules/h-rules-education-lbsl.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("EDUC94"), 
  harmony_name = "educ4"
)
# verify
dto[["unitData"]][["lbsl"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "EDUC94", "educ4")



# ---- II-C-education-satsa-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "satsa", construct == "education") %>%
  # dplyr::filter(name %in% c("EDUC")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-C-education-satsa-2 -------------------------------------------------
study_name <- "satsa"
path_to_hrule <- "./data/meta/h-rules/h-rules-education-satsa.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("EDUC"), 
  harmony_name = "educ4"
)
# verify
dto[["unitData"]][["satsa"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "EDUC", "educ4")



# ---- II-C-education-share-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "share", construct == "education") %>%
  # dplyr::filter(name %in% c("DN0100")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-C-education-share-2 -------------------------------------------------
study_name <- "share"
path_to_hrule <- "./data/meta/h-rules/h-rules-education-share.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("DN0100","DN012D01","DN012D02","DN012D03",
                     "DN012D04","DN012D05","DN012D09", "DN012DNO", "DN012DOT",
                     "DN012DRF", "DN012DDK"), 
  harmony_name = "educ4"
)
# verify
knitr::kable(dto[["unitData"]][["share"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "DN0100","DN012D01","DN012D02","DN012D03",
                 "DN012D04","DN012D05","DN012D09", "DN012DNO", "DN012DOT",
                 "DN012DRF", "DN012DDK", "educ4"))



# ---- II-C-education-tilda-1 -------------------------------------------------
dto[["metaData"]] %>%
  dplyr::filter(study_name == "tilda", construct == "education") %>%
  # dplyr::filter(name %in% c("SMK94", "SMOKE")) %>%
  dplyr::select(study_name, name, label_short,categories)
# ---- II-C-education-tilda-2 -------------------------------------------------
study_name <- "tilda"
path_to_hrule <- "./data/meta/h-rules/h-rules-education-tilda.csv"
dto[["unitData"]][[study_name]] <- recode_with_hrule(
  dto,
  study_name = study_name, 
  variable_names = c("DM001"), 
  harmony_name = "educ4"
)
# verify
dto[["unitData"]][["tilda"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "DM001", "educ4")





# ---- III-A-assembly ---------------------------------------------
dumlist <- list()
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]]
  dumlist[[s]] <- ds[,c("id","educ4")]
}
ds <- plyr::ldply(dumlist,data.frame,.id = "study_name")
head(ds)
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
ds$educ4 <- ordered(
  ds$educ4, 
  levels = c("less than high-school", 
             "high-school most", 
             "college", 
             "college plus")
)
table( ds$educ4, ds$study_name)



# ---- reproduce ---------------------------------------
rmarkdown::render(
  input = "./reports/harmonize-education/harmonize-education.Rmd" ,
  output_format="html_document", clean=TRUE
)


















