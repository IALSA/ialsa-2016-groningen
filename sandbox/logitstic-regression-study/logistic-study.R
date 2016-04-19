# This report conducts harmonization procedure 
# knitr::stitch_rmd(script="./___/___.R", output="./___/___/___.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console 

# the starter example taken from http://stackoverflow.com/questions/26694931/how-to-plot-logit-and-probit-in-ggplot2

library(ggplot2)

# Generate data
mydata <- data.frame(
 covar3 = c(1,0,1,1,1,1,1,0,0,0,1,1,0,0,1,1,0,1,1,1,1,0,0), 
 covar2 = c(1, 6, 11, 16, 21, 2, 7, 12, 17, 22, 3, 8, # Ft
        13, 18, 23, 4, 9, 14, 19, 5, 10, 15, 20),
 covar1 = c(66, 72, 70, 75, 75, 70, 73, 78, 70, 76, 69, 70, # Temp
          67, 81, 58, 68, 57, 53, 76, 67, 63, 67, 79),
 outcome = c(0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, #TD
        0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0)
)
mydata


# ---- single-predictor -------------------------------------

# Run logistic regression model
model <- glm(outcome ~ covar1, data=mydata, family=binomial(link="logit"))

# Create a temporary data frame of hypothetical values
temp.data <- data.frame(covar1 = seq(53, 81, 0.5))

# Predict the fitted values given the model and hypothetical data
predicted.data <- as.data.frame(predict(model, newdata = temp.data, 
                                        type="link", se=TRUE))

# Combine the hypothetical data and predicted values
new.data <- cbind(temp.data, predicted.data)

# Calculate confidence intervals
std <- qnorm(0.95 / 2 + 0.5)
new.data$ymin <- model$family$linkinv(new.data$fit - std * new.data$se)
new.data$ymax <- model$family$linkinv(new.data$fit + std * new.data$se)
new.data$fit <- model$family$linkinv(new.data$fit)  # Rescale to 0-1

# Plot everything
p <- ggplot(mydata, aes(x=covar1, y=outcome)) 
p + geom_point() + 
  geom_ribbon(data=new.data, aes(y=fit, ymin=ymin, ymax=ymax), alpha=0.5) + 
  geom_line(data=new.data, aes(y=fit)) + 
  labs(x="Temperature", y="Thermal Distress")



# ---- two-predictors --------------
# Alternative, if you want to go crazy
# Run logistic regression model with two covariates
# Run logistic regression model with two covariates
model_formula <- as.formula(outcome ~ covar1 + covar2)

model <- glm(model_formula, data=mydata, family=binomial(link="logit"))

# Create a temporary data frame of hypothetical values
temp.data <- data.frame(covar1 = rep(seq(53, 81, 0.5), 2), # Temp
                        covar2 = c(rep(3, 57), rep(18, 57))) # Ft

# Predict the fitted values given the model and hypothetical data
predicted.data <- as.data.frame(predict(model, newdata = temp.data, 
                                        type="link", se=TRUE))

# Combine the hypothetical data and predicted values
new.data <- cbind(temp.data, predicted.data)

# Calculate confidence intervals
std <- qnorm(0.95 / 2 + 0.5)
new.data$ymin <- model$family$linkinv(new.data$fit - std * new.data$se)
new.data$ymax <- model$family$linkinv(new.data$fit + std * new.data$se)
new.data$fit <- model$family$linkinv(new.data$fit)  # Rescale to 0-1

# Plot everything
p <- ggplot(mydata, aes(x=covar1, y=outcome)) 
p + geom_point() + 
  geom_ribbon(data=new.data, aes(y=fit, ymin=ymin, ymax=ymax, 
                                 fill=as.factor(covar2)), alpha=0.5) + 
  geom_line(data=new.data, aes(y=fit, colour=as.factor(covar2))) + 
  labs(x="Temperature", y="Thermal Distress") 


# ---- three-predictors --------------
# Alternative, if you want to go crazy

mydata <- data.frame(
  covar3 = c(1,0,1,1,1,1,1,0,0,0,1,1,0,0,1,1,0,1,1,1,1,0,0), 
  covar2 = c(1,0,0,1,1,0,1,1,1,1,0,0,1,0,1,1,1,1,1,0,0,0,1),
  covar1 = c(66, 72, 70, 75, 75, 70, 73, 78, 70, 76, 69, 70, # Temp
             67, 81, 58, 68, 57, 53, 76, 67, 63, 67, 79),
  outcome = c(0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, #TD
              0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0)
)
mydata
# Run logistic regression model with two covariates
# model_formula <- as.formula(outcome ~ covar1 + covar2 + covar3)
model_formula <- as.formula(outcome ~ covar1 + covar2 + covar3)

model <- glm(model_formula, data=mydata, family=binomial(link="logit"))

# Create a temporary data frame of hypothetical values
temp.data <- as.data.frame(mydata %>% 
  dplyr::select(covar1, covar2, covar3))

# Create a temporary data frame of hypothetical values
# temp.data <- data.frame(covar1 = rep(seq(53, 81, 0.5), 2), # Temp
#                         covar2 = c(rep(3, 57), rep(18, 57))) # Ft

# Predict the fitted values given the model and hypothetical data
predicted.data <- as.data.frame(predict(model, newdata = temp.data, 
                                        type="link", se=TRUE))

# Combine the hypothetical data and predicted values
new.data <- cbind(temp.data, predicted.data)

# Calculate confidence intervals
std <- qnorm(0.95 / 2 + 0.5)
new.data$ymin <- model$family$linkinv(new.data$fit - std * new.data$se)
new.data$ymax <- model$family$linkinv(new.data$fit + std * new.data$se)
new.data$fit <- model$family$linkinv(new.data$fit)  # Rescale to 0-1

# Plot everything
p <- ggplot(mydata, aes(x=covar1, y=outcome)) 
p + geom_point() + 
  # geom_ribbon(data=new.data, aes(y=fit, ymin=ymin, ymax=ymax, 
  #                                fill=as.factor(covar2)), alpha=0.5) + 
  # geom_line(data=new.data, aes(y=fit, colour=as.factor(covar2))) + 
  geom_ribbon(data=new.data, aes(y=fit, ymin=ymin, ymax=ymax, 
                                 fill=as.factor(covar3)), alpha=0.5) + 
  geom_line(data=new.data, aes(y=fit, colour=as.factor(covar3))) + 
  labs(x="Temperature", y="Thermal Distress") 
