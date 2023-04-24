library(car)
library(lmtest)


mdf <- read.csv('05 mini_project/03 Visalization/data/Marketing_Data.csv')
plot(mdf)
cor(mdf)

boxplot(mdf)

mdf <- mdf[mdf$newspaper <= quantile(mdf$newspaper, 0.25) + 1.5 * IQR(mdf$newspaper),]

boxplot(mdf)

smdf<- mdf
for (i in 1:4){
    smdf[,i] <- scale(smdf[, i])
}

boxplot(smdf)


m <- lm(sales ~ ., data = smdf)
summary(m)
vif(m)

par(mfrow = c(2, 2))
plot(m)
dwtest(m)
shapiro.test(resid(m))
step(m, direction = 'backward')


m2 <- lm(sales ~ youtube, data = smdf)
summary(m2)
plot(m2)
shapiro.test(resid(m2))
dwtest(m2)

m2 <- lm(sales ~ newspaper, data = smdf)
summary(m2)
plot(m2)

m2 <- lm(sales ~ facebook, data = df)
summary(m2)
plot(m2)

m3 <- lm(sales ~ youtube + facebook, data = smdf)
summary(m3)
plot(m3)

vif(m3)
dwtest(m3)
shapiro.test(resid(m3))
car::boxTidwell(sales ~ youtube + facebook, data = smdf)
ncvTest(m3)

# install.packages('gvlma')
library(gvlma)
gvmodel<-gvlma(m3)
summary(gvmodel)
car::outlierTest(m3)

