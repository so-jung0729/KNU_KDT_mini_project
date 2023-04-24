library(psych)
library(GGally)
library(pgirmess)
library(palmerpenguins)
library(dplyr)
library(car)
library(ggplot2)
library(ggcorrplot)
df <- penguins
str(df)
dim(df)  # 344, 8
sum(is.na(df))
df %>% filter(!is.na(df$bill_length_mm)) -> m_df
dim(m_df)

set.seed(2023)
nums<- sample(1:342, 182, replace = FALSE)
pang <- m_df[nums, ]
dim(pang)

sum(is.na(pang$bill_length_mm))

table(pang$species, pang$island)
mosaicplot(table(pang$island, pang$species), color = c("orange", "skyblue", 'tomato'), main = "Species & island")


cor(pang[3:6])

ggcorrplot(cor(pang[3:6]),lab=T)
library(ggpairs)
ggpairs(pang[,c(1, 3:6)], aes(colour = species, alpha = 0.7), main = 'Species')
ggpairs(pang[,c(1, 3:6)],main = 'Species')


par(mfrow=c(1,4))
boxplot(pang$bill_length_mm, main = 'bill_length_mm')
boxplot(pang$bill_depth_mm, main = 'bill_depth_mm')
boxplot(pang$flipper_length_mm, main = 'flipper_length_mm')
boxplot(pang$body_mass_g, main = 'body_mass_g')

library(tidyr)
penguins %>% 
    group_by(species) %>% 
    summarize(across(where(is.numeric), mean, na.rm = TRUE))


adelie <- pang[pang$species == 'Adelie',]; adelie
chinstrap <- pang[pang$species == 'Chinstrap',]
gentoo <- pang[pang$species == 'Gentoo',]
sub <- c(adelie, chinstrap, gentoo)
plot


# body_mass_g and species
par(mfrow=c(1,1))
plot(body_mass_g ~ species, data = pang,
     main = 'Penguins: species and body_mass_g',
     xlab = 'Species',
     ylab = 'body_mass_g',
     barwidth = 3,
     col = 'orange',
     lwd = 2)


par(mfrow=c(1,3))
qqnorm(adelie$body_mass_g, main = 'adelie')
qqline(adelie$body_mass_g, col = 'red')

qqnorm(chinstrap$body_mass_g, main = 'chinstrap')
qqline(chinstrap$body_mass_g, col = 'red')

qqnorm(gentoo$body_mass_g, main = 'gentoo')
qqline(gentoo$body_mass_g, col = 'red')

shapiro.test(adelie$body_mass_g)
shapiro.test(chinstrap$body_mass_g)
shapiro.test(gentoo$body_mass_g)

leveneTest(pang$body_mass_g, pang$species)

kruskal.test(body_mass_g ~ species, data = pang)
kruskalmc(pang$body_mass_g, pang$species)

body <- aov(body_mass_g ~ species, data = pang)
summary(body)
TukeyHSD(body)
par(mfrow=c(2,2))
plot(body)

# bill_length_mm and species
par(mfrow=c(1,1))
plot(bill_length_mm  ~ species, data = m_df,
     main = 'Penguins: species and bill_length_mm',
     xlab = 'Species',
     ylab = 'bill_length_mm',
     barwidth = 3,
     col = 'orange',
     lwd = 2)

par(mfrow=c(1,3))
qqnorm(adelie$bill_length_mm, main = 'adelie')
qqline(adelie$bill_length_mm, col = 'red')

qqnorm(chinstrap$bill_length_mm, main = 'chinstrap')
qqline(chinstrap$bill_length_mm, col = 'red')

qqnorm(gentoo$bill_length_mm, main = 'gentoo')
qqline(gentoo$bill_length_mm, col = 'red')

shapiro.test(adelie$bill_length_mm)
shapiro.test(chinstrap$bill_length_mm)
shapiro.test(gentoo$bill_length_mm)

leveneTest(pang$bill_length_mm  , pang$species)

bill_length <- aov(bill_length_mm ~ species, data = pang)
summary(bill_length)
TukeyHSD(bill_length)
par(mfrow=c(2,2))
plot(bill_length)


# bill_depth_mm and species
par(mfrow=c(1,1))
plot(bill_depth_mm  ~ species, data = m_df,
     main = 'Penguins: species and bill_depth_mm',
     xlab = 'Species',
     ylab = 'body width',
     barwidth = 3,
     col = 'orange',
     lwd = 2)


par(mfrow=c(1,3))
qqnorm(adelie$bill_depth_mm, main = 'adelie')
qqline(adelie$bill_depth_mm, col = 'red')

qqnorm(chinstrap$bill_depth_mm, main = 'chinstrap')
qqline(chinstrap$bill_depth_mm, col = 'red')

qqnorm(gentoo$bill_depth_mm, main = 'gentoo')
qqline(gentoo$bill_depth_mm, col = 'red')


shapiro.test(adelie$bill_depth_mm)
shapiro.test(chinstrap$bill_depth_mm)
shapiro.test(gentoo$bill_depth_mm)

leveneTest(pang$bill_depth_mm , pang$species)

kruskal.test(bill_depth_mm  ~ species + sex, data = pang)
kruskalmc(pang$bill_depth_mm , pang$species)

bill_depth <- aov(bill_depth_mm ~ species, data = pang)
summary(bill_depth)
TukeyHSD(bill_depth)
par(mfrow=c(2,2))
plot(bill_depth)

# flipper_length_mm and species
par(mfrow=c(1,1))
plot(flipper_length_mm ~ species, data = pang,
     main = 'Penguins: species and flipper_length_mm',
     xlab = 'Species',
     ylab = 'flipper_length_mm',
     barwidth = 3,
     col = 'orange',
     lwd = 2)

par(mfrow=c(1,3))
qqnorm(adelie$flipper_length_mm, main = 'adelie')
qqline(adelie$flipper_length_mm, col = 'red')

qqnorm(chinstrap$flipper_length_mm, main = 'chinstrap')
qqline(chinstrap$flipper_length_mm, col = 'red')

qqnorm(gentoo$flipper_length_mm, main = 'gentoo')
qqline(gentoo$flipper_length_mm, col = 'red')


shapiro.test(adelie$flipper_length_mm)
shapiro.test(chinstrap$flipper_length_mm)
shapiro.test(gentoo$flipper_length_mm)

leveneTest(pang$flipper_length_mm, pang$species)

flipper_length <- aov(flipper_length_mm ~ species, data = pang)
summary(flipper_length)
TukeyHSD(flipper_length)

par(mfrow=c(2,2))
plot(flipper_length)









