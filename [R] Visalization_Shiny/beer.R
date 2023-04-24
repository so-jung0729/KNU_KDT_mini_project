library(car)
library(lmtest)

beer <- read.csv('05 mini_project/03 Visalization/data/Consumo_cerveja.csv')

str(beer)
print(1)
colnames(beer) <- c('date', 'temp_m', 'temp_min', 'temp_max', 'rain', 'weekend', 'beer_l')


sum(is.na(beer))
beer <- na.omit(beer)
dim(beer)

beer$date <- as.POSIXct(beer$date)

for (i in 2:5){
    beer[,i] <- as.numeric(gsub(',', '.', beer[, i]))
}



plot(beer$beer_l, type = 'l')
plot(beer$temp_m, type = 'l')
plot(beer$rain, type = 'l')

summary(beer$rain)
boxplot(beer$rain)
beer <- beer[beer$rain <= 40, ]

print(2)

beer_df <- beer[, c(2:5, 7)] 
print(3)


# for (i in 1:nrow(beer_df)){
#     beer_df[, i] <- scale(beer_df[, i])
# }
print(4)


dim(beer_df)
str(beer_df)
plot(beer_df)

par(mfrow = c(1, 1))

boxplot(beer_df$rain)

cor(beer_df)

shapiro.test(df$temp_m)
shapiro.test(df$temp_max)
shapiro.test(df$temp_min)
shapiro.test(df$rain)
shapiro.test(df$beer_l)



lm1 <- lm(beer_l ~ temp_max + rain , data = df)
summary(lm1)
par(mfrow = c(2, 2))
plot(lm1)
car::vif(lm1)


lm2 <- lm(beer_l ~ ., data = df)
summary(lm2)
plot(lm2)

car::vif(lm2)


lm2 <- lm(beer_l ~ temp_max, data = df)
summary(lm2)
plot(lm2)

car::vif(lm2)


dwtest(lm2)
shapiro.test(resid(lm2))












