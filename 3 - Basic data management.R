## 3 - Basic data management
##
## Author: Bo Zhang
##
## Date Created: 5/23/2022
##
## Email: bzhang4@luc.edu
##
## ---------------------------
##
## Special notes:
##   for CARE 2022 students
##
## ---------------------------

# set working directory and import Edgewater_B_2021
#setwd("dir")
#Edgewater_B_2021 <- read.csv("Edgewater_B_2021.csv")
#Edgewater <- read.csv("Edgewater_B_20210101.csv")

# get lubridate from tidyverse
#install.packages("tidyverse")
#library(lubridate)

# add a new column for time
Edgewater_B_2021$Time <- ymd_hms(Edgewater_B_2021$created_at, tz = "UTC")
plot(Edgewater_B_2021$Time , Edgewater_B_2021$PM2.5_CF1_ug.m3, type = "l", ylim = c(0, 400))
Edgewater$Time <- ymd_hms(Edgewater$created_at, tz = "UTC")

Edgewater_B_2021$Time_local <- with_tz(Edgewater_B_2021$Time, "America/Chicago")
Edgewater$Time_local <- with_tz(Edgewater$Time, "America/Chicago")

plot(Edgewater$Time_local, Edgewater$PM2.5_CF1_ug.m3)

# Extracting time information
hour(Edgewater$Time)

# recoding pm2.5 to two levels
Edgewater$level_2.5[Edgewater$PM2.5_CF1_ug.m3 > 50] <- "High"
Edgewater$level_2.5[Edgewater$PM2.5_CF1_ug.m3 <= 50] <- "Low"

# summarize how many are "high" and how many are "low"
Edgewater$level_2.5 <- as.factor(Edgewater$level_2.5)
summary(Edgewater$level_2.5)

# another way of recoding pm2.5 - useful when you have many levels
Edgewater$level_2.5 <- NULL
Edgewater <- within(Edgewater, {
  level_2.5 <- NA
  level_2.5[PM2.5_CF1_ug.m3 > 60] <- "High"
  level_2.5[PM2.5_CF1_ug.m3 <= 60 & PM2.5_CF1_ug.m3 > 40] <- "Mid"
  level_2.5[PM2.5_CF1_ug.m3 <= 40] <- "Low"
})

# summarize how many are "high" and how many are "low"
Edgewater$level_2.5 <- as.factor(Edgewater$level_2.5)
summary(Edgewater$level_2.5)

# rename variables
names(Edgewater)
names(Edgewater)[2] <- "PM1.0"
names(Edgewater)[2:4] <- c("PM1.0", "PM2.5", "PM10")
names(Edgewater)

# dealing with NA values
mean(Edgewater_B_2021$Pressure_hpa)
mean(Edgewater_B_2021$Pressure_hpa, na.rm = T)

# selecting or dropping variables
myvars <- c("Time", "PM1.0", "PM2.5", "PM10")
newdata <- Edgewater[myvars]
Edgewater$IAQ <- NULL

# selecting rows based on time
startdate <- ymd_hms("2021-02-01 00:00:00", tz = "UTC")
enddate <- ymd_hms("2021-02-28 23:59:59", tz = "UTC")
Feb_data <- Edgewater_B_2021[which(Edgewater_B_2021$Time >= startdate & Edgewater_B_2021$Time <= enddate),]
pm_8 <- Edgewater_B_2021[which(hour(Edgewater_B_2021$Time) == 20),]
# variable name cannot start with a number