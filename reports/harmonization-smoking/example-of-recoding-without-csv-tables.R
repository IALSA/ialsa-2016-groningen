# ---- target-1-alsa-3 -------------------------------------------------
ds$SMOKER <- as.character(ds$SMOKER) 
ds$PIPCIGAR <- as.character(ds$PIPCIGAR) 
# apply harmonization algorythm to generate values for `h_smoke_now`

ds$h_smoke_now[ds$SMOKER=="Yes" & ds$PIPCIGAR=="Yes" ] <- "YES"
ds$h_smoke_now[ds$SMOKER=="Yes" & ds$PIPCIGAR=="No" ] <- "YES"
ds$h_smoke_now[ds$SMOKER=="No" & ds$PIPCIGAR=="Yes" ] <- "YES"
ds$h_smoke_now[ds$SMOKER=="No" & is.na(ds$PIPCIGAR) ] <- "NO"
ds$h_smoke_now[is.na(ds$SMOKER) & is.na(ds$PIPCIGAR) ] <- NA

# verify  the logic of recoding
ds %>% 
  dplyr::filter(study_name=="alsa") %>%
  dplyr::group_by(SMOKER, PIPCIGAR, h_smoke_now) %>% 
  dplyr::summarize(count = n()) 




# ---- target-1-lbsl-1 -------------------------------------------------
# view data schema candidates 
dto[["metaData"]] %>% 
  dplyr::filter(study_name=="lbsl", construct == "smoking") %>% 
  dplyr::select(name,label)

# ---- target-1-lbsl-2 -------------------------------------------------
# view the joint profile of responses
ds %>% 
  dplyr::filter(study_name=="lbsl") %>%
  dplyr::group_by(SMK94, SMOKE) %>% 
  dplyr::summarize(count = n()) 

# ---- target-1-lbsl-3 -------------------------------------------------
ds$SMK94 <- as.character(ds$SMK94) 
ds$SMOKE <- as.character(ds$SMOKE) 
# apply harmonization algorythm to generate values for `h_smoke_now`

ds$h_smoke_now[ds$SMK94=="no" & ds$SMOKE=="smoke at present time" ] <- "YES"
ds$h_smoke_now[ds$SMK94=="no" & ds$SMOKE=="don't smoke at present but smoked in the past" ] <- "NO"
ds$h_smoke_now[ds$SMK94=="no " & ds$SMOKE=="never smoked" ] <- "NO"
ds$h_smoke_now[ds$SMK94=="no " & is.na(ds$SMOKE) ] <- "NO"
ds$h_smoke_now[ds$SMK94=="yes " & ds$SMOKE=="never smoked" ] <- "NO"
ds$h_smoke_now[ds$SMK94=="yes " & ds$SMOKE=="never smoked" ] <- "NO"
ds$h_smoke_now[is.na(ds$SMK94)  & ds$SMOKE=="never smoked" ] <- "NO"
ds$h_smoke_now[is.na(ds$SMK94)  & ds$SMOKE=="never smoked" ] <- "NO"
ds$h_smoke_now[is.na(ds$SMK94)  & is.na(ds$SMOKE) ] <- NA

ds$h_smoke_now[ds$SMK94=="No" & is.na(ds$SMOKE) ] <- "NO"
ds$h_smoke_now[is.na(ds$SMK94) & is.na(ds$SMOKE) ] <- NA

# verify  the logic of recoding
ds %>% 
  dplyr::filter(study_name=="alsa") %>%
  dplyr::group_by(SMOKER, PIPCIGAR, h_smoke_now) %>% 
  dplyr::summarize(count = n()) 

