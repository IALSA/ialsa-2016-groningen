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

# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("ggplot2") # graphing
# requireNamespace("readr") # data input
requireNamespace("tidyr") # data manipulation
requireNamespace("dplyr") # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit")# For asserting conditions meet expected patterns.
# requireNamespace("car") # For it's `recode()` function.

# ---- declare-globals ---------------------------------------------------------

# ---- load-data ---------------------------------------------------------------
# load the product of 0-ellis-island.R,  a list object containing data and metadata
main_list <- readRDS("./data/unshared/derived/main_list.rds")
# each element this list is another list:
names(main_list)
# 1st element - names of the studies as character vector
main_list[["studyName"]]
studyNames <- main_list[["studyName"]]
# 2nd element - file paths of the data files for each study
main_list[["filePath"]]
# 3rd element - list objects with 
names(main_list[["dataFiles"]])
dplyr::tbl_df(main_list[["dataFiles"]][["alsa"]]) 
# 4th element - dataset with metadata
dplyr::tbl_df(main_list[["metaData"]])

# ---- inspect-data -------------------------------------------------------------
ds <- main_list[["dataFiles"]][["tilda"]] # load ds for a study
ds %>% dplyr::glimpse() # preview
mds <- main_list[["metaData"]] # load metadata object

names(mds)
metastem <- c(
  "label_short", # item label, created for this analytical session
  "study", # short name of study
  "name", # variable name as appears in the original data file of each study
  "item",  # item name, created for this analytical session, may be same across studies
  # "label", # original label in raw file
  # "url", #url to item's details webpage"
  "construct", # the measured construct, could be operationalized variously
  "type", # type of variable (e.g. design, demographic, lifestyle, cognitive)
   "categories" # number of catergies in the possible range of values
) 
mds <- mds %>% 
  dplyr::select_(.dots=metastem) %>% 
  # dplyr::arrange(item, study)
  dplyr::arrange(study, item)
mds %>% dplyr::tbl_df() 
# how to subset base on values
mds_sub <- mds %>% dplyr::filter(construct %in% c('smoking')) 
print(mds_sub, nrow(mds_sub))



ds <- main_list[["dataFiles"]][["alsa"]]
ds %>% dplyr::group_by_("PIPCIGAR") %>% dplyr::summarize(count = n())

# ---- tweak-data --------------------------------------------------------------

# ---- combine-datasets-smoking ----------
names(main_list)
# extract specific variables from raw data sets
ds_list <- list(); names_list <- list()
for(i in studyNames){  
  # i = "alsa"
  (keepvars <- mds_sub[mds_sub$study==i, "name"] )
  (newvars <-  mds_sub[mds_sub$study==i, "item"]) 
  dd <- main_list[["dataFiles"]][[i]][,keepvars]; head(dd)
  d <- dd; head(d)
  names(d) <- newvars # rename into new item names
  name_new <- names(d); name_old <- names(dd)
  (oldnew <- cbind(name_new,name_old))
  names_list[[i]] <- oldnew
  d <- dplyr::bind_cols(d, dd) # bind originals
  ds_list[[i]] <- d
  
} 
names(ds_list) <- studyNames
names(names_list) <- studyNames

d <- ds_list[['alsa']]
n <- names_list[["alsa"]]
head(d); head(n)

# convert dtos into a dataframe
# http://stackoverflow.com/questions/2851327/converting-a-list-of-data-frames-into-one-data-frame-in-r
ds <- plyr::ldply(ds_list, data.frame)
ds <- plyr::rename(ds, c(".id" = "study_name"))

ds_names <- plyr::ldply(names_list, data.frame)
ds_names <- plyr::rename(ds_names, c(".id" = "study_name"))
ds_names <- ds_names %>% dplyr::arrange(study_name)
print(ds_names)
a <- ds_names$study_name
a <- c("aaa","bbb")
dput(d)
# study_name SMOKER PIPCIGAR SMK94 SMOKE GEVRSMK GEVRSNS GSMOKNOW BR0010 BR0020 BR0030

# item <- "PIPCIGAR"
viewer1 <- function(ds, item){ 
  t <- table(ds[,item], ds$study_name)
  t[t=="0"]<-"."
  cat(paste0(item," : ", attr(ds[,item], "label")))
  print(t,title="newtitle")
}

for(i in names(ds)){
  viewer1(ds,i)
  cat("\n")
}


######### dev ###############
t <- table(ds$SMOKER, ds$study_name); t[t=="0"]<-".";t


t <- table(ds$PIPCIGAR, ds$study_name); t[t=="0"]<-".";t
t <- table(ds$SMK94, ds$study_name); t[t=="0"]<-".";t
t <- table(ds$SMOKE, ds$study_name); t[t=="0"]<-".";t
t <- table(ds$GEVRSMK, ds$study_name); t[t=="0"]<-".";t
t <- table(ds$GEVRSNS, ds$study_name); t[t=="0"]<-".";t
t <- table(ds$GSMOKNOW, ds$study_name); t[t=="0"]<-".";t
t <- table(ds$BR0010, ds$study_name); t[t=="0"]<-".";t
t <- table(ds$BR0020, ds$study_name); t[t=="0"]<-".";t
t <- table(ds$BR0030, ds$study_name); t[t=="0"]<-".";t


names(main_list)
# extract specific variables from raw data sets
ds_list <- list()
for(i in studyNames){  
  keepvars <- mds_sub[mds_sub$study==i, "name"] 
  newvars <-  mds_sub[mds_sub$study==i, "item"] 
  d <- main_list[["dataFiles"]][[i]][,keepvars]
  names(d) <- newvars # rename into new item names
  ds_list[[i]] <- d
} 
names(ds_list) <- studyNames
# d <- ds_list[["alsa"]]
# head(d)

# convert dtos into a dataframe
# http://stackoverflow.com/questions/2851327/converting-a-list-of-data-frames-into-one-data-frame-in-r
ds <- plyr::ldply(ds_list, data.frame)
ds <- plyr::rename(ds, c(".id" = "study_name"))

head(ds); names(ds); names_labels(ds)

t<-table(ds$smoke_now,ds$study_name);t[t=="0"]<-".";t
t<-table(ds$smoke_pipecigar,ds$study_name);t[t=="0"]<-".";t
t<-table(ds$smoke_history,ds$study_name);t[t=="0"]<-".";t
t<-table(ds$smoke_history2, ds$study_name);t[t=="0"]<-".";t
t<-table(ds$smoke_years,ds$study_name);t[t=="0"]<-".";t



















