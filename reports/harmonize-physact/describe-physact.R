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
# 3rd element - list objects with the following elements
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


# ----- view-metadata ---------------------------------------------
# view metadata for the construct of age
seeitems <- dto[["metaData"]] %>%
  dplyr::filter(construct %in% c('physact')) %>% 
  dplyr::select(-item, -url, -label, -notes, -construct, -type, -categories) %>%
  dplyr::arrange(study_name, name) %>%
  base::print()  
seeitems %>% dplyr::select(-label_short)

# ----- alsa-EXRTHOUS ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="alsa", name=="EXRTHOUS")%>%dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>%histogram_discrete("EXRTHOUS")
dto[["unitData"]][["alsa"]]%>%dplyr::group_by_("EXRTHOUS")%>%dplyr::summarize(n=n())

# ----- alsa-HWMNWK2W ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="HWMNWK2W") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>% histogram_continuous("HWMNWK2W", bin_width=1)
dto[["unitData"]][["alsa"]]%>% dplyr::group_by_("HWMNWK2W") %>% dplyr::summarize(n=n())

# ----- alsa-LSVEXC2W ---------------------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="alsa", name=="LSVEXC2W") %>% dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>% histogram_continuous("LSVEXC2W", bin_width=1)
dto[["unitData"]][["alsa"]]%>% dplyr::group_by_("LSVEXC2W") %>% dplyr::summarize(n=n())


# ----- alsa-LSVIGEXC ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="alsa", name=="LSVIGEXC")%>%dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>%histogram_discrete("LSVIGEXC")
dto[["unitData"]][["alsa"]]%>%dplyr::group_by_("LSVIGEXC")%>%dplyr::summarize(n=n())

# ----- alsa-TMHVYEXR ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="alsa", name=="TMHVYEXR")%>%dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>%histogram_continuous("TMHVYEXR", bin_width=5)
dto[["unitData"]][["alsa"]]%>%dplyr::group_by_("TMHVYEXR")%>%dplyr::summarize(n=n())

# ----- alsa-TMVEXC2W ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="alsa", name=="TMVEXC2W")%>%dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>%histogram_continuous("TMVEXC2W", bin_width=60)
dto[["unitData"]][["alsa"]]%>%dplyr::group_by_("TMVEXC2W")%>%dplyr::summarize(n=n())

# ----- alsa-VIGEXC2W ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="alsa", name=="VIGEXC2W")%>%dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>%histogram_continuous("VIGEXC2W", bin_width=1)
dto[["unitData"]][["alsa"]]%>%dplyr::group_by_("VIGEXC2W")%>%dplyr::summarize(n=n())

# ----- alsa-VIGEXCS ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="alsa", name=="VIGEXCS")%>%dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>%histogram_discrete("VIGEXCS")
dto[["unitData"]][["alsa"]]%>%dplyr::group_by_("VIGEXCS")%>%dplyr::summarize(n=n())

# ----- alsa-WALK2WKS ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="alsa", name=="WALK2WKS")%>%dplyr::select(name,label)
dto[["unitData"]][["alsa"]]%>%histogram_discrete("WALK2WKS")
dto[["unitData"]][["alsa"]]%>%dplyr::group_by_("WALK2WKS")%>%dplyr::summarize(n=n())





# ----- lbsl-CHORE94 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="lbsl", name=="CHORE94")%>%dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>%histogram_continuous("CHORE94", bin_width=1)
dto[["unitData"]][["lbsl"]]%>%dplyr::group_by_("CHORE94")%>%dplyr::summarize(n=n())


# ----- lbsl-DANCE94 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="lbsl", name=="DANCE94")%>%dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>%histogram_continuous("DANCE94", bin_width=1)
dto[["unitData"]][["lbsl"]]%>%dplyr::group_by_("DANCE94")%>%dplyr::summarize(n=n())


# ----- lbsl-EXCERTOT ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="lbsl", name=="EXCERTOT")%>%dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>%histogram_continuous("EXCERTOT", bin_width=1)
dto[["unitData"]][["lbsl"]]%>%dplyr::group_by_("EXCERTOT")%>%dplyr::summarize(n=n())


# ----- lbsl-EXCERWK ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="lbsl", name=="EXCERWK")%>%dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>%histogram_continuous("EXCERWK", bin_width=1)
dto[["unitData"]][["lbsl"]]%>%dplyr::group_by_("EXCERWK")%>%dplyr::summarize(n=n())


# ----- lbsl-FIT94 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="lbsl", name=="FIT94")%>%dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>%histogram_continuous("FIT94", bin_width=1)
dto[["unitData"]][["lbsl"]]%>%dplyr::group_by_("FIT94")%>%dplyr::summarize(n=n())


