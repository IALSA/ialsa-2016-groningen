# knitr::stitch_rmd(script="./manipulation/studies-ellis.R", output="./manipulation/stitched-output/studies-ellis.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console 

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
source("./scripts/common-functions.R")


# ---- load-packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr) #Pipes

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("ggplot2")
# requireNamespace("readr")
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit") #For asserting conditions meet expected patterns.
# requireNamespace("car") #For it's `recode()` function.

# ---- declare-globals ---------------------------------------------------------
# inspect what files there are
(listFiles <- list.files("./data/unshared/", full.names = T,  pattern = ".sav", recursive = F))
# list the specific files to be used 
studyNames <- c("alsa", "lbsl", "satsa", "share", "tilda")
# manually declare the file paths 
alsa_path_input  <- "./data/unshared/ALSA-Wave1 SPSS.Final.sav"
lbsl_path_input  <- "./data/unshared/LBSL-Panel2-Wave1 SPSS.Final.sav"
satsa_path_input <- "./data/unshared/SATSA-Q3 SPSS.Final.sav" 
share_path_input <- "./data/unshared/SHARE-Israel Wave 1.Final.sav"   
tilda_path_input <- "./data/unshared/TILDA-Wave1 SPSS.Final.sav"      
# combine file paths into a single object
filePaths <- c(alsa_path_input, lbsl_path_input, satsa_path_input, share_path_input, tilda_path_input)
# declare where the derived data object should be placed
path_output_folder <- "./data/unshared/derived/"
figure_path <- 'manipulation/stitched-output/'

# ---- load-data ---------------------------------------------------------------
# create a list object containing the names of the studies and the paths to their data files
main_list <- list("studyName"=studyNames, "filePath" = filePaths)
# import each data file and include it into the main list object 
data_list <- list() # first create a separate list object containing the data files
for(i in seq_along(studyNames)){
  data_list[[i]] <- Hmisc::spss.get(main_list[["filePath"]][i], use.value.labels = TRUE) 
}
names(data_list) <- studyNames # name the elements of the data list
main_list[["dataFiles"]] <- data_list # include data list into the main list
names(main_list) 
names(main_list[["dataFiles"]])
# remove everything, but the main object
# rm(list=setdiff(ls(),c("main_list")))
# at this point the main list object contains three components:
# main_list contains:  "studyName" ,  "filePath",  "dataFiles"
# data_list <- main_list[["dataFiles"]]
# names(data_list)

# ---- inspect-raw-data -------------------------------------------------------------
names_labels(data_list[["alsa"]])
names_labels(data_list[["lbsl"]])
names_labels(data_list[["satsa"]])
names_labels(data_list[["share"]])
names_labels(data_list[["tilda"]])

# ---- tweak-data --------------------------------------------------------------
colnames(ds)

# ---- verify-values -----------------------------------------------------------
# testit::assert("`model_name` should be a unique value", sum(duplicated(ds$model_name))==0L)
# testit::assert("`miles_per_gallon` should be a positive value.", all(ds$miles_per_gallon>0))
# testit::assert("`weight_gear_z` should be a positive or missing value.", all(is.na(ds$miles_per_gallon) | (ds$miles_per_gallon>0)))

# ---- save-to-disk ------------------------------------------------------------
# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
saveRDS(ds, file=path_output, compress="xz")















