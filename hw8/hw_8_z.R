library(ggplot2)
library(gridExtra)
library(dplyr)

training <- read.csv('TitanicTrain.csv')[1:1000,]
testing <- read.csv('TitanicQuestion.csv')

sapply(training,function(x){sum(is.na(x))})
sapply(testing,function(x){sum(is.na(x))})

#有沒有上船 v.s. 有沒有活下來
training$onboat[training$boat==""] <- 0
training$onboat[training$boat!=""] <- 1
training$onboat <- as.factor(training$onboat)
training$survived <- as.factor(training$survived)

p1 <- ggplot(training,aes(x=onboat,fill=survived))+
  geom_bar(stat = 'count',position = position_dodge())+
  theme_grey()+
  geom_label(stat = 'count',aes(label=..count..))

training$pclass <- as.factor(training$pclass)

p2 <- ggplot(training,aes(x=pclass,fill=onboat))+
  geom_bar(stat='count',position = position_dodge())+
  theme_grey()+
  geom_label(stat = 'count',aes(label=..count..))

grid.arrange(p1,p2,ncol=2)

#性別 v.s. 有沒有活下來
training$sex <- as.character(training$sex)
training$sex <- as.factor(training$sex)

ggplot(training,aes(x=sex,fill=survived))+
  geom_bar(stat = 'count',position = position_dodge())+
  theme_grey()+
  geom_label(stat = 'count',aes(label=..count..))

ggplot(training,aes(x=onboat,fill=sex))+
  geom_bar(stat = 'count',position = position_dodge())+
  theme_grey()+
  geom_label(stat = 'count',aes(label=..count..))




