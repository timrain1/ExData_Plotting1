##loading library
library(dplyr)
library(lubridate)
##downloading and unzipping the file
if(!file.exists("./dataProject1Exploratory")){
  dir.create("./dataProject1Exploratory")
}
if(!file.exists("./dataProject1Exploratory/POWER.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,destfile = "./dataProject1Exploratory/POWER.zip", mode = "wb")
}
unzip("./dataProject1Exploratory/POWER.zip",exdir = "./dataProject1Exploratory")
##reading the file
data<-tbl_df(read.table("./dataProject1Exploratory/household_power_consumption.txt",
                        sep=";",header = TRUE,na.strings = "?",stringsAsFactors = FALSE))
##subsetting the data
x<-subset(data,Date=="1/2/2007")
y<-subset(data,Date=="2/2/2007")
clean<-rbind(x,y)
##converting character into date
clean$Time <- dmy_hms(paste(clean$Date,clean$Time))
clean$Date <- dmy(clean$Date)

##opening png graphic device
png(filename = "plot4.png",width = 480, height = 480)
##setting the layer for graphs
par(mfrow=c(2,2))
##first graph
with(clean,plot(clean$Time,clean$Global_active_power, type = "l", 
                xlab = "", ylab = "Global Active Power (kilowatts)"))
##second graph
with(clean,plot(Time,Voltage, type = "l", 
                xlab = "datetime"))
##third graph
with(clean,plot(Time,Sub_metering_1, type = "l", 
                xlab = "", ylab = "Energy sub metering"))
lines(clean$Time,clean$Sub_metering_2,col="red")
lines(clean$Time,clean$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), lty = 1, lwd = 2, bty = "n")
##fouth graph
with(clean,plot(Time,Global_reactive_power, type = "l", 
                xlab = "datetime"))
##close device
dev.off()