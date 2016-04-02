# encode a multi-state variable useing csv mapping
recode_with_hrule <- function(dto, study_name, variable_names, harmony_name){
  unitData <- dto[["unitData"]][[study_name]] 
  (hrule <- read.csv(path_to_hrule, stringsAsFactors = F, na.strings = "NA"))
  stem_name <- c("id",variable_names)
  d <- dto[["unitData"]][[study_name]] %>% 
    dplyr::select_(.dots=stem_name)
  # head(d); str(d)
  for(i in variable_names){
    d[,i] <- as.character(d[,i])
  }
  # head(d); str(d)
  # head(hrule);str(hrule)
  dd <- base::merge(d, hrule[ ,c(variable_names, harmony_name)], by=variable_names, all.x=T)  
  # head(dd)
  # verify
  dots_name <- lapply(c(variable_names, harmony_name), as.symbol)
  dd %>% dplyr::group_by_(.dots=dots_name)%>%
    dplyr::summarize(n=n()) %>% print(n=100)
  # append multistate variable to the original data
  # names(dd)
  dd <- dd[,c("id",harmony_name)]
  unitData <- unitData %>% 
    dplyr::left_join(dd, by = "id") 
  # head(unitData %>% dplyr::select(id, SMOKER, PIPCIGAR, smoke_now))
  # unitData
  return(unitData)
}

# study_name <- "alsa"
# path_to_hrule <- "./data/shared/raw/response-profiles/h-rule-smoking-alsa.csv"
# dto[["unitData"]][[study_name]] <- recode_with_hrule(
#   dto,
#   study_name = study_name, 
#   variable_names = c("SMOKER", "PIPCIGAR"), 
#   harmony_name = "smoked_ever"
# )

# define function to extract profiles
response_profile <- function(dto, h_target, study, varnames_values){
  ds <- dto[["unitData"]][[study]]
  varnames_values <- lapply(varnames_values, as.symbol)   # Convert character vector to list of symbols
  d <- ds %>% 
    dplyr::group_by_(.dots=varnames_values) %>% 
    dplyr::summarize(count = n()) 
  write.csv(d,paste0("./data/shared/derived/response-profiles/",h_target,"-",study,".csv"))
}

# schema_sets <- list(
#   "alsa" = c("SMOKER", "PIPCIGAR"),
#   "lbsl" = c("SMK94","SMOKE"),
#   "satsa" = c("GSMOKNOW", "GEVRSMK","GEVRSNS"),
#   "share" = c("BR0010","BR0020","BR0030cat" ), # "BR0030" is continuous
#   "tilda" = c("BH001","BH002", "BEHSMOKER","BH003cat") # "BH003" is continuous
# )

# for(s in names(schema_sets))
#   response_profile(dto,
#                    study = s,
#                    h_target = 'smoking',
#                    varnames_values = schema_sets[[s]]
#                    
#   )

# ---- load-data-schema-function -----------------
# dto <- dto 
# construct_name <- "smoking"
# varname_new="item"#
# s = "alsa"
load_data_schema <- function(
  dto, # dto = dto , pass the the main data transfer object
  construct_name,# = "smoking", # select all variable classified into this construct
  varname_new="item"#, # the column in metadata that to provide new values for variable names
  # varlabel # the column in metadata to provide values for labels
  ){
  
  d_list <- list() # empty list for datasets
  n_list <- list() # empty list for names of variables
  md_sub <- dto[["metaData"]] 
  # md_sub <- md_sub %>% dplyr::filter(construct == "short_label") 
  md_sub <- md_sub[md_sub$construct == construct_name,]
  for(s in dto[["studyName"]]){  
    # s = "satsa"
    # initial name of variables
    (keepvars <- as.character(md_sub[md_sub$study==s, "name"]))
    dd <- dto[["unitData"]][[s]][,keepvars]; head(dd)
    # new names of variables
    (newvars <-  as.character(md_sub[md_sub$study==s, varname_new]))  
    d <- dd; head(d)
    names(d) <- newvars # rename into new item names
    name_new <- names(d) 
    name_old <- names(dd)
    (name_labels <- as.character(md_sub[md_sub$study==s, "label_short"])) 
    # (responses <- t(sapply(dd, levels)))
    # attr(responses, "dimnames") <- NULL
    # str(responses)
    (oldnew <- cbind(name_old, name_new, "label_short" = name_labels))
    # (oldnew <- cbind(name_new, "label_short" = name_labels, responses))
    # (oldnew <- as.data.frame(oldnew))
    n_list[[s]] <- oldnew
    d <- dplyr::bind_cols(d, dd) # bind originals
    d <- as.data.frame(d)
    for(i in names(d)){
      # i = "SMOKER"
      attr(d[,i], "label") <- paste0(as.character(md_sub[md_sub$name==i,"label_short"])) # assign label attribute
    }
    d_list[[s]] <- d
  } 
  n <- plyr::ldply(n_list, data.frame)
  n <- plyr::rename(n, c(".id" = "study_name"))
  # print(n)
  # convert dtos into a dataframe
  d <- plyr::ldply(d_list, data.frame)
  d <- plyr::rename(d, c(".id" = "study_name"))
  return(d)
}
# ds <- load_data_schema(dto,
#                        varname_new="item",
#                        construct_name = "smoking")

