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
(studyNames <- main_list[["studyName"]])
# 2nd element - file paths of the data files for each study
main_list[["filePath"]]
# 3rd element - list objects with 
names(main_list[["dataFiles"]])
dplyr::tbl_df(main_list[["unitData"]][["alsa"]]) 
# 4th element - dataset with augmented names and labels for variables from all involved studies
dplyr::tbl_df(main_list[["metaData"]])

# ---- inspect-data -------------------------------------------------------------

# ---- tweak-data --------------------------------------------------------------

# ---- generate-report -------------------------
ls <- main_list
function1 <- function(ls){ 
  for(s in studyNames){ # s <- "alsa"
    ds <- ls[["unitData"]][[s]]  
    mds <- ls[["metaData"]]
    varnames <- names(ds)
    cat("\n") # force new line
    cat(paste0("### ", toupper(s))) 
        
    for(v in varnames){ # v <- "SMOKER"
      cat("\n") # force new line
      cat(paste0("#### ", v))
      # (label <- as.character(mds[mds$name==v,"label"])) # from metadata
      (label <- attr(ds[,v], "label")) # original label
      if( is.factor(ds[,v])){
      # g <-histogram_discrete(ds, v)
        table(ds[,v])
      }
      if(is.numeric(ds[,v])){
      # g <-histogram_continuous(ds,v)
      }
      # return(g)
    }
  } 
} 

function1(ls)
