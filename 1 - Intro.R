## 1 - R intro
##
## Author: Bo Zhang
##
## Date Created: 5/18/2022
##
## Email: bzhang4@luc.edu
##
## ---------------------------
##
## Special notes:
##   for CARE 2022 students
##
## ---------------------------

# R can handle different types of data and they behave differently
numObject <- 2
numObject + 4

textObject <- 'CARE is Awesome!!! % ~_~'

# variable names need to be unique
logicalObject <- T
logicalObject <- F

numObject * 6
textObject * 6
logicalObject * 6

# str function returns the structure of an object
str(numObject)
str(textObject)
str(logicalObject)

# creating vectors and data frames
column1 <- c("A", "A", "B", "B")
column2 <- c(1, 2, 3, 4)
column3 <- c(T, T, F, F)
myDF <- data.frame(column1, column2, column3)

# accessing a column from a data frame
myDF$column2
myDF$column4 <- myDF$column2 + 2

# install packages and then load them before using
library(ggplot2)

# set working directory by coping the folder path where you saved your data
# make sure it's forward slash /, not backslash \
# if you use a Mac, right click on a file, Get Info, under "where" copy the path
setwd('dir')
edgewater_B <- read.csv("Edgewater_B_20210101.csv")
