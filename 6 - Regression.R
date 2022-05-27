## 6 - Regression
##
## Author: Bo Zhang
##
## Date Created: 5/26/2022
##
## ---------------------------
##
## Special notes:
##   for CARE 2022 students 
##
## ---------------------------

# set working directory and import Edgewater sample data
# setwd("dir")
airdata <- read.csv("Airquality.csv")
plot(airdata$CO_GT, airdata$C6H6)

# scatterplot of PT08.S1 and CO_GT
plot(CO_GT ~ PT08.S1, data = airdata)

# build a simple linear regression model using PT08.S1 to predict CO_GT
model <- lm(CO_GT ~ PT08.S1, data = airdata)
model
summary(model)

# create model plots
par(mfrow=c(2,2))
plot(model)

# build a multiple regression model using PT08.S1 and C6H6 to predict CO_GT
model_1 <- lm(CO_GT ~ PT08.S1 + C6H6, data = airdata)
model_1
summary(model_1)

# create model plots
par(mfrow=c(2,2))
plot(model_1)
