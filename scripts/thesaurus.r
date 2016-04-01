# ---- describe-renaming-scheme --------------------------
library(magrittr)

study_name <- c( "alsa",  "alsa",  "lbsl",  "lbsl",  "satsa", "satsa", "satsa", "share", "share", "share", "tilda", "tilda", "tilda", "tilda") 
name_new   <-  c("smoke_now", "smoke_pipecigar", "smoke_history"   ,"smoke_now", "smoke_history", "smoke_now" , "snuff_history", "smoke_history", "smoke_now", "smoke_years" , "smoke_age", "smoke_history", "smoke_history2", "smoke_now") 
name_old <-  c("SMOKER","PIPCIGAR","SMOKE","SMK94","GEVRSMK","GSMOKNOW","GEVRSNS","BR0010","BR0020","BR0030","BH003","BH001","BEHSMOKER","BH002")

length(study_name)
length(name_new)
d <- data.frame(
  study_name = study_name,
  name_new   = name_new,
  name_old =  name_old
  )
d

table(d$name_old, d$name_new)



# ---- how-to-pass-vector-of-strings-to-group-by --------------------
# define function to extract profiles
response_profile <- function(dto, h_target, study, varnames_values){
  ds <- dto[["unitData"]][[study]]
  varnames_values <- lapply(varnames_values, as.symbol)   # Convert character vector to list of symbols
  d <- ds %>% 
    dplyr::group_by_(.dots=varnames_values) %>% 
    dplyr::summarize(count = n()) 
  write.csv(d,paste0("./data/shared/derived/response-profiles/",h_target,"-",study,".csv"))
}
# extract response profile for data schema set from each study
for(s in names(schema_sets)){
  response_profile(dto,
                   study = s,
                   h_target = 'smoking',
                   varnames_values = schema_sets[[s]]
  )
}
