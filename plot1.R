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
unzip("dataProject1Exploratory/POWER.zip",exdir = "./dataProject1Exploratory")
##reading the file
data<-tbl_df(read.table("./dataProject1Exploratory/household_power_consumption.txt",
                        sep=";",header = TRUE,na.strings = "?",stringsAsFactors = FALSE))
##subsetting the data
x<-subset(data,Date=="1/2/2007")
y<-subset(data,Date=="2/2/2007")
clean<-rbind(x,y)
##drawing the plot and saving it to png graphic device
png(filename = "plot1.png",width = 480, height = 480)
with(clean,hist(Global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)"))
dev.off()

