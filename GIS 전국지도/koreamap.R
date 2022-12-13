install.packages('ggmap')
install.packages('ggplot2')
install.packages('raster')
install.packages('rgeos')
install.packages('maptools')
install.packages('rgdal')
install.packages('terra')
install.packages('sf')
install.packages('tidyverse')
install.packages('mapproj')
install.packages('maps')
install.packages('dplyr')

library(dplyr)
library(maps)
library(tidyverse)
library(mapproj)
library(terra)
library(sf)
library(ggmap)
library(ggplot2)
library(raster)
library(rgeos)
library(maptools)
library(rgdal)

ingusu<-read.csv('ingusu.csv',header=TRUE)
ingusu <- rename(ingusu, 'sigungu_name'='시군구')
ingusu <- rename(ingusu, 'id' = '시군구ID')
ingusu <- rename(ingusu, 'plusminus'='인구증감비')
ingusu %>% head
dim(ingusu)
str(ingusu)
summary(ingusu)

map_st<- st_read("data/SIG_201703/TL_SCCO_SIG.shp")
map_st$SIG_KOR_NM <-iconv(map$SIG_KOR_NM, localeToCharset(), 'UTF-8')
map<- fortify(map_st, region="SIG_CD")
map<- rename(map, 'id'='SIG_CD')
map %>% head
str(map)
summary(map)

map_ssg <- st_read("data/SIG_201703/TL_SCCO_SIG.shp")
map_ssg$SIG_CD <- iconv(map_ssg$SIG_CD,
                       from="CP949",
                       to="UTF-8",
                       sub=NA,
                       mark=TRUE,
                       toRaw=FALSE)
map_ssg_shp <- as(map_ssg, 'Spatial')
map_ssg_df <- fortify(map_ssg_shp)
map_ssg_df$id <- as.numeric(map_ssg_df$id)
map_ssg %>% head
map_ssg_df %>% head
str(map_ssg_df)
summary(map_ssg_df)

map_a =readOGR("data/SIG_201703/TL_SCCO_SIG.shp")
df_map=fortify(map_a)
ggplot(data=df_map,aes(x=long, y=lat, group=group, color=id))+
  geom_polygon(fill='white')+theme(legend.position='none')
df_map %>% head



ingusu_map <- merge(ingusu, map, by='id')
ingusu_map %>% head
summary(ingusu_map)

plot(ingusu_map)

ggplot(data=ingusu_map,aes(, group=group, color=id))+geom_polygon(data=ingusu_map,aes(x=long,y=lat,group=group,fill=plusminus),color='white')+
  scale_fill_gradient(low="#ffe5e4", high = '#ff1d10',space='lab', guide='colourbar')+
  labs(fill='전국 인구증감률')+
  theme_void()+
  theme(legend.position = c(.2,.85))
  
