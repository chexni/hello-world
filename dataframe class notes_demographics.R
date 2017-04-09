getwd()
setwd("/Users/Chex/Google Drive/Data Science Resources/R")
stats <- read.csv("DemographicData.csv")
#------------Useful exploratory functions
nrow(stats)
ncol(stats)
head(stats)
tail(stats)
str(stats) #structure, NOT string | #runif () --> r uniform
summary(stats)

#------------Using the $ sign 
stats$Internet.users[2] #specify the col you want
#stats$Internet.users == stats[,"Internet.users"]

levels(stats$Income.Group)

#------------Basic operations with a DF
stats[1:10,] #subsetting
stats[c(4,100),]
stats$MyCalc <- stats$Birth.rate * stats$Internet.users
stats$xyz < 1:5 #the vector gets recycled. but it has to be a multiple of the total rows

#remove a column
stats$MyCalc <- NULL
stats$xyz <- NULL

#------------Filtering DF
head(stats)
filter <- stats$Internet.users <2
stats[filter,]

stats[stats$Birth.rate>40 & stats$Internet.users <2,]
stats[stats$Country.Name=="Malta",]

#------------Qplot
qplot(data=stats,x=Internet.users)
qplot(data=stats,x=Income.Group,y=Birth.rate,size=I(3),
      colour=I("blue"), geom="boxplot")

#------------Visualizing what we need
qplot(data=stats,x=Internet.users,y=Birth.rate)
qplot(data=stats,x=Internet.users,y=Birth.rate,
      color=Income.Group, size=I(2))

#------------Creating DF
#mydf <- data.frame(Countries_2012_Dataset,Codes_2012_Dataset,Regions_2012_Dataset)
#colnames(mydf) <- c("Country","Code","Region")

rm(mydf)
mydf <- data.frame(Country=Countries_2012_Dataset,
                   Code=Codes_2012_Dataset,
                   Region=Regions_2012_Dataset)
head(mydf)
summary(mydf)

#------------Merging DF
merged <- merge(stats,mydf, by.x="Country.Code",by.y="Code")
merged
head(merged)
merged$Country <- NULL

#------------Visualizing with new split
qplot(data=merged,x=Internet.users,y=Birth.rate)
qplot(data=merged,x=Internet.users,y=Birth.rate,
      color=Region)
#1.Shapes
qplot(data=merged,x=Internet.users,y=Birth.rate,
      color=Region, size=I(2),shape=I(18))

#2.Transparency
qplot(data=merged,x=Internet.users,y=Birth.rate,
      color=Region, size=I(2),shape=I(18),
      alpha=I(0.6))

#3.Title
qplot(data=merged,x=Internet.users,y=Birth.rate,
      color=Region, size=I(2),shape=I(18),
      alpha=I(0.6), main="Birth rate vs. Internet users")

