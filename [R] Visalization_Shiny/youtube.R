library("caret")
library(car)



youtube <- read.csv('05 mini_project/03 Visalization/data/topSubscribed.csv')
str(youtube)
youtube <- youtube[youtube$Started >= 2005, ]
youtube <- youtube[30:1000, c(3, 4, 5)];youtube

youtube <- youtube[(youtube$Video.Views != 0)|(youtube$Video.Count != 0),]
str(youtube)
youtube$Subscribers <- as.integer(gsub(',', '', youtube$Subscribers))
youtube$Video.Views <- as.numeric(gsub(',', '', youtube$Video.Views))
youtube$Video.Count <- as.integer(gsub(',', '', youtube$Video.Count))
str(youtube)

youtube

# boxplot(youtube$Started)

plot(youtube)
cor(youtube)

shapiro.test(youtube$Subscribers)
shapiro.test(youtube$Video.Views)
shapiro.test(youtube$Video.Count)
shapiro.test(youtube$Started)


boxplot(youtube$Subscribers)

lm1 <- lm(Subscribers ~ Video.Views + Video.Count, data = youtube)
summary(lm1)
par(mfrow = c(2, 2))
plot(lm1)






























