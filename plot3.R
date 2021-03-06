## This script reads in downloaded data and subsets a certain date range and 
## finally plots a Time series


## first get the col classes, to make reading in faster
tab5rows <- read.table("./data/household_power_consumption.txt", sep = ";", 
                       header = TRUE, nrows = 5)
classes <- sapply(tab5rows, class)
data <- read.table("./data/household_power_consumption.txt", sep = ";",
                   header = TRUE, nrows = 2075259, colClasses = classes, 
                   na.strings = "?")

## 2,075,259 rows in dataset

## Next we create a new DateTime variable
library(lubridate)
data[,"DateTime"]<-
        paste(as.character(data[,"Date"]),as.character(data[,"Time"]))
data[,"DateTime"]<-dmy_hms(data[,"DateTime"])

## Then we convert the "Date" variable into 'Date' class
data[,"Date"]<-as.Date(data[,"Date"],"%d/%m/%Y")

## Then we can subset for data on specific dates, this creats a smaller table 
data<-data[data$Date==as.Date("2007-02-01")|data$Date==as.Date("2007-02-02"),]

## Creating the plot
png(file="plot3.png")
with(data,plot(data$DateTime,data$Sub_metering_1,
               xlab="",ylab = "Energy sub metering",type = "n"))
with(data,lines(data$DateTime,data$Sub_metering_1))
with(data,lines(data$DateTime,data$Sub_metering_2,col="red"))
with(data,lines(data$DateTime,data$Sub_metering_3,col="blue"))

legend("topright",lty=c(1,1),col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()