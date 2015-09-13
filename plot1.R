#Plot 1
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile ="./test.zip", method="curl" )
unzip('./test.zip')
elecData<-read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=FALSE,sep=';')
library(plyr)
elecData<-rename(elecData,c('V1'='Date','V2'='Time','V3'='GAP','V4'='GRP','V5'='Volt','V6'='GI','V7'='SM1','V8'='SM2','V9'='SM3'))
elecData$Combo2 <-paste(elecData$Date,elecData$Time)
elecData$Combo2<-strptime(elecData$Combo2,format="%d/%m/%Y %H:%M:%S")

png('plot1.png', width=480, height=480, units='px')

with(elecData,hist(GAP,col='red',xlab='Global Active Power (kilowatts',main ='Global Active Power'))

dev.off()