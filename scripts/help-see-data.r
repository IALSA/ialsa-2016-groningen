studyNames <- c("alsa", "lbsl", "satsa", "share", "tilda")

ds <- data_list[["tilda"]]

names(ds)

# if equal than truely unuique id
length(unique(ds[["SEQNUM"]])); nrow(ds)
length(unique(ds[["ID"]])); nrow(ds)
length(unique(ds[["TWINNR"]])); nrow(ds)
length(unique(ds[["SAMPID.rec"]])); nrow(ds)

ds %>% dplyr::group_by_("AGE") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("AGE94") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("DN0030") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("CM003") %>% dplyr::summarize(count = n())


ds %>% dplyr::group_by_("SEX") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("SEX94") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("GENDER") %>% dplyr::summarize(count = n())

ds %>% dplyr::group_by_("MARITST") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("MSTAT94") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("GMARITAL") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("DN0140") %>% dplyr::summarize(count = n())


ds %>% dplyr::group_by_("SCHOOL") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("TYPQUAL") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("EDUC94") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("EDUC") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("DN0100") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("DM001") %>% dplyr::summarize(count = n())

ds %>% dplyr::group_by_("RETIRED") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("NOWRK94") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("GAMTWORK") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("EP0050") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("WE001") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("WE003") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("WE106") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("WE601") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("WE610") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("EMP3") %>% dplyr::summarize(count = n())


ds %>% dplyr::group_by_("YRBORN") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("QAGE3") %>% dplyr::summarize(count = n())

# tilda
ds %>% dplyr::group_by_("CS006") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("SOCMARRIED") %>% dplyr::summarize(count = n())
ds %>% dplyr::group_by_("MAR4") %>% dplyr::summarize(count = n())

