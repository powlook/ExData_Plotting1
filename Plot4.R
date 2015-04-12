## Exploratory Data Analysis
## Author : Yap Pow Look
## Date : 12 Apr 2015

library(sqldf)
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
## Use the read.csv.sql command to filter the required data. Reading on the first 70000 rows as reading 1.5mlines will take a long time
household <- read.csv.sql("./dataset/household_power_consumption.txt",header = TRUE, sep=";",colClasses="character",nrows=70000,sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")

## Plot 4 - Plotting 4 graphs in a page
household$Date <- dmy_hms(paste(household$Date,household$Time))
household$Voltage <- as.numeric(household$Voltage)
household$Global_reactive_power <- as.numeric(household$Global_reactive_power)
household$Global_active_power   <- as.numeric(household$Global_active_power)
household$Sub_metering_1 <- as.numeric(household$Sub_metering_1)
household$Sub_metering_2 <- as.numeric(household$Sub_metering_2)
household$Sub_metering_3 <- as.numeric(household$Sub_metering_3)

par(mfrow = c(2,2))
plot(Global_active_power~Date,household,type ="l",ylab="Global Active Power",xlab="")
plot(Voltage~Date,household,type ="l",ylab="Voltage",xlab="datetime")
with(household,plot(household$Sub_metering_1~Date,ylab="Energy Sub metering",xlab="",type="n"))
with(household, points(Sub_metering_1~Date,col="black",type="l"))
with(household, points(Sub_metering_2~Date,col="red",type="l"))
with(household, points(Sub_metering_3~Date,col="blue",type="l"))
legend("topright",pch="___", col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(Global_reactive_power~Date,household,type ="l",xlab="datetime")

dev.copy(png,file = "Plot4.png",width = 480, height = 480)
dev.off()

## The End

