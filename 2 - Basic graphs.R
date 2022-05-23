## 2 - Basic graphs in R
##
## Author: Bo Zhang
##
## Date Created: 5/20/2022
##
## Email: bzhang4@luc.edu
##
## ---------------------------
##
## Special notes:
##   for CARE 2022 students
##
## ---------------------------

# form two vector that store pm2.5 and pm10 data as examples
pm2.5 <- c(48.56, 48.15, 51.37, 53.38, 58.99, 63.48, 55.21, 51.8, 49.97, 52.5)
pm10 <- c(55.89, 55.14, 58.44, 62.3, 68.48, 73.41, 63.9, 59.02, 58.45, 59.55)

# run these two lines first and see they appear in R Environment
# call plot() function to create a simple scatterplot
plot(pm2.5, pm10, type = 'p')

# change line type and symbol type
plot(pm2.5, pm10, type = 'b', lty = 2, pch = 17)

# change the color of the symbol
# add a title, a subtitle, and labels
plot(pm2.5, pm10, type = 'b', lty = 2, pch = 17, col = 'red',
     main = 'Plot of pm2.5 and pm10 levels',
     sub = 'This is hypothetical data',
     xlab = 'pm2.5', ylab = 'pm10')

# plot two lines on one figure
plot(pm2.5, type = "o", pch = 21, col = "red", lty = 2, ylim = c(40, 80), ylab = "value")
lines(pm10, type = "o", pch = 22, col = "blue", lty = 2)

# add a legend
plot(pm2.5, type = "o", pch = 21, col = "red", lty = 2, ylim = c(40, 80), ylab = "value")
lines(pm10, type = "o", pch = 22, col = "blue", lty = 2)
legend(x = c(1,2.1), y = c(73, 80), inset=0.05, title="Legend", c("pm2.5","pm10"),lty=c(2, 2), pch=c(21, 22), col=c("red", "blue"))

# combining graphs in one plot
# save the original setting
opar <- par(no.readonly = TRUE)
# 3 graphs distributed over 1 row and 3 columns
par(mfrow = c(1, 3))
# 1st - two lines
plot(pm2.5, type = "o", pch = 21, col = "red", lty = 2, ylim = c(40, 80), ylab = "value")
lines(pm10, type = "o", pch = 22, col = "blue", lty = 2)
# 2nd - a histogram of pm2.5
hist(pm2.5)
# 3rd - a boxplot of pm10
boxplot(pm10)
# restore original setting - no combination
par(opar)