install.packages('extrafont')
library('dplyr')
library(datasets)
library(extrafont)
library(ggplot2)

par(family='AppleGothic')

raw_data <- read.csv('decade_pop.csv')
head(raw_data)

target<-c('부안군')

year_pick <- filter(raw_data,sigungu==target)
head(year_pick)

year_pop <- year_pick[1,2:12]
head(year_pop)
years <- 2011:2021
years
plot(years, year_pop,
     main=target,
     type='b', lty=1, col='red',
     xlab='연도', ylab='인구수', ylim = c(20000,50000))

df_year <- data.frame(t(year_pop),years)
colnames(df_year) <- c('인구수','연도')
df_year

theme_set(theme_gray(base_family = 'AppleGothic'))
ggplot(data = df_year, aes(x = 연도, y = 인구수, color='pink')) + geom_line(linewidth=2)+ geom_point(size=6)+ theme_linedraw() + theme(legend.position = "none")

