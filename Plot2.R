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
## setwd("./dataset")


## ----- This segment reads the file in the R table
## Only reads the first 70,000 rows since 2007/01/01 & 02 are within those rows. After that,then subset. It will reduce the loading time.
household <- subset(read.table("./dataset/household_power_consumption.txt",header = TRUE,sep=";",colClasses="character",nrows=70000),Date == "1/2/2007" | Date == "2/2/2007")


## Plot 2 - Plotting Global Active Power Against Weekdays
household$Date <- dmy_hms(paste(household$Date,household$Time))
household$Global_active_power <- as.numeric(household$Global_active_power)

plot(Global_active_power~Date,household,type ="l",ylab="Global Active Power (kilowatts)")
dev.copy(png,file = "Plot2.png",width = 480, height = 480)
dev.off()

## The End

