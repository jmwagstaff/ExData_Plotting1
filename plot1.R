## This script reads in downloaded data and subsets a certain date range and 
## finally plots a Histogram.


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
png(file="plot1.png")
hist(data$Global_active_power,main="Global Active Power",
     xlab = "Global Active Power (kilowatts)",col ="red")
dev.off()


