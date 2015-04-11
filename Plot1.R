## Exploratory Data Analysis
## Author : Yap Pow Look
## Date : 12 Apr 2015

library(dplyr)
library(lubridate)
setInternet2(use = TRUE)
#checks if the data is already downloaded and unzipped. If not it downloads and/or unzips
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("dataset")){
   if(!file.exists("dataset.zip")){ 
      download.file(fileUrl,destfile="./dataset.zip")
      unzip("dataset.zip",exdir="dataset.dat")
   } 
   else{
      unzip("dataset.zip",exdir="dataset")
   }
}

#set the working directory   
path <- getwd()


## ----- This segment reads the file in the R table
household <- subset(read.table("./dataset/household_power_consumption.txt",header = TRUE,sep=";",colClasses="character",nrows=70000),Date == "1/2/2007" | Date == "2/2/2007")


## Plot 1 - Global Active Power histogram
household$Global_active_power <- as.numeric(household$Global_active_power)
with(household, hist(Global_active_power,col="red",main = "Global Active Power",xlab="Global Active Power (kilowatts)"))
dev.copy(png, file= "Plot1.png",width = 480, height = 480)
dev.off()

## The End

