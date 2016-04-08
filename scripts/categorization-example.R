
# export categories
categorization_profile <- function(dto, study, variable_name){
  ds <- dto[["unitData"]][[study]]
  variable_name <- lapply(variable_name, as.symbol)   # Convert character vector to list of symbols
  d <- ds %>% 
    dplyr::group_by_(.dots=variable_name) %>% 
    dplyr::summarize(count = n()) 
  write.csv(d,paste0("./data/meta/categorization-live/",study,"-",variable_name,".csv"))
}
categorization_profile(dto,"share","BR0030")

# import and apply categorization rules
study_name <- "share"
path_to_crule <- "./data/meta/c-rules/c-rules-share-BR0030.csv"
dto[["unitData"]][[study_name]] <- recode_with_crule(
  dto,
  study_name = study_name, 
  variable_names = c("BR0030"), 
  categorization_name = "decades_smoked"
)
# verify rules
dto[["unitData"]][["share"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "BR0030", "decades_smoked")
# frequencies
dto[["unitData"]][["share"]] %>%
  dplyr::group_by_("decades_smoked") %>% 
  dplyr::summarise(average_years = mean(BR0030),
                   sd = sd(BR0030),
                   count = n())

# convert to an ordered factor
order_in_factor <- c("less than a year","1-10 years","11-20 years","21-30 years","31-40 years","41-50 years","51+ years")
ds$decades_smoked <- ordered(ds$decades_smoked, labels = order_in_factor)
ds %>% dplyr::group_by(decades_smoked) %>% dplyr::summarize(count=n())
# attach modified dataset to dto, local to this report
dto[["unitData"]][["share"]] <- ds
dto[["unitData"]][["share"]] %>% histogram_discrete("decades_smoked")






# ---- II-A-categorization-3 ----------------------
dto[["metaData"]] %>% dplyr::filter(study_name=="tilda", name=="BH003") %>% dplyr::select(name,label)
dto[["unitData"]][["tilda"]] %>% dplyr::filter(!BH003==-1) %>% histogram_continuous("BH003", bin_width=1)
# categorize continuous variable BH003 of TILDA
ds <- dto[["unitData"]][["tilda"]]


# export categories
categorization_profile(dto,"tilda","BH003")

# import and apply categorization rules
study_name <- "tilda"
path_to_crule <- "./data/meta/c-rules/c-rules-tilda-BH003.csv"
dto[["unitData"]][[study_name]] <- recode_with_crule(
  dto,
  study_name = study_name, 
  variable_names = c("BH003"), 
  categorization_name = "smoke_stop_decade"
)
# verify rules
dto[["unitData"]][["tilda"]] %>%
  dplyr::filter(id %in% sample(unique(id),10)) %>%
  dplyr::select_("id", "BH003", "smoke_stop_decade")
# frequencies
dto[["unitData"]][["tilda"]] %>%
  dplyr::group_by_("smoke_stop_decade") %>% 
  dplyr::summarise(ave_duration_years = mean(BH003),
                   sd = sd(BH003),
                   count = n())

dto[["unitData"]][["tilda"]] %>% dplyr::group_by(smoke_stop_decade) %>% dplyr::summarize(count=n())
# attach modified dataset to dto, local to this report
dto[["unitData"]][["tilda"]] %>% histogram_discrete("smoke_stop_decade")
