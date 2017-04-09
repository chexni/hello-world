#file <- file.path(".","Weather Data")
getwd()
setwd("./Weather Data")
Chicago <- read.csv("Chicago-F.csv", row.names = 1)
NewYork <- read.csv("NewYork-F.csv", row.names = 1)
Houston <- read.csv("Houston-F.csv", row.names = 1)
SanFran <- read.csv("SanFrancisco-F.csv", row.names = 1)

#convert dataframes into matrices
Chicago <- as.matrix(Chicago)
NewYork <- as.matrix(NewYork)
Houston <- as.matrix(Houston)
SanFran <- as.matrix(SanFran)

#put into a list
Weather <- list(Chicago=Chicago, NewYork=NewYork, Houston=Houston, SanFran=SanFran)

#using apply()
apply(Chicago,1,mean) # 1: rows. 2: columns
apply(Chicago,1,min)
apply(Chicago,1,max)

#compare
apply(Chicago,1,mean)
apply(NewYork,1,mean)
apply(Houston,1,mean)
apply(SanFran,1,mean)
  
  # recreating the apply function with loops 
Chicago
#find the mean of every row
  # 1. via loops
output <- NULL #preparing an empty vector
for(i in 1:5) { #run cycle
  output[i] <- mean(Chicago[i,])
}
output 
names(output) <- rownames(Chicago)
  # 2. via apply function
apply(Chicago,1,mean)

#using lapply()
Chicago
t(Chicago)
#lapply allows us to apply a function to all elements of a list
mynewlist <- lapply(Weather, t) #list(t(Weather$Chicago),t(Weather$NewYork),t(Weather$Houston),t(Weather$SanFran))

#example 2
Chicago
rbind(Chicago,NewRow=1:12)
lapply(Weather,rbind,NewRow=1:12)

#example 3
rowMeans(Chicago) #identify to: apply(Chicago, 1, mean)
lapply(Weather,rowMeans)
#rowMeans, colMeans, rowSums, colSums

#combining lapply() with []
Weather
#extracting an element
Weather$Chicago[1,1]
Weather[[1]][1,1] #Weather[[1]][1,1], Weather[[2]][1,1],...
lapply(Weather,"[",1,1 ) #lapply is iterating through Weather[[1]], Weather[[2]],...
lapply(Weather,"[",1,)
lapply(Weather,"[",,3)

#adding your own functions
lapply(Weather,rowMeans)
lapply(Weather,function(x) x[1,]) #for every component of weather, do <chicago>[1,]
lapply(Weather,function(x) x[5,]) 
lapply(Weather,function(x) x[,12]) 
lapply(Weather,function(z) z[1,]-z[2,])
lapply(Weather,function(z) round((z[1,]-z[2,])/z[2,],2)) #temp fluctuations 

#using sapply()
Weather
#AvgHigh_F for July:
lapply(Weather,"[",1,7) #always returns a list
sapply(Weather,"[",1,7) #can return a vector/matrix. here it returns a vector

#AvgHigh_F for 4th quarter
lapply(Weather,"[",1,10:12)
sapply(Weather,"[",1,10:12)

#another example
lapply(Weather,rowMeans)
sapply(Weather,rowMeans)
round(sapply(Weather,rowMeans),2)

#another example
lapply(Weather,function(z) round((z[1,]-z[2,])/z[2,],2)) 
x <- sapply(Weather,function(z) round((z[1,]-z[2,])/z[2,],2)) 
t(x)

#by the way (sapply is a version of lapply)
sapply(Weather,rowMeans,simplify=FALSE) #same as lapply

#nesting apply functions
Weather
lapply(Weather,rowMeans)
apply(Chicago,1,max) #treat this as an function and then apply it across a list
lapply(Weather,apply,1,max) #"1,max" becomes the optional argument to put into the apply function. lapply function iterates through the list so chicago can't be there.
lapply(Weather,function(x) apply(x,1,max))

#tidy up
sapply(Weather,apply,1,max)
sapply(Weather,apply,1,min)

#which.max (we want to know the months for the max/min)
which.max(Chicago[1,])
#returns a named vector
names(which.max(Chicago[1,]))
Weather
# we need to do this for each row and each city
# we will have apply() to iterate over rows of the matrix
# we will have lapply or sapply to iterate over components of the list (the cities)
apply(Chicago, 1, function(x) names(which.max(x))) #apply names(which.max(x)) over all rows of Chicago
sapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x)))  )


