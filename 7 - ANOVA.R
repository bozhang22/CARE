## 7 - ANOVA
##
## Author: Bo Zhang
##
## Date Created: 5/27/2022
##
## ---------------------------
##
## Special notes:
##   for CARE 2022 students 
##
## ---------------------------

#install package FSA

# set working directory and import Edgewater sample data
# setwd("dir")
Edgewater_B_2021 <- read.csv("Edgewater_B_2021.csv")

library(lubridate)
library(FSA)

# add a new column for time
Edgewater_B_2021$Time <- ymd_hms(Edgewater_B_2021$created_at, tz = "UTC")
Edgewater_B_2021$Time_local <- with_tz(Edgewater_B_2021$Time, "America/Chicago")

startdate <- ymd_hms("2021-02-01 00:00:00", tz = "UTC")
enddate <- ymd_hms("2021-02-28 23:59:59", tz = "UTC")
Feb_data <- Edgewater_B_2021[which(Edgewater_B_2021$Time >= startdate & Edgewater_B_2021$Time <= enddate),]
Feb_data$month <- "Feb"

startdate <- ymd_hms("2021-03-01 00:00:00", tz = "UTC")
enddate <- ymd_hms("2021-03-31 23:59:59", tz = "UTC")
Mar_data <- Edgewater_B_2021[which(Edgewater_B_2021$Time >= startdate & Edgewater_B_2021$Time <= enddate),]
Mar_data$month <- "Mar"

startdate <- ymd_hms("2021-04-01 00:00:00", tz = "UTC")
enddate <- ymd_hms("2021-04-30 23:59:59", tz = "UTC")
Apr_data <- Edgewater_B_2021[which(Edgewater_B_2021$Time >= startdate & Edgewater_B_2021$Time <= enddate),]
Apr_data$month <- "Apr"

pm2.5_Feb <- Feb_data[,c(3, 12)]
pm2.5_Mar <- Mar_data[,c(3, 12)]
pm2.5_Apr <- Apr_data[,c(3, 12)]

pm2.5 <- rbind(pm2.5_Feb, pm2.5_Mar, pm2.5_Apr)

bartlett.test(pm2.5$PM2.5_CF1_ug.m3 ~ pm2.5$month)
aov_res <- aov(pm2.5$PM2.5_CF1_ug.m3 ~ pm2.5$month)
summary(aov_res)
TukeyHSD(aov_res)
plot(TukeyHSD(aov_res))

kruskal.test(pm2.5$PM2.5_CF1_ug.m3 ~ pm2.5$month)
dunnTest(pm2.5$PM2.5_CF1_ug.m3, pm2.5$month)
