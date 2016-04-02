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
dto[["metaData"]] %>%
  dplyr::filter(construct %in% c('age')) %>% 
  dplyr::select(-url, -label, -notes) %>%
  dplyr::arrange(study_name, item) %>%
  base::print()  


# ---- assemble ------------------
# s ="alsa"
dmls <- list()
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]]
  (varnames <- names(ds))
  (get_these_variables <- c("id","year_of_wave", "AGE","QAGE3","AGE94","YRBORN","DN0030"))
  (variables_present <- varnames %in% get_these_variables)
  dmls[[s]] <- ds[,variables_present]
}
# view the contents of the list object
lapply(dmls, names)

# ---- age-alsa ------------------------------------
# transform into harmonized variable
ds <- dmls[['alsa']]; head(ds)
ds <- ds %>%
  dplyr::mutate(age_in_years = AGE, # direct transform
                   year_born = year_of_wave - age_in_years) %>% 
  dplyr::select(-AGE)
head(ds)
dmls[['alsa']] <- ds

# ---- age-lbsl ------------------------------------
# transform into harmonized variable
ds <- dmls[['lbsl']]; head(ds)
ds <- ds %>%
  dplyr::mutate(age_in_years = AGE94, # direct transform
                year_born = year_of_wave - age_in_years) %>% 
  dplyr::select(-AGE94)
head(ds)
dmls[['lbsl']] <- ds

# ---- age-satsa ------------------------------------
# transform into harmonized variable
ds <- dmls[['satsa']]; head(ds)
ds <- ds %>%
  dplyr::mutate(age_in_years = QAGE3, # direct transform; (??) should it be rounded (??)
                year_born = YRBORN +1900) %>%  
  dplyr::select(-QAGE3, - YRBORN )
head(ds)
dmls[['satsa']] <- ds
# Reconcile the difference between (YEAR_BORN) and (year_born)

# ---- age-share ------------------------------------
# transform into harmonized variable
ds <- dmls[['share']]; head(ds)
ds <- ds %>%
  dplyr::mutate(year_born = DN0030, # direct transform
                age_in_years = year_of_wave - year_born) %>%  
  dplyr::select(-DN0030)
head(ds)
dmls[['share']] <- ds

# ---- age-tilda ------------------------------------
# transform into harmonized variable
ds <- dmls[['tilda']]; head(ds)
ds <- ds %>%
  dplyr::mutate(age_in_years = AGE, # direct transform
                year_born = year_of_wave - age_in_years) %>% 
  dplyr::select(-AGE)
head(ds)
dmls[['tilda']] <- ds
# Reconcile the difference between (YEAR_BORN) and (year_born)


# ---- assemble-harmonized ------------------------------------
ds <- plyr::ldply(dmls,data.frame,.id = "study_name")
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
head(ds)


# ---- reproduce ---------------------------------------
rmarkdown::render(input = "./reports/harmonization-age/harmonization-age.Rmd" , 
                  output_format="html_document", clean=TRUE)


















