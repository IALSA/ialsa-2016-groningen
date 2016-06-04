
###################################
#### REPORTING FUNCTIONS ####################
#########################################

# ----- compare-custom-and-subset-local ----------------
# Review models

# local_custom_object = local_custom_plus
# local_subset_object = local_BB_bs
#   
compare_local_solutions <- function(
  local_custom_object, 
  baseline_model="BB", 
  local_subset_object, 
  study_name_){
  
  model_object <- local_custom_object[[baseline_model]][[study_name_]]
  subset_object <- local_subset_object[[study_name_]]
  
  print(subset_object) # results of the best subset search
  print(plot(subset_object)) # red line: models whose AICc is more than 2 units away from "best" 
  
  tmp <- weightable(subset_object)
  tmp <- tmp[tmp$aicc <= min(tmp$aicc) + 2,][1:10,]
  tmp$model_rank <- c(1:length(tmp$aicc))
  tmp$model <- NULL
  akaike_weights <- tmp %>% dplyr::select(model_rank, aicc, weights)
  print(knitr::kable(akaike_weights)) # weight could be thought of as the probability that model is the "best"
  print(plot(subset_object, type="s")) # average importance of terms 
  print(model_object$formula, showEnv = F)
  print(knitr::kable(basic_model_info(model_object)))
  # print(model_report(model_object, subset_object))
  cat("\n Best subset selection using the same predictors : ")
  (top_models <- basic_model_info(subset_object@objects[[1]]))
  for(i in 2:5){
    top_models <- rbind(top_models, basic_model_info(subset_object@objects[[i]]))
  }
  print(knitr::kable(top_models))
  cat("\n")
  for(i in 1:5){
    cat("Model",i," : ", sep="")
    print(subset_object@formulas[[i]], showEnv = F)
  }
}

# compare_local_solutions(
#   local_custom_object = local_custom_plus, 
#        baseline_model = "BB",
#   local_subset_object = local_BB_bs, 
#           study_name_ = "alsa"
# ) 

# compare_local_solutions(local_custom_plus,"BB",local_BB_bs, "alsa")


# ---- functions-to-make-results-table ------------------

display_odds_prepare <- function(model_object, model_label){
  x <- make_result_table(model_object)
  x$display_odds <- paste0(x$odds,x$odds_ci,x$sign)
  # x$display_odds <- paste0(x$sign,x$odds,x$odds_ci)
  # x$display_odds <- paste0(x$odds,x$sign ,x$odds_ci)
  # x$display_odds <- paste0(x$odds," ",x$sign)  
  x <- x[, c("coef_name", "display_odds")]
  x <- plyr::rename(x, replace = c("display_odds" = model_label))
  return(x)
}

# list_object must contain five elements : (A, B, AA, BB, best)
# each element is a glm object
# list object = pooled_custom_plus  or list_object = local_custom_plus
# given a list with glm objects as elements produces a display table for each
# BETWEEN model comparison 
make_display_table <- function(list_object){
  (a <- display_odds_prepare(list_object[["A"]], "A"))
  (aa <- display_odds_prepare(list_object[["AA"]], "AA"))
  (b <- display_odds_prepare(list_object[["B"]], "B"))
  (bb <- display_odds_prepare(list_object[["BB"]],"BB"))
  (best <- display_odds_prepare(list_object[["best"]],"best"))
  
  d1 <- bb %>% dplyr::left_join(aa, by = "coef_name")
  d2 <- d1 %>% dplyr::left_join(b, by = "coef_name")
  d3 <- d2 %>% dplyr::left_join(a, by = "coef_name")
  # d_results <- d3 %>% dplyr::select_("coef_name","A","B","AA", "BB")
  d4 <- d3 %>% dplyr::left_join(best, by = "coef_name")
  d_results <- d4 %>% dplyr::select_("coef_name","A","B","AA", "BB","best")
  d_results[is.na(d_results)] <- ""
  return(d_results)
}

# local_list_object must contain five elements : (A, B, AA, BB, best) 
# each of which contains five elements : (alsa, lbsl, satsa, share, tilda)
# each of which is a glm object
# local_list_object <- local_custom_plus
# BETWEEN model comparison 
make_study_table <- function(local_list_object, study_name_){
  a <- local_list_object[["A"]][[study_name_]]
  aa <- local_list_object[["AA"]][[study_name_]]
  b <- local_list_object[["B"]][[study_name_]]
  bb <- local_list_object[["BB"]][[study_name_]]
  best <- local_list_object[["best"]][[study_name_]]
  
  l_results <- list("A" = a,"AA" = aa,"B" = b, "BB" = bb, "best" = best)
  # l_results <- list("A" = a,"AA" = aa,"B" = b, "BB" = bb)
  results_table <- make_display_table(l_results)
  return(results_table)
}
# alsa_table <- make_study_table(local_custom_plus, "alsa")