# ---- define_lookup_function -------------------------------------------------
# Create function that inspects names and labels
names_labels <- function(ds){
  nl <- data.frame(matrix(NA, nrow=ncol(ds), ncol=2))
  names(nl) <- c("name","label")
  for (i in seq_along(names(ds))){
    # i = 2
    nl[i,"name"] <- attr(ds[i], "names")
    if(is.null(attr(ds[[i]], "label")) ){
      nl[i,"label"] <- NA}else{
        nl[i,"label"] <- attr(ds[,i], "label")  
      }
  }
  return(nl)
}
# names_labels(ds=oneFile)

# function to create discrete histogram. taken from RAnalysisSkeleton
histogram_discrete <- function(
  d_observed,
  variable_name,
  levels_to_exclude   = character(0),
  main_title          = variable_name,
  x_title             = NULL,
  y_title             = "Number of Included Records",
  text_size_percentage= 6,
  bin_width           = 1L) {
  
  d_observed <- as.data.frame(d_observed) #Hack so dplyr datasets don't mess up things
  if( !base::is.factor(d_observed[, variable_name]) )
    d_observed[, variable_name] <- base::factor(d_observed[, variable_name])
  
  d_observed$iv <- base::ordered(d_observed[, variable_name], levels=rev(levels(d_observed[, variable_name])))
  
  ds_count <- plyr::count(d_observed, vars=c("iv"))
  # if( base::length(levels_to_exclude)>0 ) { }
  ds_count <- ds_count[!(ds_count$iv %in% levels_to_exclude), ]
  
  ds_summary <- plyr::ddply(ds_count, .variables=NULL, transform, count=freq, proportion = freq/sum(freq) )
  ds_summary$percentage <- base::paste0(base::round(ds_summary$proportion*100), "%")
  
  y_title <- base::paste0(y_title, " (n=", scales::comma(base::sum(ds_summary$freq)), ")")
  
  g <- ggplot(ds_summary, aes_string(x="iv", y="count", fill="iv", label="percentage")) +
    geom_bar(stat="identity") +
    geom_text(stat="identity", size=text_size_percentage, hjust=.8) +
    scale_y_continuous(labels=scales::comma_format()) +
    labs(title=main_title, x=x_title, y=y_title) +
    coord_flip()
  
  theme  <- theme_light(base_size=14) +
    theme(legend.position = "none") +
    theme(panel.grid.major.y=element_blank(), panel.grid.minor.y=element_blank()) +
    theme(axis.text.x=element_text(colour="gray40")) +
    theme(axis.title.x=element_text(colour="gray40")) +
    theme(axis.text.y=element_text(size=14)) +
    theme(panel.border = element_rect(colour="gray80")) +
    theme(axis.ticks.length = grid::unit(0, "cm"))
  
  return( g + theme )
}

# function to create continuous histogram. taken from RAnalysisSkeleton
histogram_continuous <- function(
  d_observed,
  variable_name,
  bin_width      = NULL,
  main_title     = variable_name,
  x_title        = paste0(variable_name, " (each bin is ", scales::comma(bin_width), " units wide)"),
  y_title        = "Frequency",
  rounded_digits = 0L
) {
  
  d_observed <- as.data.frame(d_observed) #Hack so dplyr datasets don't mess up things
  d_observed <- d_observed[!base::is.na(d_observed[, variable_name]), ]
  
  ds_mid_points <- base::data.frame(label=c("italic(X)[50]", "bar(italic(X))"), stringsAsFactors=FALSE)
  ds_mid_points$value <- c(stats::median(d_observed[, variable_name]), base::mean(d_observed[, variable_name]))
  ds_mid_points$value_rounded <- base::round(ds_mid_points$value, rounded_digits)
  
  g <- ggplot(d_observed, aes_string(x=variable_name)) +
    geom_histogram(binwidth=bin_width, fill="gray70", color="gray90", position=position_identity()) +
    geom_vline(xintercept=ds_mid_points$value, color="gray30") +
    geom_text(data=ds_mid_points, aes_string(x="value", y=0, label="value_rounded"), color="tomato", hjust=c(1, 0), vjust=.5) +
    scale_x_continuous(labels=scales::comma_format()) +
    scale_y_continuous(labels=scales::comma_format()) +
    labs(title=main_title, x=x_title, y=y_title) +
    theme_light() +
    theme(axis.ticks.length = grid::unit(0, "cm"))
  
  ds_mid_points$top <- stats::quantile(ggplot2::ggplot_build(g)$panel$ranges[[1]]$y.range, .8)
  g <- g + ggplot2::geom_text(data=ds_mid_points, ggplot2::aes_string(x="value", y="top", label="label"), color="tomato", hjust=c(1, 0), parse=TRUE)
  return( g )
}