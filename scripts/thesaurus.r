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
