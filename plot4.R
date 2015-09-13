#plot 4
download.file(url,destfile ="./test.zip", method="curl" )
unzip('./test.zip')
download.file(url,destfile ="./test.zip", method="curl" )
read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'))
elecData<-read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=FALSE,sep=';')
library(plyr)
elecData<-rename(elecData,c('V1'='Date','V2'='Time','V3'='GAP','V4'='GRP','V5'='Volt','V6'='GI','V7'='SM1','V8'='SM2','V9'='SM3'))
elecData$Combo2 <-paste(elecData$Date,elecData$Time)
elecData$Combo2<-strptime(elecData$Combo2,format="%d/%m/%Y %H:%M:%S")

png('plot4.png', width=480,height=480,units='px')
par(mfrow=c(2,2))

with(elecData,plot(Combo2,GAP,type = "l",xlab='',ylab="Global Active Power"))

with(elecData,plot(Combo2,Volt,type='l',xlab="datetime",ylab='Voltage'))

with(elecData,plot(Combo2,SM1,type="l",xlab="",ylab="Energy sub metering"))
lines(elecData$Combo2,elecData$SM2, type="l",col="red")
lines(elecData$Combo2,elecData$SM3, type="l",col="blue")
x<-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright",col = c("black", "red", "blue"),lty=1,legend=x,bty='n')

with(elecData,plot(Combo2,GRP,type='l',xlab='datetime',ylab='Global_reactive_power'))

dev.off()