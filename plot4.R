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

# function plot1st plots Global reactive power with datetime
plot1st <- function(data.frame) {
    plot.new()
    plot.window(xlim = c(0, 3000), ylim = c(0, 8))
    axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))# 1440 observations are for 
    axis(2, at = c(0, 2, 4, 6)) # Thursday and remaining 1440 observations are for Friday
    box() # To keep box around plot area
    points(newData[,2], type = "l")
    title(ylab = "Global Active Power")
}

# function plot2nd plots energy sub metering over datetime
plot2nd <- function(data.frame) {
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
}


# function plot3rd creates plot of voltage vs datetime
plot3rd <- function(data.frame){
    plot.new()
    plot.window(xlim = c(0, 3000), ylim = c(234, 248))
    axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
    axis(2, at = c(234, 238, 242, 246))
    box()
    points(data.frame[, 4], type = "l")
    title(ylab = "Voltage", xlab = "datetime")
}

# function plot4th plots Global_reactive_power vs datetime
plot4th <- function(data.frame){
    plot.new()
    plot.window(xlim = c(0, 3000), ylim = c(0.0, .51))
    axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
    axis(2, at = c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5))
    box()
    points(data.frame[,3], type = "l")
    title(xlab = "datetime", ylab = "Global_reactive_power")
}

# finalplot function calls above four function to produce plot4.png
finalPlot <- function(data.frame){
    png("plot4.png", height = 480, width = 480)
    par(mfcol = c(2, 2)) # to divide plot area in 2 * 2 
    plot1st(data.frame) # plot will be created column wise 
    plot2nd(data.frame)
    plot3rd(data.frame)
    plot4th(data.frame)
    dev.off()
}

finalPlot(newData)
