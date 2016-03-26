# knitr::stitch_rmd(script="./manipulation/0-ellis-island.R", output="./manipulation/stitched-output/0-ellis-island.md")
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
requireNamespace("readxl") # for importing excel sheets
requireNamespace("tidyr")
requireNamespace("dplyr") #Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit") #For asserting conditions meet expected patterns.
# requireNamespace("car") #For it's `recode()` function.

# ---- declare-globals ---------------------------------------------------------
# inspect what files there are
(listFiles <- list.files("./data/unshared/raw", full.names = T,  pattern = ".sav", recursive = F))
# list the names of the studies to be used in subsequent code
studyNames <- c("alsa", "lbsl", "satsa", "share", "tilda")
# manually declare the file paths 
alsa_path_input  <- "./data/unshared/raw/ALSA-Wave1.Final.sav"
lbsl_path_input  <- "./data/unshared/raw/LBSL-Panel2-Wave1.Final.sav"
satsa_path_input <- "./data/unshared/raw/SATSA-Q3.Final.sav" 
share_path_input <- "./data/unshared/raw/SHARE-Israel-Wave1.Final.sav"   
tilda_path_input <- "./data/unshared/raw/TILDA-Wave1.Final.sav"     

# combine file paths into a single object
filePaths <- c(alsa_path_input, lbsl_path_input, satsa_path_input, share_path_input, tilda_path_input )
# declare where the derived data object should be placed
path_output_folder <- "./data/unshared/derived/"
figure_path <- 'manipulation/stitched-output/'

# ---- load-data ---------------------------------------------------------------
# create a list object containing the names of the studies and the paths to their data files
main_list <- list("studyName"=studyNames, "filePath" = filePaths)

# at this point the object `main_list` contains components:
names(main_list)
# next, we will add another element to this list `main_list` 
# which, will reach to the file paths in `main_list[["filePath"]][[i]] and input raw data sets
# where `i` is iteratively each study in `main_list[["studyName"]][[i]]


# create a list object with data files as its elements
data_list <- list() # declare a list to populate
for(i in seq_along(studyNames)){
  # input the 5 SPSS files in .SAV extension provided with the exercise
  data_list[[i]] <- Hmisc::spss.get(main_list[["filePath"]][i], use.value.labels = TRUE) 
}
names(data_list) <- studyNames # name the elements of the data list
main_list[["unitData"]] <- data_list # include data list into the main list as another element
names(main_list) # elements in the main list object
names(main_list[["unitData"]]) # elements in the subelement 

# at this point the object `main_list` contains components:
names(main_list)
# main_list contains:  "studyName" ,  "filePath",  "unitData"
# we have just add
data_list <- main_list[["unitData"]]
names(data_list)

# ---- inspect-raw-data -------------------------------------------------------------
names_labels(data_list[["alsa"]])
names_labels(data_list[["lbsl"]])
names_labels(data_list[["satsa"]])
names_labels(data_list[["share"]])
names_labels(data_list[["tilda"]])

# names_labels <- names_labels(data_list[["alsa"]])

# rename "MAR4" because it can be confused by machines for  March-4
data_list[["tilda"]] <- plyr::rename(data_list[["tilda"]], replace = c("MAR4"= "marital4"))

# ---- export-names-and-labels -----------------------------------------
# # for a single study:
# mds_alsa <- names_labels(data_list[["alsa"]])
# write.csv(mds_alsa, "./data/shared/derived/profile_alsa.csv")
# for all studies:
for(i in studyNames){  
  save_csv <- names_labels(data_list[[i]])
  write.csv(save_csv, paste0("./data/shared/derived/meta-raw-",i,".csv"), 
            row.names = T)  
}  
# these .cvs contain the original variable names and labels
# there are queried by an aggregating Excel workbook "names-lables-augmented.xls" 
dum <- list()
for(i in studyNames){  
  dum[[i]] <- read.csv(paste0("./data/shared/derived/meta-raw-",i,".csv"),
                       header = T, stringsAsFactors = F )  
}
mdsraw <- plyr::ldply(dum, data.frame,.id = "study_name") # convert list of ds into a single ds
# mdsraw <- plyr::rename(mdsraw, replace = c(".id" = "study_name"))
mdsraw["X"] <- NULL
write.csv(mdsraw, "./data/shared/derived/meta-raw-live.csv", row.names = T)  

# ----- import-meta-data-dead -----------------------------------------
# after the final version of the data files used in the excerside have been obtained
# make a dead copy of `./data/shared/derived/meta-raw-live.csv` and name it `./data/shared/meta-data-map.csv`
# unlile its live counterpart, the new file will not be connected to the output of ellis-island script. 
# the new file, `meta-data-map.csv` now can be edited directly
# it will account for all renaming of variables and their classification 
# reproduce ellis-island script every time you make changes to `meta-data-map.csv`
dsm <- read.csv("./data/shared/meta-data-map.csv")

# ---- import-meta-data-live -----------------------------------------
# the manhole in which raw meta-data (names and labels) are augmented  outside of R
# can contain a live query, aimed at the mdsraw
# and by adding classifications and classification manipulations are done outside of R
# is now 

# after adding new columns with variable classification,  bring them into R
# this is the meta data set (mds)
filePath_mds <- "./data/shared/meta-data.xls" # input file with your manual classification


mds_list <- list()
for(i in studyNames){  
  mds_list[[i]] <- readxl::read_excel(filePath_mds, sheet = i)
} 
names(mds_list) <- studyNames
# convert dtos into a dataframe
# http://stackoverflow.com/questions/2851327/converting-a-list-of-data-frames-into-one-data-frame-in-r
mds <- plyr::ldply(mds_list, data.frame)
head(mds)
# costmetic corrections:
mds <- plyr::rename(mds,replace =  c(".id" = "study",
                                   "NA." = "varnum"))
head(mds)

attr(mds$study,"label") <- "short name of study"
attr(mds,"label")
attr(mds$varnum, "label") <- "variable id number in raw file" 
attr(mds$name, "label") <- "variable name in raw file"
attr(mds$label, "label") <- "item label as appears in raw file"
attr(mds$type, "label") <- "broad class of variables" 
attr(mds$construct, "label") <- "construct, operationalized variously"
attr(mds$item, "label") <- "operationalization of the construct"
attr(mds$categories, "label") <- "number of catergies in range of values"
attr(mds$label_short, "label") <- "item label, created for local session"
attr(mds$url, "label") <- "url to item's details webpage"

names_labels(mds)
# save it to the main list object
main_list[["metaData"]] <- mds

table(mds$study, mds$type)
table(mds$type, mds$study)
# ---- tweak-data --------------------------------------------------------------


# ---- verify-values -----------------------------------------------------------
# testit::assert("`model_name` should be a unique value", sum(duplicated(ds$model_name))==0L)
# testit::assert("`miles_per_gallon` should be a positive value.", all(ds$miles_per_gallon>0))
# testit::assert("`weight_gear_z` should be a positive or missing value.", all(is.na(ds$miles_per_gallon) | (ds$miles_per_gallon>0)))

# ---- save-to-disk ------------------------------------------------------------
# Save as a compress, binary R dataset.  It's no longer readable with a text editor, but it saves metadata (eg, factor information).
saveRDS(main_list, file="./data/unshared/derived/main_list.rds", compress="xz")




## Part B. Inspecting individual files
names_labels(data_list[["satsa"]])
# ds <- main_list[["unitData"]][["lbsl"]]
ds <- data_list[["lbsl"]]






