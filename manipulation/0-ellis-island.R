# The purpose of this script is to create a data object (dto) 
# (dto) which will hold all data and metadata from each candidate study of the exercise
# Run the line below to stitch a basic html output. For elaborated report, run the corresponding .Rmd file
# knitr::stitch_rmd(script="./manipulation/0-ellis-island.R", output="./manipulation/stitched-output/0-ellis-island.md")
# These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
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
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit") #For asserting conditions meet expected patterns.

# ---- dto-1 ---------------------------------------------------------
#
# There will be a total of (4) elements in (dto): (1) studyName, (2) filePath, (3) unitDat, and (4) metaData
dto <- list() # creates empty list object to populate with script to follow 
#
### dto (1) : names of candidate studies
#
# inspect what files there are
(listFiles <- list.files("./data/unshared/raw", full.names = T,  pattern = ".sav", recursive = F))
# list the names of the studies to be used in subsequent code
studyNames <- c("alsa", "lbsl", "satsa", "share", "tilda")
dto[["studyName"]] <- studyNames

# ---- dto-2 ---------------------------------------------------------
#
### dto (2) : file paths to corresponding data files
#
# manually declare the file paths to enforce the order and prevent mismatching
alsa_path_input  <- "./data/unshared/raw/ALSA-Wave1.Final.sav"
lbsl_path_input  <- "./data/unshared/raw/LBSL-Panel2-Wave1.Final.sav"
satsa_path_input <- "./data/unshared/raw/SATSA-Q3.Final.sav" 
share_path_input <- "./data/unshared/raw/SHARE-Israel-Wave1.Final.sav"   
tilda_path_input <- "./data/unshared/raw/TILDA-Wave1.Final.sav"     
# combine file paths into a single object
filePaths <- c(alsa_path_input, lbsl_path_input, satsa_path_input, share_path_input, tilda_path_input )
dto[["filePath"]] <- filePaths

# ---- declare-globals ----------------------------------------------------
# declare where the derived data object should be placed
path_output_folder <- "./data/unshared/derived/"
figure_path <- 'manipulation/stitched-output/'

# ---- dto-3 ---------------------------------------------------------
#
### dto (3) : datasets with raw source data from each study
#
# at this point the object `dto` contains components:
names(dto)
# next, we will add another element to this list `dto`  and call it "unitData"
# it will be a list object in itself, storing datasets from studies as seperate elements
# no we will reach to the file paths in `dto[["filePath"]][[i]] and input raw data sets
# where `i` is iteratively each study in `dto[["studyName"]][[i]]
data_list <- list() # declare a list to populate
for(i in seq_along(dto[["studyName"]])){
  # i <- 1
  # input the 5 SPSS files in .SAV extension provided with the exercise
  data_list[[i]] <- Hmisc::spss.get(dto[["filePath"]][i], use.value.labels = TRUE) 
}
names(data_list) <- studyNames # name the elements of the data list
dto[["unitData"]] <- data_list # include data list into the main list as another element
names(dto) # elements in the main list object
names(dto[["unitData"]]) # elements in the subelement 

# at this point the object `dto` contains components:
names(dto)
# dto contains:  "studyName" ,  "filePath",  "unitData"
# we have just added the (3rd) element, a list of datasets:
names(dto[["unitData"]])


#
### dto (4) : collect metadata
#

# ---- inspect-raw-data -------------------------------------------------------------
# inspect the variable names and their labels in the raw data files
# names_labels(dto[["unitData"]][["alsa"]])
# names_labels(dto[["unitData"]][["lbsl"]])
# names_labels(dto[["unitData"]][["satsa"]])
# names_labels(dto[["unitData"]][["share"]])
# names_labels(dto[["unitData"]][["tilda"]])


# ---- tweak-data --------------------------------------------------------------
# rename "MAR4" because it can be confused by machines for  March-4
dto[["unitData"]][["tilda"]] <- plyr::rename(dto[["unitData"]][["tilda"]], replace = c("MAR4"= "MAR_4"))
 
