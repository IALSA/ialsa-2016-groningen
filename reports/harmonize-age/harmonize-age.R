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
get_these_variables <- c("id", "AGE","QAGE3","AGE94","YRBORN","DN0030")
dmls <- list() # dummy list
for(s in dto[["studyName"]]){
  ds <- dto[["unitData"]][[s]] # get study data from dto
  (varnames <- names(ds)) # see what variables there are
  (variables_present <- varnames %in% get_these_variables) # variables on the list
  dmls[[s]] <- ds[,variables_present] # keep only them
}
lapply(dmls, names) # view the contents of the list object





# ---- age-alsa ------------------------------------
# review existing variables
ds <- dmls[['alsa']]; head(ds)
# # https://www.maelstrom-research.org/mica/study/alsa
ds$year_of_wave <- 1992
ds$AGE <- as.numeric(ds$AGE)
ds <- ds %>% # transform into harmonization target
  dplyr::mutate(age_in_years = AGE, # rename
                   year_born = year_of_wave - age_in_years # compute
                ) %>% 
  dplyr::select(-AGE) 
head(ds)
str(ds)
sapply(ds,summary)
dmls[['alsa']] <- ds

# ---- age-lbsl ------------------------------------
# review existing variables
ds <- dmls[['lbsl']]; head(ds)
ds$AGE94 <- as.numeric(ds$AGE94)
# https://www.maelstrom-research.org/mica/study/lbls
ds$year_of_wave <- 1994
ds <- ds %>% # transform into harmonization target
  dplyr::mutate(age_in_years = AGE94, # rename
                year_born = year_of_wave - age_in_years # compute
                ) %>% 
  dplyr::select(-AGE94)
head(ds)
str(ds)
sapply(ds,summary)
dmls[['lbsl']] <- ds # replace with augmented

# ---- age-satsa ------------------------------------
# review existing variables
ds <- dmls[['satsa']]; head(ds)
ds$YRBORN <- as.numeric(ds$YRBORN)
ds$QAGE3 <- as.numeric(ds$QAGE3)
# https://www.maelstrom-research.org/mica/study/satsa
ds$year_of_wave <- 1991
ds <- ds %>% # transform into harmonization target
  dplyr::mutate(age_in_years = QAGE3, # direct transform; (??) should it be rounded (??)
                year_born = YRBORN + 1900 # compute
                ) %>%  
  dplyr::select(-QAGE3, - YRBORN ) 
head(ds)
str(ds)
sapply(ds,summary)
dmls[['satsa']] <- ds


# ---- age-share ------------------------------------
# review existing variables
ds <- dmls[['share']]; head(ds)
ds$DN0030 <- as.numeric(ds$DN0030)
# http://wiki.obiba.org/display/MHSA2016/The+Survey+of+Health%2C+Ageing+and+Retirement+in+Europe+%28SHARE%29+-+Israel?preview=/32801017/32801020/22160-0001-Codebook.pdf
ds$year_of_wave <- 2006
ds <- ds %>% # transform into harmonization target
  dplyr::mutate(year_born = DN0030, # rename
                age_in_years = year_of_wave - year_born # compute
                ) %>%  
  dplyr::select(-DN0030)
str(ds)
ds[ds$age_in_years<1,"age_in_years"] <- NA
head(ds)
sapply(ds, summary)
dmls[['share']] <- ds

# ---- age-tilda ------------------------------------
# review existing variables
ds <- dmls[['tilda']]; head(ds)
ds$AGE <- as.numeric(ds$AGE)
# https://www.maelstrom-research.org/mica/study/tilda
ds$year_of_wave <- 2009
ds <- ds %>% # transform into harmonization target
  dplyr::mutate(age_in_years = AGE, # rename
                year_born = year_of_wave - age_in_years # compute
                ) %>% 
  dplyr::select(-AGE)
str(ds)
head(ds)
sapply(ds, summary)
dmls[['tilda']] <- ds



# ---- III-A-assembly ---------------------------------------------
# convert the dummy list into a dataframe with study names as factor
ds <- plyr::ldply(dmls,data.frame,.id = "study_name")
ds$id <- 1:nrow(ds) # some ids values might be identical, replace
head(ds); str(ds)

# augment dto with the harmonized age variables
for(s in dto[["studyName"]]){
  d <- dto[["unitData"]][[s]]
  d <- d %>% 
    dplyr::left_join(dmls[[s]], by = "id")
  dto[["unitData"]][[s]] <- d
  
}


# ---- save-to-disk ------------------------------------------------------------
# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
saveRDS(dto, file="./data/unshared/derived/dto.rds", compress="xz")


# ---- reproduce ---------------------------------------
rmarkdown::render(input = "./reports/harmonize-age/harmonize-age.Rmd" , 
                  output_format="html_document", clean=TRUE)


















