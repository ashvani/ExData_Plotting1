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


# myPlot <- function(){}
png("plot2.png", height = 480, width = 480) # to send graph in png file of specified dimension
plot.new()
plot.window(xlim = c(0, 3000), ylim = c(0, 8))
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))# 1440 observations are for 
axis(2, at = c(0, 2, 4, 6)) # Thursday and remaining 1440 observations are for Friday
box() # To keep box around plot area
points(newData[,2], type = "l")
title(ylab = "Global Active Power(kilowatts)")
dev.off()
