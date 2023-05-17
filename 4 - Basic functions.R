## 4 - Basic functions
##
## Author: Bo Zhang
##
## Date Created: 5/24/2022
##
## ---------------------------
##
## Special notes:
##   for CARE 2022 students 
##
## ---------------------------

# set working directory and import Edgewater sample data
#setwd("dir")
#Edgewater_B_2021 <- read.csv("Edgewater_B_2021.csv")
#Edgewater <- read.csv("Edgewater_B_20210101.csv")

# Rename
names(Edgewater)[2:4] <- c("PM1.0", "PM2.5", "PM10")
# Mathematical functions
abs(-10)
sqrt(25)
sqrt(-25)
round(3.14159, digits = 2)

# Statistical functions
mean(Edgewater$PM2.5)
median(Edgewater$PM2.5)
sd(Edgewater$PM2.5)
var(Edgewater$PM2.5)
# 25th and 75th percentiles of PM2.5
quantile(Edgewater$PM2.5, c(0.25, 0.75))
range(Edgewater$PM2.5)
diff(range(Edgewater$PM2.5))
sum(Edgewater$PM2.5)

# for loop
for (i in 1:10) print(Edgewater[i,])
# while loop
i <- 1
while (i <= 10) {print(Edgewater[i,]); i <- i + 1}

# Conditional execution
if (mean(Edgewater_B_2021$PM2.5_CF1_ug.m3, na.rm = T) < 12) print("Air quality meets EPA standards.") else print("Air quality does not meet EPA standards.")

# Value correction
Edgewater_B_2021$PM2.5_Correct <- NA
Edgewater_B_2021$PM2.5_Correct <- with(Edgewater_B_2021,
  ifelse(PM2.5_CF1_ug.m3 <= 343,
         0.52*PM2.5_CF1_ug.m3 - 0.086*RH + 5.75,
         0.46*PM2.5_CF1_ug.m3 + 0.000393 * PM2.5_CF1_ug.m3 * PM2.5_CF1_ug.m3 + 2.97))
