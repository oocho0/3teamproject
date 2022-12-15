install.packages('extrafont')
library('dplyr')
library(datasets)
library(extrafont)
library(ggplot2)

par(family='AppleGothic')
par(mfrow=c(2,2),mar=c(3,3,4,2))

raw_data <- read.csv('./data/pop_12_21.csv')
head(raw_data)
locals = c('영동군', '금산군', '부여군', '서천군')

for (local in locals){
  target<-c(local)
  year_pick <- filter(raw_data,region==local)
  head(year_pick)

  year_pop <- year_pick[1,2:11]
  head(year_pop)
  years <- 2012:2021

  df_year <- data.frame(t(year_pop),years)
  colnames(df_year) <- c('인구수','연도')
  df_year

  ggplot(data = df_year, aes(x = 연도, y = 인구수, color='pink')) 
  + geom_line(linewidth=1)
  + geom_point(size=3)
  + theme_linedraw() 
  + theme(legend.position = "none")
  }


warnings()
