# ---- define-modeling-functions -------------------------
# model_object = best_local_A

# ---- model-solution-table ---------------------------------------
make_result_table <- function(model_object){ 
  (cf <- summary(model_object)$coefficients)
  (ci <- exp(cbind(coef(model_object), confint(model_object))))
  if(ncol(ci)==2L){
    (ci <- t(ci)[1,])
    ds_table <- cbind.data.frame("coef_name" = rownames(cf), cf,"V1"=NA,"2.5 %" = ci[1], "97.5 %"=ci[2])
  }else{
    ds_table <- cbind.data.frame("coef_name" = rownames(cf), cf,ci)   
  }
  row.names(ds_table) <- NULL
  ds_table <- plyr::rename(ds_table, replace = c(
    "Estimate" = "estimate",
    "Std. Error"="se",
    "z value" ="zvalue",
    "Pr(>|z|)"="pvalue",
    "V1"="odds",
    "2.5 %"  = "ci95_low",
    "97.5 %"  ="ci95_high"
  ))
  # prepare for display
  ds_table$est <- gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$estimate, 2))
  ds_table$se <- gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$se, 2))
  ds_table$z <- gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$zvalue, 3))
  # ds_table$p <- gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$pvalue, 4))
  ds_table$p <- as.numeric(round(ds_table$pvalue, 4))
  ds_table$odds <- gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$odds, 2))
  ds_table$odds_ci <- paste0("(",
                             gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$ci95_low,2)), ",",
                             gsub("^([+-])?(0)?(\\.\\d+)$", "\\1\\3", round(ds_table$ci95_high,2)), ")"
  )
  
  ds_table$sign_ <- cut(
    x = ds_table$pvalue,
    breaks = c(-Inf, .001, .01, .05, .10, Inf),
    labels = c("<=.001", "<=.01", "<=.05", "<=.10", "> .10"), #These need to coordinate with the color specs.
    right = TRUE, ordered_result = TRUE
  )
  ds_table$sign <- cut(
    x = ds_table$pvalue,
    breaks = c(-Inf, .001, .01, .05, .10, Inf),
    labels = c("***", "**", "*", ".", " "), #These need to coordinate with the color specs.
    right = TRUE, ordered_result = TRUE
  )
  ds_table$display_odds <- paste0(ds_table$odds," ",ds_table$sign , "\n",  ds_table$odds_ci)
  
  ds_table <- ds_table %>% 
    dplyr::select_(
      "sign",
      "coef_name",
      "odds",
      "odds_ci",
      "est",
      "se",
      "p",
      "sign_"
    )
  
  return(ds_table)
}


# compute basic info table
# model_object = pooled_A_bs@objects[[1]]
basic_model_info <- function(model_object){
  (logLik<-logLik(model_object))
  (dev<-deviance(model_object))
  (AIC <- round(AIC(model_object),1))
  (BIC <- round(BIC(model_object),1))
  (dfF <- round(model_object$df.residual,0))
  (dfR <- round(model_object$df.null,0))
  (dfD <- dfR - dfF)
  (model_Info <- t(c("logLik"=logLik,"dev"=dev,"AIC"=AIC,"BIC"=BIC, "df_Null"=dfR, "df_Model"=dfF, "df_drop"=dfD)))
  # return(model_Info)
  model_Info <- as.data.frame(model_Info)
  return(model_Info)
  # print(knitr::kable(model_Info))
  
  # print(model_Info)
}


show_best_subset <- function(best_subset){
  (top_models <- basic_model_info(best_subset@objects[[1]]))
  # b <- data.frame(matrix(NA, nrow = 5, ncol = 7))
  for(i in 1:5){  
    cat("Model ",i," : ", sep="")
    print(best_subset@formulas[[i]], showEnv = F)  
  } 
  for(i in 2:5){  
    top_models <- rbind(top_models, basic_model_info(best_subset@objects[[i]]))
    # b[i,] <- a[i,]
    # rbind(new,a)
  } 
  # print(knitr::kable(top_models))
  return(top_models)
}




estimate_pooled_model <- function(data, predictors){
  eq_formula <- as.formula(paste0(pooled_stem, predictors))
  print(eq_formula, showEnv = FALSE)
  models <- glm(eq_formula, data = data, family = binomial(link="logit")) 
  basic_model_info(models)
  return(models)
}

estimate_pooled_model_best_subset <- function(data, predictors, level=1, method="h"){
  eq_formula <- as.formula(paste0(pooled_stem, predictors))
  print(eq_formula, showEnv = FALSE)
  best_subset <- glmulti::glmulti(
    eq_formula,
    data = data,
    level = level,           # 1 = No interaction considered
    method = method,            # Exhaustive approach
    crit = "aic",            # AIC as criteria
    confsetsize = 5,         # Keep 5 best models
    plotty = F, report = T,  # No plot or interim reports
    fitfunction = "glm",     # glm function
    family = binomial(link="logit"))       # binomial family for logistic regression family=binomial(link="logit")
  show_best_subset(best_subset)
  # for(i in 1:5){  
  #   cat("Model ",i," : ", sep="")
  #   print(models@formulas[[i]], showEnv = F)  
  # } 
  # for(i in 1:5){  
  #   basic_model_info(models@objects[[i]])
  # } 
  return(best_subset)
}

estimate_local_models <- function(data, predictors){
  eq_formula <- as.formula(paste0(local_stem, predictors))
  print(eq_formula, showEnv = FALSE)
  model_study_list <- list()
  for(study_name_ in dto[["studyName"]]){
    d_study <- data[data$study_name==study_name_, ]
    model_study <- glm(eq_formula, data=d_study,  family=binomial(link="logit")) 
    model_study_list[[study_name_]] <- model_study
  }
  return(model_study_list)
}

best_local_study <- function(data, predictors, eq_formula, level=1, method="h"){
  # eq_formula <- as.formula(paste0(local_stem, predictors))
  best_subset_local <- glmulti::glmulti(
    eq_formula,
    data = data,
    level = level,           # 1 = No interaction considered
    method = method,            # Exhaustive approach
    crit = "aic",            # AIC as criteria
    confsetsize = 5,         # Keep 5 best models
    plotty = F, report = T,  # No plot or interim reports
    fitfunction = "glm",     # glm function
    family = binomial)       # binomial family for logistic regression family=binomial(link="logit")
  
}

estimate_local_models_best_subset <- function(data, predictors, level=1){
  eq_formula <- as.formula(paste0(local_stem, predictors))
  print(eq_formula, showEnv = FALSE)
  model_study_list <- list()
  for(study_name_ in as.character(sort(unique(data$study_name)))){
    d_study <- data[data$study_name==study_name_, ]
    # browser()
    best_subset_local <- best_local_study(data=d_study,predictors,eq_formula, level)
    model_study_list[[study_name_]] <- best_subset_local
  }
  return(model_study_list)
}





model_report <- function(model_object, best_subset){ 
  # cat("Fitted model || ")
  print(model_object$formula, showEnv = F)
  # cat("Model Information \n")
  print(knitr::kable(basic_model_info(model_object)))
  cat("\n Best subset selection using the same predictors : \n\n")
  print(knitr::kable(show_best_subset(best_subset)))  
} 


local_model_report <- function(data, model_object, best_subset){
  for(study_name_ in as.character(sort(unique(data$study_name))) ){
    cat("Study : ", study_name_, "\n",sep="")
    # model_object = local_A[[study_name_]]
    # best_subset  = local_A_bs[[study_name_]]
    model_report(model_object= model_object, best_subset = best_subset)
    cat("\n\n")
  }
}