# ----- lbsl-SPEC94 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="lbsl", name=="SPEC94")%>%dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>%histogram_continuous("SPEC94", bin_width=1)
dto[["unitData"]][["lbsl"]]%>%dplyr::group_by_("SPEC94")%>%dplyr::summarize(n=n())


# ----- lbsl-SPORT94 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="lbsl", name=="SPORT94")%>%dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>%histogram_continuous("SPORT94", bin_width=1)
dto[["unitData"]][["lbsl"]]%>%dplyr::group_by_("SPORT94")%>%dplyr::summarize(n=n())


# ----- lbsl-WALK94 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="lbsl", name=="WALK94")%>%dplyr::select(name,label)
dto[["unitData"]][["lbsl"]]%>%histogram_continuous("WALK94", bin_width=1)
dto[["unitData"]][["lbsl"]]%>%dplyr::group_by_("WALK94")%>%dplyr::summarize(n=n())






# ----- satsa-GEXERCIS ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="satsa", name=="GEXERCIS")%>%dplyr::select(name,label)
dto[["unitData"]][["satsa"]]%>%histogram_discrete("GEXERCIS")
dto[["unitData"]][["satsa"]]%>%dplyr::group_by_("GEXERCIS")%>%dplyr::summarize(n=n())


# ----- share-BR0150 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="share", name=="BR0150")%>%dplyr::select(name,label)
dto[["unitData"]][["share"]]%>%histogram_discrete("BR0150")
dto[["unitData"]][["share"]]%>%dplyr::group_by_("BR0150")%>%dplyr::summarize(n=n())

# ----- share-BR0160 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="share", name=="BR0160")%>%dplyr::select(name,label)
dto[["unitData"]][["share"]]%>%histogram_discrete("BR0160")
dto[["unitData"]][["share"]]%>%dplyr::group_by_("BR0160")%>%dplyr::summarize(n=n())





# ----- tilda-BH101 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="BH101")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%histogram_discrete("BH101")
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("BH101")%>%dplyr::summarize(n=n())


# ----- tilda-BH102 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="BH102")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]] %>% dplyr::filter(!BH102==-1)%>%histogram_discrete("BH102")
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("BH102")%>%dplyr::summarize(n=n())

# ----- tilda-BH102A ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="BH102A")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% dplyr::filter(!BH102A==-1)%>%histogram_continuous("BH102A", bin_width=5)
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("BH102A")%>%dplyr::summarize(n=n())

# ----- tilda-BH103 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="BH103")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%histogram_discrete("BH103")
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("BH103")%>%dplyr::summarize(n=n())

# ----- tilda-BH104 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="BH104")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% dplyr::filter(!BH104==-1)%>%histogram_continuous("BH104", bin_width=1)
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("BH104")%>%dplyr::summarize(n=n())

# ----- tilda-BH104A ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="BH104A")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% dplyr::filter(!BH104A==-1)%>%histogram_continuous("BH104A", bin_width=5)
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("BH104A")%>%dplyr::summarize(n=n())

# ----- tilda-BH105 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="BH105")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%histogram_discrete("BH105")
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("BH105")%>%dplyr::summarize(n=n())

# ----- tilda-BH106 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="BH106")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%histogram_discrete("BH106")
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("BH106")%>%dplyr::summarize(n=n())

# ----- tilda-BH106A ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="BH106A")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>% dplyr::filter(!BH106A==-1)%>%histogram_continuous("BH106A", bin_width=1)
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("BH106A")%>%dplyr::summarize(n=n())

# ----- tilda-BH107 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="BH107")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%histogram_continuous("BH107")
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("BH107")%>%dplyr::summarize(n=n())

# ----- tilda-BH107A ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="BH107A")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%histogram_continuous("BH107A")
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("BH107A")%>%dplyr::summarize(n=n())

# ----- tilda-IPAQEXERCISE3 ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="IPAQEXERCISE3")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%histogram_continuous("IPAQEXERCISE3", bin_width = 500)
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("IPAQEXERCISE3")%>%dplyr::summarize(n=n())

# ----- tilda-IPAQMETMINUTES ---------------------------------
dto[["metaData"]]%>%dplyr::filter(study_name=="tilda", name=="IPAQMETMINUTES")%>%dplyr::select(name,label)
dto[["unitData"]][["tilda"]]%>%histogram_continuous("IPAQMETMINUTES", bin_width = 500)
dto[["unitData"]][["tilda"]]%>%dplyr::group_by_("IPAQMETMINUTES")%>%dplyr::summarize(n=n())




# ---- reproduce ---------------------------------------
rmarkdown::render(
          input = "./reports/harmonize-physact/describe-physact.Rmd",
  output_format = "html_document", 
          clean = TRUE
)


























