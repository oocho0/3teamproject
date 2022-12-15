install.packages('extrafont')
library('dplyr')
library(datasets)
library(extrafont)
library(ggplot2)

par(family='AppleGothic')
par(mfrow=c(2,3),mar=c(3,3,4,2))

raw_data <- read.csv('./data/pop_12_21.csv')
head(raw_data)
locals = c('영동군', '금산군', '부여군', '서천군','김제시','정읍시')

pop_guide = c(0,130000)

for (local in locals){
  target<-c(local)
  year_pick <- filter(raw_data,region==local)
  head(year_pick)

  year_pop <- year_pick[1,2:11]
  head(year_pop)
  years <- 2012:2021
  head(years)
  plot(years,year_pop,
      main= local,
      type='b', lty=1, col='red',
      xlab='연도', ylab='인구수',
)
  }
