## 9 - ggplot
##
## Author: Bo Zhang
##
## Date Created: 6/6/2022
##
## ---------------------------
##
## Special notes:
##   for CARE 2022 students
##
## ---------------------------

# load the libraries
library(tidyverse)
library(reshape2)
library(gridExtra)

# set working directory and import datasets
# setwd("dir")
Edgewater <- read.csv("Edgewater_B_20210101.csv")

# update column name
names(Edgewater)[2:4] <- c("PM1.0", "PM2.5", "PM10")

# add a factor indicating if record is before or after noon
Edgewater$noon <- NA
Edgewater[1:72,]$noon <- "before"
Edgewater[73:144,]$noon <- "after"

# add a factor indicating pm2.5 level
Edgewater$level_2.5 <- NULL
Edgewater <- within(Edgewater, {
  level_2.5 <- NA
  level_2.5[PM2.5 > 60] <- "High"
  level_2.5[PM2.5 <= 60 & PM2.5 > 40] <- "Mid"
  level_2.5[PM2.5 <= 40] <- "Low"
})

# add local time column
Edgewater$Time <- ymd_hms(Edgewater$created_at, tz = "UTC")
Edgewater$Time_local <- with_tz(Edgewater$Time, "America/Chicago")

# use the function ggplot() to start plotting
# add one or more layers to ggplot()
ggplot(data = Edgewater) + 
  geom_point(mapping = aes(x = PM2.5, y = PM10))
ggplot(data = Edgewater) + 
  geom_point(mapping = aes(x = PM2.5, y = PM10, color = noon))
ggplot(data = Edgewater) + 
  geom_point(mapping = aes(x = PM2.5, y = PM10, size = noon))
ggplot(data = Edgewater) + 
  geom_point(mapping = aes(x = PM2.5, y = PM10, color = noon, size = PM2.5))

# if you want to set the aesthetics manually, set them outside of aes()
ggplot(data = Edgewater) + 
  geom_point(mapping = aes(x = PM2.5, y = PM10, size = PM2.5), color = "blue")

# Scatterplot with smooth lines
ggplot(data = Edgewater) + 
  geom_smooth(mapping = aes(x = PM2.5, y = PM10))

ggplot(data = Edgewater) + 
  geom_point(mapping = aes(x = PM2.5, y = PM10)) +
  geom_smooth(mapping = aes(x = PM2.5, y = PM10))

ggplot(data = Edgewater) + 
  geom_point(mapping = aes(x = PM2.5, y = PM10, shape = noon)) +
  geom_smooth(mapping = aes(x = PM2.5, y = PM10, linetype = noon))

# histogram, kernel density
ggplot(data = Edgewater) + 
  geom_histogram(mapping = aes(x = PM2.5))

ggplot(data = Edgewater) + 
  geom_density(aes(PM2.5), color = "blue", lwd = 2)

# relative frequency
ggplot(data = Edgewater) +
  geom_histogram(mapping = aes(x = PM2.5, y = ..count../sum(..count..)), color = 1, fill = "white", binwidth = 3) +
  geom_density(mapping = aes(x = PM2.5), color = "black", lwd = 2) +
  ylab("Percent")

# barplot
ggplot(data = Edgewater) + 
  geom_bar(mapping = aes(x = level_2.5, fill = noon))

ggplot(data = Edgewater) + 
  geom_bar(mapping = aes(x = level_2.5, fill = noon), position = "dodge")

ggplot(data = Edgewater) + 
  geom_bar(mapping = aes(x = level_2.5, fill = noon), position = "fill")

# boxplot
ggplot(data = Edgewater) + 
  geom_boxplot(mapping = aes(x = noon, y = PM2.5, fill = noon), color = "black") +
  theme_classic()

# melt takes unstacked format data and melts it into stacked format data
Edgewater_subset <- Edgewater[,c(13, 3, 4)]
Edgewater_line <- melt(Edgewater_subset, id = c("Time_local"))
ggplot(data = Edgewater_line) +
  geom_line(aes(x = Time_local, y = value, color = variable), lwd = 1.5) + 
  theme_bw() +
  xlab("") +
  ggtitle("Time series plot") +
  theme(panel.background = element_rect(colour = "black", size=1.5), 
        axis.text = element_text(size = 12), 
        axis.title = element_text(size = 12),
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 12),
        plot.title = element_text(size = 15, color = "Blue", hjust = 0.5))

# multiple plots
p1 <- ggplot(data = Edgewater) + 
  geom_point(mapping = aes(x = PM2.5, y = PM10))
p2 <- ggplot(data = Edgewater) + 
  geom_bar(mapping = aes(x = level_2.5, fill = noon))
p3 <- ggplot(data = Edgewater) + 
  geom_boxplot(mapping = aes(x = noon, y = PM2.5, fill = noon), color = "black") +
  theme_classic()
p4 <- ggplot(data = Edgewater_line) +
  geom_line(aes(x = Time_local, y = value, color = variable), lwd = 1.5)
grid.arrange(p1, p2, p3, p4, nrow = 2)
