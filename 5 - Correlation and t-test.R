## 5 - Correlations and t-test
##
## Author: Bo Zhang
##
## Date Created: 5/25/2022
##
## ---------------------------
##
## Special notes:
##   for CARE 2022 students 
##
## ---------------------------

# load required library
library(lubridate)

# set working directory and import Edgewater sample data
setwd("D:/OneDrive - Loyola University Chicago/Summer2022")
Edgewater_B_2021 <- read.csv("Edgewater_B_2021.csv")
Edgewater <- read.csv("Edgewater_B_20210101.csv")

# add local time column
Edgewater$Time <- ymd_hms(Edgewater$created_at, tz = "UTC")
Edgewater$Time_local <- with_tz(Edgewater$Time, "America/Chicago")

Edgewater_B_2021$Time <- ymd_hms(Edgewater_B_2021$created_at, tz = "UTC")
Edgewater_B_2021$Time_local <- with_tz(Edgewater_B_2021$Time, "America/Chicago")

# Rename
names(Edgewater)[2:4] <- c("PM1.0", "PM2.5", "PM10")
names(Edgewater_B_2021)[2:4] <- c("PM1.0", "PM2.5", "PM10")

# use scatter plot to visualize correlation
plot(Edgewater$PM2.5, Edgewater$PM10)
plot(Edgewater$PM1.0, Edgewater$PM2.5)
plot(Edgewater$PM1.0, Edgewater$PM10)

# calculate correlation between two numeric column
cor(Edgewater$PM2.5, Edgewater$PM10)
cor(Edgewater$PM1.0, Edgewater$PM2.5)
cor(Edgewater$PM1.0, Edgewater$PM10)

# subset Jan data and Feb data
startdate <- ymd_hms("2021-01-01 00:00:00", tz = "UTC")
enddate <- ymd_hms("2021-01-31 23:59:59", tz = "UTC")
Jan_data <- Edgewater_B_2021[which(Edgewater_B_2021$Time >= startdate & Edgewater_B_2021$Time <= enddate),]

startdate <- ymd_hms("2021-02-01 00:00:00", tz = "UTC")
enddate <- ymd_hms("2021-02-28 23:59:59", tz = "UTC")
Feb_data <- Edgewater_B_2021[which(Edgewater_B_2021$Time >= startdate & Edgewater_B_2021$Time <= enddate),]

# compare if the mean pm2.5 levels are the same for Jan and Feb
t.test(Jan_data$PM2.5, Feb_data$PM2.5)

# load the records from another sensor
Edgewater1 <- read.csv("Edgewater_20210101.csv")
names(Edgewater1)[2:4] <- c("PM1.0", "PM2.5", "PM10")

# using t-test compare if two sensors reading are the same
t.test(Edgewater$PM2.5, Edgewater1$PM2.5, paired = TRUE)

# using Wilcoxon test
wilcox.test(Jan_data$PM2.5, Feb_data$PM2.5)
wilcox.test(Edgewater$PM2.5, Edgewater1$PM2.5, paired = TRUE)