# rename personal identifiers for consistency
dto[["unitData"]][["alsa"]] <- plyr::rename(dto[["unitData"]][["alsa"]], replace = c("SEQNUM"= "id"))
dto[["unitData"]][["lbsl"]] <- plyr::rename(dto[["unitData"]][["lbsl"]], replace = c("ID"= "id"))
dto[["unitData"]][["satsa"]] <- plyr::rename(dto[["unitData"]][["satsa"]], replace = c("ID"= "id"))
dto[["unitData"]][["share"]] <- plyr::rename(dto[["unitData"]][["share"]], replace = c("SAMPID.rec"= "id"))
dto[["unitData"]][["tilda"]] <- plyr::rename(dto[["unitData"]][["tilda"]], replace = c("ID"= "id"))


# ---- collect-meta-data -----------------------------------------
# to prepare for the final step in which we add metadata to the dto
# we begin by extracting the names and (hopefuly their) labels of variables from each dataset
# and combine them in a single rectanguar object, long/stacked with respect to study names
for(i in studyNames){  
  save_csv <- names_labels(dto[["unitData"]][[i]])
  write.csv(save_csv, paste0("./data/meta/names-labels-live/nl-",i,".csv"), 
            row.names = T)  
}  
# these 5 individual .cvs contain the original variable names and labels
# now we combine these files to create the starter for our metadata object
dum <- list()
for(i in studyNames){  
  dum[[i]] <- read.csv(paste0("./data/meta/names-labels-live/nl-",i,".csv"),
                       header = T, stringsAsFactors = F )  
}
mdsraw <- plyr::ldply(dum, data.frame,.id = "study_name") # convert list of ds into a single ds
mdsraw["X"] <- NULL # remove native counter variable, not needed
write.csv(mdsraw, "./data/meta/names-labels-live/names-labels-live.csv", row.names = T)  

# ----- import-meta-data-dead -----------------------------------------
# after the final version of the data files used in the excerside have been obtained
# we made a dead copy of `./data/shared/derived/meta-raw-live.csv` and named it `./data/shared/meta-data-map.csv`
# decisions on variables' renaming and classification is encoded in this map
# reproduce ellis-island script every time you make changes to `meta-data-map.csv`
dsm <- read.csv("./data/meta/meta-data-map.csv")
dsm["X"] <- NULL # remove native counter variable, not needed
dsm["X.1"] <- NULL # remove native counter variable, not needed
# dsm$url <- if(is.na(dsm$url){paste0("[link](", dsm$url,")")
dsm$url <- as.character(dsm$url)
for(i in seq_along(dsm$url)){ # i <- 20
  if(!dsm[i,"url"]==""){
    dsm[i,"url"] <- paste0("[link](",dsm[i,"url"],")")
  } 
}   
  
# attach metadata object as the 4th element of the dto
dto[["metaData"]] <- dsm




# ---- verify-values -----------------------------------------------------------
# testit::assert("`model_name` should be a unique value", sum(duplicated(ds$model_name))==0L)
# testit::assert("`miles_per_gallon` should be a positive value.", all(ds$miles_per_gallon>0))
# testit::assert("`weight_gear_z` should be a positive or missing value.", all(is.na(ds$miles_per_gallon) | (ds$miles_per_gallon>0)))

# ---- save-to-disk ------------------------------------------------------------

# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
saveRDS(dto, file="./data/unshared/derived/dto.rds", compress="xz")

# ---- object-verification ------------------------------------------------
# the production of the dto object is now complete
# we verify its structure and content:
dto <- readRDS("./data/unshared/derived/dto.rds")
# each element this list is another list:
names(dto)
# 1st element - names of the studies as character vector
dto[["studyName"]]
# 2nd element - file paths of the data files for each study
dto[["filePath"]]
# 3rd element - list objects with 
names(dto[["unitData"]])
dplyr::tbl_df(dto[["unitData"]][["alsa"]]) 
# 4th element - dataset with augmented names and labels for variables from all involved studies
dplyr::tbl_df(dto[["metaData"]])