# ---- define-modeling-functions -------------------------
# model_object = best_local_A

# ---- model-solution-table ---------------------------------------

# given a glm object produces a table of model information indices
basic_model_info <- function(model_object, eq=F){
  if(eq){
    cat("Model equation :")
    print(model_object$formula, showEnv = F)
    cat("\n")
  }
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


# given a glm object computes odds and creates a results table
make_result_table <- function(model_object){ 
  (cf <- summary(model_object)$coefficients)
  # (cf <- model_object$coefficients)
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


# work only when includeobjects = T in the glmulti call
# given a subset object shows the top five models 
show_best_subset <- function(subset_object){
  (top_models <- basic_model_info(subset_object@objects[[1]]))
  for(i in 2:5){
    top_models <- rbind(top_models, basic_model_info(subset_object@objects[[i]]))
  }
  print(knitr::kable(top_models))
  cat("\n")
  for(i in 1:5){
    cat("Model ",i," : ", sep="")
    print(subset_object@formulas[[i]], showEnv = F)
  }
}

# work only when includeobjects = T in the glmulti call
# Print model report comparing a custom model with a subset object
model_report <- function(model_object, subset_object){ 
  # cat("Fitted model || ")
  print(model_object$formula, showEnv = F)
  # cat("Model Information \n")
  print(knitr::kable(basic_model_info(model_object)))
  cat("\n Best subset selection using the same predictors : \n\n")
  print(show_best_subset(subset_object))  
} 




###################################
#### ESTIMATION FUNCTIONS ####################
#########################################


# Custom model estimation
estimate_pooled_model <- function(data, predictors){
  eq_formula <- as.formula(paste0(pooled_stem, predictors))
  print(eq_formula, showEnv = FALSE)
  models <- glm(eq_formula, data = data, family = binomial(link="logit")) 
  basic_model_info(models)
  return(models)
}

# estimate model locally within each study
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



# Best Subset estimation

# Define a general function
estimate_best_subset <- function(data, predictors, eq_formula, level, method, plotty, includeobjects){
  # eq_formula <- as.formula(paste0(local_stem, predictors))
  best_subset_local <- glmulti::glmulti(
    eq_formula,
    data = data,
    level = level,           # 1 = No interaction considered
    method = method,            # Exhaustive approach
    crit = "aicc",            # AIC as criteria
    confsetsize = 100,         # Keep 5 best models
    plotty = plotty, report = T,  # No plot or interim reports
    fitfunction = "glm",     # glm function
    family = binomial,       # binomial family for logistic regression family=binomial(link="logit")
    includeobjects = includeobjects
  )
}
# Define specific function for (pooled)
estimate_pooled_model_best_subset <- function(data, predictors, level, method, plotty, includeobjects){
  eq_formula <- as.formula(paste0(pooled_stem, predictors))
  print(eq_formula, showEnv = FALSE)
  best_subset <- estimate_best_subset(data=data,predictors,eq_formula, level, method, plotty, includeobjects)
  if(length(best_subset@objects)>1L ){
    show_best_subset(best_subset)
  }
  return(best_subset)
}
# Define specific function for (study local)
estimate_local_models_best_subset <- function(data, predictors, level, method, plotty, includeobjects){
  eq_formula <- as.formula(paste0(local_stem, predictors))
  print(eq_formula, showEnv = FALSE)
  model_study_list <- list()
  for(study_name_ in as.character(sort(unique(data$study_name)))){
    d_study <- data[data$study_name==study_name_, ]
    # browser()
    best_subset_local <- estimate_best_subset(data=d_study,predictors,eq_formula, level, method, plotty, includeobjects)
    model_study_list[[study_name_]] <- best_subset_local
  }
  return(model_study_list)
}

# for(i in 1:5){  
#   cat("Model ",i," : ", sep="")
#   print(models@formulas[[i]], showEnv = F)  
# } 
# for(i in 1:5){  
#   basic_model_info(models@objects[[i]])
# } 




# # Print local model report
# local_model_report <- function(data, model_object, best_subset){
#   for(study_name_ in as.character(sort(unique(data$study_name))) ){
#     cat("Study : ", study_name_, "\n",sep="")
#     # model_object = local_A[[study_name_]]
#     # best_subset  = local_A_bs[[study_name_]]
#     model_report(model_object= model_object, best_subset = best_subset)
#     cat("\n\n")
#   }
# }
