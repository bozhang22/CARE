## 8 - Making Maps with R
##
## Author: Dr. Ping Jing
##
## Date updated: 5/31/2022 (Bo Zhang)
##
## ---------------------------
##
## Special notes:
##   for CARE 2022 students 
##
## ---------------------------

#Reference1: https://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html 
#Reference2: https://www.r-graph-gallery.com/275-add-text-labels-with-ggplot2.html 

#install.packages(c("ggplot2", "devtools", "dplyr", "stringr"))
#install.packages(c("maps", "mapdata"))

#Load up a few of the libraries we will use
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)

############################
##
## AQS Sites 
##
############################

# get map data for USA
usa <- map_data("usa")

############################
##
## With ggplot2, you begin a plot with the function ggplot().
## ggplot() creates a coordinate system that you can add layers to. 
## You complete your graph by adding one or more layers to ggplot().
## The function geom_polygon() adds a layer of polygons to your plot.
## We will see geom_point() later.
##
############################

gg1 <- ggplot() + 
  geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill = NA, color = "blue") + 
  coord_fixed(ratio=1.2)
gg1

## The ratio represents the number of units on the y-axis equivalent to one unit on the x-axis
## The default (ratio = 1) means that one unit on the x-axis is the same length as one unit on the y-axis

# Ozone AQS sites
labs_O3 <- data.frame(
  lon = c(-87.732,-87.545,-87.792,-87.991,-87.752, -87.799,-87.675,-87.863,-87.713,-87.876),
  lat = c(41.671,  41.756, 41.984, 41.668, 41.855,  42.140, 42.062, 42.060, 41.751,41.965),
  name = c("17-031-0001","17-031-0032","17-031-1003","17-031-1601","17-031-4002",
                 "17-031-4201","17-031-7002","17-031-4007","17-031-0076","17-031-3103"),
  type = "Ozone",
  stringsAsFactors = FALSE)

# NO2 sites
labs_NO2 <- data.frame(
  lon = c(-87.752, -87.713, -87.876),
  lat = c( 41.855,  41.751, 41.965),
  name = c("17-031-4002","17-031-0076","17-031-3103"),
  type = "NO2",
  stringsAsFactors = FALSE)

df = rbind(labs_O3, labs_NO2)

# get map data for all the US states
states <- map_data("state")

# Plot just a subset of states:
midwest_df <- subset(states, region %in% c("illinois", "wisconsin","indiana"))

gg2 <- ggplot(data = midwest_df) + 
  geom_polygon(aes(x = long, y = lat, group = group), fill = "wheat", color = "black") + 
  coord_fixed(1.2)
gg2

# get the map data for all the counties
counties <- map_data("county")

midwest_county <- subset(counties, region %in% c("illinois", "wisconsin", "michigan","indiana"))
cook_county <- subset(midwest_county, subregion == "cook")

# if fill = region, then different states are filled in different colors
# if fill = subregion, then different counties are filled in diff colors

# gg3: counties or states filled in different colors
gg3 <- gg2 + 
  geom_polygon(data = midwest_county, aes(x = long, y = lat,fill = region, group = group), color = "grey") +
  geom_polygon(data = midwest_df, aes(x = long, y = lat, group = group), fill = NA, color = "black")
gg3

# gg4: states not filled in colors
gg4 <- gg2 + 
  geom_polygon(data = midwest_county, aes(x = long, y = lat, group = group), fill= NA, color = "grey")+
  geom_polygon(data = midwest_df, aes(x = long, y = lat, group = group), fill = NA, color = "black")
gg4

gg5 <- gg4 + 
  geom_polygon(data = cook_county, aes(x = long, y = lat, group = group), fill="grey", color = "grey")+
  geom_polygon(data = midwest_df, aes(x = long, y = lat, group = group), fill = NA, color = "brown")
gg5

# zoom in to Cook County
gg6 <- gg5 + coord_fixed(xlim = c(-88.5, -87.15),  ylim = c(41.2, 42.7), ratio = 1.2)
gg6

# create a figure with ozone and NO2 stations
fig0<- gg6 + 
  geom_point(data = labs_O3, aes(x = lon, y = lat), color = "blue", size = 2) +
  geom_point(data = labs_O3, aes(x = lon, y = lat), color = "white", size = 1)+
  geom_point(data = labs_NO2, aes(x = lon, y = lat), color = "brown", size = 1)+
  geom_point(data=NULL,aes(x=-87.6,y=42.5),color="blue", size=2) +
  geom_point(data=NULL,aes(x=-87.6,y=42.5),color="white", size=1)+
  geom_point(data=NULL,aes(x=-87.6,y=42.4),color="blue",size=2)+
  geom_point(data=NULL,aes(x=-87.6,y=42.4),color="brown",size=1)
fig0

fig1 <- fig0 +
  geom_label(label="O3 only", x=-87.4,y=42.5, label.size = 0.,color = "black")+
  geom_label(label="O3+NO2", x=-87.4,y=42.4, label.size = 0,color = "black") + 
  labs(subtitle="AQS Sites", x ="Longitude",y="Latitude")
fig1