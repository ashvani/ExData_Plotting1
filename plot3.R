# project for exploratory data analysis
# Dated 08/07/2014

# reading data from file house_hold_consumption.txt kept in current working directory
fileName <- "household_power_consumption.txt"
columnClass <- c("character", "character", "numeric", "numeric", "numeric", "numeric",
                 "numeric", "numeric", "numeric")
data <- read.table(fileName, header = T, sep = ";", colClasses = columnClass, 
                   nrow = 2075259, comment.char = "", na.strings = "?" )
# na.strings = "?" as missing values are coded as ?
# comment.char = "" as input file has no comments

# Extract data for date 01/02/2007 and 02/02/2007 using vectorization
powerConsumptionData <- data[data[, 1] == "1/2/2007" | data[, 1] == "2/2/2007", ]
date <- powerConsumptionData[, 1] # first column is date
time <- powerConsumptionData[, 2] # second column is time

# combine time and date column 
timeData <- paste(date, time)

# to create object of class POSIXlt 
timeObject <- strptime(timeData, format = "%d/%m/%Y %H:%M:%S", tz = "USA pacific time")
Day <- weekdays(timeObject, abbreviate = T)

# Create a data frame having 8 columns in which first two columns are replaced by single
# column Day
newData <- data.frame(Day, powerConsumptionData[,3:9])


png("plot3.png", height = 480, width = 480)
plot.new()
plot.window(xlim = c(0, 3000), ylim = c(0, 40))
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
axis(2, at = c(0, 10, 20, 30))
box()
points(newData[, 6], type = "l", col = "black")
points(newData[, 7], type = "l", col = "red")
points(newData[, 8], type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), pch = "_", bty = "n")
title(ylab = "Energy sub metering")
dev.off()